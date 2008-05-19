From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: kill unused constants
Date: Tue, 20 May 2008 02:17:50 +0900
Message-ID: <12112174751732-git-send-email-htejun@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:16517 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYESRSA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:00 -0400
Received: by po-out-1718.google.com with SMTP id c31so3028399poi.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:00 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

Kill a few unused constants.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 95a2000..989088e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -111,13 +111,10 @@ enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
 	LIBATA_DUMB_MAX_PRD	= ATA_MAX_PRD / 4,	/* Worst case */
-	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
 	ATA_MAX_QUEUE		= 32,
 	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
-	ATA_MAX_BUS		= 2,
-	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
-- 
1.5.2.4

