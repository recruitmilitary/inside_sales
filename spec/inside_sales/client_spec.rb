require 'spec_helper'

describe InsideSales::Client do

  let(:client) {
    client = InsideSales::Client.new(ENV['IS_SUBDOMAIN'],
                                     ENV['IS_USERNAME'],
                                     ENV['IS_PASSWORD'],
                                     ENV['IS_TOKEN'])
    client.login
    client
  }

  describe '#get_leads' do

    context 'with filters' do
      use_vcr_cassette

      it 'uses filters for returning the correct leads' do
        email = 'michael@recruitmilitary.com'
        filters = [{
                     'field'    => 'email',
                     'operator' => '=',
                     'values'   => [email]
                   }]

        leads = client.get_leads(filters)
        leads.map { |lead| lead['email'] }.uniq.should == [email]
      end
    end

    context 'with an offset and limit' do
      use_vcr_cassette

      it 'can limit the number of leads returned' do
        email = 'michael@recruitmilitary.com'
        filters = [{
                     'field'    => 'email',
                     'operator' => '=',
                     'values'   => [email]
                   }]

        client.get_leads(filters, 0, 1).size.should == 1
      end
    end

  end

end
