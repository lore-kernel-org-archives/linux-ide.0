From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] pata_cs5536: add quirk for broken udma
Date: Tue,  9 Oct 2012 17:53:12 +0200
Message-ID: <1349797992-32611-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39817 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab2JIPkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2012 11:40:25 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4844324wgb.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Oct 2012 08:40:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, mkp@mkp.net, jgarzik@pobox.com
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>

I am working on a device which uses the cs5536 pata driver. There
are some broken hardware revisions out in the field, which can be
detected via DMI. On older versions with an embedded BIOS I
used libata.dma=0 to disable dma completely.
Now we are switching to a coreboot/seabios based BIOS where we
have DMI support and so I think its a good idea to get rid of
all those hacky kernel parameters as the same image
is used other devices where libata.dma=0 is not a good idea.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/ata/pata_cs5536.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index dec1b6c..0448860 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <scsi/scsi_host.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86_32
 #include <asm/msr.h>
@@ -80,6 +81,21 @@ enum {
 	IDE_ETC_UDMA_MASK	= 0xc0,
 };
 
+/* Some Bachmann OT200 devices have a non working UDMA support due a
+ * missing resistor.
+ */
+static const struct dmi_system_id udma_quirk_dmi_table[] = {
+	{
+		.ident = "Bachmann electronic OT200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Bachmann electronic"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OT200"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1")
+		},
+	},
+	{ }
+};
+
 static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
 	if (unlikely(use_msr)) {
@@ -242,9 +258,23 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &cs5536_port_ops,
 	};
 
-	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
+	static const struct ata_port_info no_udma_info = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = ATA_PIO4,
+		.port_ops = &cs5536_port_ops,
+	};
+
+
+	const struct ata_port_info *ppi[2];
 	u32 cfg;
 
+	if (dmi_check_system(udma_quirk_dmi_table))
+		ppi[0] = &no_udma_info;
+	else
+		ppi[0] = &info;
+
+	ppi[1] = &ata_dummy_port_info;
+
 	if (use_msr)
 		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
 
-- 
1.7.12.2.421.g261b511

