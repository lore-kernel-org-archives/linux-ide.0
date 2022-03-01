Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6FC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 15:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiCAP0G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiCAPZ4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 10:25:56 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA78BE0B;
        Tue,  1 Mar 2022 07:24:49 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 5B8445FD47;
        Tue,  1 Mar 2022 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646148288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4mDNDnNrc2l6l2KQYpl88DRF0oS2RB4UmRhs1zBpaA=;
        b=HprEB0730UH3XpwJHwa8vjTm1DZo+5lXhkA2Eb9BgsafDAOCIzFCOytOvgdxmNiLibaQnF
        FMgYDRzyjmbCcwIshFpAZ1w3/SeKCmaWO4RE37zSSNssdkDM0gKH5Oz+QN3P6Y+maJow7P
        A/iep4XYWCT4I8SG3tV4KG5vWfnZTAs=
Received: from localhost.localdomain (fttx-pool-80.245.77.190.bambit.de [80.245.77.190])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 47D3C10011C;
        Tue,  1 Mar 2022 15:24:47 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 4/5] dt-bindings: Add rk3568-dwc3-ahci compatible
Date:   Tue,  1 Mar 2022 16:24:20 +0100
Message-Id: <20220301152421.57281-5-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301152421.57281-1-linux@fw-web.de>
References: <20220301152421.57281-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6258418b-4d96-4beb-b093-528b24be8dfe
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add SoC specific compatible for rk3568 ahci controller

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4: new Patch
 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index ea1af283d125..7111cf448f45 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -29,6 +29,10 @@ properties:
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
         - const: generic-ahci
+      - items:
+        - enum:
+          - rockchip,rk3568-dwc-ahci
+        - const: snps,dwc-ahci
       - enum:
         - brcm,iproc-ahci
         - cavium,octeon-7130-ahci
-- 
2.25.1

