Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C554CE92FFD
	for <linux-ide@archiver.kernel.org>; Sat,  7 Oct 2023 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjJGHm3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 7 Oct 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJGHm2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 7 Oct 2023 03:42:28 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F1CBF
        for <linux-ide@vger.kernel.org>; Sat,  7 Oct 2023 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WB7nK
        i52YjLc4sG3q3T1xtcsv16IVqBRlO8CrGHAiyQ=; b=TWSEngi9Ng51AvfcInrg1
        XNiGPvm3Qd1zYFdbMnUqX+CRFkdintfb07NQ/aBH8gmGfT2FBNdkiiuBb4Gsf3aZ
        /NWKABl0x2Ry9cM1fcW5KTWibu+07QtUoAAhu6JAaCsInoPOIt+sDy022Q13hRSP
        EvTmijHUD/Pa5MH9geMWqQ=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wDncjVDCCFlWnx6EA--.50896S4;
        Sat, 07 Oct 2023 15:27:06 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] ata: sata_mv: aspeed: fix value check in mv_platform_probe()
Date:   Sat,  7 Oct 2023 15:26:57 +0800
Message-Id: <20231007072657.4001311-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDncjVDCCFlWnx6EA--.50896S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFy5tr17Awb_yoWfXwbEka
        yxu39rWr429Fsrt345Xw13ArWxKF4vvFn0va4Iyw1ayr17Xa13JrWDXwsxu39xWw48AFy0
        vr1UC3y3Cry5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRthFxDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivgoCC1ZcjAVt3wAAsM
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In mv_platform_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/ata/sata_mv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 45e48d653c60..96f9841aae6c 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4125,8 +4125,11 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
-	else
-		clk_prepare_enable(hpriv->clk);
+	else {
+		rc = clk_prepare_enable(hpriv->clk);
+		if (rc)
+			return rc;
+	}
 
 	for (port = 0; port < n_ports; port++) {
 		char port_number[16];
-- 
2.37.2

