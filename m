From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it821x: (partially) fix DMA in RAID mode
Date: Sun, 10 Jun 2007 18:43:20 +0200
Message-ID: <200706101843.20947.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51549 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbXFJQrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 12:47:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1304713ugf
        for <linux-ide@vger.kernel.org>; Sun, 10 Jun 2007 09:47:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>


Code intended to check DMA status was checking DMA command register.

Moreover firmware seems to "forget" to set DMA capable bit for the
slave device (at least in RAID mode but without ITE RAID volumes) so
check device ID for DMA capable bit when deciding whether to use DMA
and remove DMA status check completely.

Thanks to Pavol =A9imo for the bugreport and testing the initial fix.

This change unfortunately still doesn't fix DMA in RAID mode (which
works fine with IDE it821x) but Alan is working on the missing pieces
(pata_it821x vs libata EH issues).

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ata/pata_it821x.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: b/drivers/ata/pata_it821x.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -2,6 +2,7 @@
  * pata_it821x.c 	- IT821x PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@redhat.com>
+ *			  (C) 2007 Bartlomiej Zolnierkiewicz
  *
  * based upon
  *
@@ -79,7 +80,7 @@
=20
=20
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.3.6"
+#define DRV_VERSION "0.3.7"
=20
 struct it821x_dev
 {
@@ -460,14 +461,8 @@ static unsigned int it821x_passthru_qc_i
=20
 static int it821x_smart_set_mode(struct ata_port *ap, struct ata_devic=
e **unused)
 {
-	int dma_enabled =3D 0;
 	int i;
=20
-	/* Bits 5 and 6 indicate if DMA is active on master/slave */
-	/* It is possible that BMDMA isn't allocated */
-	if (ap->ioaddr.bmdma_addr)
-		dma_enabled =3D ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
 	for (i =3D 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev =3D &ap->device[i];
 		if (ata_dev_enabled(dev)) {
@@ -476,7 +471,7 @@ static int it821x_smart_set_mode(struct=20
 			dev->dma_mode =3D XFER_MW_DMA_0;
 			/* We do need the right mode information for DMA or PIO
 			   and this comes from the current configuration flags */
-			if (dma_enabled & (1 << (5 + i))) {
+			if (ata_id_has_dma(dev->id)) {
 				ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
 				dev->xfer_mode =3D XFER_MW_DMA_0;
 				dev->xfer_shift =3D ATA_SHIFT_MWDMA;
