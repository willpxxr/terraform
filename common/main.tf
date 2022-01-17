module "dns_zone" {
  source = "../modules/azure/dns_zone"

  name = "willpxxr.com"
  zone = "UK South"
}
