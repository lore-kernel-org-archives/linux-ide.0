Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936920;
	b=AUSNgQbEXMM2MjIaHw2eY4LbOLLWoWWUS9z4WFY5UZ3LXdf6xL020bRp9qvp24JayG3o
	 s2rcU7U1PFcXFVYI8GkQoXVsusliMTaL8cbe8RW4MgKC0LxbKxd6H9an6LygMr/F3xxiv
	 cE4rE2WRinor4GBG8M9gLJpgepR+8MTEYg+XdRgbrdqvtSL7Wr9kcLg8U1MHsZZHNGfzv
	 tzeHd/SWlWUUeWnLEzLMqpkY5S2QTC/GiD4CECKl5pykUUCQosrcDRbqODt2bQavBxzvM
	 B96oycnCxokY/xinIYnQ+AP9ocOQG+yelt5LFcw2anIABE8iSX/ysm8SiTXq2SHzDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936920;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uTnztLJQR+fLZMvHR4MbwlpHJ6bGzalLO0Qii68tS/U=;
	b=gpfnE/nlbEEvuvIhM3bB2YjwUGMLBy2bs1JVomCRXX74+Y3vh+fxc3B4/Dn/r1vxTSKh
	 rCiUFxnRzExEVjNooOtPnr/2FagF1DGVLxuRz5IWid67ilYxVIfR11A7oeH3ZRYW8oElo
	 z4XUzziEOB5F97qR/QpDPvWsfCZdKNz6eFVevMgMb7JelZ1hAq9Fwju7UJTUxAHNl91Cz
	 MlUBoAw/lnFKeFyEzbB51FobVMSefV7ZMzAToFql/JhgPdi5UPiMOPdGWh5T22trTYpzg
	 /n426ZD37rmXkgINaCym3FqgLm1kn/bJEWm9HtXAAjxJstqRFEqvHTalG4F1G3mUN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5Sb8ZAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E6606A33F;
	Tue, 17 Nov 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5Sb8ZAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0311F000CA;
	Tue, 17 Nov 2026 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936920;
	bh=uTnztLJQR+fLZMvHR4MbwlpHJ6bGzalLO0Qii68tS/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y5Sb8ZARbyMp0CDy5GmbW+vgUiAxxXstzq2ccWfFtGNkFwUsypXt9Xq1E4D3HvCex
	 +EAkMKZTwP9zVNnF5D9o7tI4AjaEG7jzeo6mOBZbem7CwjFqFnvRjHlj/VCsgylvli
	 7LpsMxTAhQrZsLALA0oEQqXYpX3qqq4CJZpvOtuLkrle7koKhzTP9ZrEtIy673Fxbx
	 qKwzt2/EjriuQCwcAT7KbWEE3QfV3gaTequXur4i8uD4cvZomYQCm2ca2CwmW3ZaLd
	 16/R3Uh39YuXeBcJFkaePPhmpMaj/Afn1S0/Bs5llNEkbpHJgnhwNNbokI1zY5tICf
	 g6zwCJW9fg6UQ==
Subject: Re: [PATCH 7/9] arm64: dts: rockchip: Add the clock and reset of the
 RK3588 PHP SMMU
From: netdev-bot+sashiko@kernel.org
To: aiyengar1990@gmail.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, david.wu@rock-chips.com,
 dlemoal@kernel.org, cassel@kernel.org, fancer.lancer@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, praan@google.com,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 shawn.lin@rock-chips.com, sebastian.reichel@collabora.com
Date: Tue, 17 Nov 2026 17:35:18 +0000
Message-ID: <179493691896.3136.9977830842313145372@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-7-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-7-231196049a3b@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not do what its commit message says.
- [Medium] The patch adds `clocks` and `resets` to the mmu600_php node
  (compatible = "arm,smmu-v3"), but…
- [Medium] The commit message says the clock and reset are described "as
  for the PCIe SMMU", but the PCIe SMMU node has neither.

--

arm64: dts: rockchip: Add the clock and reset of the RK3588 PHP SMMU

This commit adds a clocks property (ACLK_MMU_PHP) and a resets property
(SRST_A_MMU_PHP) to the mmu600_php node in rk3588-base.dtsi. The stated
goal is to keep the SMMU clocked while its masters are idle.

> Describe ACLK_MMU_PHP, so the SMMU keeps its clock while its masters
> are idle, and SRST_A_MMU_PHP, as for the PCIe SMMU.

[Severity: Medium]
Is the "as for the PCIe SMMU" reference accurate? The mmu600_pcie node in
rk3588-base.dtsi has no clocks or resets:

	mmu600_pcie: iommu@fc900000 {
		compatible = "arm,smmu-v3";
		reg = <0x0 0xfc900000 0x0 0x200000>;
		interrupts = <GIC_SPI 369 IRQ_TYPE_EDGE_RISING 0>,
		...
		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
		#iommu-cells = <1>;
	};

No rockchip DTS uses ACLK_MMU_PCIE or SRST_A_MMU_PCIE. The only MMU_PCIE
or MMU_PHP references are the two lines this patch adds.

mmu600_pcie is enabled by default, and its clock sits in the same place in
clk-rk3588.c. aclk_mmu_pcie is the parent of the aclk_pcie_*_mstr clocks:

	GATE(ACLK_MMU_PCIE, "aclk_mmu_pcie", "aclk_pcie_bridge", 0,
			RK3588_CLKGATE_CON(34), 7, GFLAGS),

Is a matching change for mmu600_pcie missing, or should the commit message
be reworded? If the reasoning is right, why does the PCIe SMMU not need
the same change?

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index 8807ce6193bfc..3bf8d0e4ff332 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -570,6 +570,8 @@ mmu600_php: iommu@fcb00000 {
>  			     <GIC_SPI 386 IRQ_TYPE_EDGE_RISING 0>,
>  			     <GIC_SPI 379 IRQ_TYPE_EDGE_RISING 0>;
>  		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
> +		clocks = <&cru ACLK_MMU_PHP>;
> +		resets = <&cru SRST_A_MMU_PHP>;

[Severity: High]
Does anything use these properties? mmu600_php binds to the generic
arm-smmu-v3 driver. arm_smmu_device_probe() never gets or enables a clock
and never touches a reset line.

There are no clk, reset_control or pm_runtime calls under
drivers/iommu/arm/arm-smmu-v3/, even at the end of the series. The
platform bus does not enable DT clocks by itself. The node also has no
power-domains that could add a pm_clk.

The gate is registered with flags 0 in clk-rk3588.c:

	GATE(ACLK_MMU_PHP, "aclk_mmu_php", "aclk_php_root", 0,
			RK3588_CLKGATE_CON(34), 8, GFLAGS),

So its enable count still comes only from its children: ACLK_GMAC0/1,
ACLK_SATA0/1/2 and ACLK_USB3OTG2. When the last of those masters disables
its aclk, the gate closes just as it did before this patch. If no master
ever enables it, clk_disable_unused() can close it at late_initcall.
Nothing drives SRST_A_MMU_PHP either.

The later patch "arm64: dts: rockchip: Enable the RK3588 PHP SMMU" removes
status = "disabled". After the series, the SMMU probes on every RK3588
board without the clock hold the commit message describes.

Later SMMU activity can then run with aclk_mmu_php gated, for example
cmdq, CFGI or TLBI commands on attach and detach, or event and gerror
handling. What a gated clock does to the SMMU at that point depends on the
Rockchip clock topology.

Does the SMMU driver need to own the clock and reset instead? That could
be devm_clk_bulk_get_all_enabled() plus reset handling in
arm_smmu_device_probe(), or a Rockchip impl hook behind a SoC-specific
compatible.

[Severity: Medium]
Will these properties pass dtbs_check? The binding
Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml lists neither
clocks nor resets, and it ends with:

additionalProperties: false

dtbs_check also validates disabled nodes. So every DTB that includes
rk3588-base.dtsi would flag 'clocks' and 'resets' as unexpected. No patch
in the series changes the iommu binding.

Would this need a SoC-specific compatible with conditional clocks and
resets in the binding, like the existing nvidia,tegra264-smmu entry, along
with driver support?

>  		#iommu-cells = <1>;
>  		status = "disabled";
>  	};

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
