From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] Revert "ide: change master/slave IDENTIFY order"
Date: Sat, 29 Mar 2008 19:57:24 +0100
Message-ID: <200803291957.25205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43474 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbYC2Snx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 14:43:53 -0400
Received: by fg-out-1718.google.com with SMTP id l27so905028fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 11:43:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This reverts commit b140b99c413ce410197cfcd4014e757cd745226a.

[ conflict in drivers/ide/ide-probe.c fixed manually ]

It turned out that probing order change causes problems for some drives:

	http://bugzilla.kernel.org/show_bug.cgi?id=10239

Since root causes are still being investigated and are unlikely to be fixed
before 2.6.25 lets revert this change for now.  As a result cable detection
becomes less reliable when compared with 2.6.24 but the affected drives are
useable again.

Reported-by: Richard Genoud <richard.genoud@gmail.com>
Bisected-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c  |    1 +
 drivers/ide/ide-probe.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
