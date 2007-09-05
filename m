From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: add Arima W730-K8 and other rebadgings to short cables list
Date: Wed, 5 Sep 2007 22:42:57 +0200
Message-ID: <200709052242.57591.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:21791 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906AbXIEUlf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 16:41:35 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1814038nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 13:41:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>


Port of Alan's patch for pata_via.c.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/via82cxxx.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.46
+ * Version 3.47
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -429,19 +429,26 @@ static struct dmi_system_id cable_dmi_ta
 	{ }
 };
 
-static int via_cable_override(void)
+static int via_cable_override(struct pci_dev *pdev)
 {
 	/* Systems by DMI */
 	if (dmi_check_system(cable_dmi_table))
 		return 1;
+
+	/* Arima W730-K8/Targa Visionary 811/... */
+	if (pdev->subsystem_vendor == 0x161F &&
+	    pdev->subsystem_device == 0x2032)
+		return 1;
+
 	return 0;
 }
 
 static u8 __devinit via82cxxx_cable_detect(ide_hwif_t *hwif)
 {
-	struct via82cxxx_dev *vdev = pci_get_drvdata(hwif->pci_dev);
+	struct pci_dev *pdev = hwif->pci_dev;
+	struct via82cxxx_dev *vdev = pci_get_drvdata(pdev);
 
-	if (via_cable_override())
+	if (via_cable_override(pdev))
 		return ATA_CBL_PATA40_SHORT;
 
 	if ((vdev->via_80w >> hwif->channel) & 1)
