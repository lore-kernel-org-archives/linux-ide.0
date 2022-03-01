Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07DC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiCAPZ6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiCAPZc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 10:25:32 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FB8A6EA;
        Tue,  1 Mar 2022 07:24:48 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 5592B401AC;
        Tue,  1 Mar 2022 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646148286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvM/I1oBTjBlwWa4oI6EL2zWGeQZf22/TQ7on05EAo0=;
        b=tcABabNGeU9UPyXoSKOwdEWXcE5qvwx01hME3ZuAnkOp1GQj3PC8hklda/MrvDDz7Hexvo
        X7XpYnzYjRCs03sufxg2ekXhCXgcv/+bq9LaPN90McOlO/zsIn0pG6QvWl7B6W3t1dmGGZ
        q2K35Yb/zVBj2hRSdZtv74yDIqQOYig=
Received: from localhost.localdomain (fttx-pool-80.245.77.190.bambit.de [80.245.77.190])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 2EFF010011C;
        Tue,  1 Mar 2022 15:24:45 +0000 (UTC)
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
Subject: [PATCH v4 2/5] arm64: dts: broadcom: Fix sata nodename
Date:   Tue,  1 Mar 2022 16:24:18 +0100
Message-Id: <20220301152421.57281-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301152421.57281-1-linux@fw-web.de>
References: <20220301152421.57281-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: aa3616cc-85b9-47a9-bd4f-f6f08ce454ab
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

After converting ahci-platform txt binding to yaml nodename is reported
as not matching the standard:

arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml:
ahci@663f2000: $nodename:0: 'ahci@663f2000' does not match '^sata(@.*)?$'

Fix it to match binding.

Fixes: ac9aae00f0fc ("arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
 - new Patch
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 2cfeaf3b0a87..8c218689fef7 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -687,7 +687,7 @@ sata_phy1: sata-phy@1 {
 			};
 		};
 
-		sata: ahci@663f2000 {
+		sata: sata@663f2000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x663f2000 0x1000>;
 			dma-coherent;
-- 
2.25.1

