Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936922;
	b=kc89ppd6PIyKoP0+L4UNvKz0s0McHxNUrtI3RqrAI9K0M4WNn3WOyDGwVID09wXLVLci
	 aszfm86D5U3ox6NVbAu3JV7SAohYcj/2zFATiBajoppkGNvlaKyxsFiWeGih979FL8h5+
	 109c+kv3R4cArhQnu0AJGb+6ZOYnrI9uJ5v+vGshydv9uhl/vWVgzMBX7WFNw9MlE912c
	 hsSR8oFwKfR+taV7JDI/QXY5CKyJ8LHUlwKcjOEgyI3qc2ehaOUfzjZWaOtYse31FYEz8
	 1E3+2yM6SAT0QHnf2oos5XJnccBKDfmlgpdAcmGSUFnVYZxaT2pR4na/NVPCwtz71ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936922;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7gBvz52KX2fm4JXHqvNvYct7fnC36l4OBFFtesBApY0=;
	b=FUEH/6lM0+1/Upc+z2OECp9Rf81+yGzwwHQzlz7PcZjkay2uu+nbQKuInkascCHlfoBb
	 JMhDkIqRN+XXIT6O8+gOZtBYpAs7LxNBJGK6tNc+0R3HRiU4J5Gxfm8knHzipq8WhSYXV
	 cYswWA/jnzjmnlr7WWCB9+6B5PVcl3G2OoPayh3L1z9Glfiq6361W4uz2Aox9qsY71MaV
	 cAYj70FeJumWQg5uk/3FByheo6bYkiBf4ykyR2TKQYRdTDBpcWIAnW2aZ+fbPHX8adM02
	 P88VKnwtQgTbqukSj4U1W7pQYs5ymvKm8YOyv0SDJAB2IRT7UQdEvl5o3Vp+rbm6Mcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+fYEYZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD325606A889;
	Tue, 17 Nov 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+fYEYZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EBF1F0092F;
	Tue, 17 Nov 2026 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936922;
	bh=7gBvz52KX2fm4JXHqvNvYct7fnC36l4OBFFtesBApY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k+fYEYZHzsmCqDcNgpuFCcgqIRs4iFOMw83ScY4DFsuvsiDbozMZ2gTj9Fwl8UN6Z
	 Z+SpgCYr9xjTkqHvgnQerC1TZAyUW5fWrGQinTX+Q3f9r7vG8NN0r7C/FuppHc9bhO
	 9GYhXXwkyzJPPjpTNxWKUdKSvKYAcFx0zQddXrFYk4ggF3T1XaZ53+nGl+7q8eBCey
	 NJE3Uq/41w34WcR2bUT6ObIuiYmmDyUVNotmcWz3WrfDlrNemY4vqrTUtq9By/qm/T
	 m+u8tpRRidEcCTy+Qd/aaEg5se4P/LigixqKdCEyR/T9PiiK7CPehALV6Kyl/x1C/U
	 p83WSZ761hRwQ==
Subject: Re: [PATCH 8/9] arm64: dts: rockchip: Attach the masters of the
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
Date: Tue, 17 Nov 2026 17:35:20 +0000
Message-ID: <179493692082.3136.9767912829887161888@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-8-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-8-231196049a3b@gmail.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Once mmu600_php is enabled, this patch makes all DMA from
  GMAC0/1, SATA0-2 and USB3OTG_2 depend on SMMU state: CR0.SMMUEN, the…
- [Medium] This patch points GMAC0/1, SATA0-2 and USB3OTG_2 at the
  mmu600_php node.
- [Low] The commit message describes StreamIDs 1-6 as a property of the
  hardware: "GMAC0/1, SATA0-2 and USB3OTG_2 are behind MMU600_PHP with…

--

arm64: dts: rockchip: Attach the masters of the RK3588 PHP SMMU

This patch adds iommus properties to GMAC0/1, SATA0-2 and USB3OTG_2 on
RK3588. They point at the PHP SMMU (mmu600_php) with StreamIDs 1 to 6.
The SMMU node is still disabled at this point in the series.

> GMAC0/1, SATA0-2 and USB3OTG_2 are behind MMU600_PHP with StreamIDs
> 1-6. No effect until the SMMU is enabled.

[Severity: Low]

Are StreamIDs 1-6 a property of the hardware? An earlier patch in this
series, "soc: rockchip: grf: Assign the StreamIDs of the RK3588 PHP SMMU
masters", says the PHP GRF StreamID registers "reset to 0 and are never
programmed".

The values only become true because rockchip_grf_init() writes them, and
rockchip_grf_resume() writes them again after suspend:

drivers/soc/rockchip/grf.c:
static const struct rockchip_grf_value rk3588_defaults_php_grf[] = {
	{ "gmac0 write streamid", RK3588_PHP_GRF_GMAC0_SID_AW, 1 },
	...
	{ "usb3otg2 read streamid", RK3588_PHP_GRF_USB3OTG2_SID_AR, 6 },
};

So the iommus specifiers in this patch encode a choice made by a Linux
driver, not fixed hardware.

Some software could use this DT with the SMMU enabled but without that
GRF programming. Examples are a stable backport that takes only the DTS
patches, U-Boot passing this DT through, or another OS. In that case
every master would emit SID 0. By the series' own design SID 0 is
unused, so DMA from all six masters would be aborted.

In-tree Linux sees no runtime effect here. The GRF patch comes earlier
in the series and mmu600_php is still disabled.

Could the commit message say this, and name the GRF patch as a hard
prerequisite?

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index 3bf8d0e4ff332..cb0a39f637887 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -534,6 +534,7 @@ usb_host2_xhci: usb@fcd00000 {
>  		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
>  		reg = <0x0 0xfcd00000 0x0 0x400000>;
>  		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> +		iommus = <&mmu600_php 6>;

[Severity: Medium]

These iommus entries make the masters depend on mmu600_php, which in
this tree has:

	mmu600_php: iommu@fcb00000 {
		compatible = "arm,smmu-v3";
		...
		clocks = <&cru ACLK_MMU_PHP>;
		resets = <&cru SRST_A_MMU_PHP>;
		#iommu-cells = <1>;
		status = "disabled";
	};

Does anything accept or use these two properties?

Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml defines no
clocks or resets and ends with additionalProperties: false. The series
does not change that binding. Would dtbs_check then reject mmu600_php on
every RK3588 DTB?

The arm-smmu-v3 driver also has no clk_* or reset_control_* calls
anywhere under drivers/iommu/arm/arm-smmu-v3/. So the SMMU never holds
this clock.

The series says the clock is there "so the SMMU keeps its clock while
its masters are idle". The final commit "arm64: dts: rockchip: Enable
the RK3588 PHP SMMU" relies on "the SMMU has its clock". In
drivers/clk/rockchip/clk-rk3588.c it is a plain gate without
CLK_IS_CRITICAL:

	GATE(ACLK_MMU_PHP, "aclk_mmu_php", "aclk_php_root", 0,
			RK3588_CLKGATE_CON(34), 8, GFLAGS),

Its only enablers are its children: ACLK_GMAC0/1, ACLK_SATA0/1/2 and
ACLK_USB3OTG2.

Can clk_disable_unused, or the masters going idle, gate this clock while
the SMMU is live? Some examples:

  - arm_smmu_attach_dev() runs before a modular master driver enables
    its clocks
  - all masters are runtime suspended
  - a board enables none of these masters

The series implies that ACLK_MMU_PHP clocks the SMMU register interface.
If so, could command queue accesses, CMD_SYNC polling or the IRQ
handlers hang the bus or time out? That would look like the PHP GRF hang
described in "Add the PHP GRF clock on RK3588".

>  		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
>  			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
>  			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> @@ -2310,6 +2311,7 @@ gmac1: ethernet@fe1c0000 {
>  		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH 0>,
>  			     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
>  		interrupt-names = "macirq", "eth_wake_irq";
> +		iommus = <&mmu600_php 2>;

[Severity: High]

Once mmu600_php is enabled, all DMA from GMAC0/1, SATA0-2 and USB3OTG_2
depends on SMMU state:

  - CR0.SMMUEN
  - the stream table and queue base registers
  - the STEs for SIDs 1-6

What restores that state after deep suspend?

arm_smmu_driver in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c has no
.pm ops:

	.probe	= arm_smmu_device_probe,
	.remove = arm_smmu_device_remove,
	.shutdown = arm_smmu_device_shutdown,

So arm_smmu_device_reset() only runs at probe.

The final commit of the series, "arm64: dts: rockchip: Enable the RK3588
PHP SMMU", says:

  "PD_PHP is powered off in deep suspend and the SMMU resumes from reset
  in bypass, so this needs arm-smmu-v3 system sleep support [1]"

That support is not in this tree. Even so, that commit removes
status = "disabled" from mmu600_php for every RK3588 board.

Take a board with an active PHP master and run
echo mem > /sys/power/state. After resume, only the PHP GRF StreamIDs
are restored, by rockchip_grf_resume(). The GMAC descriptor rings, AHCI
command lists and xHCI rings still hold IOVAs.

Wouldn't their DMA go out untranslated, with the IOVAs used as physical
addresses?

This patch alone does nothing while the SMMU is disabled. But it creates
the dependency, and the problem is still present at the end of the
series. Should the enable commit wait until arm-smmu-v3 system sleep
support has landed?

>  		clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
>  			 <&cru PCLK_GMAC1>, <&cru ACLK_GMAC1>,
>  			 <&cru CLK_GMAC1_PTP_REF>;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
