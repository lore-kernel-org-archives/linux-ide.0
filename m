From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove bogus ide_fix_driveid() comment
Date: Thu, 22 Nov 2007 22:58:40 +0100
Message-ID: <200711222258.40762.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:57239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbXKVWHS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409665ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -303,9 +303,6 @@ void default_hwif_transport(ide_hwif_t *
 	hwif->atapi_output_bytes	= atapi_output_bytes;
 }
 
-/*
- * Beginning of Taskfile OPCODE Library and feature sets.
- */
 void ide_fix_driveid (struct hd_driveid *id)
 {
 #ifndef __LITTLE_ENDIAN
