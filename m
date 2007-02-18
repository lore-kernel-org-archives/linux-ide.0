From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] libata: Remove duplicate dma blacklist entry
Date: Sun, 18 Feb 2007 17:53:32 +0900
Message-ID: <20070218085332.623.18005.sendpatchset@va-lsv.local.valinux.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1]:36992 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161184AbXBRIxd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Feb 2007 03:53:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>, bzolnier@gmail.com

libata: Remove duplicate dma blacklist entry

The exact same entry is already present.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to 2.6.20-git14.

 libata-core.c |    1 -
 1 file changed, 1 deletion(-)

--- 0002/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c	2007-02-18 16:40:27.000000000 +0900
@@ -3242,7 +3242,6 @@ static const struct ata_blacklist_entry 
 	{ "WPI CDD-820", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SC",	NULL,		ATA_HORKAGE_NODMA },
-	{ "SanDisk SDP3B-64", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,ATA_HORKAGE_NODMA },
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
