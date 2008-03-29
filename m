From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Sat, 29 Mar 2008 20:01:17 +0100
Message-ID: <200803292001.17584.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:50233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966AbYC2Srn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 14:47:43 -0400
Received: by fg-out-1718.google.com with SMTP id l27so906607fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 11:47:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-iops.c  |    1 +
 drivers/ide/ide-probe.c |    5 +++--
 include/linux/ide.h     |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)


Bartlomiej Zolnierkiewicz (2):
      Revert "ide: change master/slave IDENTIFY order"
      ide: fix defining SUPPORT_VLB_SYNC


diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index c419266..01b9220 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -595,6 +595,7 @@ u8 eighty_ninty_three (ide_drive_t *drive)
 
 	/*
 	 * FIXME:
+	 * - change master/slave IDENTIFY order
 	 * - force bit13 (80c cable present) check also for !ivb devices
 	 *   (unless the slave device is pre-ATA3)
 	 */
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 194ecb0..47a1149 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -774,9 +774,10 @@ static int ide_probe_port(ide_hwif_t *hwif)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
-	 * Need to probe slave device first to make it release PDIAG-.
+	 * Second drive should only exist if first drive was found,
+	 * but a lot of cdrom drives are configured as single slaves.
 	 */
-	for (unit = MAX_DRIVES - 1; unit >= 0; unit--) {
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a3b69c1..bc26b2f 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -26,7 +26,7 @@
 #include <asm/semaphore.h>
 #include <asm/mutex.h>
 
-#if defined(CRIS) || defined(FRV)
+#if defined(CONFIG_CRIS) || defined(CONFIG_FRV)
 # define SUPPORT_VLB_SYNC 0
 #else
 # define SUPPORT_VLB_SYNC 1
