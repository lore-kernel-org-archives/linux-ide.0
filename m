From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] pata_via: disable ATAPI DMA on AVERATEC 3200
Date: Thu, 4 Aug 2011 11:15:07 +0200
Message-ID: <20110804091507.GB25100@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42912 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1HDJPM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2011 05:15:12 -0400
Received: by fxh19 with SMTP id 19so1547726fxh.19
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2011 02:15:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Jim Bray <jimsantelmo@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On AVERATEC 3200, pata_via causes memory corruption with ATAPI DMA,
which often leads to random kernel oops.  The cause of the problem is
not well understood yet and only small subset of machines using the
controller seem affected.  Blacklist ATAPI DMA on the machine.

Signed-off-by: Tejun Heo <tj@kernel.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=11426
Reported-and-tested-by: Jim Bray <jimsantelmo@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/ata/pata_via.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 65e4be6..8e9f504 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -124,6 +124,17 @@ static const struct via_isa_bridge {
 	{ NULL }
 };
 
+static const struct dmi_system_id no_atapi_dma_dmi_table[] = {
+	{
+		.ident = "AVERATEC 3200",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AVERATEC"),
+			DMI_MATCH(DMI_BOARD_NAME, "3200"),
+		},
+	},
+	{ }
+};
+
 struct via_port {
 	u8 cached_device;
 };
@@ -355,6 +366,13 @@ static unsigned long via_mode_filter(struct ata_device *dev, unsigned long mask)
 			mask &= ~ ATA_MASK_UDMA;
 		}
 	}
+
+	if (dev->class == ATA_DEV_ATAPI &&
+	    dmi_check_system(no_atapi_dma_dmi_table)) {
+		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
+		mask &= ATA_MASK_PIO;
+	}
+
 	return mask;
 }
 
