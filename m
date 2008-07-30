From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: ide_id_has_flush_cache() -> ata_id_flush_enabled()
Date: Wed, 30 Jul 2008 23:25:39 +0200
Message-ID: <200807302325.39596.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:26226 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYG3WXH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 18:23:07 -0400
Received: by fk-out-0910.google.com with SMTP id 18so179799fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 15:23:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

* Add ata_id_flush_enabled() inline helper to <linux/ata.h>.

* ide_id_has_flush_cache() -> ata_id_flush_enabled()

  The latter one also checks if the command is marked as
  supported in word 83 and validity of words 83 & 86.

Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    6 +++---
 drivers/ide/ide-io.c   |    2 +-
 include/linux/ata.h    |    9 +++++++++
 include/linux/ide.h    |    3 ---
 4 files changed, 13 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -657,7 +657,7 @@ static void update_ordered(ide_drive_t *
 		 * not available so we don't need to recheck that.
 		 */
 		capacity = idedisk_capacity(drive);
-		barrier = ide_id_has_flush_cache(id) && !drive->noflush &&
+		barrier = ata_id_flush_enabled(id) && !drive->noflush &&
 			(drive->addressing == 0 || capacity <= (1ULL << 28) ||
 			 ide_id_has_flush_cache_ext(id));
 
@@ -684,7 +684,7 @@ static int set_wcache(ide_drive_t *drive
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
 
-	if (ide_id_has_flush_cache(drive->id)) {
+	if (ata_id_flush_enabled(drive->id)) {
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tf.feature = arg ?
 			SETFEATURES_WC_ON : SETFEATURES_WC_OFF;
@@ -892,7 +892,7 @@ static void idedisk_setup(ide_drive_t *d
 
 static void ide_cacheflush_p(ide_drive_t *drive)
 {
-	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
+	if (!drive->wcache || ata_id_flush_enabled(drive->id) == 0)
 		return;
 
 	if (do_idedisk_flushcache(drive))
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -184,7 +184,7 @@ static ide_startstop_t ide_start_power_s
 		if (drive->media != ide_disk)
 			break;
 		/* Not supported? Switch to next step now. */
-		if (!drive->wcache || !ide_id_has_flush_cache(drive->id)) {
+		if (!drive->wcache || ata_id_flush_enabled(drive->id) == 0) {
 			ide_complete_power_step(drive, rq, 0, 0);
 			return ide_stopped;
 		}
Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -557,6 +557,15 @@ static inline int ata_id_has_flush(const
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 12);
 }
 
+static inline int ata_id_flush_enabled(const u16 *id)
+{
+	if (ata_id_has_flush(id) == 0)
+		return 0;
+	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
+		return 0;
+	return id[ATA_ID_CFS_ENABLE_2] & (1 << 12);
+}
+
 static inline int ata_id_has_flush_ext(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1451,9 +1451,6 @@ extern struct mutex ide_cfg_mtx;
 extern struct bus_type ide_bus_type;
 extern struct class *ide_port_class;
 
-/* check if CACHE FLUSH command is supported (as defined in ATA-6) */
-#define ide_id_has_flush_cache(id)	((id)[ATA_ID_CFS_ENABLE_2] & 0x1000)
-
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)[ATA_ID_CFS_ENABLE_2] & 0x2400) == 0x2400)
