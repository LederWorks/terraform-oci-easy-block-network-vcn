# Change Log

## v0.2.0 [current]
FEATURES:
- Added VCN support
- Added subnet support
- Added DNS Resolver support
- Added DNS Resolver Endpoint support
- Added DHCP Options support
- Added Route Table support
- Added Security List support
- Added support for a context module

ENHANCEMENTS:
- Improved dns label validation for vcn_subnets variable
- When using context module names are generated with the vcn_name_suffix, vcn_subnets.name_suffix, vcn_dns_name_suffix and vcn_dns_endpoints.name_suffix inputs

BUG FIXES:
- Added vcn_dns_manage variable with default false value, so the initial run not failing on the resolver not available yet.

## v0.1.0
FEATURES:
- Initial version