moved {
  from = module.prereqs[0].ibm_sm_arbitrary_secret.secret_signing_certifcate[0]
  to   = module.prereqs[0].ibm_sm_arbitrary_secret.secret_signing_certificate[0]
}
