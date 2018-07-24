require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes - first_name, last_name, email, password' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')
      @user.save
      expect(@user).to be_valid
    end
    it 'is not valid without first_name' do
      @user = User.new(first_name: nil, last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')      
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")      
      expect(@user).to_not be_valid
    end
    it 'is not valid without last_name' do
      @user = User.new(first_name: 'Laura', last_name: nil, email: 'laura@me.me', password: '123456', password_confirmation: '123456')      
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")      
      expect(@user).to_not be_valid
    end
    it 'is not valid without email' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: nil, password: '123456', password_confirmation: '123456')      
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")            
      expect(@user).to_not be_valid
    end
    it 'is not valid without password' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: nil, password_confirmation: nil)      
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password digest can't be blank")
      expect(@user).to_not be_valid
    end
    it 'is not valid with password and password_confirmation not matching' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '345678')      
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      expect(@user).to_not be_valid      
    end
    it 'is not valid with email that had already registered' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')
      @user.save!
      @newuser = User.new(first_name: 'Laura', last_name: 'Tan', email: 'LAURA@me.me', password: '123456', password_confirmation: '123456')  
      @newuser.save
      expect(@newuser.errors.full_messages).to include('Email has already been taken')
      expect(@newuser).to_not be_valid
    end
    it 'is not valid if password does not match minimum length' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password confirmation is too short (minimum is 6 characters)")
      expect(@user).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should authenticate when email and password matches existing user' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')
      @user.save!
      expect(@user.authenticate_with_credentials('laura@me.me', '123456')).to eql(@user)
    end 
    it 'should not authenticate when email and password does not match an existing user' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')
      @user.save!
      expect(@user.authenticate_with_credentials('laura@me.me', '456789')).to_not eql(@user)
    end 
    it 'should authenticate when there are whitespace/capitalized email and password matches existing user' do
      @user = User.new(first_name: 'Laura', last_name: 'Tan', email: 'laura@me.me', password: '123456', password_confirmation: '123456')
      @user.save!
      expect(@user.authenticate_with_credentials('  LAURA@ME.ME  ', '123456')).to eql(@user)
    end
  end
end
