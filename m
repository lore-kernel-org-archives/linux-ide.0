From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/15] dtc2278: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:32:27 +0200
Message-ID: <200710012332.28041.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbXJAVjg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Stop abusing ide_lock lock (switch to a private locking).

Fixes same issue as fixed by Alan Cox in atiixp host driver with
commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/dtc2278.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -67,18 +67,20 @@ static void sub22 (char b, char c)
 	}
 }
 
+static DEFINE_SPINLOCK(dtc2278_lock);
+
 static void dtc2278_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 
 	if (pio >= 3) {
-		spin_lock_irqsave(&ide_lock, flags);
+		spin_lock_irqsave(&dtc2278_lock, flags);
 		/*
 		 * This enables PIO mode4 (3?) on the first interface
 		 */
 		sub22(1,0xc3);
 		sub22(0,0xa0);
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&dtc2278_lock, flags);
 	} else {
 		/* we don't know how to set it back again.. */
 	}
