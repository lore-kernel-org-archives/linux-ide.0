From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ide-cd: unsigned len subtracted below 0?
Date: Wed, 04 Mar 2009 00:13:46 +0100
Message-ID: <49ADB9AA.106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:2653 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZCCXNq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 18:13:46 -0500
Received: by nf-out-0910.google.com with SMTP id d21so618348nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 03 Mar 2009 15:13:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

len is unsigned, so take care not to subtract below 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index ddfbea4..23447a0 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -916,7 +916,10 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 		xferfunc(drive, NULL, ptr, blen);
 
 		thislen -= blen;
-		len -= blen;
+		if (blen > len)
+			len -= blen;
+		else
+			len = 0;
 
 		if (blk_fs_request(rq)) {
 			rq->buffer += blen;
