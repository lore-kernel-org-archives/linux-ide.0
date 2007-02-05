From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c cable check
Date: Mon, 5 Feb 2007 16:45:35 +0900
Message-ID: <20070205074535.GE1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:31364 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbXBEHpk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 02:45:40 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1530998wxd
        for <linux-ide@vger.kernel.org>; Sun, 04 Feb 2007 23:45:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable@kernel.org

The 80c wire bit is bit 13, not 14.  Bit 14 is always 1 if word93 is
implemented.  This increases the chance of incorrect wire detection
especially because host side cable detection is often unreliable and
we sometimes soley depend on drive side cable detection.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Please consider for -stable.  This bug has been copied from ide and
it's just amazing how long this has gone unnoticed.  Will post
separate patch for ide.

 include/linux/ata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/include/linux/ata.h
===================================================================
--- work.orig/include/linux/ata.h
+++ work/include/linux/ata.h
@@ -347,7 +347,7 @@ static inline int ata_drive_40wire(const
 {
 	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
 		return 0;	/* SATA */
-	if (dev_id[93] & 0x4000)
+	if (dev_id[93] & (1 << 13))
 		return 0;	/* 80 wire */
 	return 1;
 }
