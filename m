From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/63] ide-cd: remove unused defines from ide-cd.h
Date: Thu, 20 Dec 2007 02:05:10 +0100
Message-ID: <200712200205.10565.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:11731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746AbXLTBeS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389245ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.h |   10 ----------
 1 file changed, 10 deletions(-)

Index: b/drivers/ide/ide-cd.h
===================================================================
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -49,16 +49,6 @@
 #endif
 #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
-#define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)
-#define SECTORS_MAX		(131072 >> SECTOR_BITS)
-
-#define BLOCKS_PER_FRAME	(CD_FRAMESIZE / BLOCK_SIZE)
-
-/* special command codes for strategy routine. */
-#define PACKET_COMMAND        4315
-#define REQUEST_SENSE_COMMAND 4316
-#define RESET_DRIVE_COMMAND   4317
-
 
 /* Configuration flags.  These describe the capabilities of the drive.
    They generally do not change after initialization, unless we learn
