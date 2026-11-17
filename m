Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936925;
	b=tWWtIy+Jvpny+ScdQjcSW4ZwtplQhsZOAi0+AN9dYTGa0OYnJz9WxB6JX73cqv9Vskqt
	 1cBHAMXo81Ouu4bX93LC+sNaRZoQK2n8ZjqPAT3Z5LGIsaO41fEE5O2YQ+zaUAxkHDalZ
	 IozClgPoURCtT5/bWe1JkZ9lNYCbt9punHWnn5NyDD5UD+nN2eodzGb3vDywndmGik+N3
	 7Uj0Xig74R6/zJQQ2hMQGoFmO1ZfPirk3T2Pg42U28if3MeK+wK1v5GGy7Q6OVTRYP9Ep
	 mfvJCwD6d8y+RIjceCqIgteHsWRzfLeUfiN8fucMOXWLkEaAK4/6mFyOUEw5mvzRNGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936925;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yZ3I9vRuX9ylJnvAv8Fd/DK7PqgzivRoTz54b66hM4s=;
	b=aWPUgx0Tjl7d917UhLN7uzDS1ewVdy88d9eUzPz5uEFyx+3KJCaD1KitPZUt7HRnQ9Z1
	 f6NZetGGsLYQT86l6fV845oqMEifGZqdkfgh46kdYypkXSmnNBYmJHl2ZvyZLQIw41jLw
	 tW6qJYZkYVUzJ91nRU9wPP6MjiJScCGj0j6OMKRvJygcMHhcbd5iDyK43BkfnHJXWVyE/
	 3ZFDEqgSyOdC9QyM2r8s3JXsgv55/hKyzn8zAYfugDFOYHqE0fOTDOJg51oSKnaeb5eEU
	 bO8UdlWI7kbPXXAJmsu/QRcF2C8qj3jDO5/sm7usDQS/tMgV5487S/hLFh8pedWUs1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldprS0uN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14126606A8AB;
	Tue, 17 Nov 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldprS0uN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437971F00923;
	Tue, 17 Nov 2026 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936924;
	bh=yZ3I9vRuX9ylJnvAv8Fd/DK7PqgzivRoTz54b66hM4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ldprS0uNwFt+H1U3be8E2gOLAGnw8BZl5s5GVpiNWByV+Ly/0OSD22JIeeAxEMp/g
	 vajUIU0EUhPQ6Grik6d7HoZo4QrEZCG/qbdNGA2DeRmLimaYUz3G22jERtSf0rlEsJ
	 XdkI0kkGlwRriDnm0fVfu4H+JZKAVemm7juPMN6KScB8unOvuReiocyYvXxlLxcjrI
	 jGnyjhxSnD1caR+wZ8oWP9VduidgsFBMr6HkihNTcuMyt0h8DBOB+F4f0IMukeKkOM
	 aNCUusgK+8Is7lqQdWI9scgMjEIbl0y4zrdB5uLRljVPhKN+GZHQu7GSdlgYDZS3NS
	 pDxvT9nAn7D5Q==
Subject: Re: [PATCH 9/9] arm64: dts: rockchip: Enable the RK3588 PHP SMMU
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
Date: Tue, 17 Nov 2026 17:35:22 +0000
Message-ID: <179493692280.3136.14096741635369747694@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-9-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-9-231196049a3b@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch enables mmu600_php on every RK3588 board, but the
  kernel cannot restore the SMMU after deep suspend.
- [High] This patch's commit message says "the SMMU has its clock", and
  the earlier series commit "arm64: dts: rockchip: Add the clock and…
- [Low] The mmu600_php node that this patch enables has `clocks = <&cru
  ACLK_MMU_PHP>;` and `resets = <&cru SRST_A_MMU_PHP>;`…

--

arm64: dts: rockchip: Enable the RK3588 PHP SMMU

This commit removes status = "disabled" from the mmu600_php node in
rk3588-base.dtsi. That enables the arm-smmu-v3 instance in front of the
PHP masters (GMAC, SATA, USB3 host2) on all RK3588 boards. The commit
message notes that PD_PHP loses power in deep suspend and that arm-smmu-v3
system sleep support is needed.

Link: https://lore.kernel.org/r/20260929034510.2023173-1-praan@google.com

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index cb0a39f637887..0c3d59a391826 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -574,7 +574,6 @@ mmu600_php: iommu@fcb00000 {
>  		clocks = <&cru ACLK_MMU_PHP>;
>  		resets = <&cru SRST_A_MMU_PHP>;

[Severity: High]

The commit message says "the SMMU has its clock". Does anything actually
enable ACLK_MMU_PHP for the SMMU?

The arm-smmu-v3 driver has no clk_get()/clk_prepare_enable(), reset_control
or pm_runtime handling. The node has no power-domains, so genpd pm_clk
does not apply. The platform core does not enable DT clocks by itself
either.

In drivers/clk/rockchip/clk-rk3588.c the clock is a plain gate with no
flags:

	GATE(ACLK_MMU_PHP, "aclk_mmu_php", "aclk_php_root", 0,
			RK3588_CLKGATE_CON(34), 8, GFLAGS),

Its only enable references come from its children ACLK_GMAC0/1,
ACLK_SATA0/1/2 and ACLK_USB3OTG2. Two things can turn it off:

- clk_disable_unused at late_initcall_sync, when no master is bound
  (modular drivers, or a board that enables only some PHP masters).
- The last master disabling its ACLK on runtime suspend or remove.

The SMMU driver still touches the hardware after that. It issues CMDQ
TLBI/CFGI plus CMD_SYNC on unmap and on flush-queue timeouts, it runs the
eventq/gerror handlers, and at reboot it runs:

arm_smmu_device_shutdown()
    arm_smmu_disable_action()

That usually happens after the consumer masters have already shut down.

Could this cause CMD_SYNC timeouts or a stalled bus access? The "Add the
PHP GRF clock on RK3588" commit in this series describes a similar hang
for pclk_php_root.

The earlier commit "arm64: dts: rockchip: Add the clock and reset of the
RK3588 PHP SMMU" says the clock was added "so the SMMU keeps its clock
while its masters are idle". Does that need clock handling in the driver
(plus a binding update), or the gate marked as critical or
ignore-unused, rather than only the DT property?

[Severity: Low]

Will this node pass dtbs_check now that it is enabled? The binding in
Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml does not define
clocks, resets or power-domains, and it has:

additionalProperties: false

No patch in the series updates this binding, although the dwmac, ahci and
grf bindings are updated.

Also, the "Add the clock and reset..." commit says the reset is added "as
for the PCIe SMMU". The sibling mmu600_pcie node, which uses the same
compatible, has neither clocks nor resets.

>  		#iommu-cells = <1>;
> -		status = "disabled";

[Severity: Critical]

The commit message says:

  PD_PHP is powered off in deep suspend and the SMMU resumes from reset
  in bypass, so this needs arm-smmu-v3 system sleep support [1].

Is that support in the tree this patch applies to? No earlier patch in
the series seems to add it.

In drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c, arm_smmu_driver has no
.pm:

static struct platform_driver arm_smmu_driver = {
	.driver	= { ... },
	.probe	= arm_smmu_device_probe,
	.remove = arm_smmu_device_remove,
	.shutdown = arm_smmu_device_shutdown,
};

The only code that programs the stream table, the queues and SMMUEN is
arm_smmu_device_reset(), and only arm_smmu_device_probe() calls it. The
syscore op added to drivers/soc/rockchip/grf.c earlier in the series
restores only the PHP GRF StreamID registers.

With this node enabled, the PHP masters get IOMMU DMA domains and their
drivers program IOVAs. Those masters are usb_host2_xhci, gmac1, sata0 and
sata2, plus gmac0 and sata1 from rk3588-extra.dtsi.

After a deep suspend cycle, does the SMMU stay in its reset bypass state
while stmmac, ahci and xhci keep using descriptor rings and buffers at
their old IOVAs?

If so, the IOVAs would be treated as physical addresses. On gmac RX the
frame contents come from the network and would be written to whatever RAM
or MMIO sits at that address. TX and SATA/USB reads could leak arbitrary
memory.

PD_PHP is also defined only in drivers/pmdomain/rockchip/pm-domains.c and
the dt-bindings header. No DTS references it, and mmu600_php has no
power-domains property, so genpd cannot order an SMMU save and restore
either.

Before this patch the node was disabled and these masters used direct
DMA, so suspend did not hit this problem. Should enabling this node wait
until the arm-smmu-v3 sleep support in [1] is merged?

>  	};

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
