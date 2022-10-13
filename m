Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2371C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 13 Oct 2022 00:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiJMAaJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Oct 2022 20:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiJMA2w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2022 20:28:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F091285F5;
        Wed, 12 Oct 2022 17:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F90B81CE7;
        Thu, 13 Oct 2022 00:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881DFC43145;
        Thu, 13 Oct 2022 00:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665620735;
        bh=DEYN2CX6xftlzs5WQJZllkRHZ5Y381wGi7pAeZQhF7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXQ729xwUxR+jWiL9qXdMie6r9xgzMHXdGk2//b0J4C/1qf7Zr6GsqmgXQ7saM6Vu
         t+NP0FbeKIcu16e0x28wFYhE9csv6JH3cVNDrE6HnH/m/ftCi1x6FYLNxA3ZdKZstM
         YIgFPTrVF2gut1G14Vf5ndF/xD6OcgcDH7TkApVa+dIFJVBIxtoC8g0RvIbsw+XsMI
         Z9cm7olkLO41+q96jSwUOOj6vpYbuYb1P9YGMrRn2GKjZw4JRK7Qrr1+y8JOI7pOKt
         Wq5ksKTl/7+X+Krut3LxvugFQkCcqVm2/jI4h0+HqRFmkMXnN/2tUzoDd7xV5aovke
         OABMAN3ud5UEw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sasha Levin <sashal@kernel.org>, hdegoede@redhat.com,
        axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/27] ata: libahci_platform: Sanity check the DT child nodes number
Date:   Wed, 12 Oct 2022 20:24:42 -0400
Message-Id: <20221013002501.1895204-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002501.1895204-1-sashal@kernel.org>
References: <20221013002501.1895204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit 3c132ea6508b34956e5ed88d04936983ec230601 ]

Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
from the further AHCI-platform initialization point of view since
exceeding the ports upper limit will cause allocating more resources than
will be used afterwards. But detecting too many child DT-nodes doesn't
seem right since it's very unlikely to have it on an ordinary platform. In
accordance with the AHCI specification there can't be more than 32 ports
implemented at least due to having the CAP.NP field of 5 bits wide and the
PI register of dword size. Thus if such situation is found the DTB must
have been corrupted and the data read from it shouldn't be reliable. Let's
consider that as an erroneous situation and halt further resources
allocation.

Note it's logically more correct to have the nports set only after the
initialization value is checked for being sane. So while at it let's make
sure nports is assigned with a correct value.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci_platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 8a963d2a951d..c0ac25b80a1f 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -451,14 +451,24 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		}
 	}
 
-	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
+	/*
+	 * Too many sub-nodes most likely means having something wrong with
+	 * the firmware.
+	 */
+	child_nodes = of_get_child_count(dev->of_node);
+	if (child_nodes > AHCI_MAX_PORTS) {
+		rc = -EINVAL;
+		goto err_out;
+	}
 
 	/*
 	 * If no sub-node was found, we still need to set nports to
 	 * one in order to be able to use the
 	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
 	 */
-	if (!child_nodes)
+	if (child_nodes)
+		hpriv->nports = child_nodes;
+	else
 		hpriv->nports = 1;
 
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
-- 
2.35.1

