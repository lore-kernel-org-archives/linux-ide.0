From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Fri, 10 Apr 2009 10:14:19 GMT
Message-ID: <200904101014.n3AAEJPQ004795@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:32837 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbZDJKOT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 06:14:19 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3AAEJnm004796
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 10:14:19 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #22 from Borislav Petkov <bbpetkov@yahoo.de>  2009-04-10 10:14:18 ---
(From update of attachment 20917)
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index e9d042d..4ef3b7e 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -8,6 +8,8 @@
 #include <linux/ide.h>
 #include <scsi/scsi.h>

+#define DEBUG 1
+
 #ifdef DEBUG
 #define debug_log(fmt, args...) \
     printk(KERN_INFO "ide: " fmt, ## args)
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index aed280f..70e7876 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -59,7 +59,7 @@ enum {
 };

 /* define to see debug info */
-#define IDETAPE_DEBUG_LOG        0
+#define IDETAPE_DEBUG_LOG        1

 #if IDETAPE_DEBUG_LOG
 #define debug_log(lvl, fmt, args...)            \
@@ -720,9 +720,11 @@ static void idetape_create_mode_sense_cmd(struct
ide_atapi_pc *pc, u8 page_code)
     if (page_code == IDETAPE_BLOCK_DESCRIPTOR)
         pc->req_xfer = 12;
     else if (page_code == IDETAPE_CAPABILITIES_PAGE)
-        pc->req_xfer = 24;
+        pc->req_xfer = IDE_PC_BUFFER_SIZE;
     else
         pc->req_xfer = 50;
+
+    memset(pc->pc_buf, 0xf, IDE_PC_BUFFER_SIZE);
 }

 static ide_startstop_t idetape_media_access_finished(ide_drive_t *drive)
@@ -2082,7 +2084,7 @@ static void idetape_get_mode_sense_results(ide_drive_t
*drive)
     struct ide_atapi_pc pc;
     u8 *caps;
     u8 speed, max_speed;
-    int i;
+    unsigned int i;

     idetape_create_mode_sense_cmd(&pc, IDETAPE_CAPABILITIES_PAGE);
     if (ide_queue_pc_tail(drive, tape->disk, &pc)) {
@@ -2097,8 +2099,11 @@ static void idetape_get_mode_sense_results(ide_drive_t
*drive)
     caps = pc.buf + 4 + pc.buf[3];

     printk(KERN_ERR "caps: ");
-    for (i = 0; i < 24; i++)
+    for (i = 0; i < IDE_PC_BUFFER_SIZE; i++) {
         printk(KERN_CONT " %x", pc.buf[i]);
+        if ((i & 0xf) == 0xf)
+            printk(KERN_CONT "\n");
+    }
     printk(KERN_CONT "\n");

     /* convert to host order and save for later use */
@@ -2207,6 +2212,7 @@ static void idetape_setup(ide_drive_t *drive,
idetape_tape_t *tape, int minor)
     drive->pc_callback     = ide_tape_callback;
     drive->pc_update_buffers = idetape_update_buffers;
     drive->pc_io_buffers     = ide_tape_io_buffers;
+    drive->debug_mask     = 0xffffffff;

     spin_lock_init(&tape->lock);

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
