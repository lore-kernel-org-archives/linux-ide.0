Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66B290BCF;
	Thu, 24 Apr 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520779; cv=pass; b=BMNNGnYR3d6bRd2twRNXSoHFkjcbOlTgOP4aBPrUw1aixggONnWeKXktKUtg/BEJ7h7eelHL3R7ZuYLvnSDKPZTioFJZtTwEjSaRijPbXXmxhn/R3fOATN2E0Pu9GCo962dRoJg+CMqGoZmulZx3/9IqHdnZZ4tsrW4foRkh4ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520779; c=relaxed/simple;
	bh=Sg+eDpGcEpQdkzE7TxWgzlH0ZwatzsoX6GOqGOsS+1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvfUAfBgdgeWsZCo54jU19HkV0PVZYhgmZHp2FiKkpigfxRq7xcFngAYhXm6XlaweV2cL+tdcXo3/26Ges9w8KYomvnbj1CgTnBub4XoHLcNQ307UceKVB9jyWIXQuOq7cOu0kdEJeqDbFbhZcYpmaKq645vr9S9vd5u5ThRV8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GLoPQ0qk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GLoPQ0qk"
ARC-Seal: i=1; a=rsa-sha256; t=1745520759; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f67g/KglThRw5wVky3xH3nsJxM3eoPm5hIn3wIWY4iOPe5HwXKP1RHzKfGVh0C3M/XQkben49bhPSSOTFNw/G8IzA55lJXiyiVE7iZXchD9/+vuFo/GP2HRzN4I0H0pSS3SF5IaOaVB6E4PD5mQ3ILEs+5AxTQX9yIKYnNVxQ2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745520759; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/9frCnYTMVTpm5V5w18G/k5cDEAONcnNNbo6wTNm04s=; 
	b=hP8WLG6fOselEXBQxz0BWOU/y2Ut31m2VmH5SkMA6r6STNkJ1qDrpwOYruqna2dFLvluRyG4zGJ1yFMhKzZRJnkEda0uptTmrnV7ltB2okFT0wbY8JVOXxMRBVQMWMWGhwWWw65LGEZeJABa/7SteN5WwN4lZC0TQPv/v1G5ims=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745520759;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=/9frCnYTMVTpm5V5w18G/k5cDEAONcnNNbo6wTNm04s=;
	b=GLoPQ0qk1WjR+1lIkWWUByBXveFgWAkJUxbLRBc+5cA6tt8Jf6BHMFNWLzrpuvd4
	dPTcaH2V+S5yJUjlogYeDPuiATLZJKZK292R9CZtoN4Vrvkk8jRRANml9FBBmXbiqwP
	yqU4qcC/IMeL4aOoQNteksUTtZT0ugMpYZjCMUMA=
Received: by mx.zohomail.com with SMTPS id 1745520756849524.09816512909;
	Thu, 24 Apr 2025 11:52:36 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 24 Apr 2025 20:52:23 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: add SATA nodes to RK3576
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-rk3576-sata-v1-2-23ee89c939fe@collabora.com>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
In-Reply-To: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Rockchip RK3576 features two SATA nodes. The first, sata0, is behind
combphy0, which muxes between pcie0 and sata0.

The second, sata1, is behind combphy1, which muxes between pcie1, sata1
and usb_drd1_dwc3.

I've only been able to test sata0 on my board, but it appears to work
just fine.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index ebb5fc8bb8b1363127b9d3782801c4a79b678a92..6e27d744acad2111616eaf4807aea1eac4f00c7f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1334,6 +1334,36 @@ gmac1_mtl_tx_setup: tx-queues-config {
 			};
 		};
 
+		sata0: sata@2a240000 {
+			compatible = "rockchip,rk3576-dwc-ahci", "snps,dwc-ahci";
+			reg = <0x0 0x2a240000 0x0 0x1000>;
+			clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
+				 <&cru CLK_RXOOB0>;
+			clock-names = "sata", "pmalive", "rxoob";
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3576_PD_SUBPHP>;
+			phys = <&combphy0_ps PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			ports-implemented = <0x1>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata1: sata@2a250000 {
+			compatible = "rockchip,rk3576-dwc-ahci", "snps,dwc-ahci";
+			reg = <0x0 0x2a250000 0x0 0x1000>;
+			clocks = <&cru ACLK_SATA1>, <&cru CLK_PMALIVE1>,
+				 <&cru CLK_RXOOB1>;
+			clock-names = "sata", "pmalive", "rxoob";
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3576_PD_SUBPHP>;
+			phys = <&combphy1_psu PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			ports-implemented = <0x1>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		ufshc: ufshc@2a2d0000 {
 			compatible = "rockchip,rk3576-ufshc";
 			reg = <0x0 0x2a2d0000 0x0 0x10000>,

-- 
2.49.0

