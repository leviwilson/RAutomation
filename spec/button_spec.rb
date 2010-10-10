require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RAutomation::Button do
  it "#button" do
    RAutomation::Window.new(:title => /file download/i).button(:text => "&Save").should exist
    lambda {RAutomation::Window.new(:title => "non-existing-window").button(:text => "&Save")}.
            should raise_exception(RAutomation::UnknownWindowException)
  end

  it "#value" do
    RAutomation::Window.new(:title => /file download/i).button(:text => "&Save").value.should == "&Save"
    lambda {RAutomation::Window.new(:title => /file download/i).button(:text => "non-existent-button").value}.
            should raise_exception(RAutomation::UnknownButtonException)
  end

  it "#exists?" do
    RAutomation::Window.new(:title => /file download/i).button(:text => "Cancel").should exist
    RAutomation::Window.new(:title => /file download/i).button(:text => "non-existent-button").should_not exist
  end

  it "#click" do
    button = RAutomation::Window.new(:title => /file download/i).button(:text => "&Save")
    button.should exist
    button.click
    button.should_not exist

    window = RAutomation::Window.new(:title => "Save As")
    RAutomation::WaitHelper.wait_until(10) {window.present?}

    lambda{window.button(:text => "non-existent-button").click}.
            should raise_exception(RAutomation::UnknownButtonException)
  end
end