Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936911;
	b=R6uARBquxsLBokTotDCdg1m/gM0Y/fGKHebzN2A8ie19SfgQwcPwPIkRkl2a8T9R/YpZ
	 SIjy/q8zJo/YgJbOYubf5XFzl9XBOcRVJic3tG7ziBHpSG7d7L4uxXPC5utE9VxK+PNbD
	 tT2Xampi2bH+tLtD01YWzGXgTZb6rFpbad37t36iM7gdrEGqa193X/B/jMISOmuwmWYrY
	 jKzEdduBrlZ+gmQRUmQN/05Ez3Lk7GLpazcTV/b/VYlpy8WgrtyHwye2Io8SKjk9bU0Zr
	 dzQk2WeZp5bk8APghMWExb/2GG5ZWg+rNgUcRedhCzKA0yQMk4A8GxEszjQLhG0FSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936911;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+KzEQNGHNyX+d3v3aVcwTAOvdhg7OdW27uOcL3lFZr8=;
	b=NL8vtiAFT6foIFjQ3Ve2ebdj0Mf7FAPHbcV30URrgpgiIO8PL/qiHQmRnn1keNxhF8Ll
	 AMU4+emJQ0aCd366uVzTLmM8MwN0aqxOjsOFWtsbiO59sf4eg+4pPFKKBF3Oq56t2iZZQ
	 FiGIqqm5hbHjmCow/tds2xuli+zg1dq3uxHlP/5EAc7wycCTXxUdKjMaFrlFk7DOmmg7r
	 UT3tYvQ5X1Tu2VUUmEeJNAfU41AQg3atSCbQDCzISTQ/Si3cV/1t1eFe5ZuqMWQ6QRyu7
	 tJ5Him+6GT1fNTZ2TJqGsOiDmUe4MUTEQn8jbFCNN8qX5JgIvstSaDQ7W6ikTNBp7SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DB31nbrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23F606A32C;
	Tue, 17 Nov 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DB31nbrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8297B1F000C4;
	Tue, 17 Nov 2026 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936910;
	bh=+KzEQNGHNyX+d3v3aVcwTAOvdhg7OdW27uOcL3lFZr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DB31nbrgHw4cb5wk09Uoa3sTa0f48KHnVB0If14yyoePPs2K870d/2jEQ5MCJTxk7
	 0HbKP/tiPgmXoOHfj2InyasAd47uGI8E/6iSoGTJhOzM8dvbDWG7HZPRHc1peUVljb
	 bpK0ef6TRTVaBEeQgE1lXV+qAr6GbTkVpd+c0RE4ulHrao45SJHUPegpUWrKFnclEo
	 FQCp6PuFn/QNCouwAXCJuSg2lpyRKy7uDDr02088M4XQa+eLK4f+LEVvyBEA+6Nq0M
	 nYXgyZYAq/AsgoC+Rn+TdaHymUq0WvnTsk/kCX4Ps8PLhsT1M+7GNk3Jc4PC38jZgV
	 TkXzr9kfqXCiA==
Subject: Re: [PATCH 1/9] dt-bindings: net: rockchip-dwmac: Allow iommus
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
Date: Tue, 17 Nov 2026 17:35:09 +0000
Message-ID: <179493690908.3136.827247860672592948@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-1-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-1-231196049a3b@gmail.com>
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

- [Low] This patch ("dt-bindings: net: rockchip-dwmac: Allow iommus")
  adds `iommus: maxItems: 1` to the top-level `properties:` map of…

--

dt-bindings: net: rockchip-dwmac: Allow iommus

This commit adds an iommus property, limited to one entry, to the
Rockchip DWMAC binding. The commit message says the RK3588 GMACs sit
behind the PHP SMMU.

> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index e8dda1961ab31..2a0cd56fb4fe9 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -87,6 +87,9 @@ properties:
>  
>    dma-coherent: true
>  
> +  iommus:
> +    maxItems: 1
> +

[Severity: Low]
The commit message only gives a reason for RK3588, but iommus is added to
the top-level properties without any compatible-based condition. Was it
intended to allow iommus on every Rockchip GMAC compatible (px30, rk3128,
rk3228, rk3288, rk3308, rk3328, rk3366, rk3368, rk3399, rk3506, rk3528,
rk3568, rk3576, rv1108, rv1126)?

In the in-tree DTS, the only SMMU a GMAC could reference appears to be
mmu600_php in rk3588-base.dtsi:

arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:
	mmu600_php: iommu@fcb00000 {

The same binding already restricts the PHP-specific rockchip,php-grf
property to the SoCs that have it:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - rockchip,rk3576-gmac
              - rockchip,rk3588-gmac
    then:
      required:
        - rockchip,php-grf
    else:
      properties:
        rockchip,php-grf: false

As written, a GMAC node for a non-RK3588 SoC that carries an iommus
phandle (for example, one copied from an RK3588 node) would pass
dtbs_check without a warning.

Could iommus be scoped in a similar conditional, with iommus: false for
the compatibles other than rockchip,rk3588-gmac? If allowing it on all
variants is intentional, could the commit message say so?

>    clock_in_out:
>      description:
>        For RGMII, it must be "input", means main clock(125MHz)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
