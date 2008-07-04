From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ide: ide-cd_ioctl.c fix sparse integer as NULL pointer
	warnings
Date: Fri, 04 Jul 2008 16:46:53 -0700
Message-ID: <1215215213.27271.2.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:8336 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYGDXq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2008 19:46:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1756666rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Jul 2008 16:46:55 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

The function ide_cd_queue_pc should be checked as the bufflen arg is
dereferenced and lots of callers are passing in NULL.

drivers/ide/ide-cd_ioctl.c:124:46: warning: Using plain integer as NULL pointer
drivers/ide/ide-cd_ioctl.c:149:47: warning: Using plain integer as NULL pointer
drivers/ide/ide-cd_ioctl.c:231:46: warning: Using plain integer as NULL pointer
drivers/ide/ide-cd_ioctl.c:374:46: warning: Using plain integer as NULL pointer

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-cd_ioctl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index fbacb7c..3a2ffd0 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -121,7 +121,7 @@ int cdrom_eject(ide_drive_t *drive, int ejectflag,
 	cmd[0] = GPCMD_START_STOP_UNIT;
 	cmd[4] = loej | (ejectflag != 0);
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, 0);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, 0);
 }
 
 /* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
@@ -146,7 +146,7 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
 		cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
 		cmd[4] = lockflag ? 1 : 0;
 
-		stat = ide_cd_queue_pc(drive, cmd, 0, NULL, 0,
+		stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL,
 				       sense, 0, 0);
 	}
 
@@ -228,7 +228,7 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 		cmd[5] = speed & 0xff;
 	}
 
-	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
+	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, &sense, 0, 0);
 
 	if (!ide_cdrom_get_capabilities(drive, buf)) {
 		ide_cdrom_update_speed(drive, buf);
@@ -371,7 +371,7 @@ static int ide_cd_fake_play_trkind(ide_drive_t *drive, void *arg)
 	lba_to_msf(lba_start,   &cmd[3], &cmd[4], &cmd[5]);
 	lba_to_msf(lba_end - 1, &cmd[6], &cmd[7], &cmd[8]);
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, &sense, 0, 0);
 }
 
 static int ide_cd_read_tochdr(ide_drive_t *drive, void *arg)
-- 
1.5.6.1.322.ge904b



