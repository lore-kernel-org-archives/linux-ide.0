From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] <linux/ide.h>: fix comment typo
Date: Mon, 12 Apr 2010 19:43:19 +0400
Message-ID: <201004121943.19556.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48763 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752446Ab0DLPoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Apr 2010 11:44:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

Fix typo in the comment to the 'dma_mode' field of the 'struct ide_drive_s'
introduced by the commit 3fccaa192b9501e79a57e02e62b6bf420d2b461e (ide: add
drive->dma_mode field).

Whilt at it, convert spaces to a tab in the declaration of the neighbouring
'dn' field...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git tree...

 include/linux/ide.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: ide-2.6/include/linux/ide.h
===================================================================
--- ide-2.6.orig/include/linux/ide.h
+++ ide-2.6/include/linux/ide.h
@@ -516,8 +516,8 @@ struct ide_drive_s {
         u8	current_speed;	/* current transfer rate set */
 	u8	desired_speed;	/* desired transfer rate set */
 	u8	pio_mode;	/* for ->set_pio_mode _only_ */
-	u8	dma_mode;	/* for ->dma_pio_mode _only_ */
-        u8	dn;		/* now wide spread use */
+	u8	dma_mode;	/* for ->set_dma_mode _only_ */
+	u8	dn;		/* now wide spread use */
 	u8	acoustic;	/* acoustic management */
 	u8	media;		/* disk, cdrom, tape, floppy, ... */
 	u8	ready_stat;	/* min status value for drive ready */
