locals {
  project     = "gds-prototype-20190629" # project name = GoogleDataStudio
  region      = "us-east1"
  environment = "staging-dev"

  # network
  vpc_network_name = "hyly-ml"

  # docker repository names
  dev_repo     = "ml-dev"
  staging_repo = "ml-staging"

  # staging-dev environment state bucket
  staging_dev_state_bucket_name = "staging-dev-state"
  staging_dev_bucket_location   = "us-east1"

  # compute engine
  name                      = "staging-dev-ml"
  machine_type              = "n2-standard-4"
  zone                      = "us-east1-b"
  disk_size                 = 80
  allow_stopping_for_update = true

  allowed_ips_for_ssh = [
    "122.129.66.210/32", # Junaid's IP
    "58.27.193.244/32",  # Junaid's IP
  ]
  allowed_ssh_pub_keys = <<EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVpBmAHtXTF5o3QPImmJgHYL0gKqi/qZH0em/Fj9cAzva4lC/bvm4CHJxSfHqtZHF6pcrCm3WBK5EOZw3jc6ZR3grfwwm0OTjRWHVSVFCv3XHgfVXNSsVsfi4fYhOv+RIsXYvH9middJYJmrf2riHghlujQHwPuA2Y7y0KqD+nv4M9rTvk2g1nieg7Yx61iFKm5ygSBqOlJd6W7TtdocBZ0H65U/J2XyZkYJpLXvX/pjRd9HfbnheTKtyL0uHNNUSyNGaH/s43JdkUX6O4aw1T86LuOgegljHBjp0/j7WihEtAZvENT2Ar0nW/Csak8Diin6pexBrvQJIsAo7NyP4T ja-keypair
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCa8HfqHd3BhoHtXSasgbQ9/HnpEByNknicekS4LTfvZA5GKgjZm8XA0v+tyy1k5LBHQ7umVG0Dm8zuVGDJH5nC/N1zXi419csaIAvdDaEBmZQ0y4PxnW4c1Rw8oxwg43drvffGGjtGTFv5JfiaZVT1WUnVUqCnsTfbfUqsJ9eo9OM8+kQhtOIMr2A5IgFG5YmmlL5e6bL2TeHJPC4P/dE5M4KbkRQASqA4mAEojno562JR5EUa0QC1Gc3Rvrv5aREaVFZokP7r5nkRUU7fyrQ/FYwCFUr0622qKS/EIKszqhlNVnWBvA/KuivRscPZPBJY2kfzif438kOBnzVDyHuH tn-keypair
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBEozArQFQJjOovP4TQZTC6iYJmDG56adfrCprpqlPQFSdXw+/L6WhtyZLuQWFJRETyyFJkl/hz2DDNqx7YKhrfX4n6VPwR0F/jhaW6o/xAckrUbTrRgeN6t7kxRI+GDYs481SeH/MaHkw1C5nukLdKgnQps7430dSYFEfBHVuX4qv0JBDYmP7h24W7+/+x6JtUWx5FWAXeIuqimvAd79TvpsPYuqUbQZvGoQhme55gK1duyAkuTVvnDs/2GkdsT1sKJkgkSU6F23Jp6HtgqgC10oCS7SVuQTXQ10i2Vrdn9scV8RnUahUKpwcjsSCJMtPBGK0KF+qdjp3iGGPGO0SdU08hUyvwSRFVg6KYJSac/5zmd/kZibjvQxRa/WJwMuw/EN+bwQOARnjgDkAB2/p06pQNeCgcU9Tkqr0tncH75aX3j0+GJzBg0i+h+llrWyZLv8+22cTVd00SDd9vRmjMO+90Zt6B59dfajp0laPo7sOAzeZEkgYTn3yYxOa1sk= ubuntu@jenkins-ml
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAahvwcjsXBQUzhQDBsAUWQ2LQG3/xhfMwPI8+yIs5KYsvF+kuMMQ+N4/voW3XcEEqGbmCrm8LNG/VhQ0a5iw/4H34M2KW9R+NF8F8BX8Y4pb+GrFiIq60Y+h89Sz+qzMSzqg1R5OBbMrb5Otil9xfcoG7PKC/AL7Dlm/kh+/zLj68LGRMO0obCzldlWTfiyiH5+zieiITxgmsog95opDoxdWF9VuoL/fsgJQXe2fEklraMwWoQFPfuUTcuzcm6lvVqaPZsLmI30qppb+/pcJ+zS7lLbEtrhO/bf9sE2/DMMjawTEqHvQzFdF9yj4WvzufYRi+SF5PnJv0VW8RVRqC/l7Bdif0jHUu4pboHiK3h2hJ80sBWKMbzGTBiKEybr6SHuXghyK+9Ds1BlJAZMF7emBzYVOGeey/4CZwvPjm7X24bkvu11rFiXE+iLuVeEAUqd1vxvDbVsDExRWdjDP6sHfpWvTzIhUE1kKwPLIAn5RPTDfKtl1FPyCphQdMF28= sanya matta@LAPTOP-KTAAGSHP
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPi3CJlca9fn4V35sw5nozc8eiXf2m2w6Dq+nydMLr/R0YODp09hkQvvX+eubZf0XIvQxrhuGVA3LyVvRU8NWhOa29/B91sfklHWk3Jm0DKPukUaQhLtgsVDLCH3+DI6p5gTBLvAGCn6MakiVczCxLeFov4gkPzKaYJbPRJqzpca6T/kti6zxgRm099WdGaujxfZY5wc/IgHR7GstjzB7yNRpCHG4JB2i5VIiGF+BZBZ9+T51eka5l7a22lBruuYEXloTbIyMhwtu56lV8MJABbghK92RjnF2YZergN/nNYFnLHXmrSKC4fo85IMQopZfwO/ROTVKVBu4llrHojTwpfrOy3/lGwu6TNd7zTIH9VceQmnFTp1pDL4JMd39s+wcOnVeZdTgHHIkknQLRK9l4sosDMGuJVx5OBBkaoZMpQzXcv+rDXcij+zUHDsGUbW5QD+FT2qIsyy/qBPctyalAANgZxOJ01Wg4puzEs+HWTsdXk1PXCfbhmfiPT6XFGm0= work@DESKTOP-3UPD527
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCg4XMhP9AMzA8kc9FKy7CiyhyXzTjZBYV6OaC0QJ82SXsYXeMRbeuzy2HVx1XOCyV6HdNbuXjBgsucVcvQWGK4ZQMa59AZ9ktv6NEvuogU+IhH43zwWF9F6vTzzccujL4xi2HM6s02NMSvNMKCh0hVd8k+Gq3uLKu4qCoFxlUqmKUtWi1ByzwRkXTl1AI6jtXtiNQTM4tcHeFIKGmwH//degREJ3DlqrSCJ3DvH/9noaySmT6+XA4f9wotgj8HHhoPAsSFdhAzYdl1P1o42XqgGfx112ByQnUF/GFJGXTnGCEf1c1X3CA0rZJfHOAMmYVBI1SNyvyjBWWy58xVvo464LmeayZgciVNaO8bwjFEflLZ+IWKa3qqVntiYpz1+G/h+5XrkwOolscuyVyC4+bkRGd3AiOVHp0yvQer+CD4u23oa3KVkdDNFACgrg9KaON3I5wwby1o4MSrgI621+SpnizPLZ/HC6eH7lG5eNqMvqnzfkRu/W5HTQqZfSFNFgPYRgHdq7XRhvFYRTG6wFpKheLCNox8XCCiDfpSK+VqP98DULX3ZnxWYcRZeeOMWPTJVAQbH70ug/dZOL1f3hSOMT6nIpJoPiVGmJAkBWuPZWlxEavFSyEtmyp6kqd4n0/gy3SC/go51PnRHeDe150DwodRTkrbUo0mTCWojPi5Vw== akshay@LAPTOP-KLQ0533A
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDmigoxmG2/uejs2eidbQ0HRE5yvgtZzExo5AkeVee6nZN/vx0HbG2dZAfb+csBYuUae1sPnMMwQd9+c7mpCBclRFNn++cb6elWTwVDgQmRIQzV/OHl22x8k7C0+MVCLbTPW2nl+pLxrl7Us4J0rl3sNkYVjwoh+eGv+LytU/igPenRmL6ankJ/0SfHaRmUi6n1ZImKejyFTl9pjw7v5JL9k8l3XuQ3dyinstzx2jWHxzYzf8oxhI52FGuDt0ATg+8HhqEzae/7J1sjxYaMTM+jsuEtWlMYdlFWDJddLnCrpxefrTxuMu2AG3UFRJRuZfLb6v6kGh72qJIkXqZVbdS04FdxOlH73PkYdxTO0IN/wzmtqWbCwN3fuNyrdEuKEJqjm1fzsDXRRx2BRMLruO8GlO7pHvdp+CFNjMN+z7Z7skzqRqPcDo/aAiWBpCKD4MpckLsxNWr0itLdWkRGnpvYP+uxGiyyA4kPU59G/J88jif4fWqsguWX7ubdTLwDZqRh60gC2hVXMv6rp25uhD6J3+K8QivIIyZ6utVvtj8S3PVlMpwaArO+H1Yrj4pvd+AgtxKL2dXqd0mJDLR95Bknb0iMsUcV8dWPcUCGA0A4bOqCBF/ZiWN+gWIEQFdSsZIIcAohS0pdWoJdJ2oWcnnfoGGspLe/w8zZngzwt3kqvQ== guljabee@guls-mbp
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpgqkAIpm4Ucysh62JviIzVDRxsRvQI1umb8crx07q9vIzR+LhJblGVUnm6Px0UOAuCWxNwuTslE66070RLGKby2haaaNg/LMKm98+BURvMpyCW6D0AA/7YcDuhdIrmqnn/ypONc8q2siz+PJCdz5aby5YKZ7PEXH3gsXc0Oi7XrW0cL1YulbZHi4Rr0zthb4Jat2PBhmQTHhBCowXMTuphnzt29dK51RSPot268vGLW/X8mfRfIFIaqhOvTCkwCqvTNzINVzyg2jNk8J/ccHGW+nVPT2J5nC7PHDNr3ol/nBy/743af4KSLgZ6W3yeyBRYyXaBEJ+QI5IrhZVjFYKPLwSlWice0pJ6NFosTAcZy/mr9S/3vHVMyahwuKHkiHxh0kDn1Ut3yc95c7I1XDaNPVJ+YmhmhpXfmTWgLTuIvVJ9UkWfyX5P4Brt4phBgVFdGQiGTEEWwlmcyto0rABYHTp0nj8dVyX8CCCF+ZilRgHYJpUrAyIDOlRKvus98U= ubuntu@ml-dev
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6jP4Tsi4brbSobcG3udXiyPK7AR58mIMlBWpjV+1vOk8DTCyjG0QTp9NcBOtGToldx8uhdojL6Iyf/E447wYgF1Z/QLsnV7iv8d/ZJcewJKOZ0jrlLX+ZBtj7iZVKHMXqxceIFF2WyL34oqH0lNO6NgFPMB7/hgDud1MY7bTC8zszepiBIGMaXQus5MtFs8O4x2XFZzFvmDTN4mksNDzJH5uLyrdwCkWVk9Lag0xcZoI1F2XGaLAt3HIN6TgeX2QPoT89cENJpv16W4QHBTuzwZpPVyZqrTIJ5H+hMQsnwcKLLInyVZLiholUqPq6WIQJ5SHrvTLFwDLl/uEOPwbFf8IgY9k5FPMxigcxW9hTP/CtLQ1XyFQ0S6P09/oH4uaheewMKfdZp/kibGgL1umDSHXvwbN26zOUM0tNLvjLZZyaVfZDTS+KIRXkzBv3ScWq9gi1z8RwbIQbEi2zbe9JarJoAAo+3tbMiET8USvl9QduYgF4ABCipUCtJjrTis0= ashish@Ashish
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrx4KRtQ3q9dxIZ85y6BE7qXHrQChCxTU2hBPTIbpklE3LPg5iIbjeY9pNmtvcCpusWq48t7n9vIjeO/l+DphkRRgqMnT2UWVuYwQLmyyb+yF593sioFy5Th6mHWNpG5NVZ0el14b5692za/g3n/oULUvii5/CPtlvKymOS8YaZpqYGCg1bKrXz8ZtcqhRh9h+pFvyr8CU9ya+yG8lsMtbihTekRsiPh9cy14gjl7JTKVFmMx0cNurh/WDPHCt0EnAfhC320D2UOOAuBidcJQ25RVY7qVR3FRJFPalphoxBVDH7ilzGqhjm7sFHOThC7Y/FHQ6A2fosYkQswF6elmuxydwprU4LqaWX7Zw4WIqE7WYLnQA5G/Soj5ecPEqoLYUFrvuvUNdjymZngD2oWbjwKOZSBvYUWJJxWeiCV0cCDYItGqaRBcuJbQdnReprWNzdaAbymcyrFxVLJXc4Eh2pwNRvVIAMUbPqI+OM7cgZUV62RWkNjNlENnmUZHXcyjror85lEw8DHh7mhCTyjh1Indrd7WR6O09J2PnSUcRRWA1PdeiH6zubZEIkRWFFHIYJBFHFMhhnTr1/G5UK8bdwnPuN5xbUG+7SPNKYFdzh39LTYCfhVwt345j/4FVL9zMAruk/pOWjBXm0rff4K5cZD7fqH7xigtMVLYAZury3w== ahsan-linux
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3B0YMbTA37a3F/8DEEi2SPvVAZoRYoG4GuamAlHspVzUfGZVpmLXtyyMz3xYlcmWKLTcJcrc6VG6nAym3Cwb/KFe72g/A3bqnRfpwsWDGKcqctArdk5ban6QJqhJcSM6SUyoyCwsrISeJV8j3OXBdixhlO782OI6xHfAgykSJr9GAkyhFgqWAyy3LqxQRQxexZVl21ZQeRo95d4Cdpgo1gcdd3EeQX1d2gvdiO2YVQ6/CIpdRCZSSsUfU5S1C4Qi6TdZQ7UwWRvg+sYVf0ecPSSYAUFFkZK4dZSGe7E4urvpg1egGvnk0/TWOyFLVfNS+lAr6fzY/hf7635lNLar5ZdbtWkFcGctxoXRb4kQiQw95qEVuhXrJU5oMaSivfjMs65jVRFDrPgYm5Q491nB2Bp/F5+VRgRiT6czozVVBSok5RnIO8ZF5cHQf0lnusJkXKjStd/xr8z8/GuaKnwr0u7c83XKQIJXp/KLWawmCL4WrZJZEShWkNDKOefsX9295A6OrWd6Ea17LOEszn/ZkpGC+lVg1y/vuQTPBlS4mKN+4BMFvYGn0zk2H5OzBbt9jy8fRLYSuaqWAAYlbIKXrZ8USkelpxX18XUyRAMSgRaTDzaJ22/XAr32U0dhUKlZ1Uo053z3PEioZEL9qL7wcgnQXY150Zgo18GPD+iGHIw== badarshaban@gmail.com
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQ8bsLWs9v5ne37K7hHqURLHFdxRfbYcNDmAq5908Y5LBZsO3kuF5EB/b7UDDQqdL7es13iKi3SRp+d9M+zF7RwyFsdKBipAPbC/VGfAFjwWe7AZh1PdfqwT5rqObO5ftiPmpaxhYi5iamDvAz2WaMkMczn7bYhW57MgbcHUZimxhMYuX2g80b8yMWEKezgwZj+CzJ4uOREZEqv7EGTImHs/xjCgfPcWQDvYonAmXpQaLYSZSeW2JvtXwGIk6LC3XvL/H5GwtbTPdRCtb8ZY8CGPVh9vTS44GY5n5xe3lF7nuOezmXpGXju8d0NodnAqiWTcEtohdXGIiB/RXXcEA/5gJQP9Bz+n2XggTpQ2wKz5ClfXwcARPCcbugIv1/ofVtNhpPyRUX2W49LQhG2nnNJwcdZwl6za4XwziNLvxqWzQabj1DZjja+vVQIz11r8wo1eYWzxg2ysZlYwjIzK2fnigBtMzY1ADlawxO3t0exc4kt9hnUI0nj+qSwSf/GZc= afaqahmad@Afaqs-MBP
  EOT

  iam_members = {
    "staging_dev_sa_token_creator"     = "roles/iam.serviceAccountTokenCreator"
    "staging_dev_sa_storage"           = "roles/storage.objectAdmin"
    "staging_dev_sa_bigquery"          = "roles/bigquery.dataOwner"
    "staging_dev_sa_bigquery_admin"    = "roles/bigquery.admin"
    "staging_dev_sa_storage_admin"     = "roles/storage.admin"
    "staging_dev_sa_dataflow_admin"    = "roles/dataflow.admin"
    "staging_dev_sa_dataflow_worker"   = "roles/dataflow.worker"
    "staging_dev_sa_workflow_admin"    = "roles/workflows.admin"
    "staging_dev_sa_artifact_registry" = "roles/artifactregistry.reader"
    "staging_dev_sa_stackdriver"       = "roles/logging.logWriter"
  }
}