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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31FC64E75
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4C020715
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jJu20bAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgKWURw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:17:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2123 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgKWURU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:17:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d60003>; Mon, 23 Nov 2020 12:17:26 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:20 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:19 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] arm64: tegra: Change order of SATA resets for Tegra132 and Tegra210
Date:   Mon, 23 Nov 2020 12:17:21 -0800
Message-ID: <1606162645-22326-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162646; bh=zpLEidUhozh9F2rcxc6BWtGsrDvmZrZdbTb8XgzAZWc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=jJu20bAr9iCxuk5oXpLqsI3uTqMC21ym90OrVf9DOuiOM1fTqhqe/boiOVPf0a8Be
         xCeKbrGKu7/bJ8Rb5GTxLxGCd4USlXQbRbBsPNxKjV5TG/VejPeMgMqKzr5u6lRUwN
         M7XeJiKOZ4Z6CulbTjvoc0vA6AplEhcTGrzC8X0sQiy4ql8YY6+HXMPI7xadQfyZO3
         rVpqEawrdzvZgfR+GWDZNDjzQ0DeX5hwXpgPF95UgTZS55eF4Yuxqsp/tiI4jC0PpD
         rI3vrTnBSVt0E+pjjQ5KrjFLaXzG7IPIgzv1V21aQlhDSY6DOE8O/R1qBMkcr8h8Zx
         RaovJ6A+kSu7w==
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
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 0ce958a..9928a87 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -629,9 +629,9 @@
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
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 6d2a9d2..ffe5da7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -979,9 +979,9 @@
 			 <&tegra_car TEGRA210_CLK_SATA_OOB>;
 		clock-names = "sata", "sata-oob";
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

