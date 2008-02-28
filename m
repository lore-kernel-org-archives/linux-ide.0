From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] use ATA_TAG_INTERNAL in ata_tag_internal()
Date: Thu, 28 Feb 2008 21:43:13 +0900
Message-ID: <20080228214313.70129569.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mfo32.po.2iij.NET ([210.128.50.15]:19842 "EHLO
	mfo32.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYB1MvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 07:51:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-ide@vger.kernel.org

It should be ATA_TAG_INTERNAL.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/linux/libata.h linux/include/linux/libata.h
--- linux-orig/include/linux/libata.h	2008-02-28 13:29:13.659279943 +0900
+++ linux/include/linux/libata.h	2008-02-28 13:29:48.221249519 +0900
@@ -1123,7 +1123,7 @@ static inline unsigned int ata_tag_valid
 
 static inline unsigned int ata_tag_internal(unsigned int tag)
 {
-	return tag == ATA_MAX_QUEUE - 1;
+	return tag == ATA_TAG_INTERNAL;
 }
 
 /*
