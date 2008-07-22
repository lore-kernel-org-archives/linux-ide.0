From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/10] ide-disk: use ata_id_hpa_enabled()
Date: Tue, 22 Jul 2008 23:13:11 +0200
Message-ID: <20080722211311.20478.47051.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:36945 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbYGVVPV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:15:21 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1285589mue.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:15:20 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

idedisk_supports_hpa() -> ata_id_hpa_enabled().

The latter one also checks validity of words 82 & 85.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -379,17 +379,6 @@ static unsigned long long sectors_to_MB(
 }
 
 /*
- * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
- * so on non-buggy drives we need test only one.
- * However, we should also check whether these fields are valid.
- */
-static inline int idedisk_supports_hpa(const u16 *id)
-{
-	return (id[ATA_ID_COMMAND_SET_1] & 0x0400) &&
-	       (id[ATA_ID_CFS_ENABLE_1] & 0x0400);
-}
-
-/*
  * The same here.
  */
 static inline int idedisk_supports_lba48(const u16 *id)
@@ -468,7 +457,7 @@ static void init_idedisk_capacity(ide_dr
 	 * If this drive supports the Host Protected Area feature set,
 	 * then we may need to change our opinion about the drive's capacity.
 	 */
-	int hpa = idedisk_supports_hpa(id);
+	int hpa = ata_id_hpa_enabled(id);
 
 	if (idedisk_supports_lba48(id)) {
 		/* drive speaks 48-bit LBA */
@@ -946,7 +935,7 @@ static int ide_disk_probe(ide_drive_t *d
  */
 static void ide_disk_resume(ide_drive_t *drive)
 {
-	if (idedisk_supports_hpa(drive->id))
+	if (ata_id_hpa_enabled(drive->id))
 		init_idedisk_capacity(drive);
 }
 
