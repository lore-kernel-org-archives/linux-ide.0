From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Fri, 1 Aug 2008 09:18:34 +0100
Message-ID: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51561 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751735AbYHAIft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 04:35:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David =?UTF-8?B?TcO8bGxlcg==?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

=46rom: Alan Cox <alan@redhat.com>

Dave M=C3=BCller sent a diff for the pata_oldpiix that highlighted a pr=
oblem
where a lot of the ATA drivers assume dma_mode =3D=3D 0 means "no DMA" =
while
the core code uses 0xFF.

This turns out to have other consequences such as code doing >=3D XFER_=
UDMA_0
also catching 0xFF as UDMAlots. Fortunately it doesn't generally affect
set_dma_mode, although some drivers call back into their own set mode c=
ode
from other points.

Having been through the drivers I've added helpers for using_udma/using=
_mwdma
dma_enabled so that people don't open code ranges that may change (eg i=
f UDMA8
appears somewhere)

Thanks to David for the initial bits

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/libata-core.c |    4 ++--
 drivers/ata/pata_acpi.c   |    2 +-
 drivers/ata/pata_atiixp.c |    2 +-
 drivers/ata/pata_cs5530.c |    6 +++---
 drivers/ata/pata_sc1200.c |    6 +++---
 include/linux/libata.h    |   22 ++++++++++++++++++++++
 6 files changed, 32 insertions(+), 10 deletions(-)


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b4297ea..d7b6633 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3267,7 +3267,7 @@ int ata_do_set_mode(struct ata_link *link, struct=
 ata_device **r_failed_dev)
 		dev->dma_mode =3D ata_xfer_mask2mode(dma_mask);
=20
 		found =3D 1;
-		if (dev->dma_mode !=3D 0xff)
+		if (ata_dma_enabled(dev))
 			used_dma =3D 1;
 	}
 	if (!found)
@@ -3292,7 +3292,7 @@ int ata_do_set_mode(struct ata_link *link, struct=
 ata_device **r_failed_dev)
=20
 	/* step 3: set host DMA timings */
 	ata_link_for_each_dev(dev, link) {
-		if (!ata_dev_enabled(dev) || dev->dma_mode =3D=3D 0xff)
+		if (!ata_dev_enabled(dev) || !ata_dma_enabled(dev))
 			continue;
=20
 		dev->xfer_mode =3D dev->dma_mode;
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index c5f91e6..783e3c2 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -181,7 +181,7 @@ static unsigned int pacpi_qc_issue(struct ata_queue=
d_cmd *qc)
=20
 	if (adev !=3D acpi->last) {
 		pacpi_set_piomode(ap, adev);
-		if (adev->dma_mode)
+		if (ata_dma_enabled(adev))
 			pacpi_set_dmamode(ap, adev);
 		acpi->last =3D adev;
 	}
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index d7de7ba..e8a0d99 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -183,7 +183,7 @@ static void atiixp_bmdma_start(struct ata_queued_cm=
d *qc)
 	u16 tmp16;
=20
 	pci_read_config_word(pdev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
-	if (adev->dma_mode >=3D XFER_UDMA_0)
+	if (ata_using_udma(adev))
 		tmp16 |=3D (1 << dn);
 	else
 		tmp16 &=3D ~(1 << dn);
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 744beeb..0c4b271 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -149,10 +149,10 @@ static unsigned int cs5530_qc_issue(struct ata_qu=
eued_cmd *qc)
 	struct ata_device *prev =3D ap->private_data;
=20
 	/* See if the DMA settings could be wrong */
-	if (adev->dma_mode !=3D 0 && adev !=3D prev && prev !=3D NULL) {
+	if (ata_dma_enabled(adev) && adev !=3D prev && prev !=3D NULL) {
 		/* Maybe, but do the channels match MWDMA/UDMA ? */
-		if ((adev->dma_mode >=3D XFER_UDMA_0 && prev->dma_mode < XFER_UDMA_0=
) ||
-		    (adev->dma_mode < XFER_UDMA_0 && prev->dma_mode >=3D XFER_UDMA_0=
))
+		if ((ata_using_udma(adev) && !ata_using_udma(prev)) ||
+		    (ata_using_udma(prev) && !ata_using_udma(adev)))
 		    	/* Switch the mode bits */
 		    	cs5530_set_dmamode(ap, adev);
 	}
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index cbab397..0278fd2 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -167,10 +167,10 @@ static unsigned int sc1200_qc_issue(struct ata_qu=
eued_cmd *qc)
 	struct ata_device *prev =3D ap->private_data;
=20
 	/* See if the DMA settings could be wrong */
-	if (adev->dma_mode !=3D 0 && adev !=3D prev && prev !=3D NULL) {
+	if (ata_dma_enabled(adev) && adev !=3D prev && prev !=3D NULL) {
 		/* Maybe, but do the channels match MWDMA/UDMA ? */
-		if ((adev->dma_mode >=3D XFER_UDMA_0 && prev->dma_mode < XFER_UDMA_0=
) ||
-		    (adev->dma_mode < XFER_UDMA_0 && prev->dma_mode >=3D XFER_UDMA_0=
))
+		if ((ata_using_udma(adev) && !ata_using_udma(prev)) ||
+		    (ata_using_udma(prev) && !ata_using_udma(adev)))
 		    	/* Switch the mode bits */
 		    	sc1200_set_dmamode(ap, adev);
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6820d6b..9bfe49e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1427,6 +1427,28 @@ static inline unsigned long ata_deadline(unsigne=
d long from_jiffies,
 	return from_jiffies + msecs_to_jiffies(timeout_msecs);
 }
=20
+/* Don't open code these in drivers as there are traps. Firstly the ra=
nge may
+   change in future hardware and specs, secondly 0xFF means 'no DMA' b=
ut is
+   > UDMA_0. Dyma ddreigiau */
+
+static inline int ata_using_mwdma(struct ata_device *adev)
+{
+	if (adev->dma_mode >=3D XFER_MW_DMA_0 && adev->dma_mode <=3D XFER_MW_=
DMA_4)
+		return 1;
+	return 0;
+}
+
+static inline int ata_using_udma(struct ata_device *adev)
+{
+	if (adev->dma_mode >=3D XFER_UDMA_0 && adev->dma_mode <=3D XFER_UDMA_=
7)
+		return 1;
+	return 0;
+}
+
+static inline int ata_dma_enabled(struct ata_device *adev)
+{
+	return (adev->dma_mode =3D=3D 0xFF ? 0 : 1);
+}
=20
 /*********************************************************************=
*****
  * PMP - drivers/ata/libata-pmp.c
