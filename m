From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 11:09:51 GMT
Message-ID: <201004111109.o3BB9pff021216@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57184 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0DKLJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 07:09:54 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BB9q11021218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 11:09:52 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #4 from Borislav Petkov <bbpetkov@yahoo.de>  2010-04-11 11:09:38 ---
Hi,

can you send me the whole dmesg with the oops, also your kernel config.
Also, you could try reproducing the bug after having enabled ide-cd
debugging. For that, you'll need to apply the following patchlet and
rebuild your kernel:


diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64207df..4713094 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1707,6 +1707,8 @@ static int ide_cd_probe(ide_drive_t *drive)
     struct gendisk *g;
     struct request_sense sense;

+    drive->debug_mask = 0xffffffff;
+
     ide_debug_log(IDE_DBG_PROBE, "driver_req: %s, media: 0x%x",
                      drive->driver_req, drive->media);

@@ -1716,7 +1718,6 @@ static int ide_cd_probe(ide_drive_t *drive)
     if (drive->media != ide_cdrom && drive->media != ide_optical)
         goto failed;

-    drive->debug_mask = debug_mask;
     drive->irq_handler = cdrom_newpc_intr;

     info = kzalloc(sizeof(struct cdrom_info), GFP_KERNEL);
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 93a3cf1..613542a 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -8,7 +8,7 @@
 #include <linux/cdrom.h>
 #include <asm/byteorder.h>

-#define IDECD_DEBUG_LOG        0
+#define IDECD_DEBUG_LOG        1

 #if IDECD_DEBUG_LOG
 #define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, ## args)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
