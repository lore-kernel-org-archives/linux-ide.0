From: Tejun Heo <tj@kernel.org>
Subject: [PATCH for-4.7-fixes] libata: LITE-ON CX1-JB256-HP needs lower
 max_sectors
Date: Mon, 18 Jul 2016 18:42:39 -0400
Message-ID: <20160718224239.GL3078@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34023 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcGRWml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2016 18:42:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so63673pfb.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Jul 2016 15:42:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: dgerasimov@gmail.com

>From 1488a1e3828d60d74c9b802a05e24c0487babe4e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 18 Jul 2016 18:40:00 -0400

Since 34b48db66e08 ("block: remove artifical max_hw_sectors cap"),
max_sectors is no longer limited to BLK_DEF_MAX_SECTORS and LITE-ON
CX1-JB256-HP keeps timing out with higher max_sectors.  Revert it to
the previous value.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: dgerasimov@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=121671
Cc: stable@vger.kernel.org # v3.19+
Fixes: 34b48db66e08 ("block: remove artifical max_hw_sectors cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Patch applied to libata/for-4.7-fixes.

Thanks.

 drivers/ata/libata-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6be7770..31c183a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4314,6 +4314,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
 
+	/*
+	 * Device times out with higher max sects.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
+	 */
+	{ "LITEON CX1-JB256-HP", NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
-- 
2.7.4

