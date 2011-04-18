From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 2/2] pata_cmd64x: fix crash on boot with disabled secondary
 port
Date: Mon, 18 Apr 2011 13:45:23 -0500
Message-ID: <1303152323.7167.16.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45052 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472Ab1DRSpZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 14:45:25 -0400
In-Reply-To: <1303152147.7167.12.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>

On non-x86 systems, probing a port which is listed as disabled can
cause an immediate crash.  Fix the driver not to do this by porting
the enablebits check from the IDE driver and setting the
ATA_HOST_SFF_SINGLE_PORT flag if only the primary is enabled.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/ata/pata_cmd64x.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 905ff76..aa71a13 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -41,6 +41,9 @@
 enum {
 	CFR 		= 0x50,
 		CFR_INTR_CH0  = 0x04,
+	ENPORT		= 0x51,
+		ENPORT_PRIMARY   = 0x04,
+		ENPORT_SECONDARY = 0x08,
 	CMDTIM 		= 0x52,
 	ARTTIM0 	= 0x53,
 	DRWTIM0 	= 0x54,
@@ -329,8 +332,8 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	};
 	const struct ata_port_info *ppi[] = { &cmd_info[id->driver_data], NULL };
-	u8 mrdmode;
-	int rc;
+	u8 mrdmode, reg;
+	int rc, hflags = 0;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -354,6 +357,19 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mrdmode |= 0x02;	/* Memory read line enable */
 	pci_write_config_byte(pdev, MRDMODE, mrdmode);
 
+	/* check for enabled ports */
+	pci_read_config_byte(pdev, ENPORT, &reg);
+	/* the cm643 primary port is always enabled */
+	if (id->driver_data != 0 && !(reg & ENPORT_PRIMARY)) {
+		dev_printk(KERN_ERR, &pdev->dev, "Primary port is disabled; detaching\n");
+		return -ENODEV;
+		
+	}
+	if (!(reg & ENPORT_SECONDARY)) {
+		dev_printk(KERN_NOTICE, &pdev->dev, "Secondary port is disabled\n");
+		hflags |= ATA_HOST_SFF_SINGLE_PORT;
+	}
+
 	/* Force PIO 0 here.. */
 
 	/* PPC specific fixup copied from old driver */
@@ -361,7 +377,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
 
-	return ata_pci_bmdma_init_one(pdev, ppi, &cmd64x_sht, NULL, 0);
+	return ata_pci_bmdma_init_one(pdev, ppi, &cmd64x_sht, NULL, hflags);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.4.1



