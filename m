From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/14] cmd640: add ->init_dev method
Date: Tue, 10 Jun 2008 22:51:19 +0200
Message-ID: <20080610205119.18469.44635.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409AbYFJUto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:49:44 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:49:42 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use ->init_dev method instead of open-coding devices
init in cmd640x_init().

While at it:

- fix printk()-s to use KERN_INFO level instead of the default KERN_ERR

- use DRV_NAME define in printk()-s

- set proper ->pio_mask also for CONFIG_BLK_DEV_CMD640_ENHANCED=n

There should be no functional changes caused by this patch
(except fixing printk()-s levels).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd640.c |   72 +++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -611,11 +611,40 @@ static void cmd640_set_pio_mode(ide_driv
 
 	display_clocks(index);
 }
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+static void cmd640_init_dev(ide_drive_t *drive)
+{
+	unsigned int i = drive->hwif->channel * 2 + drive->select.b.unit;
+
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+	/*
+	 * Reset timing to the slowest speed and turn off prefetch.
+	 * This way, the drive identify code has a better chance.
+	 */
+	setup_counts[i]    =  4;	/* max possible */
+	active_counts[i]   = 16;	/* max possible */
+	recovery_counts[i] = 16;	/* max possible */
+	program_drive_counts(drive, i);
+	set_prefetch_mode(drive, i, 0);
+	printk(KERN_INFO DRV_NAME ": drive%d timings/prefetch cleared\n", i);
+#else
+	/*
+	 * Set the drive unmask flags to match the prefetch setting.
+	 */
+	check_prefetch(drive, i);
+	printk(KERN_INFO DRV_NAME ": drive%d timings/prefetch(%s) preserved\n",
+				  i, drive->no_io_32bit ? "off" : "on");
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+}
+
 
 static const struct ide_port_ops cmd640_port_ops = {
+	.init_dev		= cmd640_init_dev,
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	.set_pio_mode		= cmd640_set_pio_mode,
+#endif
 };
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 
 static int pci_conf1(void)
 {
@@ -658,10 +687,8 @@ static const struct ide_port_info cmd640
 				  IDE_HFLAG_NO_DMA |
 				  IDE_HFLAG_ABUSE_PREFETCH |
 				  IDE_HFLAG_ABUSE_FAST_DEVSEL,
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	.port_ops		= &cmd640_port_ops,
 	.pio_mask		= ATA_PIO5,
-#endif
 };
 
 static int cmd640x_init_one(unsigned long base, unsigned long ctl)
@@ -689,7 +716,6 @@ static int __init cmd640x_init(void)
 {
 	int second_port_cmd640 = 0, rc;
 	const char *bus_type, *port2;
-	unsigned int index;
 	u8 b, cfr;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	hw_regs_t hw[2];
@@ -813,44 +839,6 @@ static int __init cmd640x_init(void)
 	printk(KERN_INFO "cmd640: %sserialized, secondary interface %s\n",
 			 second_port_cmd640 ? "" : "not ", port2);
 
-	/*
-	 * Establish initial timings/prefetch for all drives.
-	 * Do not unnecessarily disturb any prior BIOS setup of these.
-	 */
-	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
-		ide_drive_t *drive;
-
-		if (index > 1) {
-			if (cmd_hwif1 == NULL)
-				continue;
-			drive = &cmd_hwif1->drives[index & 1];
-		} else  {
-			if (cmd_hwif0 == NULL)
-				continue;
-			drive = &cmd_hwif0->drives[index & 1];
-		}
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		/*
-		 * Reset timing to the slowest speed and turn off prefetch.
-		 * This way, the drive identify code has a better chance.
-		 */
-		setup_counts    [index] = 4;	/* max possible */
-		active_counts   [index] = 16;	/* max possible */
-		recovery_counts [index] = 16;	/* max possible */
-		program_drive_counts(drive, index);
-		set_prefetch_mode(drive, index, 0);
-		printk("cmd640: drive%d timings/prefetch cleared\n", index);
-#else
-		/*
-		 * Set the drive unmask flags to match the prefetch setting
-		 */
-		check_prefetch(drive, index);
-		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
-			index, drive->no_io_32bit ? "off" : "on");
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-	}
-
 #ifdef CMD640_DUMP_REGS
 	cmd640_dump_regs();
 #endif
