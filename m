From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c cable check, take 3
Date: Mon, 5 Feb 2007 23:21:19 +0900
Message-ID: <20070205142119.GM1625@htj.dyndns.org>
References: <20070205074535.GE1625@htj.dyndns.org> <20070205105744.6f22fc7d@localhost.localdomain> <20070205124106.GK1625@htj.dyndns.org> <20070205132706.1ff6d761@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:54490 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932814AbXBEOVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 09:21:24 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1616216nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 06:21:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070205132706.1ff6d761@localhost.localdomain>
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
Sure, updated as suggested.

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1df9416..939be94 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -347,7 +347,7 @@ static inline int ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
 		return 0;	/* SATA */
-	if (dev_id[93] & 0x4000)
+	if ((dev_id[93] & 0xE000) == 0x6000)
 		return 0;	/* 80 wire */
 	return 1;
 }
