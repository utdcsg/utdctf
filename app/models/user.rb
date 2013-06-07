# Stores user information for competitors and carries out authentication
#
# ==== Important Database Attributes
#
# * +name+ - Stores the user's login username
# * +description+ - Stores an optional description
# * +hashed_password+ - The password digest that's actually stored in the database
# * +salt+ - Random salt generated and saved when the password is set
#
# ==== Constraints
# * +name+ is unique
# * +name+, +role+, and +password+ are required
# * +password+ is confirmed
# * +role+ cannot be mass assigned without :as => :admin
# * +role+ must be either :user or :admin
class User < ActiveRecord::Base

  has_many :competitions, :through => :participations
  has_many :problems, :through => :solves
  has_many :people, :through => :logins
  has_many :participations, :dependent => :destroy
  has_many :solves, :dependent => :destroy
  has_many :logins, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true, :presence => true
  validates :role, :presence => true, :inclusion => { :in => [:user, :admin] }

  # Used for password confirmation forms
  attr_accessor :password_confirmation
  # Along with the +password=+ method, transparently salts, hashes, and sets the hashed_password
  attr_reader :password

  attr_accessible :name, :description, :hashed_password, :password, :password_confirmation
  attr_accessible :name, :description, :hashed_password, :password, :password_confirmation, :as => :user
  attr_accessible :name, :description, :hashed_password, :password, :password_confirmation, :role, :as => :admin

  # Called to authenticate a username and password pair.
  #
  # * *Args* :
  #   - +name+ -> The username string
  #   - +password+ -> The password plaintext
  # * *Returns* :
  #   - The user object on successful authentication, otherwise nil
  #
  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  # Salts and stores the digest for a plaintext password
  #
  # Digest is computed as: hash(password.'nonsense'.salt) and the algorithm is SHA2
  #
  # * *Args* :
  #   - +password+ -> The password's plaintext
  #   - +salt+ -> The prestored salt
  # * *Returns* :
  #   - The string of the hashed password
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "nonsense" + salt)
  end

  # Simple helper to make the role pretty
  def display_role
    if role == 'admin'
      'Admin'
    else
      'User'
    end
  end

  # Computes a user's total score in a specific competition
  #
  # * *Args* :
  #   - +competition+ -> The database object for the competition
  # * *Returns* :
  #   - An integer score representing the sum of the user's solved problems for that competition.
  def score(competition)
    competition_problems = competition.problems
    competition_problems.select { |p| problems.include? p and p.active }.reduce(0) { |a,x| a+x.points }
  end

  # Overloaded = operator that allows the password to be hashed and stored transparently
  #
  # * *Args* :
  #   - +password+ -> The password plaintext
  # * *Returns* :
  #   - Nothing, just updates the database
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
