Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B97C63697
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4369D206E5
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DL0dnBw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgKWURV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:17:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11573 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbgKWURT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:17:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d20000>; Mon, 23 Nov 2020 12:17:22 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:19 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:18 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] arm: tegra: Change order of SATA resets for Tegra124
Date:   Mon, 23 Nov 2020 12:17:20 -0800
Message-ID: <1606162645-22326-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162642; bh=dsJaMW2E8x66lSobB5W6JfCyLdlUss/7lLoDgCHhcrA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=DL0dnBw79rcFy6VlWnZsJ9TRi7DlZ3P2zNOlRZivGPwfpzmzgV6lzw4Y+YdIzBowx
         z3W734KQdM4ga6/h0rN5HPOWK1scNTmpMoOuDfZL9o2pGZSF8Cs2EX+E/blvwq01xB
         PDOPTDDY6V7sLTc6up7toyG3aJSEFiIH/rTA/5D5kCMj04Uf1SBpfoQf47rNc5i9M2
         bLntT+6PFMS+fhkw0nVY6FbaGL4ERCEWuXskDOAJ1X4yUB1JNj5zYgxOYlqpjt1iEI
         akWF0NpxB62vG7fGFvXSVJW5odf9d7F0bODYKZoReUxo3LT1zFd2Otr6ChKIyGR39w
         VkZPhR0fQgybA==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Tegra AHCI dt-binding doc is converted from text based to yaml based.

dtbs_check valdiation strictly follows reset-names order specified
in yaml dt-binding.

Tegra124 thru Tegra210 has 3 resets sata, sata-oob and sata-cold.
Tegra186 has 2 resets sata and sata-cold.

This patch changes order of SATA resets to maintain proper resets
order for commonly available resets across Tegra124 thru Tegra186
for dtbs_check to pass.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index d7001b2..e61e68a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -650,9 +650,9 @@
 			 <&tegra_car TEGRA124_CLK_PLL_E>;
 		clock-names = "sata", "sata-oob", "cml1", "pll_e";
 		resets = <&tegra_car 124>,
-			 <&tegra_car 123>,
-			 <&tegra_car 129>;
-		reset-names = "sata", "sata-oob", "sata-cold";
+			 <&tegra_car 129>,
+			 <&tegra_car 123>;
+		reset-names = "sata", "sata-cold", "sata-oob";
 		status = "disabled";
 	};
 
-- 
2.7.4

