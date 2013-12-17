From: Marc Carino <marc.ceeeee@gmail.com>
Subject: [PATCH 1/2] libata: add horkage flag to disable issuance of queued TRIM commands
Date: Mon, 16 Dec 2013 18:15:53 -0800
Message-ID: <1387246554-7311-2-git-send-email-marc.ceeeee@gmail.com>
References: <1387246554-7311-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58862 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3LQCQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Dec 2013 21:16:16 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so6004138oag.9
        for <linux-ide@vger.kernel.org>; Mon, 16 Dec 2013 18:16:16 -0800 (PST)
In-Reply-To: <1387246554-7311-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: marc.ceeeee@gmail.com, mykola.dvornik@gmail.com

Certain drives cannot handle queued TRIM commands properly, even though
support is indicated in the IDENTIFY DEVICE buffer. This patch allows
for disabling of the commands for the affected drives.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0e23c26..59f8f97 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -418,6 +418,8 @@ enum {
 	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
 	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
 	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
+	ATA_HORKAGE_BROKEN_QUEUED_TRIM = (1 << 19), /* device doesn't handle
+						       queued TRIMs correctly */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.8.1.3

