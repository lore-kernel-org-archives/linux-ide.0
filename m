Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E76C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 13 Nov 2021 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E924260FE7
	for <linux-ide@archiver.kernel.org>; Sat, 13 Nov 2021 06:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhKMG3q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 13 Nov 2021 01:29:46 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:59865 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhKMG3o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 13 Nov 2021 01:29:44 -0500
X-QQ-mid: bizesmtp51t1636784777tgdf0y1a
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 14:26:15 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: 3uawQE1sH+291VbBBWnryed0ntvm7R6avfLrXgIcdCpjaQtx7yWViNbybxB31
        uayKxrAeLP5YmUF3X5cba2dcLdT8r5bYWWE7vXZvC3i5OrUMXAwqvWD8vk7KyFDKMt5+pX2
        CRgEZnAMH6BVSXL3M2C74xYSDKM56njRagvOfWYswjvgDn4G5DrkQJoVpfSGq8H5IVmbPa+
        COLFF73PtitYD3hLUOHulzc/qMHi9DAnFmIv6ISaK/jaZMrOImJDzds1nPJ3XSaKrGeMYdp
        LVSd5FOCt8F6Hy8iwoCpmu981Evs9p9gtnusWCHQ5Ps6ubrgWvVDEcHKltwytDdSo1cCPio
        TExq5vZNffCiA+YSVC1X0R4Y/GZYQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ata: pata_ali: no need to initialise statics to 0
Date:   Sat, 13 Nov 2021 14:26:14 +0800
Message-Id: <20211113062614.246352-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Static variables do not need to be initialized to 0.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index b7ff63ed3bbb..ab28a6707b94 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -37,7 +37,7 @@
 #define DRV_NAME "pata_ali"
 #define DRV_VERSION "0.7.8"
 
-static int ali_atapi_dma = 0;
+static int ali_atapi_dma;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
-- 
2.33.0

