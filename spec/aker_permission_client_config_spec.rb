require 'spec_helper'

RSpec.describe 'AkerPermissionClientConfig' do
  context 'a client using this config' do
  	before do
  	  module CanCan::AccessDenied::I18n
  	  	def self.t(a,b)
  	  	end
  	  end
  	  class MyClient
  	  	include AkerPermissionClientConfig
  	  end
  	end
  	context 'when authorizing a user' do
  	  before do
  	  	@user = 'test@test'
  	  	@role = :execute

  	  end
  	  context 'evaluating to use a resource' do
  	  	before do
	   	  @resource = double('resource', id: '1234')
	   	  result = double('result')
	   	  @response = MyClient.new
	   	  allow(@response).to receive(:id).and_return('1234')
	   	  allow(MyClient).to receive(:where).and_return(result)
	   	  allow(result).to receive(:includes).and_return([@response])
  	  	end
	  	it 'returns true if the user has the permission specified set to true' do
	  	  @permissions = [double('Permission', permitted: @user, x: true)]
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	  expect{MyClient.authorize!(@role, @resource, @user)}.to_not raise_error
	  	end
	  	it 'returns true if the user has at least one of the permissions specified set to true' do
	  	  @permissions = [
	  	  	double('Permission', permitted: 'user2', x: false),
	  	  	double('Permission', permitted: 'user3', x: false),
	  	  	double('Permission', permitted: @user, x: true)
	  	  ]
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	  expect{MyClient.authorize!(@role, @resource, @user)}.to_not raise_error
	  	end	  	
	  	it 'raises an exception if it has the permission specified set to false' do
	  	  @permissions = [double('Permission', permitted: @user, x: false)]
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	 expect{MyClient.authorize!(@role, @resource, @user)}.to raise_error(CanCan::AccessDenied)	  	  	
	  	end
	  	it 'raises an exception if it does not have permission' do
	  	  @permissions = [double('Permission', permitted: 'otheruser', r: true, w: true, x: true)]
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	 expect{MyClient.authorize!(@role, @resource, @user)}.to raise_error(CanCan::AccessDenied)	  	  	
	  	end
	  	it 'raises an exception if there is no permissions specified' do
	  	  @permissions = []
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	 expect{MyClient.authorize!(@role, @resource, @user)}.to raise_error(CanCan::AccessDenied)	  	  	
	  	end
	  	it 'performs validation while using resource id instead of resource' do
	  	  @permissions = [double('Permission', permitted: @user, x: true)]
          allow(@response).to receive(:permissions).and_return(@permissions)
	  	  expect{MyClient.authorize!(@role, @resource.id, @user)}.to_not raise_error	  		
	  	end
	  end
  	end
  end
end