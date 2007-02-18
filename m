From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] ide: Remove duplicate dma blacklist entry
Date: Sun, 18 Feb 2007 17:51:03 +0900
Message-ID: <20070218085103.32069.27873.sendpatchset@va-lsv.local.valinux.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1]:36830 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161173AbXBRIvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Feb 2007 03:51:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>, bzolnier@gmail.com

ide: Remove duplicate dma blacklist entry

The exact same entry is already present.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to 2.6.20-git14.

 ide-dma.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/ide/ide-dma.c
+++ work/drivers/ide/ide-dma.c	2007-02-18 16:37:22.000000000 +0900
@@ -125,7 +125,6 @@ static const struct drive_list_entry dri
 	{ "WPI CDD-820",		"ALL"		},
 	{ "SAMSUNG CD-ROM SC-148C",	"ALL"		},
 	{ "SAMSUNG CD-ROM SC",	"ALL"		},
-	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
 	{ NULL			,	NULL		}
