From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 10/21] ide-floppy: remove struct idefloppy_mode_parameter_header
Date: Fri, 11 Jan 2008 12:58:08 +0100
Message-ID: <1200052699-28420-11-git-send-email-bbpetkov@yahoo.de>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-2-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-6-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-8-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-9-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-10-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.plus.mail.re1.yahoo.com ([69.147.102.64]:33567 "HELO
	smtp101.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758863AbYAKMDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:38 -0500
In-Reply-To: <1200052699-28420-10-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   25 ++++---------------------
 1 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 7d4ac0b..11c2c9b 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -238,24 +238,6 @@ struct idefloppy_id_gcw {
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
@@ -899,10 +881,11 @@ static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int b, int l,
 /*
  *	A mode sense command is used to "sense" floppy parameters.
  */
-static void idefloppy_create_mode_sense_cmd (idefloppy_pc_t *pc, u8 page_code, u8 type)
+static void idefloppy_create_mode_sense_cmd(idefloppy_pc_t *pc, u8 page_code,
+		u8 type)
 {
-	u16 length = sizeof(idefloppy_mode_parameter_header_t);
-	
+	u16 length = 8; /* sizeof(Mode Parameter Header) = 8 Bytes */
+
 	idefloppy_init_pc(pc);
 	pc->c[0] = GPCMD_MODE_SENSE_10;
 	pc->c[1] = 0;
-- 
1.5.3.7

