Factory.define :attorney do |a|
  a.email "jdoe@example.com"
  a.password "foobar"
  a.password_confirmation "foobar"
  
  a.after_build{ |attorney|
    attorney.build_personal_record(first_name: "John",
                                   last_name: "Doe",
                                   email: "jdoe@example.com");
    attorney.build_professional_record
  }
  a.after_create {|attorney|
    attorney.personal_record.save; attorney.professional_record.save}
      
end
