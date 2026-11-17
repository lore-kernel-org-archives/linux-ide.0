Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936915;
	b=14OSY+FnjyhNNYk8ObhlawcrmqXycCavB1hlJpyo+KeDpq+uJuKcnbCa/ksIUeVAVU4J
	 Mr51d5HEJnH4Mz7thSErJJscpuGM65oPEsUGDB+2zJS6OgSF86jVmHYPnfaJoXlsuOK6q
	 DBJA586gj6ogQAbBfDT+eYiMvA2Wg05QQPAA6U/b2Wj65ngeh2InAfgi7O3LhB+ErQDSQ
	 dgr8h5tsCQKusKuuTPYR4km0a7yfK5vHnldVAt7/ubhoFIqie6bhyYvOL3qqIH4/QEIJ6
	 +wh9ZcnL64cSx5sZHzp1StkIrLhvXG/sSLFzPRdF8xPuKwtbT0ViGh6Dd2ncmg9sB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936915;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ysk2En5dt3U606AzY6P1J/hKMgdqPY85D/NlOep2mDM=;
	b=eg5M4InC3GKX/5WKzjNioBqx/vNrvNTNDwxxD0lPu8A19ZLcP64+zNGwnxUOell6AxzK
	 RoNzpsD8q2/UqHdBVr+wqaGdV4Kv05y8A7+b51MhaWPUqLWdGikahrEPyBb2ad+L7HtJS
	 NkiYcpecG4jkIv9W9T0DosfjYugFo5G9Nz4vKFwwmVL9uVMVLFR5KlbbyEWK6AqL1Z5jw
	 TaxycKC/eBuPFh9FruPY6Udar3n/twsL20Qj6WrLzXTPJSPvi/wFEYh3Yx7gI7xltOK8Q
	 292dMiBZv7B5WEKg1DLAXdANrtK6vg1OoSw1f+buDCXr6vnv28XwHSnDh3c+TwzChdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIPaXsJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A7606A883;
	Tue, 17 Nov 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIPaXsJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821621F00923;
	Tue, 17 Nov 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936914;
	bh=ysk2En5dt3U606AzY6P1J/hKMgdqPY85D/NlOep2mDM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZIPaXsJezFD6AiJqncn2itUrMLKrGXEgbgoPFwcEsq8boZKgknPdwJtMy2wI4sXGr
	 HqQUFqbXQvLNgBq08hK7OekXX3IdsOfggLyQRBeNb7w083up+ru65npI5lUKFQ6xQR
	 a+Yp57ygka+UF3/I9hhXL5MyfBnNacdwqwdYZ0XOeUp5qkcibJMnpYf2b/IK4JOV08
	 b/uLjlkHATw4GCztXNJ40m4zvRjQjMd3RiEFXbBasTWHqLGDome3NANaagIXVkZR0S
	 pOA2fghSKmGiAadVTXL4uHQdXzmgyb6EIt9AdoiWkW8UjTB4rysSlX3tF9GtGv3UB7
	 vhT7ijesUk4PA==
Subject: Re: [PATCH 3/9] dt-bindings: soc: rockchip: grf: Allow a clock for
 the RK3588 PHP GRF
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
Date: Tue, 17 Nov 2026 17:35:13 +0000
Message-ID: <179493691305.3136.16311404541139130213@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-3-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-3-231196049a3b@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The RK3588 PHP GRF clock is allowed but not required.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a
  pre-existing use-after-free in the error unwind of…

--

dt-bindings: soc: rockchip: grf: Allow a clock for the RK3588 PHP GRF

This patch changes the clocks conditional in the Rockchip GRF binding.
The rockchip,rk3588-php-grf compatible is now exempt from "clocks: false",
so the node can describe pclk_php_root and the syscon regmap can enable it.

> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index e94c83d7c1383..2525eb51f13b0 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -321,8 +321,16 @@ allOf:
>          - clocks
>  
>      else:
> -      properties:
> -        clocks: false
> +      if:
> +        not:
> +          properties:
> +            compatible:
> +              contains:
> +                const: rockchip,rk3588-php-grf
> +
> +      then:
> +        properties:
> +          clocks: false

[Severity: Low]
Should rockchip,rk3588-php-grf go into the enum in the if: branch above,
so that clocks is required and not just allowed?

The commit message says the PHP GRF is clocked from pclk_php_root, which
gets gated. The later patch "arm64: dts: rockchip: Add the PHP GRF clock on
RK3588" says PHP GRF accesses hang without it.

This block already handles GRFs that need a clock. rockchip,rk3588-vo-grf
and rockchip,rk3576-dcphy-grf are listed in the enum, which both allows and
requires clocks.

As written, a php_grf node without clocks still passes dtbs_check. At
runtime, of_syscon_register() treats a missing clock as optional:

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

On such a DT the regmap would never enable pclk_php_root. The StreamID
restore added later in the series ("soc: rockchip: grf: Restore the RK3588
PHP StreamIDs after system suspend") would also be skipped without any
warning.

If the clock is meant to stay optional for older DTBs, could the commit
message say so? The binding also doesn't say which clock is expected. There
is no items list or description naming pclk_php_root.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. With
this series, php_grf goes through the clock-attached path in
of_syscon_register(). Is there a use-after-free of the struct clk in that
function's error unwind?

regmap_mmio_attach_clk() stores the clk in the regmap context before it
prepares it:

drivers/base/regmap/regmap-mmio.c:regmap_mmio_attach_clk() {
	ctx->clk = clk;
	ctx->attached_clk = true;

	return clk_prepare(ctx->clk);
}

Two failures reach err_attach_clk: clk_prepare() failing, or
of_reset_control_get_optional_exclusive() returning an error. For example,
the reset lookup returns -EPROBE_DEFER if the reset controller hasn't
probed yet. The unwind is:

err_attach_clk:
	if (!IS_ERR(clk))
		clk_put(clk);
err_clk:
	regmap_exit(regmap);

clk_put() frees the struct clk through __clk_put()->free_clk(). After that,
regmap_exit()->regmap_mmio_free_context() still uses the stored pointer:

	if (!IS_ERR(ctx->clk)) {
		clk_unprepare(ctx->clk);
		...

clk_unprepare() then reads clk->core from the freed object. If
clk_prepare() was the step that failed, it also unprepares a clock that was
never prepared.

Would it fix this to detach the clock from the regmap, or to call
regmap_exit(), before clk_put()?

The php_grf node has no resets, so for php_grf only a clk_prepare() failure
can reach this path. Any syscon node with both clocks and resets is
affected. Syscon registration is retried on every lookup, so the path can
run repeatedly. The unwind comes from a00406b71c5f ("mfd: syscon: Add
optional clock support") and 7d1e3bd94828 ("mfd: syscon: Allow reset
control for syscon devices").

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
