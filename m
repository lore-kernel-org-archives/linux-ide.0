From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Wed, 16 Apr 2008 04:06:18 +0200
Message-ID: <48055F1A.9020706@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758900AbYDPCGd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Is this the right fix in this case?
---
valid is unsigned and cannot be below 0.,
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index c8d0e87..a60f5df 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -182,8 +182,6 @@ void cdrom_analyze_sense_data(ide_drive_t *drive,
 			sector &= ~(bio_sectors -1);
 			valid = (sector - failed_command->sector) << 9;
 
-			if (valid < 0)
-				valid = 0;
 			if (sector < get_capacity(info->disk) &&
 				drive->probed_capacity - sector < 4 * 75) {
 				set_capacity(info->disk, sector);
