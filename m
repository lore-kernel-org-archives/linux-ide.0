From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_it821x: Update RDC UDMA handling
Date: Sun, 11 Jan 2009 19:51:08 +0000
Message-ID: <20090111195052.16272.22844.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52109 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752375AbZAKTuz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 14:50:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

The UDMA affliction is apparently specific to revision 0x11. Keeps us in sync
with drivers/ide current.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_it821x.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)


diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index f828a29..f1bb2f9 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -80,7 +80,7 @@
 
 
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.4.0"
+#define DRV_VERSION "0.4.2"
 
 struct it821x_dev
 {
@@ -494,8 +494,6 @@ static int it821x_smart_set_mode(struct ata_link *link, struct ata_device **unus
  *	special. In our case we need to lock the sector count to avoid
  *	blowing the brains out of the firmware with large LBA48 requests
  *
- *	FIXME: When FUA appears we need to block FUA too. And SMART and
- *	basically we need to filter commands for this chip.
  */
 
 static void it821x_dev_config(struct ata_device *adev)
@@ -890,6 +888,13 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &it821x_rdc_port_ops
+	};
+	static const struct ata_port_info info_rdc_11 = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
 		/* No UDMA */
 		.port_ops = &it821x_rdc_port_ops
 	};
@@ -903,7 +908,11 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 		
 	if (pdev->vendor == PCI_VENDOR_ID_RDC) {
-		ppi[0] = &info_rdc;
+		/* Deal with Vortex86SX */
+		if (pdev->revision == 0x11)
+			ppi[0] = &info_rdc_11;
+		else
+			ppi[0] = &info_rdc;
 	} else {
 		/* Force the card into bypass mode if so requested */
 		if (it8212_noraid) {

