From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c cable check, take 2
Date: Mon, 5 Feb 2007 21:41:06 +0900
Message-ID: <20070205124106.GK1625@htj.dyndns.org>
References: <20070205074535.GE1625@htj.dyndns.org> <20070205105744.6f22fc7d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:7053 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbXBEMlL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 07:41:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1583643wxd
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 04:41:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070205105744.6f22fc7d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

The 80c wire bit is bit 13, not 14.  Bit 14 is always 1 if word93 is
implemented.  This increases the chance of incorrect wire detection
especially because host side cable detection is often unreliable and
we sometimes soley depend on drive side cable detection.  Fix the test
and add word93 validity check.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Thanks for pointing out, fixed accordingly.

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1df9416..ea2d597 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -347,7 +347,7 @@ static inline int ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
 		return 0;	/* SATA */
-	if (dev_id[93] & 0x4000)
+	if ((dev_id[93] & 0xC000) == 0x4000 && (dev_id[93] & 0x2000))
 		return 0;	/* 80 wire */
 	return 1;
 }
