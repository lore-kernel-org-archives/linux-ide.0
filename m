From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] ide: use ->OUTBSYNC in ide_set_irq()
Date: Thu, 8 May 2008 21:36:55 +0200
Message-ID: <200805082136.55417.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:25618 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYEHTV5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 15:21:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so617347fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 12:21:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1325,7 +1325,8 @@ static inline void ide_set_irq(ide_drive
 {
 	ide_hwif_t *hwif = drive->hwif;
 
-	hwif->OUTB(drive->ctl | (on ? 0 : 2), hwif->io_ports.ctl_addr);
+	hwif->OUTBSYNC(hwif, drive->ctl | (on ? 0 : 2),
+		       hwif->io_ports.ctl_addr);
 }
 
 static inline u8 ide_read_status(ide_drive_t *drive)
