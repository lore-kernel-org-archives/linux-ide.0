From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
Date: Wed, 17 Jun 2015 15:30:02 +0200
Message-ID: <20150617133002.GW10428@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
 <20150617084852.GL4914@rric.localhost>
 <5581379C.3090607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0068.outbound.protection.outlook.com ([207.46.100.68]:31184
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753081AbbFQNaS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jun 2015 09:30:18 -0400
Content-Disposition: inline
In-Reply-To: <5581379C.3090607@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org

Tejun, Gerry,

On 17.06.15 17:02:20, Jiang Liu wrote:
> On 2015/6/17 16:48, Robert Richter wrote:

> >  static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 ent=
ry)
> >  {
> > +#ifdef CONFIG_PCI_MSI
> >  	struct msi_desc *desc;
> > =20
> >  	list_for_each_entry(desc, &dev->msi_list, list) {
> >  		if (desc->msi_attrib.entry_nr =3D=3D entry)
> >  			return desc;
> >  	}
> > -
> > +#endif

> Hi Robert,
> 	While at it, could you please help to use  for_each_pci_msi_entry()
> from include/linux/msi.h instead of hard-coding? We are trying to ref=
ine
> the msi_list related code,
> so we don't need to touch this code again later.

While looking into this I realized the code can be much more
simplified so that the desc lookup function can be removed at all.
See below.

Sorry for the patch noise.

-Robert


=46rom e43b79f0afd794d3e37ec0922c75e44b1c3f2e22 Mon Sep 17 00:00:00 200=
1
=46rom: Robert Richter <rrichter@cavium.com>
Date: Wed, 17 Jun 2015 10:33:22 +0200
Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

It turned out the irq vector of the msix can be obtained from struct
msix_entry. This makes the lookup function for msi_desc obsolete.

This fixes a build error if PCI_MSI is unset:

 drivers/ata/ahci.c: In function =E2=80=98msix_get_desc=E2=80=99:
 drivers/ata/ahci.c:1210:2: error: =E2=80=98struct pci_dev=E2=80=99 has=
 no member named =E2=80=98msi_list=E2=80=99

Catched by Fengguang's build bot.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bdedaa4f9d7b..c478a40e32c6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1203,18 +1203,6 @@ static inline void ahci_gtf_filter_workaround(st=
ruct ata_host *host)
 {}
 #endif
=20
-static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
-{
-	struct msi_desc *desc;
-
-	list_for_each_entry(desc, &dev->msi_list, list) {
-		if (desc->msi_attrib.entry_nr =3D=3D entry)
-			return desc;
-	}
-
-	return NULL;
-}
-
 /*
  * ahci_init_msix() only implements single MSI-X support, not multiple
  * MSI-X per-port interrupts. This is needed for host controllers that=
 only
@@ -1223,7 +1211,6 @@ static struct msi_desc *msix_get_desc(struct pci_=
dev *dev, u16 entry)
 static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
 			  struct ahci_host_priv *hpriv)
 {
-	struct msi_desc *desc;
 	int rc, nvec;
 	struct msix_entry entry =3D {};
=20
@@ -1248,13 +1235,7 @@ static int ahci_init_msix(struct pci_dev *pdev, =
unsigned int n_ports,
 	if (rc < 0)
 		goto fail;
=20
-	desc =3D msix_get_desc(pdev, 0);	/* first entry */
-	if (!desc) {
-		rc =3D -EINVAL;
-		goto fail;
-	}
-
-	hpriv->irq =3D desc->irq;
+	hpriv->irq =3D entry.vector;
=20
 	return 1;
 fail:
--=20
2.1.1

