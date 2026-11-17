Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936916;
	b=0R3nz1z3p7R6ThCczNYQ3I/Kp0F41HxjChWLhB6a6rTTEVGviSbgKOGg2JE4h4VB+zJK
	 FsTz5HuUS9Ye99JT4d/rtZc2pjAXke3DbplsHl1BDAtjuwlJlGL9cM7GpA4ve1FVHy0Rg
	 HlN6B/BoUEC2ehHLJnvXgRlZupB4JsA4mDV+lk4LC/mF0zR9wZuVDLsG3s5AwVKWWc7i5
	 UxMghPYBKO5fI7V59OFYi0+9ZgIRfTKXLItiQ2qsnJHYZjeK3mWJp/Q4gDvWH7Q8hTAFb
	 ka9sLSjzC9E9V3BS+pQ7lMb41zJuQMQQLe8gsDPcpiH2nYJ4DhrIf9aQ5UouyvrnY+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936916;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xNa0xDXSS+zJh+Kso81OgDVFRXsupSK+qlsYOnCFju8=;
	b=1VRYK1wUYLePc/fH4+Vy8U1ta4A/LPBU1DcG0zAJeEzBCYdA0/Jz4QfduoNi8on9EVoY
	 zMtqSbTk48tQEazlc+imAKw668r+/Mho8CukS64vP9Cuh9vOz0cCK+XNif51qdstzaBEY
	 6MoYKp6nmaWt/PmPMsZeAN8LesMpY2VLtz+mhb8lAdO6d81027huTMAYroUYaPfaR7hGW
	 PgtxXF1C8NSggkbPqwnYamcFJlGzyzvzDQD1B8hAqroP9pFh59PUSrfuId7UzqXCimnXc
	 StUxr6SLe/Cybt8AINdVCmzflurPL2tFHMPgu7OyiDyEswWt84WZUt99BzdT0NaITRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/Rk9Z+/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD108606A339;
	Tue, 17 Nov 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/Rk9Z+/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B591F000CC;
	Tue, 17 Nov 2026 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936916;
	bh=xNa0xDXSS+zJh+Kso81OgDVFRXsupSK+qlsYOnCFju8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f/Rk9Z+/w2sDE60G7c5yxPTEM8K3B3ApYnUWzJ9FKtTrQ0MgX0uDktfKkK95bd83T
	 EHf0Wit/AhL7mxkmpqZJi1f5kTRmMy2cvT84rmk+DxfSpRUyuBL9fqfKfyfwQCJ5oQ
	 RYvwKhBPD5BSvXNEZyY0XkZjHhk9KrlHQXnltMjJdlRGBrfsTjd0uMSEm7f355Qxg1
	 mh+Cse4brl6p2aGfHzWaallLHet7TQYHAn6UzoPdL4XxJVPeAQsX/TGTmoWANB+Vhc
	 VFgLsBmzjBD4Z0vsXINFmchPjf5F77TWPoq3EHaD13BZlzo3ASfzMFsXa5blTcqhom
	 Ajxv+5E12C+hQ==
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: Add the PHP GRF clock on RK3588
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
Date: Tue, 17 Nov 2026 17:35:15 +0000
Message-ID: <179493691507.3136.7881513635093439298@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-5-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-5-231196049a3b@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Adding `clocks = <&cru PCLK_PHP_ROOT>` to php_grf creates a DT
  dependency cycle: the cru node has `rockchip,grf = <&php_grf>`…
- [Low] Once the clock is attached, regmap-mmio wraps every PHP GRF
  access in clk_enable()/clk_disable() (regmap_mmio_write lines 157/165,…

--

arm64: dts: rockchip: Add the PHP GRF clock on RK3588

This adds a PCLK_PHP_ROOT clock reference to the php_grf syscon node on
RK3588, so that the syscon regmap enables pclk_php_root around PHP GRF
accesses. The motivation is a deep suspend hang in the syscore resume op
added by the next patch, which ran after the PHP peripherals had gated
pclk_php_root.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index d0f364547ae55..8807ce6193bfc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -619,6 +619,7 @@ usb_grf: syscon@fd5ac000 {
>  	php_grf: syscon@fd5b0000 {
>  		compatible = "rockchip,rk3588-php-grf", "syscon";
>  		reg = <0x0 0xfd5b0000 0x0 0x1000>;
> +		clocks = <&cru PCLK_PHP_ROOT>;

[Severity: Medium]
Does this create a dependency cycle with the cru node? The cru node in
this same file already has:

	rockchip,grf = <&php_grf>;

and php_grf now references a clock that cru provides.

On RK3588 the CRU looks up its GRF from the CLK_OF_DECLARE_DRIVER hook,
before its own clock provider is registered:

of_clk_init()
  rk3588_clk_early_init()
    rockchip_clk_init_early()
      rockchip_clk_init_base()
        syscon_regmap_lookup_by_phandle(ctx->cru_node, "rockchip,grf")
          of_syscon_register(php_grf, check_res=true)
            of_clk_get(np, 0)   <- now returns -EPROBE_DEFER
    ...
    rockchip_clk_of_add_provider(np, ctx)   <- provider only added here

of_syscon_register() only treats -ENOENT as a missing clock:

drivers/mfd/syscon.c:of_syscon_register() {
    ...
		clk = of_clk_get(np, 0);
		if (IS_ERR(clk)) {
			ret = PTR_ERR(clk);
			/* clock is optional */
			if (ret != -ENOENT)
				goto err_clk;
    ...
}

So the regmap is torn down and nothing is cached. clk_rk3588_probe()
reuses early_ctx and never retries the lookup. Would ctx->grf then stay
ERR_PTR(-EPROBE_DEFER) for good? Before this patch it was a valid php_grf
regmap.

Nothing on RK3588 seems to dereference ctx->grf today. The pll_rk3588 ops
don't use it, and the GATE_GRF branches use grf_type_sys from
aux_grf_table. However, rockchip_clk_register_branches() falls back to it
for grf mux/gate/mmc branches that have no matching aux GRF:

	struct regmap *grf = ctx->grf;

A future branch like that would silently get an error pointer.

There is also a second interaction. Before this patch, the CRU's early
lookup was the first to create and cache the php_grf regmap, and it did so
without a clock. Every later syscon_node_to_regmap() user got that
clockless regmap: rockchip_grf_init(), dwmac-rk via rockchip,php-grf, and
naneng-combphy via rockchip,pipe-grf.

With this patch, the clock only gets attached because the CRU lookup
fails. That failure moves the first successful creation to
rockchip_grf_init() at postcore_initcall, when PCLK_PHP_ROOT is already
available.

If the CRU lookup were moved after provider registration, or some earlier
caller created the regmap without the clock, a clockless regmap would be
cached again. The restore op in the following patch "soc: rockchip: grf:
Restore the RK3588 PHP StreamIDs after system suspend" only checks
of_property_present(np, "clocks"). It doesn't check whether the cached
regmap actually carries the clock. Wouldn't deep suspend hang again in
that case?

Should the commit message describe this ordering dependency and the
effect on ctx->grf?

[Severity: Low]
With the clock attached, regmap-mmio wraps each PHP GRF access in
clk_enable()/clk_disable(). Does this change when pclk_php_root is gated
in hardware?

rockchip_grf_init() runs at postcore_initcall. After the earlier patch
"soc: rockchip: grf: Assign the StreamIDs of the RK3588 PHP SMMU masters",
it writes 12 StreamID registers through this regmap. At that point no PHP
consumer holds pclk_php_root, and the clock is a plain gate with flags 0:

	COMPOSITE_NODIV(PCLK_PHP_ROOT, "pclk_php_root", mux_150m_50m_24m_p, 0,

So each write takes enable_count from 0 to 1 and back to 0:

rockchip_grf_init()
  regmap_write()
    regmap_mmio_write()
      clk_enable()
      ...
      clk_disable()
        clk_core_disable()
          core->ops->disable()
          clk_core_disable(core->parent)

Before this patch, the clock kept its bootloader state until
clk_disable_unused at late_initcall_sync. With clk_ignore_unused it was
never touched. Now it is gated at postcore_initcall, along with any parent
whose count also drops to zero, and this happens even with
clk_ignore_unused.

Could a PHP-domain register access in that window now hang? The same
question applies to an access under clk_ignore_unused that relied on the
bootloader leaving the clock on.

The commit message says the regmap enables the clock. It doesn't mention
that the regmap also gates it this early.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
