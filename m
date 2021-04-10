Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C2AC433ED
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4988C610F9
	for <linux-ide@archiver.kernel.org>; Sat, 10 Apr 2021 14:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhDJOZL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 10 Apr 2021 10:25:11 -0400
Received: from m12-13.163.com ([220.181.12.13]:56304 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234781AbhDJOY4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 10 Apr 2021 10:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M3pE8
        79huBIU0JRzqJ2pcE9coxXHeCptiOi+gjhWg+I=; b=fJKzt+LVwGgj8ly+RAI3a
        6FuZZouMd1YRKMVpzcHRs1TvqnCgG39J6Jqkt74e7wk/zO++NSAVaJ9a8nIq67li
        7pwePokj9vyQjpSIBjXSrB9mc2weha0clSfjdv/60dME9YxO+CJEGFuf+WLBMLDP
        s4avBbbd5BSe/m5EoagzSs=
Received: from yangjunlin.ccdomain.com (unknown [119.137.53.114])
        by smtp9 (Coremail) with SMTP id DcCowAA3nbhAsXFgiRE5FQ--.33694S2;
        Sat, 10 Apr 2021 22:08:01 +0800 (CST)
From:   angkery <angkery@163.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v2] pata_ipx4xx_cf: Fix unsigned comparison with less than zero
Date:   Sat, 10 Apr 2021 22:07:57 +0800
Message-Id: <20210410140757.2093-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA3nbhAsXFgiRE5FQ--.33694S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1fKw1xWw13tF4kAr4fZrb_yoW8Jw4DpF
        WUCaykurWkJas09w4kJr47ZF13JFn5W3yIv3y3C3y3Zrn8XrykJFySga4jvF1qkrZ7Gr13
        try5tr4UWFsrZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jToGQUUUUU=
X-Originating-IP: [119.137.53.114]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBHglwI13mAONV1wAAse
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

The return from the call to platform_get_irq() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'irq', so making 'irq' an int, and change the position to
keep the code format.

Fixes coccicheck warnings:
./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
WARNING: Unsigned expression compared with zero: irq < 0

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
changes in v1:
update the commit information.
changes in v2:
As Sergei said, it should read irq < 0, update commit information.

 drivers/ata/pata_ixp4xx_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index abc0e87..43215a4 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -135,12 +135,12 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 
 static int ixp4xx_pata_probe(struct platform_device *pdev)
 {
-	unsigned int irq;
 	struct resource *cs0, *cs1;
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
 	int ret;
+	int irq;
 
 	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
1.9.1


