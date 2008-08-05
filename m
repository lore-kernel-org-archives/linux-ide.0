From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ide_check_atapi_device() helper
Date: Tue, 5 Aug 2008 18:37:19 +0200
Message-ID: <200808051837.19811.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:45603 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486AbYHEQjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 12:39:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1327518fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 09:39:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

* Add ide_check_atapi_device() to ide-atapi.c and convert
  ide-{floppy,tape}.c to use it instead of ide*_identify_device().

While at it:

* Add DRV_NAME defines to ide-{floppy,tape}.c.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-atapi.c  |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-floppy.c |   48 ++---------------------------------------------
 drivers/ide/ide-tape.c   |   43 ++----------------------------------------
 include/linux/ide.h      |    2 +
 4 files changed, 55 insertions(+), 85 deletions(-)

Index: b/drivers/ide/ide-atapi.c
===================================================================
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -14,6 +14,53 @@
 #define debug_log(fmt, args...) do {} while (0)
 #endif
 
+/*
+ * Check whether we can support a device,
+ * based on the ATAPI IDENTIFY command results.
+ */
+int ide_check_atapi_device(ide_drive_t *drive, const char *s)
+{
+	u16 *id = drive->id;
+	u8 gcw[2], protocol, device_type, removable, drq_type, packet_size;
+
+	*((u16 *)&gcw) = id[ATA_ID_CONFIG];
+
+	protocol    = (gcw[1] & 0xC0) >> 6;
+	device_type =  gcw[1] & 0x1F;
+	removable   = (gcw[0] & 0x80) >> 7;
+	drq_type    = (gcw[0] & 0x60) >> 5;
+	packet_size =  gcw[0] & 0x03;
+
+#ifdef CONFIG_PPC
+	/* kludge for Apple PowerBook internal zip */
+	if (drive->media == ide_floppy && device_type == 5 &&
+	    !strstr((char *)&id[ATA_ID_PROD], "CD-ROM") &&
+	    strstr((char *)&id[ATA_ID_PROD], "ZIP"))
+		device_type = 0;
+#endif
+
+	if (protocol != 2)
+		printk(KERN_ERR "%s: %s: protocol (0x%02x) is not ATAPI\n",
+			s, drive->name, protocol);
+	else if ((drive->media == ide_floppy && device_type != 0) ||
+		 (drive->media == ide_tape && device_type != 1))
+		printk(KERN_ERR "%s: %s: invalid device type (0x%02x)\n",
+			s, drive->name, device_type);
+	else if (removable == 0)
+		printk(KERN_ERR "%s: %s: the removable flag is not set\n",
+			s, drive->name);
+	else if (drive->media == ide_floppy && drq_type == 3)
+		printk(KERN_ERR "%s: %s: sorry, DRQ type (0x%02x) not "
+			"supported\n", s, drive->name, drq_type);
+	else if (packet_size != 0)
+		printk(KERN_ERR "%s: %s: packet size (0x%02x) is not 12 "
+			"bytes\n", s, drive->name, packet_size);
+	else
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ide_check_atapi_device);
+
 /* TODO: unify the code thus making some arguments go away */
 ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry,
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -15,6 +15,8 @@
  * Documentation/ide/ChangeLog.ide-floppy.1996-2002
  */
 
+#define DRV_NAME "ide-floppy"
+
 #define IDEFLOPPY_VERSION "1.00"
 
 #include <linux/module.h>
@@ -962,50 +964,6 @@ static sector_t idefloppy_capacity(ide_d
 	return capacity;
 }
 
-/*
- * Check whether we can support a drive, based on the ATAPI IDENTIFY command
- * results.
- */
-static int idefloppy_identify_device(ide_drive_t *drive, u16 *id)
-{
-	u8 gcw[2];
-	u8 device_type, protocol, removable, drq_type, packet_size;
-
-	*((u16 *)&gcw) = id[ATA_ID_CONFIG];
-
-	device_type =  gcw[1] & 0x1F;
-	removable   = (gcw[0] & 0x80) >> 7;
-	protocol    = (gcw[1] & 0xC0) >> 6;
-	drq_type    = (gcw[0] & 0x60) >> 5;
-	packet_size =  gcw[0] & 0x03;
-
-#ifdef CONFIG_PPC
-	/* kludge for Apple PowerBook internal zip */
-	if (device_type == 5 &&
-	    !strstr((char *)&id[ATA_ID_PROD], "CD-ROM") &&
-	    strstr((char *)&id[ATA_ID_PROD], "ZIP"))
-		device_type = 0;
-#endif
-
-	if (protocol != 2)
-		printk(KERN_ERR "ide-floppy: Protocol (0x%02x) is not ATAPI\n",
-			protocol);
-	else if (device_type != 0)
-		printk(KERN_ERR "ide-floppy: Device type (0x%02x) is not set "
-				"to floppy\n", device_type);
-	else if (!removable)
-		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");
-	else if (drq_type == 3)
-		printk(KERN_ERR "ide-floppy: Sorry, DRQ type (0x%02x) not "
-				"supported\n", drq_type);
-	else if (packet_size != 0)
-		printk(KERN_ERR "ide-floppy: Packet size (0x%02x) is not 12 "
-				"bytes\n", packet_size);
-	else
-		return 1;
-	return 0;
-}
-
 #ifdef CONFIG_IDE_PROC_FS
 ide_devset_rw(bios_cyl,  0, 1023, bios_cyl);
 ide_devset_rw(bios_head, 0,  255, bios_head);
@@ -1407,7 +1365,7 @@ static int ide_floppy_probe(ide_drive_t 
 	if (drive->media != ide_floppy)
 		goto failed;
 
-	if (!idefloppy_identify_device(drive, drive->id)) {
+	if (!ide_check_atapi_device(drive, DRV_NAME)) {
 		printk(KERN_ERR "ide-floppy: %s: not supported by this version"
 				" of ide-floppy\n", drive->name);
 		goto failed;
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -15,6 +15,8 @@
  * Documentation/ide/ChangeLog.ide-tape.1995-2002
  */
 
+#define DRV_NAME "ide-tape"
+
 #define IDETAPE_VERSION "1.20"
 
 #include <linux/module.h>
@@ -2295,45 +2297,6 @@ static int idetape_chrdev_release(struct
 	return 0;
 }
 
-/*
- * check the contents of the ATAPI IDENTIFY command results. We return:
- *
- * 1 - If the tape can be supported by us, based on the information we have so
- * far.
- *
- * 0 - If this tape driver is not currently supported by us.
- */
-static int idetape_identify_device(ide_drive_t *drive)
-{
-	u8 gcw[2], protocol, device_type, removable, packet_size;
-
-	if (drive->id_read == 0)
-		return 1;
-
-	*((u16 *)&gcw) = drive->id[ATA_ID_CONFIG];
-
-	protocol	=   (gcw[1] & 0xC0) >> 6;
-	device_type	=    gcw[1] & 0x1F;
-	removable	= !!(gcw[0] & 0x80);
-	packet_size	=    gcw[0] & 0x3;
-
-	/* Check that we can support this device */
-	if (protocol != 2)
-		printk(KERN_ERR "ide-tape: Protocol (0x%02x) is not ATAPI\n",
-				protocol);
-	else if (device_type != 1)
-		printk(KERN_ERR "ide-tape: Device type (0x%02x) is not set "
-				"to tape\n", device_type);
-	else if (!removable)
-		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
-	else if (packet_size != 0) {
-		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12"
-				" bytes\n", packet_size);
-	} else
-		return 1;
-	return 0;
-}
-
 static void idetape_get_inquiry_results(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -2678,7 +2641,7 @@ static int ide_tape_probe(ide_drive_t *d
 	if (drive->media != ide_tape)
 		goto failed;
 
-	if (!idetape_identify_device(drive)) {
+	if (drive->id_read == 1 && !ide_check_atapi_device(drive, DRV_NAME)) {
 		printk(KERN_ERR "ide-tape: %s: not supported by this version of"
 				" the driver\n", drive->name);
 		goto failed;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1107,6 +1107,8 @@ extern int drive_is_ready(ide_drive_t *)
 
 void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u8);
 
+int ide_check_atapi_device(ide_drive_t *, const char *);
+
 ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry,
 	void (*update_buffers)(ide_drive_t *, struct ide_atapi_pc *),
