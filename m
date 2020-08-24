Return-Path: <SRS0=MqiA=CC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D6C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 24 Aug 2020 20:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC6E204EA
	for <linux-ide@archiver.kernel.org>; Mon, 24 Aug 2020 20:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kN9FCpEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHXUkM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:40:12 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47754 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgHXUkM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Aug 2020 16:40:12 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3475C30C59A;
        Mon, 24 Aug 2020 13:37:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3475C30C59A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1598301438;
        bh=VUcYyNhxVc56Z1xLuntQ21z2Ol04rpFCa0F1A3b4tjA=;
        h=From:To:Cc:Subject:Date:From;
        b=kN9FCpEJYHAPr9gXB2XjBiqWrzhRYXBlIhExa8sIzGmCKsFCu/3IH+THutR7wWErf
         M5T8U7waXJz0g+UGZy8YFIMEdmhWnOIaqAu8VhbhaUxAtC24Bm+r1ssVcB8yGZSLRv
         7TZHrO8RmYQbhbjR4IjqcR2MwBWaUdGegkmeqRxE=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2FC301400A6;
        Mon, 24 Aug 2020 13:40:07 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Mon, 24 Aug 2020 16:40:02 -0400
Message-Id: <20200824204002.45500-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

A reset controller "rescal" is shared between the AHCI driver and the PCIe
driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared() to handle this sharing.

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6853dbb4131d..d6115bc04b09 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 
 	/* Reset is optional depending on platform and named differently */
 	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
+		priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
 	else
-		reset_name = "ahci";
+		priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
 
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
 	if (IS_ERR(priv->rcdev))
 		return PTR_ERR(priv->rcdev);
 
@@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
-- 
2.17.1

