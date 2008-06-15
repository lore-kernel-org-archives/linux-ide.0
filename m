From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: increase timeout in wait_drive_not_busy()
Date: Sun, 15 Jun 2008 20:24:24 +0200
Message-ID: <200806152024.24596.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:64485 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758960AbYFOSXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 14:23:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2934525ywe.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 11:23:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Some ATAPI devices take longer than the current max timeout value to
become ready (i.e. TEAC DV-W28ECW takes 6 ms) so increase the timeout
value to 10 ms.

This fixes kernel.org bugzilla bug #10887:
http://bugzilla.kernel.org/show_bug.cgi?id=10887

Reported-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
draft patch, I'm waiting on feedback from Masanari on this one

 drivers/ide/ide-taskfile.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -225,10 +225,10 @@ static u8 wait_drive_not_busy(ide_drive_
 	u8 stat;
 
 	/*
-	 * Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec, but we will wait max 1 ms.
+	 * Last sector was transfered, wait until device is ready.  This can
+	 * take up to 6 ms on some ATAPI devices, so we will wait max 10 ms.
 	 */
-	for (retries = 0; retries < 100; retries++) {
+	for (retries = 0; retries < 1000; retries++) {
 		stat = ide_read_status(drive);
 
 		if (stat & BUSY_STAT)
