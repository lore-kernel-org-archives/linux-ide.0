From: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [PATCH]: [RFC] Fix error handlnig in hwif-init and sgiioc4 driver
Date: Tue, 08 Feb 2005 09:10:21 -0500
Message-ID: <4208C84D.1050104@sgi.com>
References: <41F79A30.4040900@sgi.com> <58cb370e050203064648e81449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905020006040003060507"
Received: from mx1.redhat.com ([66.187.233.31]:12216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261532AbVBHOLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 09:11:12 -0500
In-Reply-To: <58cb370e050203064648e81449@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905020006040003060507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the comments Bartlomiej -- your input is always appreciated.

Here's a new patch taking into account your comments.  I have updated 
hwif_init
to return 0 on success and -errno on failure.

Thanks again,

P.

--------------060905020006040003060507
Content-Type: text/plain;
 name="acpi-ide2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-ide2.patch"

Signed-off-by: Prarit Bhargava <prarit@sgi.com>

===== ide-probe.c 1.90 vs edited =====
--- 1.90/drivers/ide/ide-probe.c	2004-12-10 14:12:14 -05:00
+++ edited/ide-probe.c	2005-02-08 08:22:37 -05:00
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

===== sgiioc4.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/sgiioc4.c	2005-01-06 20:35:35 -05:00
+++ edited/sgiioc4.c	2005-02-08 08:54:27 -05:00
@@ -669,7 +669,8 @@
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
 		       hwif->name, d->name);
 
-	probe_hwif_init(hwif);
+	if (probe_hwif_init(hwif))
+		return -EIO;
 
 	/* Create /proc/ide entries */
 	create_proc_ide_interfaces(); 

--------------060905020006040003060507--
