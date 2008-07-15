From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 1/2] ide: ide-tape.c sparse annotations and unaligned
	access removal
Date: Tue, 15 Jul 2008 13:14:04 -0700
Message-ID: <1216152845.6610.18.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:53599 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYGOUOH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jul 2008 16:14:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5464846wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 13:14:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

If this is actually unaligned the access of speed/max_speed above
is already broken and needs a get_unaligned.  Otherwise it is
aligned and they can be removed.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Bart, if this truly should be unaligned, let me know and I'll send you
a patch fixing the speed/maxspeed issue.

 drivers/ide/ide-tape.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 34fc925..40b09b2 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -655,10 +655,10 @@ static void ide_tape_callback(ide_drive_t *drive)
 			uptodate = 0;
 		} else {
 			debug_log(DBG_SENSE, "Block Location - %u\n",
-					be32_to_cpu(*(u32 *)&readpos[4]));
+					be32_to_cpup((__be32 *)&readpos[4]));
 
 			tape->partition = readpos[1];
-			tape->first_frame = be32_to_cpu(*(u32 *)&readpos[4]);
+			tape->first_frame = be32_to_cpup((__be32 *)&readpos[4]);
 			set_bit(IDE_DFLAG_ADDRESS_VALID, &drive->dev_flags);
 		}
 	}
@@ -2381,13 +2381,13 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
 	caps = pc.buf + 4 + pc.buf[3];
 
 	/* convert to host order and save for later use */
-	speed = be16_to_cpu(*(u16 *)&caps[14]);
-	max_speed = be16_to_cpu(*(u16 *)&caps[8]);
+	speed = be16_to_cpup((__be16 *)&caps[14]);
+	max_speed = be16_to_cpup((__be16 *)&caps[8]);
 
-	put_unaligned(max_speed, (u16 *)&caps[8]);
-	put_unaligned(be16_to_cpu(*(u16 *)&caps[12]), (u16 *)&caps[12]);
-	put_unaligned(speed, (u16 *)&caps[14]);
-	put_unaligned(be16_to_cpu(*(u16 *)&caps[16]), (u16 *)&caps[16]);
+	*(u16 *)&caps[8] = max_speed;
+	*(u16 *)&caps[12] = be16_to_cpup((__be16 *)&caps[12]);
+	*(u16 *)&caps[14] = speed;
+	*(u16 *)&caps[16] = be16_to_cpup((__be16 *)&caps[16]);
 
 	if (!speed) {
 		printk(KERN_INFO "ide-tape: %s: invalid tape speed "
-- 
1.5.6.3.499.geae9


