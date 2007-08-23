From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: implement IOCFG bit18 quirk
Date: Thu, 23 Aug 2007 10:15:18 +0900
Message-ID: <20070823011518.GD2909@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:4873 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXHWBP1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 21:15:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so264065rvb
        for <linux-ide@vger.kernel.org>; Wed, 22 Aug 2007 18:15:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, dangelis@beta-cae.gr

Some notebooks need bit18 of IOCFG to be cleared for the drive bay to
work even though the bit is NOOP according to the datasheet.  This
patch implement IOCFG bit18 quirk and apply it to Clevo M570U.

  http://bugzilla.kernel.org/show_bug.cgi?id=8051

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: D. Angelis <dangelis@beta-cae.gr>
---
 drivers/ata/ata_piix.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a78832e..15ec19b 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1132,6 +1132,39 @@ static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 	hpriv->map = map;
 }
 
+static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
+{
+	static struct dmi_system_id sysids[] = {
+		{
+			/* Clevo M570U sets IOCFG bit 18 if the cdrom
+			 * isn't used to boot the system which
+			 * disables the channel.
+			 */
+			.ident = "M570U",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Clevo Co."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "M570U"),
+			},
+		},
+	};
+	u32 iocfg;
+
+	if (!dmi_check_system(sysids))
+		return;
+
+	/* The datasheet says that bit 18 is NOOP but certain systems
+	 * seem to use it to disable a channel.  Clear the bit on the
+	 * affected systems.
+	 */
+	pci_read_config_dword(pdev, PIIX_IOCFG, &iocfg);
+	if (iocfg & (1 << 18)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "applying IOCFG bit18 quirk\n");
+		iocfg &= ~(1 << 18);
+		pci_write_config_dword(pdev, PIIX_IOCFG, iocfg);
+	}
+}
+
 /**
  *	piix_init_one - Register PIIX ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -1193,6 +1226,9 @@ static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			      piix_map_db_table[ent->driver_data]);
 	}
 
+	/* apply IOCFG bit18 quirk */
+	piix_iocfg_bit18_quirk(pdev);
+
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
 	 * On ICH6, this bit has the same effect, but only when
