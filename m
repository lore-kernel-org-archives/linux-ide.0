Return-Path: <SRS0=yu+U=AE=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970ACC433DF
	for <linux-ide@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762E620774
	for <linux-ide@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933968;
	bh=W1eadARlGahJjOg5KrWyJCvs5DwkTNwLFWf11lo/REc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f6gx5q9KXv9/7PzLT83q4SWulIfjOI7ePdAJN1Y0DrZbdjnAwCqg9tuMkMWlGc2cT
	 /+v2ySQjOx7M5ykU3U9Sy0voDfzUluPulYMuaOUu3gZYU9NEHMm2O1V4sm/yfOBGUO
	 2kKsCMNU55mFiCiet1WPaa1qWn2JaO5oxwaX5l3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgFWRjX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732971AbgFWRgc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CDBB207E8;
        Tue, 23 Jun 2020 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933792;
        bh=W1eadARlGahJjOg5KrWyJCvs5DwkTNwLFWf11lo/REc=;
        h=From:To:Cc:Subject:Date:From;
        b=yGTZcKHw6OAlKsFjAyLaxMhM54WM2UmY1ns9a8oaKUnUaq537qcg36ShltF9Hw8YR
         SxEVlceLkAYEdHBmNAcIPsahCY572ah4W04xfE8qOiSmSDTVxCZDTf2Vq2y5TX3YGn
         Qu0cf62rLFce5Lqzzd3hr5bUQPbkJ4crGnPR4Rnk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/15] sata_rcar: handle pm_runtime_get_sync failure cases
Date:   Tue, 23 Jun 2020 13:36:16 -0400
Message-Id: <20200623173630.1355971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit eea1238867205b9e48a67c1a63219529a73c46fd ]

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 03867f539f3a8..50ebd779d975f 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -909,7 +909,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		goto err_pm_disable;
+		goto err_pm_put;
 
 	host = ata_host_alloc(dev, 1);
 	if (!host) {
@@ -940,7 +940,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-err_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -994,8 +993,10 @@ static int sata_rcar_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	if (priv->type == RCAR_GEN3_SATA) {
 		sata_rcar_init_module(priv);
@@ -1020,8 +1021,10 @@ static int sata_rcar_restore(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	sata_rcar_setup_port(host);
 
-- 
2.25.1

