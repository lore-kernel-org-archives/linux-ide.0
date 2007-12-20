From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 34/63] ide-cd: remove duplicate sense keys definitions from ide-cd.h
Date: Thu, 20 Dec 2007 02:19:20 +0100
Message-ID: <200712200219.20219.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758698AbXLTBej (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389247ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


ide-cd.c already uses sense keys definitions from <scsi/scsi.h>.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.h |   17 -----------------
 1 file changed, 17 deletions(-)

Index: b/drivers/ide/ide-cd.h
===================================================================
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -158,23 +158,6 @@ struct cdrom_info {
  */
 
 /* This stuff should be in cdrom.h, since it is now generic... */
-
-/* ATAPI sense keys (from table 140 of ATAPI 2.6) */
-#define NO_SENSE                0x00
-#define RECOVERED_ERROR         0x01
-#define NOT_READY               0x02
-#define MEDIUM_ERROR            0x03
-#define HARDWARE_ERROR          0x04
-#define ILLEGAL_REQUEST         0x05
-#define UNIT_ATTENTION          0x06
-#define DATA_PROTECT            0x07
-#define BLANK_CHECK             0x08
-#define ABORTED_COMMAND         0x0b
-#define MISCOMPARE              0x0e
-
- 
-
-/* This stuff should be in cdrom.h, since it is now generic... */
 #if VERBOSE_IDE_CD_ERRORS
 
  /* The generic packet command opcodes for CD/DVD Logical Units,
