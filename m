From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] pata-rb532-cf: fix and rename register definitions
Date: Fri, 28 Nov 2008 20:48:26 +0100
Message-ID: <20081128194550.734FF386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:52454 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYK1Tpw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Nov 2008 14:45:52 -0500
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

The original standalone driver uses a custom address for the error
register. Use it in pata-rb532-cf, too.

Rename two register definitions:
- The address offset 0x0800 in fact is the ATA base, not ATA command
  address.
- The offset 0x0C00 is not a regular ATA data address, but a buffered one
  allowing 4-byte IO.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..392116c 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -39,9 +39,11 @@
 #define RB500_CF_MAXPORTS	1
 #define RB500_CF_IO_DELAY	400
 
-#define RB500_CF_REG_CMD	0x0800
+#define RB500_CF_REG_BASE	0x0800
+#define RB500_CF_REG_ERR	0x080D
 #define RB500_CF_REG_CTRL	0x080E
-#define RB500_CF_REG_DATA	0x0C00
+/* 32bit buffered data register offset */
+#define RB500_CF_REG_DBUF32	0x0C00
 
 struct rb532_cf_info {
 	void __iomem	*iobase;
@@ -146,13 +148,14 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 	ap->pio_mask	= 0x1f; /* PIO4 */
 	ap->flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
 
-	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_CMD;
+	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_BASE;
 	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
 	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
 
 	ata_sff_std_ports(&ap->ioaddr);
 
-	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
+	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DBUF32;
+	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
 }
 
 static __devinit int rb532_pata_driver_probe(struct platform_device *pdev)
-- 
1.5.6.4

