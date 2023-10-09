Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F11E95A8E
	for <linux-ide@archiver.kernel.org>; Mon,  9 Oct 2023 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376588AbjJIMud (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Oct 2023 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376584AbjJIMu1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Oct 2023 08:50:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D3A8E;
        Mon,  9 Oct 2023 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KXXre
        BVQdXZOPq21+dI2Ub8P0pQKFmcLRcl/V0uA8iQ=; b=mF2TVrA4nV5zi2oqQhR8a
        cSiUNotrGUBi0vUv7sjG6fK38SJwumPdkJPf/VGvYoOg/Dg3O60BnZRodrZ0j0EN
        htK6bnKWFnYgI4vjchlkGVIpHQBJG5YXXl8gpJcMg3msFxq1stQ1ySrXTrHJOPgl
        rJfwG3gpca6gt1DFuFJ1d0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wDnD9D09iNlFqBXAA--.35653S4;
        Mon, 09 Oct 2023 20:50:03 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v2] ata: sata_mv: aspeed: fix value check in mv_platform_probe()
Date:   Mon,  9 Oct 2023 20:49:55 +0800
Message-Id: <20231009124955.4046988-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnD9D09iNlFqBXAA--.35653S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rAw4fGw18tFy5tr17Awb_yoWfGwcEka
        y7urW7Wr429r4Dtw15Jw1ayrZ7KF4vvrsYvas2yw1ayr17Xw43XrWDXwnxu3yDWw48XFy0
        yr4UC3y3Cry5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtoGHUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyB0EC1p7MEUB+QAAs2
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In mv_platform_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/ata/sata_mv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 45e48d653c60..df3a02e7a50b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4125,8 +4125,10 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
-	else
-		clk_prepare_enable(hpriv->clk);
+	else {
+		rc = clk_prepare_enable(hpriv->clk);
+		goto err;
+	}
 
 	for (port = 0; port < n_ports; port++) {
 		char port_number[16];
-- 
2.37.2

