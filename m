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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEAC6379F
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B3720715
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I5X2+23L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgKWUR0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:17:26 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11577 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgKWURX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:17:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d60000>; Mon, 23 Nov 2020 12:17:26 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:23 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:22 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] arm64: tegra: Enable AHCI on Jetson TX2
Date:   Mon, 23 Nov 2020 12:17:24 -0800
Message-ID: <1606162645-22326-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162646; bh=qVTpNTARpxFPRZwBVNChWjl+Ht3cqycld42DMDClpBs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=I5X2+23LuVOcHvu3ahfFCKT6NskdiMsc4LFNB0FYVOnasfSFqFoHsWQSIvTc7iUnH
         T7aecwbTeL99wqyTXiwXfu0HmjR8SOCVbg34IzF53mx+qZKwr7q3hX7oNZBuoVcR+j
         wjsHve3ETOPQzChOabFl97IvrPFomFkfQXwrNcj1jTtel/TGkvNq58z8tjxqlLLIIJ
         Ormuzk7BMg8WEeevkULSlui1RtsMkNN70Wla0C2ftSPELRG7SGcIvakcCGcNbk3enN
         josDE3TfTvt/wbtgqsgjkT/t32LY+5OK6YNDLVywLFXNnyENYepuxTf2zlVldwPyKL
         Tp4wCg45ADWRA==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch enables AHCI on Jetson TX2.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  4 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 28 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index c28d51c..6fd2e05 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -285,6 +285,10 @@
 		};
 	};
 
+	sata@3507000 {
+		status = "okay";
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 98544d1..a303f45 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1503,6 +1503,34 @@
 		};
 	};
 
+	sata@3507000 {
+		compatible = "nvidia,tegra186-ahci";
+		reg = <0x0 0x03507000 0x0 0x00002000>, /* AHCI */
+		      <0x0 0x03500000 0x0 0x00007000>, /* SATA */
+		      <0x0 0x03A90000 0x0 0x00010000>; /* SATA AUX */
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_SAX>;
+		interconnects = <&mc TEGRA186_MEMORY_CLIENT_SATAR &emc>,
+				<&mc TEGRA186_MEMORY_CLIENT_SATAW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommus = <&smmu TEGRA186_SID_SATA>;
+
+		clocks = <&bpmp TEGRA186_CLK_SATA>,
+			 <&bpmp TEGRA186_CLK_SATA_OOB>;
+		clock-names = "sata", "sata-oob";
+		assigned-clocks = <&bpmp TEGRA186_CLK_SATA>,
+				  <&bpmp TEGRA186_CLK_SATA_OOB>;
+		assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLP_OUT0>,
+					 <&bpmp TEGRA186_CLK_PLLP>;
+		assigned-clock-rates = <102000000>,
+				       <204000000>;
+		resets = <&bpmp TEGRA186_RESET_SATA>,
+			<&bpmp TEGRA186_RESET_SATACOLD>;
+		reset-names = "sata", "sata-cold";
+		status = "disabled";
+	};
+
 	bpmp: bpmp {
 		compatible = "nvidia,tegra186-bpmp";
 		interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
-- 
2.7.4

