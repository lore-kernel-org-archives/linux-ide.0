Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34080C56201
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 02:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D198320735
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 02:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nDHroDoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKFCQM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:16:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12513 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKFCQK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2020 21:16:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4b1ec0000>; Thu, 05 Nov 2020 18:16:12 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 02:16:10 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 02:16:09 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/4] arm64: tegra: Enable AHCI on Jetson TX2
Date:   Thu, 5 Nov 2020 18:16:07 -0800
Message-ID: <1604628968-1501-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604628972; bh=r3AVUbvt3RNfrllkiehC3fL0fC0040AbIRoa2VJA/gs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=nDHroDoejbEUUp7P4sZcKrbV1s/Y+2GaJiSrVvpZU3h7y372aL6QtnWMh5GYyAYHc
         TeeZq8JB15LHD5X+8mJtTW4YjPoi4IkGY0qFfQHjTHRrEZSMpS5Q/aXWDNVibKKrbQ
         ZV7/nx4MFpYsfVduNO+z/kTjJjeU5XpecQQDAXK+pZw2UQvN1B8QuuupLMQziz9pBt
         IOaqhdMoN56/tHOJYBX3KQT/3ScGLPehM+8fI2c00mUbuOGJUA3DKqjjp/upuQibow
         1wnMETaUuxQnUQCPm0Cc1FfWG5k57Fzj8/qGRvHt6optQrbsjsTWnuRRQTO3/oJFH+
         OS6pQq2StCc+Q==
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
index 381a84912..7e1723e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -297,6 +297,10 @@
 		};
 	};
 
+	sata@3507000 {
+		status = "okay";
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0c46ab7..7f5c002 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1501,6 +1501,34 @@
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

