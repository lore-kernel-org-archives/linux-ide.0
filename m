From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] ata: correctly handling failed allocation
Date: Tue, 29 Dec 2015 16:21:15 -0500
Message-ID: <1451424075-19654-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:33819 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbbL2VSc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Dec 2015 16:18:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>

Since kzalloc can be failed in memory pressure, return error when failed.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/ata/sata_sx4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index fab504f..48301cb 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1396,6 +1396,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		addr = 0;
 		length = size * 1024 * 1024;
 		buf = kzalloc(ECC_ERASE_BUF_SZ, GFP_KERNEL);
+		if (!buf)
+			return 1;
 		while (addr < length) {
 			pdc20621_put_to_dimm(host, buf, addr,
 					     ECC_ERASE_BUF_SZ);
-- 
1.9.1

