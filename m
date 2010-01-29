From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/68] ata_piix: factor out short cable detection code to ich_short_ata40()
Date: Fri, 29 Jan 2010 17:04:08 +0100
Message-ID: <20100129160408.21495.10059.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53041 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab0A2QEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:04:16 -0500
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ata_piix: factor out short cable detection code to ich_short_ata40()

Fix up ich_pata_cable_detect() documentation while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/ata_piix.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

Index: b/drivers/ata/ata_piix.c
===================================================================
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -611,6 +611,21 @@ static const struct ich_laptop ich_lapto
 	{ 0, }
 };
 
+static int ich_short_ata40(struct pci_dev *pdev)
+{
+	const struct ich_laptop *lap = &ich_laptop[0];
+
+	while (lap->device) {
+		if (lap->device == pdev->device &&
+		    lap->subvendor == pdev->subsystem_vendor &&
+		    lap->subdevice == pdev->subsystem_device)
+			return 1;
+		lap++;
+	}
+
+	return 0;
+}
+
 /**
  *	ich_pata_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -626,18 +641,11 @@ static int ich_pata_cable_detect(struct
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct piix_host_priv *hpriv = ap->host->private_data;
-	const struct ich_laptop *lap = &ich_laptop[0];
 	u8 mask;
 
-	/* Check for specials - Acer Aspire 5602WLMi */
-	while (lap->device) {
-		if (lap->device == pdev->device &&
-		    lap->subvendor == pdev->subsystem_vendor &&
-		    lap->subdevice == pdev->subsystem_device)
-			return ATA_CBL_PATA40_SHORT;
-
-		lap++;
-	}
+	/* check for specials */
+	if (ich_short_ata40(pdev))
+		return ATA_CBL_PATA40_SHORT;
 
 	/* check BIOS cable detect results */
 	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
