From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] ide: remove broken disk byte-swapping support
Date: Mon, 3 Dec 2007 22:53:26 +0100
Message-ID: <200712032253.26766.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20756 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbXLCVrX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458774ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove broken disk byte-swapping support:
- it can cause a data corruption on SMP (or if using PREEMPT on UP)
- all data coming from disk are byte-swapped by taskfile_*_data() which
  results in incorrect identify data being reported by /proc/ide/ and IOCTLs
- "hdx=bswap/byteswap" kernel parameter has been broken on m68k host drivers
  (including Atari Q40 one) since 2.5.x days (because of 'hwif' zero-ing)
- byte-swapping is limited to PIO transfers (for working with TiVo disks on
  x86 machines using user-space solutions or dm-byteswap should result in
  much better performance because DMA can be used)

For previous discussions please see:

http://www.ussg.iu.edu/hypermail/linux/kernel/0201.0/0768.html
http://lkml.org/lkml/2004/2/28/111

[ I have dm-byteswap device mapper target if somebody is interested
  (patch is for 2.6.4 though but I'll dust it off if needed). ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide.txt      |    4 ----
 drivers/ide/ide-disk.c     |    1 -
 drivers/ide/ide-taskfile.c |   32 ++------------------------------
 drivers/ide/ide.c          |    6 +-----
 include/linux/ide.h        |    1 -
 5 files changed, 3 insertions(+), 41 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -244,10 +244,6 @@ Summary of ide driver parameters for ker
 
  "hdx=nodma"		: disallow DMA
 
- "hdx=swapdata"		: when the drive is a disk, byte swap all data
-
- "hdx=bswap"		: same as above..........
-
  "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -761,7 +761,6 @@ static void idedisk_add_settings(ide_dri
 	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,			
1,	1,	&drive->bios_head,	NULL);
 	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,			
1,	1,	&drive->bios_sect,	NULL);
 	ide_add_setting(drive,	"address",	SETTING_RW,	TYPE_BYTE,	0,	2,			
1,	1,	&drive->addressing,	set_lba_addressing);
-	ide_add_setting(drive,	"bswap",	SETTING_READ,	TYPE_BYTE,	0,	1,			
1,	1,	&drive->bswap,		NULL);
 	ide_add_setting(drive,	"multcount",	SETTING_RW,	TYPE_BYTE,	0,	id->max_multsect,	
1,	1,	&drive->mult_count,	set_multcount);
 	ide_add_setting(drive,	"nowerr",	SETTING_RW,	TYPE_BYTE,	0,	1,			
1,	1,	&drive->nowerr,		set_nowerr);
 	ide_add_setting(drive,	"lun",		SETTING_RW,	TYPE_INT,	0,	7,			
1,	1,	&drive->lun,		NULL);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -35,34 +35,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-static void ata_bswap_data (void *buffer, int wcount)
-{
-	u16 *p = buffer;
-
-	while (wcount--) {
-		*p = *p << 8 | *p >> 8; p++;
-		*p = *p << 8 | *p >> 8; p++;
-	}
-}
-
-static void taskfile_input_data(ide_drive_t *drive, void *buffer, u32 wcount)
-{
-	HWIF(drive)->ata_input_data(drive, buffer, wcount);
-	if (drive->bswap)
-		ata_bswap_data(buffer, wcount);
-}
-
-static void taskfile_output_data(ide_drive_t *drive, void *buffer, u32 wcount)
-{
-	if (drive->bswap) {
-		ata_bswap_data(buffer, wcount);
-		HWIF(drive)->ata_output_data(drive, buffer, wcount);
-		ata_bswap_data(buffer, wcount);
-	} else {
-		HWIF(drive)->ata_output_data(drive, buffer, wcount);
-	}
-}
-
 void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -352,9 +324,9 @@ static void ide_pio_sector(ide_drive_t *
 
 	/* do the actual data transfer */
 	if (write)
-		taskfile_output_data(drive, buf, SECTOR_WORDS);
+		hwif->ata_output_data(drive, buf, SECTOR_WORDS);
 	else
-		taskfile_input_data(drive, buf, SECTOR_WORDS);
+		hwif->ata_input_data(drive, buf, SECTOR_WORDS);
 
 	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 #ifdef CONFIG_HIGHMEM
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1297,7 +1297,7 @@ static int __init ide_setup(char *s)
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
 			"none", "noprobe", "nowerr", "cdrom", "nodma",
-			"autotune", "noautotune", "minus8", "swapdata", "bswap",
+			"autotune", "noautotune", "-8", "-9", "-10",
 			"noflush", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
@@ -1333,10 +1333,6 @@ static int __init ide_setup(char *s)
 			case -7: /* "noautotune" */
 				drive->autotune = IDE_TUNE_NOAUTO;
 				goto obsolete_option;
-			case -9: /* "swapdata" */
-			case -10: /* "bswap" */
-				drive->bswap = 1;
-				goto done;
 			case -11: /* noflush */
 				drive->noflush = 1;
 				goto done;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -394,7 +394,6 @@ typedef struct ide_drive_s {
 	u8	state;			/* retry state */
 	u8	waiting_for_dma;	/* dma currently in progress */
 	u8	unmask;			/* okay to unmask other irqs */
-	u8	bswap;			/* byte swap data */
 	u8	noflush;		/* don't attempt flushes */
 	u8	dsc_overlap;		/* DSC overlap */
 	u8	nice1;			/* give potential excess bandwidth */
