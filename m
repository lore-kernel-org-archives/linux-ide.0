From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc9] ATA/IDE: fix platform driver hotplug/coldplug
Date: Sun, 13 Apr 2008 10:11:13 -0700
Message-ID: <200804131011.13404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:28725 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751590AbYDMR3r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 13:29:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org
Cc: kay.sievers@vrfy.org

From: Kay Sievers <kay.sievers@vrfy.org>

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
hotpluggable ATA and IDE platform drivers, to re-enable auto loading.

NOTE:  both ata/pata_platform.c and ide/legacy/ide_platform.c claim
to provide "the" platform_pata driver, and there's no build-time
mutual exclusion mechanism.  This means that configs which enable
both drivers will make some trouble when hotplugging...

[ dbrownell@users.sourceforge.net: more drivers, registration fixes ]
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/ata/pata_at32.c           |    3 +++
 drivers/ata/pata_bf54x.c          |    1 +
 drivers/ata/pata_ixp4xx_cf.c      |    1 +
 drivers/ata/pata_platform.c       |    1 +
 drivers/ata/pata_rb500_cf.c       |    3 +++
 drivers/ata/sata_mv.c             |    2 +-
 drivers/ide/arm/palm_bk3710.c     |    4 ++++
 drivers/ide/legacy/ide_platform.c |    2 ++
 8 files changed, 16 insertions(+), 1 deletion(-)

--- g26.orig/drivers/ata/pata_at32.c	2008-04-13 09:11:53.000000000 -0700
+++ g26/drivers/ata/pata_at32.c	2008-04-13 09:12:20.000000000 -0700
@@ -419,6 +419,9 @@ static int __exit pata_at32_remove(struc
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:at32_ide");
+
 static struct platform_driver pata_at32_driver = {
 	.remove	       = __exit_p(pata_at32_remove),
 	.driver	       = {
--- g26.orig/drivers/ata/pata_bf54x.c	2008-04-13 09:12:10.000000000 -0700
+++ g26/drivers/ata/pata_bf54x.c	2008-04-13 09:12:20.000000000 -0700
@@ -1630,3 +1630,4 @@ MODULE_AUTHOR("Sonic Zhang <sonic.zhang@
 MODULE_DESCRIPTION("PATA driver for blackfin 54x ATAPI controller");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
--- g26.orig/drivers/ata/pata_ixp4xx_cf.c	2008-04-13 09:12:10.000000000 -0700
+++ g26/drivers/ata/pata_ixp4xx_cf.c	2008-04-13 09:12:20.000000000 -0700
@@ -255,6 +255,7 @@ MODULE_AUTHOR("Alessandro Zummo <a.zummo
 MODULE_DESCRIPTION("low-level driver for ixp4xx Compact Flash PATA");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
 
 module_init(ixp4xx_pata_init);
 module_exit(ixp4xx_pata_exit);
--- g26.orig/drivers/ata/pata_platform.c	2008-04-13 09:12:10.000000000 -0700
+++ g26/drivers/ata/pata_platform.c	2008-04-13 09:12:20.000000000 -0700
@@ -311,3 +311,4 @@ MODULE_AUTHOR("Paul Mundt");
 MODULE_DESCRIPTION("low-level driver for platform device ATA");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
--- g26.orig/drivers/ata/pata_rb500_cf.c	2008-04-13 09:11:53.000000000 -0700
+++ g26/drivers/ata/pata_rb500_cf.c	2008-04-13 09:12:20.000000000 -0700
@@ -279,6 +279,9 @@ static __devexit int rb500_pata_driver_r
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" DRV_NAME);
+
 static struct platform_driver rb500_pata_platform_driver = {
 	.probe		= rb500_pata_driver_probe,
 	.remove		= __devexit_p(rb500_pata_driver_remove),
--- g26.orig/drivers/ata/sata_mv.c	2008-04-13 09:11:53.000000000 -0700
+++ g26/drivers/ata/sata_mv.c	2008-04-13 09:12:20.000000000 -0700
@@ -3192,7 +3192,7 @@ MODULE_DESCRIPTION("SCSI low-level drive
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
-MODULE_ALIAS("platform:sata_mv");
+MODULE_ALIAS("platform:" DRV_NAME);
 
 #ifdef CONFIG_PCI
 module_param(msi, int, 0444);
--- g26.orig/drivers/ide/arm/palm_bk3710.c	2008-04-13 09:11:53.000000000 -0700
+++ g26/drivers/ide/arm/palm_bk3710.c	2008-04-13 09:12:20.000000000 -0700
@@ -409,9 +409,13 @@ out:
 	return -ENODEV;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:palm_bk3710");
+
 static struct platform_driver platform_bk_driver = {
 	.driver = {
 		.name = "palm_bk3710",
+		.owner = THIS_MODULE,
 	},
 	.probe = palm_bk3710_probe,
 	.remove = NULL,
--- g26.orig/drivers/ide/legacy/ide_platform.c	2008-04-13 09:12:10.000000000 -0700
+++ g26/drivers/ide/legacy/ide_platform.c	2008-04-13 09:12:20.000000000 -0700
@@ -130,6 +130,7 @@ static int __devexit plat_ide_remove(str
 static struct platform_driver platform_ide_driver = {
 	.driver = {
 		.name = "pata_platform",
+		.owner = THIS_MODULE,
 	},
 	.probe = plat_ide_probe,
 	.remove = __devexit_p(plat_ide_remove),
@@ -147,6 +148,7 @@ static void __exit platform_ide_exit(voi
 
 MODULE_DESCRIPTION("Platform IDE driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pata_platform");
 
 module_init(platform_ide_init);
 module_exit(platform_ide_exit);
