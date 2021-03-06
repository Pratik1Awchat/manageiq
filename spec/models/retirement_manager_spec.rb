describe RetirementManager do
  describe "#check" do
    it "with retirement date, runs retirement checks" do
      _, _, zone = EvmSpecHelper.local_guid_miq_server_zone
      ems = FactoryBot.create(:ems_network, :zone => zone)

      load_balancer = FactoryBot.create(:load_balancer, :retires_on => Time.zone.today + 1.day, :ext_management_system => ems)
      FactoryBot.create(:load_balancer, :retired => true)
      orchestration_stack = FactoryBot.create(:orchestration_stack, :retires_on => Time.zone.today + 1.day, :ext_management_system => ems)
      FactoryBot.create(:orchestration_stack, :retired => true)
      vm = FactoryBot.create(:vm, :retires_on => Time.zone.today + 1.day, :ems_id => ems.id)
      FactoryBot.create(:vm, :retired => true)
      service = FactoryBot.create(:service, :retires_on => Time.zone.today + 1.day)
      FactoryBot.create(:service, :retired => true)

      expect(RetirementManager.check).to match_array([load_balancer, orchestration_stack, vm, service])
    end
  end
end
