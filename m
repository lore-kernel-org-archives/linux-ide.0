From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/6] pata_via: Blacklist some combinations of Transcend Flash
	and via
Date: Mon, 30 Nov 2009 13:22:43 +0000
Message-ID: <20091130132243.27236.69356.stgit@localhost.localdomain>
References: <20091130132005.27236.77890.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50830 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752318AbZK3NmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 08:42:17 -0500
In-Reply-To: <20091130132005.27236.77890.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

Reported by Mikulas Patocka.

VIA VT82C586B + Transcend TS64GSSD25-M v0826 does not work in UDMA mode

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/pata_via.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)


diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 520d5a3..78eac27 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -337,6 +337,32 @@ static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
+ *	via_mode_filter		-	filter buggy device/mode pairs
+ *	@dev: ATA device
+ *	@mask: Mode bitmask
+ *
+ *	We need to apply some minimal filtering for old controllers and at least
+ *	one breed of Transcend SSD. Return the updated mask.
+ */
+
+static unsigned long via_mode_filter(struct ata_device *dev, unsigned long mask)
+{
+	struct ata_host *host = dev->link->ap->host;
+	const struct via_isa_bridge *config = host->private_data;
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+
+	if (config->id == PCI_DEVICE_ID_VIA_82C586_0) {
+		ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+		if (strcmp(model_num, "TS64GSSD25-M") == 0) {
+			ata_dev_printk(dev, KERN_WARNING,
+	"disabling UDMA mode due to reported lockups with this device.\n");
+			mask &= ~ ATA_MASK_UDMA;
+		}
+	}
+	return ata_bmdma_mode_filter(dev, mask);
+}
+
+/**
  *	via_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
@@ -427,6 +453,7 @@ static struct ata_port_operations via_port_ops = {
 	.prereset	= via_pre_reset,
 	.sff_tf_load	= via_tf_load,
 	.port_start	= via_port_start,
+	.mode_filter	= via_mode_filter,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {

