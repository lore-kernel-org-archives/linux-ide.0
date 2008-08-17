From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/5] ide: add a driver-wide debugging macro
Date: Sun, 17 Aug 2008 19:23:44 +0200
Message-ID: <1218993826-4571-4-git-send-email-petkovbb@gmail.com>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:37409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbYHQRXs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:23:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1456295fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:23:46 -0700 (PDT)
In-Reply-To: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Add __ide_debug_log() debugging macro which is controlled by drive->debug_mask.
The macro has to have the macro DRV_NAME defined in each driver before use.
Also, add different debugging levels depending on the functionality debugged.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 include/linux/ide.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index c161840..b6d714d 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -925,6 +925,26 @@ static inline void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 #endif
 
+enum {
+	/* enter/exit functions */
+	IDE_DBG_FUNC =			(1 << 0),
+	/* sense key/asc handling */
+	IDE_DBG_SENSE =			(1 << 1),
+	/* packet commands handling */
+	IDE_DBG_PC =			(1 << 2),
+	/* request handling */
+	IDE_DBG_RQ =			(1 << 3),
+	/* driver probing/setup */
+	IDE_DBG_PROBE =			(1 << 4),
+};
+
+/* DRV_NAME has to be defined in the driver before using the macro below */
+#define __ide_debug_log(lvl, fmt, args...)			\
+{								\
+	if (unlikely(drive->debug_mask & lvl))			\
+		printk(KERN_INFO DRV_NAME ": " fmt, ## args);	\
+}
+
 /*
  * Power Management step value (rq->pm->pm_step).
  *
-- 
1.5.5.4

