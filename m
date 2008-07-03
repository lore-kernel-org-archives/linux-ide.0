From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ide: ide-cd.c fix sparse endianness warnings
Date: Thu, 03 Jul 2008 16:34:45 -0700
Message-ID: <1215128085.16647.40.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:18401 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811AbYGCXf7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2008 19:35:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1232218rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2008 16:35:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

drivers/ide/ide-cd.c:1276:46: warning: Using plain integer as NULL pointer
drivers/ide/ide-cd.c:1298:19: warning: cast to restricted __be32
drivers/ide/ide-cd.c:1300:4: warning: cast to restricted __be32
drivers/ide/ide-cd.c:1522:14: warning: cast to restricted __le16
drivers/ide/ide-cd.c:1523:14: warning: cast to restricted __le16
drivers/ide/ide-cd.c:1525:14: warning: cast to restricted __be16
drivers/ide/ide-cd.c:1526:14: warning: cast to restricted __be16
drivers/ide/ide-cd.c:1667:37: warning: cast to restricted __be16

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-cd.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 9b4acbe..47c58a8 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1273,7 +1273,7 @@ int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 	 */
 	cmd[7] = cdi->sanyo_slot % 3;
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, REQ_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, REQ_QUIET);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -1281,8 +1281,8 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 			       struct request_sense *sense)
 {
 	struct {
-		__u32 lba;
-		__u32 blocklen;
+		__be32 lba;
+		__be32 blocklen;
 	} capbuf;
 
 	int stat;
@@ -1515,15 +1515,12 @@ void ide_cdrom_update_speed(ide_drive_t *drive, u8 *buf)
 	struct cdrom_info *cd = drive->driver_data;
 	u16 curspeed, maxspeed;
 
-	curspeed = *(u16 *)&buf[8 + 14];
-	maxspeed = *(u16 *)&buf[8 +  8];
-
 	if (drive->dev_flags & IDE_DFLAG_LE_SPEED_FIELDS) {
-		curspeed = le16_to_cpu(curspeed);
-		maxspeed = le16_to_cpu(maxspeed);
+		curspeed = le16_to_cpup((__le16 *)&buf[8 + 14]);
+		maxspeed = le16_to_cpup((__le16 *)&buf[8 + 8]);
 	} else {
-		curspeed = be16_to_cpu(curspeed);
-		maxspeed = be16_to_cpu(maxspeed);
+		curspeed = be16_to_cpup((__be16 *)&buf[8 + 14]);
+		maxspeed = be16_to_cpup((__be16 *)&buf[8 + 8]);
 	}
 
 	cd->current_speed = (curspeed + (176/2)) / 176;
@@ -1664,7 +1661,7 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
 	else
 		printk(KERN_CONT " drive");
 
-	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpu(*(u16 *)&buf[8 + 12]));
+	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpup((__be16 *)&buf[8 + 12]));
 
 	return nslots;
 }
-- 
1.5.6.1.281.g1087e

