From: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [PATCH]: [RFC] Fix error handlnig in hwif-init and sgiioc4 driver
Date: Tue, 08 Feb 2005 10:53:56 -0500
Message-ID: <4208E094.1020403@sgi.com>
References: <41F79A30.4040900@sgi.com> <58cb370e050203064648e81449@mail.gmail.com> <4208C84D.1050104@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030808050503010402070400"
Received: from mx1.redhat.com ([66.187.233.31]:6794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261548AbVBHPyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 10:54:43 -0500
In-Reply-To: <4208C84D.1050104@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808050503010402070400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej pointed out that the sgiioc4.c changes have made their way 
into Linus' tree.

Here's an updated change set.

Thanks,

P.

--------------030808050503010402070400
Content-Type: text/plain;
 name="acpi-ide3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-ide3.patch"

Signed-off-by: Prarit Bhargava <prarit@sgi.com>

===== ide-probe.c 1.90 vs edited =====
--- 1.90/drivers/ide/ide-probe.c	2004-12-10 14:12:14 -05:00
+++ edited/ide-probe.c	2005-02-08 10:41:46 -05:00
@@ -841,7 +841,10 @@
 	if (fixup)
 		fixup(hwif);
 
-	hwif_init(hwif);
+	if (hwif_init(hwif) < 0) {
+		printk("%s: Failed to initialize IDE interface\n", hwif->name);
+		return -1;
+	}
 
 	if (hwif->present) {
 		u16 unit = 0;
@@ -1245,20 +1248,22 @@
 	int old_irq, unit;
 
 	if (!hwif->present)
-		return 0;
+		return -ENODEV;
 
 	if (!hwif->irq) {
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
 		{
 			printk("%s: DISABLED, NO IRQ\n", hwif->name);
-			return (hwif->present = 0);
+			hwif->present = 0;
+			return -EIO;
 		}
 	}
 #ifdef CONFIG_BLK_DEV_HD
 	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD "
 			"HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return (hwif->present = 0);
+		hwif->present = 0;
+		return -EIO;
 	}
 #endif /* CONFIG_BLK_DEV_HD */
 
@@ -1266,7 +1271,7 @@
 	hwif->present = 0;
 
 	if (register_blkdev(hwif->major, hwif->name))
-		return 0;
+		return -EIO;
 
 	if (!hwif->sg_max_nents)
 		hwif->sg_max_nents = PRD_ENTRIES;
@@ -1305,7 +1310,7 @@
 done:
 	init_gendisk(hwif);
 	hwif->present = 1;	/* success */
-	return 1;
+	return 0;
 
 out_disks:
 	for (unit = 0; unit < MAX_DRIVES; unit++) {
@@ -1315,7 +1320,7 @@
 	}
 out:
 	unregister_blkdev(hwif->major, hwif->name);
-	return 0;
+	return -EIO;
 }
 
 int ideprobe_init (void)

--------------030808050503010402070400--
