Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587932;
	b=IBprCT25vJMZRaY1bOdAPeS3pfA3qBpBR4H//iYSD9gkd7FPJ6GmrUSjtr/l0ZjdHMA8
	 RB/6rlt53bdzuLmDE+nXsfRP1Vq8kEn6NNNx1a4Xc5yIjzleW9S129AEhjN7opoEgFh+e
	 AL45rUJBIn0hx4bUasZpb58QA3zJjJXporHE7Mdls2vcQXkIXPR83NbA56iOIP53rLsA7
	 d6sU7vTJWaVz+y7LGNpIiunqqXMVg6d91pWAboDdiMCZKhsNDUZ3N2Qh1hDiecQ2kZu+y
	 ubS4hOj+GIPubyaVr2QcTN+rvVC7AFjixJmAT7nxzQxmBITnZj/16g5Do2zgqPoxGrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587932;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aWQrPeagJRuHhlv3UwVohIzY/ndLnIlqUr3hBo8qhN4=;
	b=jDKlXifN9XknHNF8ttPTolwk/Snuw4IGgomEisJPFltgtvK1JElH7ngRJEqRQ7qnALfj
	 kZT/WMn4QsX58WF4I6r0yG90BZMryOOiHWgAFWIph4ztQ5CwcSRZdsqHwdC6z+4yA/UOS
	 dAFbi4f+dBwciPqio9IQ7wKSfGUbc7r6gz8n+sLyDIY/Giqj2YlS5ER7PdcP+7JI+bxNk
	 C4R1H7oLfGUGWbNY34K0r33p8DsyCyzQCwxGdgXnjXSb7wTnbmYrze6/57d2fH0mf/a6z
	 lwSUviE7jbaTx0q59zpX6cpHkG0i+ZcDBxJcFRaQPEno9TCZh/fFPYU8wAYSwjPohuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANwfseDx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3A60A3807;
	Fri, 13 Nov 2026 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANwfseDx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587931;
	b=FPQod+xZcgov4am5UvhhKxVM3/XYCnmqf1qlOmO8QI4NcqeCJs43qvfAU9JbjPQzf7a2
	 lzULnx7gDbyQu9YJrSJWLyEM2MFnu84VpPSa05q7IDtRs5NiGhQTTJu7Aqk6dQ9x24XPQ
	 N32lYpU9T2cfsmeAoQjaNKrJd9puCynG76/gN7N5bzusuLncXpGsFA2be/8M2jmNfLeNI
	 OjIvV3Ra2sHfz+CqGzkGfneE5Md6s7TTQRDhJPgl996kVKhnA4mZBBKd13PKZ+CJTguMy
	 mZqgSk0EgYUd4aiP6tWWkCTm53S6A+4nS47ckGxMUGZ9vDPF9GqWeUSFF+vZKSnfeMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587931;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aWQrPeagJRuHhlv3UwVohIzY/ndLnIlqUr3hBo8qhN4=;
	b=Ox0GQEJMGgZhUCOqYDTR9ZFZdXSM22p0O7oXObwYi/V/g+p/sp/De69weM+AO0G5OU2s
	 60Xj1aFzJQRhWrMHyAHT5gd5jhcw7CA9W48uJUJ2M3LpAYdgSBZA1L8WGWcvjGpFaNDj2
	 T4N+uqCDhRBNyU8v3VpLJg/Hj2KHC5R/09bWCqXie3DYjR6HCfRIsqs6yQMxyQIeZfjeO
	 0gFLdJfBhC/5626sk36sE7pgKyuxv9gF9F83FvByA+c8Ki5mBKH4jVWWUdQKpP81Lc1fe
	 73XF3nUTsIUCCzE9qUi03l5PKS5uCVhLswuNNeGEqqniPEoO5A5QQy8Pw8PcbWnTXig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 673B91F000C8;
	Fri, 13 Nov 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587931;
	bh=aWQrPeagJRuHhlv3UwVohIzY/ndLnIlqUr3hBo8qhN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ANwfseDxlRVhtwI/+TDGsbXThfNorLa/nWtjxjgun5swENib16W2LvfsDBmNgJO8Y
	 LqcQ1t7KodxhOXluBrKg9Z8YJV6D4Q39LURJYARnwXywXdkuBYBlyw/TtwGFosedO1
	 6JiNPH0Li/FDSxkqiA2kA3OHM2Jm9CM7M6rsFYDdit5chlWTrcdDxgom/agRJQA2P/
	 quG7YRxRmyiWh7gQfLvCLSRK91dK1VaNJoWOE2paFHZX3em22Lq7tQW536C+kNpfMP
	 k16oy1gZsBAFuJjFpFiMEwvSO3cjtpy8VdK+1CoexEFhWeGDIQviLjLNbDI30PaHkZ
	 IsZfiP68Bhn5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B74F499AE;
	Fri, 13 Nov 2026 16:38:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:54 +0000
Subject: [PATCH 8/9] arm64: dts: rockchip: Attach the masters of the RK3588
 PHP SMMU
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-mmu600-php-v1-8-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
In-Reply-To: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=3063;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Eywo1baNrJ1Su6epW6UvLlR5LbuALQF4wCpKeTucpp0=;
 b=nZdrYLxPkrM8t5kgc8zE46GmG7YiEe37zQU/0qimGODqdNWa1XU0hl4ibHEnRFGyNy0jrx5Wz
 AIpNMKWpha+CX4LhWo3q5qXrGXglhp81dgdSq7IpUmmNkhylyT/XD48
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

GMAC0/1, SATA0-2 and USB3OTG_2 are behind MMU600_PHP with StreamIDs
1-6. No effect until the SMMU is enabled.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi  | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 3bf8d0e4ff33..cb0a39f63788 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -534,6 +534,7 @@ usb_host2_xhci: usb@fcd00000 {
 		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
 		reg = <0x0 0xfcd00000 0x0 0x400000>;
 		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+		iommus = <&mmu600_php 6>;
 		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
 			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
 			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
@@ -2310,6 +2311,7 @@ gmac1: ethernet@fe1c0000 {
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "macirq", "eth_wake_irq";
+		iommus = <&mmu600_php 2>;
 		clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
 			 <&cru PCLK_GMAC1>, <&cru ACLK_GMAC1>,
 			 <&cru CLK_GMAC1_PTP_REF>;
@@ -2357,6 +2359,7 @@ sata0: sata@fe210000 {
 		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
 		reg = <0 0xfe210000 0 0x1000>;
 		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
+		iommus = <&mmu600_php 3>;
 		clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
 			 <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
 			 <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
@@ -2380,6 +2383,7 @@ sata2: sata@fe230000 {
 		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
 		reg = <0 0xfe230000 0 0x1000>;
 		interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+		iommus = <&mmu600_php 5>;
 		clocks = <&cru ACLK_SATA2>, <&cru CLK_PMALIVE2>,
 			 <&cru CLK_RXOOB2>, <&cru CLK_PIPEPHY2_REF>,
 			 <&cru CLK_PIPEPHY2_PIPE_ASIC_G>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 2bcf30d8a338..425770a8ff61 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -538,6 +538,7 @@ gmac0: ethernet@fe1b0000 {
 		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "macirq", "eth_wake_irq";
+		iommus = <&mmu600_php 1>;
 		clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
 			 <&cru PCLK_GMAC0>, <&cru ACLK_GMAC0>,
 			 <&cru CLK_GMAC0_PTP_REF>;
@@ -585,6 +586,7 @@ sata1: sata@fe220000 {
 		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
 		reg = <0 0xfe220000 0 0x1000>;
 		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+		iommus = <&mmu600_php 4>;
 		clocks = <&cru ACLK_SATA1>, <&cru CLK_PMALIVE1>,
 			 <&cru CLK_RXOOB1>, <&cru CLK_PIPEPHY1_REF>,
 			 <&cru CLK_PIPEPHY1_PIPE_ASIC_G>;

-- 
2.55.0


