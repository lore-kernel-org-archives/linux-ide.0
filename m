From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/2] ide-floppy: remove MODE_SENSE_* defines
Date: Thu, 7 Aug 2008 19:11:22 +0200
Message-ID: <200808071911.22171.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:24895 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbYHGRPS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 13:15:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so303554fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 07 Aug 2008 10:15:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Only MODE_SENSE_CURRENT (0x00) is ever used so just remove
these defines and then drop no longer needed 'type' argument
from idefloppy_create_mode_sense_cmd().

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -123,12 +123,6 @@ typedef struct ide_floppy_obj {
 
 #define IDEFLOPPY_TICKS_DELAY	HZ/20	/* default delay for ZIP 100 (50ms) */
 
-/* Defines for the MODE SENSE command */
-#define MODE_SENSE_CURRENT		0x00
-#define MODE_SENSE_CHANGEABLE		0x01
-#define MODE_SENSE_DEFAULT		0x02
-#define MODE_SENSE_SAVED		0x03
-
 /* IOCTLs used in low-level formatting. */
 #define	IDEFLOPPY_IOCTL_FORMAT_SUPPORTED	0x4600
 #define	IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY	0x4601
@@ -501,14 +495,14 @@ static void idefloppy_create_format_unit
 
 /* A mode sense command is used to "sense" floppy parameters. */
 static void idefloppy_create_mode_sense_cmd(struct ide_atapi_pc *pc,
-		u8 page_code, u8 type)
+					    u8 page_code)
 {
 	u16 length = 8; /* sizeof(Mode Parameter Header) = 8 Bytes */
 
 	idefloppy_init_pc(pc);
 	pc->c[0] = GPCMD_MODE_SENSE_10;
 	pc->c[1] = 0;
-	pc->c[2] = page_code + (type << 6);
+	pc->c[2] = page_code;
 
 	switch (page_code) {
 	case IDEFLOPPY_CAPABILITIES_PAGE:
@@ -665,8 +659,7 @@ static int ide_floppy_get_flexible_disk_
 	u16 transfer_rate, sector_size, cyls, rpm;
 	u8 heads, sectors;
 
-	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_FLEXIBLE_DISK_PAGE,
-					MODE_SENSE_CURRENT);
+	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_FLEXIBLE_DISK_PAGE);
 
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-floppy: Can't get flexible disk page"
@@ -714,10 +707,10 @@ static int idefloppy_get_sfrp_bit(ide_dr
 	struct ide_atapi_pc pc;
 
 	floppy->srfp = 0;
-	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_CAPABILITIES_PAGE,
-						 MODE_SENSE_CURRENT);
 
+	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_CAPABILITIES_PAGE);
 	pc.flags |= PC_FLAG_SUPPRESS_ERROR;
+
 	if (idefloppy_queue_pc_tail(drive, &pc))
 		return 1;
 
