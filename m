Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936913;
	b=IK6AyUwll9V62s3iIs/EslcOibo/2DHrmQAJZYVjhERnpqd190wSZ/pZF5kTlkk8DkIW
	 ItDtdwjrNEcm06qaKZrAAEYtccolH2i4S+Bt9n0Mv9OpLF+xY9xmobmuHULrXPwwlRatV
	 fVwyWpQeoSUKSsjjF9EJ2Z/pwQnUuPa2bdJxVHeKbUIcyJcwqInuoZyfN/ybtIIOi0F8p
	 YKpAxGhFWwSl0FlMqN39byy1snZEM6rW7W2nYfuLWuwHk2rVPB7hIHQkeWU141ArwsdwU
	 jGB49k6q7HxSE51MI3ErD+F9jhd8srhEiokhdI0cPUxGaEh16W/ho44MbA4sQ/ah83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936913;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nB6Yq8d6ULrFd8IzeuoWmxpqPH/+v/zha4BrdYeZUfE=;
	b=RlrYyGeeQf28DbFNjQgSBaHYt9nLt9Uddptcbdmyp1YFQRDIco55pIH+Gx3dn+Hup4+9
	 2V1532/h36Vp0aI6eqxFqOqV7FiZA2tQ9YJQmgcJun43y7Y9qAN+RSD2fJ+sceGLI09JR
	 c0gERjXPZvsW83Ej1whV6rIWARXJVuqslbsxqQpskArG/vg6dOwnuzvs1hr/IYmwZZ8OF
	 iL1BW8eI+eVwvXivL79Cu188M6VmVueq34GSkkNhEA4func3SI9GqYBKduQEQdqFQ3tf8
	 7CaQq9+EeM+WA55RgAMG3mEH7anF5XGvWfNULlFH55mOlJrcSYQoWC4Te6SGaYuizNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+OoLnyK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD7606A88C;
	Tue, 17 Nov 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+OoLnyK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DABF1F000CA;
	Tue, 17 Nov 2026 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936912;
	bh=nB6Yq8d6ULrFd8IzeuoWmxpqPH/+v/zha4BrdYeZUfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m+OoLnyKEqRzuR8W24SKYyqeH6WL7WtYTv9Yk+iWroEVoyZLBNbO3Y34RvRRI3Li6
	 /dqFOQJYNXfrnUueeuBIWz/Pq55xJASipZl83hyCmOTvWei+1Qp2rFUZsB73vFGKtm
	 35NfflWKQng5deftSY4vK2xDDXYheYikiiyUb5Q0Kcbktk7ZGkEdfKE9+8qnPoZ3qN
	 haR1l3Sym7RSui+tJMYRXzDxK5wtrwbpjr72i54Gv/hCOuiF69sGojba3BwyK8pw83
	 v2XOdBeqx0jm8zY6gQyw7yR8rBSPJgHHM4BG5gHI15d5XFldxiAdymXaSy7s7+hiPY
	 xYZp9hwEuww5Q==
Subject: Re: [PATCH 2/9] dt-bindings: ata: rockchip,dwc-ahci: Allow iommus
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
Date: Tue, 17 Nov 2026 17:35:10 +0000
Message-ID: <179493691098.3136.12498888747300831285@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-2-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-2-231196049a3b@gmail.com>
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

- [Low] The patch adds `iommus: maxItems: 1` at the top level of
  `Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml` (lines…

--

dt-bindings: ata: rockchip,dwc-ahci: Allow iommus

This adds an iommus property, limited to one item, to the Rockchip DWC
AHCI binding. The commit message says the RK3588 SATA controllers sit
behind the PHP SMMU.

> diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> index b5ecaabfe2e25..e33e8b5591ee5 100644
> --- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> @@ -34,6 +34,9 @@ properties:
>            - rockchip,rk3588-dwc-ahci
>        - const: snps,dwc-ahci
>  
> +  iommus:
> +    maxItems: 1
> +

[Severity: Low]
Should iommus be limited to rockchip,rk3588-dwc-ahci?

As added, the property is unconditional. That makes it valid for all
three compatibles in the select block: rockchip,rk3568-dwc-ahci,
rockchip,rk3576-dwc-ahci and rockchip,rk3588-dwc-ahci.

The commit message only gives a hardware reason for RK3588:

  The RK3588 SATA controllers are behind the PHP SMMU.

The in-tree SoC descriptions match that. mmu600_php: iommu@fcb00000
(arm,smmu-v3) exists only in rk3588-base.dtsi. In rk356x-base.dtsi and
rk3576.dtsi, the only IOMMUs are for media blocks (vdpu, vepu, vicap,
vop, vdec), and none of them sit in front of the SATA nodes.

The binding already has a separate allOf entry for the older SoCs:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - rockchip,rk3568-dwc-ahci
              - rockchip,rk3576-dwc-ahci
    then:
      properties:
        clocks:
          maxItems: 3

With this patch, dtbs_check would no longer flag an iommus property
added by mistake to an RK3568 or RK3576 SATA node.

One option is to add iommus: false to the rk3568/rk3576 then: branch.
Another is to allow iommus only in the rk3588 branch.

snps,dwc-ahci.yaml, which the commit message cites, does allow iommus
unconditionally. This binding is per-SoC, though, and already has
per-compatible constraints.

>    ports-implemented:
>      const: 1
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
