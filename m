From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 1/12] ide-floppy: remove struct idefloppy_mode_parameter_header
Date: Sun, 13 Jan 2008 21:18:14 +0100
Message-ID: <1200255505-31418-2-git-send-email-bbpetkov@yahoo.de>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp109.plus.mail.re1.yahoo.com ([69.147.102.72]:45585 "HELO
	smtp109.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753369AbYAMUWE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:04 -0500
In-Reply-To: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 2b9885f..7648684 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -365,24 +365,6 @@ typedef struct {
 #define	IDEFLOPPY_CAPABILITIES_PAGE	0x1b
 #define IDEFLOPPY_FLEXIBLE_DISK_PAGE	0x05
 
-/*
- *	Mode Parameter Header for the MODE SENSE packet command
- */
-typedef struct {
-	u16		mode_data_length;	/* Length of the following data transfer */
-	u8		medium_type;		/* Medium Type */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	reserved3	:7;
-	unsigned	wp		:1;	/* Write protect */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	wp		:1;	/* Write protect */
-	unsigned	reserved3	:7;
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u8		reserved[4];
-} idefloppy_mode_parameter_header_t;
-
 static DEFINE_MUTEX(idefloppy_ref_mutex);
 
 #define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)
@@ -1029,7 +1011,7 @@ static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int b, int l,
  */
 static void idefloppy_create_mode_sense_cmd (idefloppy_pc_t *pc, u8 page_code, u8 type)
 {
-	u16 length = sizeof(idefloppy_mode_parameter_header_t);
+	u16 length = 8; /* sizeof(Mode Parameter Header) = 8 Bytes */
 	
 	idefloppy_init_pc(pc);
 	pc->c[0] = GPCMD_MODE_SENSE_10;
@@ -1195,7 +1177,6 @@ static int idefloppy_get_flexible_disk_page (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_pc_t pc;
-	idefloppy_mode_parameter_header_t *header;
 	idefloppy_flexible_disk_page_t *page;
 	int capacity, lba_capacity;
 
@@ -1205,10 +1186,9 @@ static int idefloppy_get_flexible_disk_page (ide_drive_t *drive)
 			"page parameters\n");
 		return 1;
 	}
-	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
-	floppy->wp = header->wp;
+	floppy->wp = !!(pc.buffer[3] & 0x80);
 	set_disk_ro(floppy->disk, floppy->wp);
-	page = (idefloppy_flexible_disk_page_t *) (header + 1);
+	page = (idefloppy_flexible_disk_page_t *) &pc.buffer[8];
 
 	page->transfer_rate = be16_to_cpu(page->transfer_rate);
 	page->sector_size = be16_to_cpu(page->sector_size);
-- 
1.5.3.7

