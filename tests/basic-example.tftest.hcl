run "basic_example_plan" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
