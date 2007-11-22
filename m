From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add TORiSAN model: CD-ROM CDR_U200 fw: 1.09 to DMA blacklist
Date: Thu, 22 Nov 2007 22:55:35 +0100
Message-ID: <200711222255.35558.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbXKVWHN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409664ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: snowbat@gmail.com


Based on the report from snowbat@gmail.com.

Should fix kernel bugzilla bug #9195.

Cc: snowbat@gmail.com
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -130,6 +130,7 @@ static const struct drive_list_entry dri
 	{ "_NEC DV5800A",               NULL            },
 	{ "SAMSUNG CD-ROM SN-124",	"N001" },
 	{ "Seagate STT20000A",		NULL  },
+	{ "CD-ROM CDR_U200",		"1.09" },
 	{ NULL			,	NULL		}
 
 };
