From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-floppy: remove struct idefloppy_id_gcw
Date: Sat, 9 Feb 2008 09:03:34 +0100
Message-ID: <20080209080334.GA23177@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.237]:47487 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYBIIDw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 03:03:52 -0500
Received: by hu-out-0506.google.com with SMTP id 19so6158277hue.21
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 00:03:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

commit a6aaf3dd3e88d1bd1e85fb4329042ecb9247e0eb
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Fri Feb 8 18:21:47 2008 +0100

    ide-floppy: remove struct idefloppy_id_gcw
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index faf22d7..5d5bde8 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -195,32 +195,6 @@ enum {
 #define	IDEFLOPPY_ERROR_GENERAL		101
=20
 /*
- * The following is used to format the general configuration word of t=
he
- * ATAPI IDENTIFY DEVICE command.
- */
-struct idefloppy_id_gcw {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned protocol		:2;	/* Protocol type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned device_type		:5;	/* Device type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned packet_size		:2;	/* Packet Size */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-};
-
-/*
  * Pages of the SELECT SENSE / MODE SENSE packet commands.
  * See SFF-8070i spec.
  */
@@ -1271,32 +1245,40 @@ static sector_t idefloppy_capacity(ide_drive_t =
*drive)
  */
 static int idefloppy_identify_device(ide_drive_t *drive, struct hd_dri=
veid *id)
 {
-	struct idefloppy_id_gcw gcw;
+	u8 gcw[2];
+	u8 device_type, protocol, removable, drq_type, packet_size;
=20
 	*((u16 *) &gcw) =3D id->config;
=20
+	device_type =3D  gcw[1] & 0x1F;
+	removable   =3D (gcw[0] & 0x80) >> 7;
+	protocol    =3D (gcw[1] & 0xC0) >> 6;
+	drq_type    =3D (gcw[0] & 0x60) >> 5;
+	packet_size =3D  gcw[0] & 0x03;
+
 #ifdef CONFIG_PPC
 	/* kludge for Apple PowerBook internal zip */
-	if ((gcw.device_type =3D=3D 5) &&
-	    !strstr(id->model, "CD-ROM") &&
-	    strstr(id->model, "ZIP"))
-		gcw.device_type =3D 0;
+	if ((device_type =3D=3D 5) &&
+		trstr(id->model, "CD-ROM") &&
+		strstr(id->model, "ZIP"))
+		device_type =3D 0;
 #endif
=20
-	if (gcw.protocol !=3D 2)
+	if (protocol !=3D 2)
 		printk(KERN_ERR "ide-floppy: Protocol (0x%02x) is not ATAPI\n",
-				gcw.protocol);
-	else if (gcw.device_type !=3D 0)
+			protocol);
+	else if (device_type !=3D 0)
 		printk(KERN_ERR "ide-floppy: Device type (0x%02x) is not set "
-				"to floppy\n", gcw.device_type);
-	else if (!gcw.removable)
-		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");
-	else if (gcw.drq_type =3D=3D 3) {
+				"to floppy\n", device_type);
+	else if (!removable)
+		printk(KERN_ERR "ide-floppy: The removable flag (0x%02x) is not"
+				" set\n", removable);
+	else if (drq_type =3D=3D 3) {
 		printk(KERN_ERR "ide-floppy: Sorry, DRQ type (0x%02x) not "
-				"supported\n", gcw.drq_type);
-	} else if (gcw.packet_size !=3D 0) {
+				"supported\n", drq_type);
+	} else if (packet_size !=3D 0) {
 		printk(KERN_ERR "ide-floppy: Packet size (0x%02x) is not 12 "
-				"bytes long\n", gcw.packet_size);
+				"bytes\n", packet_size);
 	} else
 		return 1;
 	return 0;
@@ -1322,11 +1304,12 @@ static inline void idefloppy_add_settings(ide_d=
rive_t *drive) { ; }
=20
 static void idefloppy_setup(ide_drive_t *drive, idefloppy_floppy_t *fl=
oppy)
 {
-	struct idefloppy_id_gcw gcw;
+	u8 gcw[2];
=20
 	*((u16 *) &gcw) =3D drive->id->config;
 	floppy->pc =3D floppy->pc_stack;
-	if (gcw.drq_type =3D=3D 1)
+
+	if (((gcw[0] & 0x60) >> 5) =3D=3D 1)
 		floppy->flags |=3D IDEFLOPPY_FLAG_DRQ_INTERRUPT;
 	/*
 	 * We used to check revisions here. At this point however I'm giving =
up.

--=20
Regards/Gru=DF,
    Boris.
