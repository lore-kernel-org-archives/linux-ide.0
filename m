From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git pull] IDE fixes
Date: Wed, 10 Sep 2008 22:47:20 +0200
Message-ID: <200809102247.21172.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:34868 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbYIJUud (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 16:50:33 -0400
Received: by wx-out-0506.google.com with SMTP id h27so20216wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 10 Sep 2008 13:50:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

Hopefully the last pull request before 2.6.27-final:

* Fixes hpt366 crash with HPT374 controllers
  (Masoud Sharbiani and Sergei Shtylyov).

* Adds ide-scsi to feature-removal-schedule.txt,
  which I forgot to do while deprecating the driver
  (FUJITA Tomonori).

BTW I'll be leaving for KS+LPC on Saturday's morning
so I may be a bit unresponsive for a while (preparations,
travelling and a "time zone change syndrome").


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 Documentation/feature-removal-schedule.txt |    8 +++++++
 drivers/ide/pci/hpt366.c                   |   31 +++++++++++++--------------
 2 files changed, 23 insertions(+), 16 deletions(-)


FUJITA Tomonori (1):
      add deprecated ide-scsi to feature-removal-schedule.txt

Masoud Sharbiani (1):
      ide: Fix pointer arithmetic in hpt3xx driver code (3rd try)


diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index eb1a47b..83c88ca 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -322,3 +322,11 @@ Why:  Accounting can now be enabled/disabled without kernel recompilation.
       controlled by a kernel/module/sysfs/sysctl parameter.
 Who:  Krzysztof Piotr Oledzki <ole@ans.pl>
 
+---------------------------
+
+What: ide-scsi (BLK_DEV_IDESCSI)
+When: 2.6.29
+Why:  The 2.6 kernel supports direct writing to ide CD drives, which
+      eliminates the need for ide-scsi. The new method is more
+      efficient in every way.
+Who:  FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index eb107ee..c37ab17 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -613,6 +613,14 @@ static int check_in_drive_list(ide_drive_t *drive, const char **list)
 	return 0;
 }
 
+static struct hpt_info *hpt3xx_get_info(struct device *dev)
+{
+	struct ide_host *host	= dev_get_drvdata(dev);
+	struct hpt_info *info	= (struct hpt_info *)host->host_priv;
+
+	return dev == host->dev[1] ? info + 1 : info;
+}
+
 /*
  * The Marvell bridge chips used on the HighPoint SATA cards do not seem
  * to support the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes...
@@ -621,9 +629,7 @@ static int check_in_drive_list(ide_drive_t *drive, const char **list)
 static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	u8 mask 		= hwif->ultra_mask;
 
 	switch (info->chip_type) {
@@ -662,9 +668,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 
 	switch (info->chip_type) {
 	case HPT372 :
@@ -700,8 +704,7 @@ static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	struct hpt_timings *t	= info->timings;
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
 	u32 old_itr		= 0;
@@ -744,8 +747,7 @@ static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev	*dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 
 	if (drive->quirk_list) {
 		if (info->chip_type >= HPT370) {
@@ -973,8 +975,7 @@ static int __devinit hpt37x_calibrate_dpll(struct pci_dev *dev, u16 f_low, u16 f
 static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev)
 {
 	unsigned long io_base	= pci_resource_start(dev, 4);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (&dev->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(&dev->dev);
 	const char *name	= DRV_NAME;
 	u8 pci_clk,  dpll_clk	= 0;	/* PCI and DPLL clock in MHz */
 	u8 chip_type;
@@ -1217,8 +1218,7 @@ static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev)
 static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
 {
 	struct pci_dev	*dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	u8 chip_type		= info->chip_type;
 	u8 scr1 = 0, ata66	= hwif->channel ? 0x01 : 0x02;
 
@@ -1262,8 +1262,7 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
+	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	int serialize		= HPT_SERIALIZE_IO;
 	u8  chip_type		= info->chip_type;
 	u8  new_mcr, old_mcr	= 0;
