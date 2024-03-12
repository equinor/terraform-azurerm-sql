run "basic_unit_tests" {
  command = plan

  module {
    source = "./examples/basic"
  }
}

run "complete_unit_tests" {
  command = plan

  module {
    source = "./examples/complete"
  }
}
