From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Add a global ide=off switch for drivers/ide
Date: Mon, 15 Oct 2007 12:43:48 +0200
Message-ID: <200710151243.48577.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:59052 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758870AbXJOKny (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 06:43:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com


Had a situation where drivers/ide was compiled in, but I wanted to turn 
it off to let the drivers/ata drivers take over. I ended up using ide*=noprobe,
but that was somewhat clumpsy because I wasn't sure how many IDE interfaces
the machine really had.

Add a global ide=off switch to handle this situation better.

The patch is a little bigger because I tried to cover all modules.

I'm also not 100% sure ENODEV is the right error return for this 
case, but I didn't come up with a better one.

The ARM/MIPS part is uncompiled.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rc8-misc/drivers/ide/ide.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide.c
@@ -91,6 +91,9 @@ static const u8 ide_hwif_to_major[] = { 
 static int idebus_parameter;	/* holds the "idebus=" parameter */
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 
+int ide_off;
+EXPORT_SYMBOL(ide_off);
+
 DEFINE_MUTEX(ide_cfg_mtx);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
 
@@ -1249,6 +1252,13 @@ static int __init ide_setup(char *s)
 		return 0;
 
 	printk(KERN_INFO "ide_setup: %s", s);
+
+	if (!strcmp(s, "ide=off")) {
+		printk(" : IDE disabled\n");
+		ide_off = 1;
+		return 1;
+	}
+
 	init_ide_data ();
 
 #ifdef CONFIG_BLK_DEV_IDEDOUBLER
@@ -1717,6 +1727,9 @@ static int __init ide_init(void)
 {
 	int ret;
 
+	if (ide_off)
+		return -ENODEV;
+
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	system_bus_speed = ide_system_bus_speed();
 
Index: linux-2.6.23-rc8-misc/drivers/ide/setup-pci.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/setup-pci.c
+++ linux-2.6.23-rc8-misc/drivers/ide/setup-pci.c
@@ -793,6 +793,8 @@ static LIST_HEAD(ide_pci_drivers);
 int __ide_pci_register_driver(struct pci_driver *driver, struct module *module,
 			      const char *mod_name)
 {
+	if (ide_off)
+		return -ENODEV;
 	if(!pre_init)
 		return __pci_register_driver(driver, module, mod_name);
 	driver->driver.owner = module;
Index: linux-2.6.23-rc8-misc/include/linux/ide.h
===================================================================
--- linux-2.6.23-rc8-misc.orig/include/linux/ide.h
+++ linux-2.6.23-rc8-misc/include/linux/ide.h
@@ -871,6 +871,8 @@ typedef struct ide_driver_s ide_driver_t
 
 extern struct mutex ide_setting_mtx;
 
+extern int ide_off;
+
 int set_io_32bit(ide_drive_t *, int);
 int set_pio_mode(ide_drive_t *, int);
 int set_using_dma(ide_drive_t *, int);
Index: linux-2.6.23-rc8-misc/drivers/ide/arm/bast-ide.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/arm/bast-ide.c
+++ linux-2.6.23-rc8-misc/drivers/ide/arm/bast-ide.c
@@ -52,6 +52,9 @@ bastide_register(unsigned int base, unsi
 
 static int __init bastide_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
+
 	/* we can treat the VR1000 and the BAST the same */
 
 	if (!(machine_is_bast() || machine_is_vr1000()))
Index: linux-2.6.23-rc8-misc/drivers/ide/arm/icside.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/arm/icside.c
+++ linux-2.6.23-rc8-misc/drivers/ide/arm/icside.c
@@ -824,6 +824,8 @@ static struct ecard_driver icside_driver
 
 static int __init icside_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	return ecard_register_driver(&icside_driver);
 }
 
Index: linux-2.6.23-rc8-misc/drivers/ide/arm/rapide.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/arm/rapide.c
+++ linux-2.6.23-rc8-misc/drivers/ide/arm/rapide.c
@@ -113,6 +113,8 @@ static struct ecard_driver rapide_driver
 
 static int __init rapide_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	return ecard_register_driver(&rapide_driver);
 }
 
Index: linux-2.6.23-rc8-misc/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide-cd.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide-cd.c
@@ -3568,6 +3568,8 @@ static void __exit ide_cdrom_exit(void)
 
 static int __init ide_cdrom_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	return driver_register(&ide_cdrom_driver.gen_driver);
 }
 
Index: linux-2.6.23-rc8-misc/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide-disk.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide-disk.c
@@ -1329,6 +1329,8 @@ static void __exit idedisk_exit (void)
 
 static int __init idedisk_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	return driver_register(&idedisk_driver.gen_driver);
 }
 
Index: linux-2.6.23-rc8-misc/drivers/ide/ide-floppy.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide-floppy.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide-floppy.c
@@ -2215,6 +2215,8 @@ static void __exit idefloppy_exit (void)
 
 static int __init idefloppy_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
 	return driver_register(&idefloppy_driver.gen_driver);
 }
Index: linux-2.6.23-rc8-misc/drivers/ide/ide-generic.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide-generic.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide-generic.c
@@ -14,6 +14,8 @@
 
 static int __init ide_generic_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_get_lock(NULL, NULL); /* for atari only */
 
Index: linux-2.6.23-rc8-misc/drivers/ide/ide-tape.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/ide-tape.c
+++ linux-2.6.23-rc8-misc/drivers/ide/ide-tape.c
@@ -4914,6 +4914,8 @@ static void __exit idetape_exit (void)
 static int __init idetape_init(void)
 {
 	int error = 1;
+	if (ide_off)
+		return -ENODEV;
 	idetape_sysfs_class = class_create(THIS_MODULE, "ide_tape");
 	if (IS_ERR(idetape_sysfs_class)) {
 		idetape_sysfs_class = NULL;
Index: linux-2.6.23-rc8-misc/drivers/ide/legacy/ali14xx.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/legacy/ali14xx.c
+++ linux-2.6.23-rc8-misc/drivers/ide/legacy/ali14xx.c
@@ -238,7 +238,7 @@ MODULE_PARM_DESC(probe, "probe for ALI M
 /* Can be called directly from ide.c. */
 int __init ali14xx_init(void)
 {
-	if (probe_ali14xx == 0)
+	if (probe_ali14xx == 0 || ide_off)
 		goto out;
 
 	/* auto-detect IDE controller port */
Index: linux-2.6.23-rc8-misc/drivers/ide/legacy/dtc2278.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/legacy/dtc2278.c
+++ linux-2.6.23-rc8-misc/drivers/ide/legacy/dtc2278.c
@@ -153,7 +153,7 @@ MODULE_PARM_DESC(probe, "probe for DTC22
 /* Can be called directly from ide.c. */
 int __init dtc2278_init(void)
 {
-	if (probe_dtc2278 == 0)
+	if (probe_dtc2278 == 0 || ide_off)
 		return -ENODEV;
 
 	if (dtc2278_probe()) {
Index: linux-2.6.23-rc8-misc/drivers/ide/legacy/ht6560b.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/legacy/ht6560b.c
+++ linux-2.6.23-rc8-misc/drivers/ide/legacy/ht6560b.c
@@ -314,7 +314,7 @@ int __init ht6560b_init(void)
 	ide_hwif_t *hwif, *mate;
 	int t;
 
-	if (probe_ht6560b == 0)
+	if (probe_ht6560b == 0 || ide_off)
 		return -ENODEV;
 
 	hwif = &ide_hwifs[0];
Index: linux-2.6.23-rc8-misc/drivers/ide/legacy/qd65xx.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/legacy/qd65xx.c
+++ linux-2.6.23-rc8-misc/drivers/ide/legacy/qd65xx.c
@@ -497,7 +497,7 @@ MODULE_PARM_DESC(probe, "probe for QD65x
 /* Can be called directly from ide.c. */
 int __init qd65xx_init(void)
 {
-	if (probe_qd65xx == 0)
+	if (probe_qd65xx == 0 || ide_off)
 		return -ENODEV;
 
 	if (qd_probe(0x30))
Index: linux-2.6.23-rc8-misc/drivers/ide/legacy/umc8672.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/legacy/umc8672.c
+++ linux-2.6.23-rc8-misc/drivers/ide/legacy/umc8672.c
@@ -176,7 +176,7 @@ MODULE_PARM_DESC(probe, "probe for UMC86
 /* Can be called directly from ide.c. */
 int __init umc8672_init(void)
 {
-	if (probe_umc8672 == 0)
+	if (probe_umc8672 == 0 || ide_off)
 		goto out;
 
 	if (umc8672_probe() == 0)
Index: linux-2.6.23-rc8-misc/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6.23-rc8-misc/drivers/ide/mips/au1xxx-ide.c
@@ -793,6 +793,8 @@ static struct device_driver au1200_ide_d
 
 static int __init au_ide_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	return driver_register(&au1200_ide_driver);
 }
 
Index: linux-2.6.23-rc8-misc/drivers/ide/mips/swarm.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/mips/swarm.c
+++ linux-2.6.23-rc8-misc/drivers/ide/mips/swarm.c
@@ -157,6 +157,8 @@ static int __devinit swarm_ide_init_modu
 	struct platform_device *pldev;
 	int err;
 
+	if (ide_off)
+		return -ENODEV;
 	printk(KERN_INFO "SWARM IDE driver\n");
 
 	if (driver_register(&swarm_ide_driver)) {
Index: linux-2.6.23-rc8-misc/drivers/ide/pci/piix.c
===================================================================
--- linux-2.6.23-rc8-misc.orig/drivers/ide/pci/piix.c
+++ linux-2.6.23-rc8-misc/drivers/ide/pci/piix.c
@@ -629,6 +629,8 @@ static struct pci_driver driver = {
 
 static int __init piix_ide_init(void)
 {
+	if (ide_off)
+		return -ENODEV;
 	piix_check_450nx();
 	return ide_pci_register_driver(&driver);
 }
Index: linux-2.6.23-rc8-misc/Documentation/ide.txt
===================================================================
--- linux-2.6.23-rc8-misc.orig/Documentation/ide.txt
+++ linux-2.6.23-rc8-misc/Documentation/ide.txt
@@ -290,6 +290,8 @@ Summary of ide driver parameters for ker
 
  "ide=nodma"		: disable DMA globally for the IDE subsystem.
 
+ "ide=off"		: Disable the IDE subsystem completely
+
 The following are valid ONLY on ide0, which usually corresponds
 to the first ATA interface found on the particular host, and the defaults for
 the base,ctl ports must not be altered.
