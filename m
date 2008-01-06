From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [RFC PATCH] ide-floppy: remove struct idefloppy_capabilities_page
Date: Sun, 6 Jan 2008 10:46:14 +0100
Message-ID: <20080106094614.GA25272@gollum.tnic>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp111.plus.mail.re1.yahoo.com ([69.147.102.74]:39664 "HELO
	smtp111.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751626AbYAFJtU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 04:49:20 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Bart,

before removing all those typedefs in ide-floppy i wanted to check with=
 you whether what
i have in mind is in the right direction before doing all the work for =
nothing.
Here's the first patch removing struct idefloppy_capabilities_page. Ple=
ase, tell
me whether it is similar to what you guys have in mind or is it missing=
 the
point.

Thanks.


=46rom 41c791f40e3fcf2287aa245f25796fa58bb17afc Mon Sep 17 00:00:00 200=
1
=46rom: Borislav Petkov <bbpetkov@yahoo.de>
Date: Sun, 6 Jan 2008 10:37:47 +0100
Subject: [PATCH] ide-floppy: remove struct idefloppy_capabilities_page

This change is rather temporary and is in preparation of using generic =
commands
as is the case with ide-cd and the uniform cdrom layer (i.e. init_cdrom=
_command())
However, before this happens, we'll have to remove all typedefs and tea=
ch
idefloppy_create_mode_sense_cmd() to work directly on u8 buffers.

Also, since idefloppy_get_capability_page() was used to read only the s=
frp bit,
rename the latter so that the name reflects what it does.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   55 +++++---------------------------------=
--------
 1 files changed, 6 insertions(+), 49 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index e8fe8ef..2b9885f 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -120,44 +120,6 @@ typedef struct idefloppy_packet_command_s {
 #define	PC_SUPPRESS_ERROR		6	/* Suppress error reporting */
=20
 /*
- *	Removable Block Access Capabilities Page
- */
-typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	page_code	:6;	/* Page code - Should be 0x1b */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	ps		:1;	/* Should be 0 */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	ps		:1;	/* Should be 0 */
-	unsigned	reserved1_6	:1;	/* Reserved */
-	unsigned	page_code	:6;	/* Page code - Should be 0x1b */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u8		page_length;		/* Page Length - Should be 0xa */
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	reserved2	:6;
-	unsigned	srfp		:1;	/* Supports reporting progress of format */
-	unsigned	sflp		:1;	/* System floppy type device */
-	unsigned	tlun		:3;	/* Total logical units supported by the device */
-	unsigned	reserved3	:3;
-	unsigned	sml		:1;	/* Single / Multiple lun supported */
-	unsigned	ncd		:1;	/* Non cd optical device */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	sflp		:1;	/* System floppy type device */
-	unsigned	srfp		:1;	/* Supports reporting progress of format */
-	unsigned	reserved2	:6;
-	unsigned	ncd		:1;	/* Non cd optical device */
-	unsigned	sml		:1;	/* Single / Multiple lun supported */
-	unsigned	reserved3	:3;
-	unsigned	tlun		:3;	/* Total logical units supported by the device */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u8		reserved[8];
-} idefloppy_capabilities_page_t;
-
-/*
  *	Flexible disk page.
  */
 typedef struct {
@@ -397,7 +359,8 @@ typedef struct {
 } idefloppy_request_sense_result_t;
=20
 /*
- *	Pages of the SELECT SENSE / MODE SENSE packet commands.
+ * Pages of the SELECT SENSE / MODE SENSE packet commands.
+ * See SFF-8070i spec.
  */
 #define	IDEFLOPPY_CAPABILITIES_PAGE	0x1b
 #define IDEFLOPPY_FLEXIBLE_DISK_PAGE	0x05
@@ -1273,25 +1236,20 @@ static int idefloppy_get_flexible_disk_page (id=
e_drive_t *drive)
 	return 0;
 }
=20
-static int idefloppy_get_capability_page(ide_drive_t *drive)
+static int idefloppy_get_sfrp_bit(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	idefloppy_pc_t pc;
-	idefloppy_mode_parameter_header_t *header;
-	idefloppy_capabilities_page_t *page;
=20
 	floppy->srfp =3D 0;
 	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_CAPABILITIES_PAGE,
 						 MODE_SENSE_CURRENT);
=20
 	set_bit(PC_SUPPRESS_ERROR, &pc.flags);
-	if (idefloppy_queue_pc_tail(drive,&pc)) {
+	if (idefloppy_queue_pc_tail(drive, &pc))
 		return 1;
-	}
=20
-	header =3D (idefloppy_mode_parameter_header_t *) pc.buffer;
-	page=3D (idefloppy_capabilities_page_t *)(header+1);
-	floppy->srfp =3D page->srfp;
+	floppy->srfp =3D pc.buffer[8 + 2] & 0x40;
 	return (0);
 }
=20
@@ -1497,8 +1455,7 @@ static int idefloppy_begin_format(ide_drive_t *dr=
ive, int __user *arg)
 		return (-EFAULT);
 	}
=20
-	/* Get the SFRP bit */
-	(void) idefloppy_get_capability_page(drive);
+	(void) idefloppy_get_sfrp_bit(drive);
 	idefloppy_create_format_unit_cmd(&pc, blocks, length, flags);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
                 return (-EIO);
--=20
1.5.3.7

--=20
Regards/Gru=DF,
    Boris.
