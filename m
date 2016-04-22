From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/5] ata: add support for Marvell Armada 7K/8K AHCI
Date: Fri, 22 Apr 2016 16:32:36 +0200
Message-ID: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello,

The following small series adds support for the Marvell Armada 7K/8K
AHCI controller. This controller is a standard AHCI controller, so not
much is needed, except that it uses a non-default port offset and
length. Due to this, some preparatory patches are used to make it
possible to override the default port offset/length used by the AHCI
core.

Thanks!

Thomas

Thomas Petazzoni (5):
  ata: ahci: add support for non-standard port offset/length
  ata: acard-ahci: use the new port_{offset,length} members
  ata: ahci_ceva: use the new port_{offset,length} members
  ata: ahci_mvebu: add support for Armada 8K
  dt-bindings: ata: add compatible string for Armada 8K to ahci-platform

 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 drivers/ata/acard-ahci.c                                | 3 ++-
 drivers/ata/ahci.c                                      | 5 +++--
 drivers/ata/ahci.h                                      | 7 ++++++-
 drivers/ata/ahci_ceva.c                                 | 5 ++---
 drivers/ata/ahci_mvebu.c                                | 5 +++++
 drivers/ata/libahci_platform.c                          | 7 ++++++-
 7 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
