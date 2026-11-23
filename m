Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422615;
	b=zVp7kZgVB19NTXxqaJO9g2RWZndJzR6BbdSDYjapgbaxktG0jp1ZVQHhq4aW2bxWI/ik
	 RdUB+eRLduI1g8ET/bh9Z181NEeZJ0MjOUdy/pyraC+2NsyDIijbJZVVnoo5U5oi0Mpjf
	 aD5/vbR+y7btMGfi9lJHPjs3CBkn4ygBAQBzgrTxh476esx+lAAYuBeBb2MJJh548Z6+M
	 S2ZSdOvdITlVtGBNBr5+IC0k87yX1hBHexqOplh/Lxe6P703gxWNLMolEGxAv24kBPaE4
	 dKUhs34Qd5hMQyM/4ey8u3wmGXsnAJE58O7WqBoB3ukB//MjUvrjEuxKULCM7n9I7sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422615;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g90/0bhbxPIHkU4mFDJWsNmnCkTgmCZxPuEg8GPDaE4=;
	b=regR6M1YLLU0r3ixVnk6f+PXd3EnI89eSUFwWZehr6QXYHwNZbwmq+rHIFb1PhtkrMqS
	 AvZUrksAAN7J1YwoWx8jI1IrfJp2XoMn+JuwOZclDA8NC160BZMuONdAn0Xasast2KwTw
	 MTtRlaK++QZ4yX0y5HxSYVTIg2SO975vomidGQxgrHteiHDWJI8AMYNcEWwvQ6nnzlSN6
	 sBRKkQM8tEQALSnMHMNDKSs4YUDF+phXeBf0vYcFGXLJOjHSsQNRj3S48csinUEYnLgiy
	 jHkp9gqAtsPBA28ppDVL7aXSm1vAFuEs10L+MJX8i+kVmB89iRegxmBu4x2dgOFCh4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXULo1uE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9D606A31A;
	Mon, 23 Nov 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXULo1uE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841501F000CA;
	Mon, 23 Nov 2026 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422615;
	bh=g90/0bhbxPIHkU4mFDJWsNmnCkTgmCZxPuEg8GPDaE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PXULo1uEs5gqu1IV55GH6XzrlAMnkg7aML82UaJ7P0OLCy2GmoAv5mYdxL9hUIV7u
	 jEnaL7Mzr0zmJzdlrh1FTVQpNNcU4E0e9whuo8ZLAWP27aVJY8zIIQxBhRVIW5qtV8
	 ITHTFckdHDzXFIroyGvBmKet6tLcxgecDClkheY54A8wnhpZm6X3t/G8TpbUd6M28h
	 FEdGAcxU0Q/gFfgk4219uGFxeYvN//XCAyraN1ZjPfgQ/ifzbksu4GKAmqWV6zm29M
	 xNB603K1JIdFM5wvMVEheM3ybmTvHLcB1sTMJHQ1a0xvq3I/76jYcSCd8ArO5DHA1I
	 SqCYOEVQW60QA==
Date: Mon, 23 Nov 2026 09:30:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/9] dt-bindings: soc: rockchip: grf: Allow a clock for
 the RK3588 PHP GRF
Message-ID: <20261123-wealthy-luminous-skunk-cb5dbb@quoll>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-3-231196049a3b@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-mmu600-php-v1-3-231196049a3b@gmail.com>

On Fri, Nov 13, 2026 at 04:38:49PM +0000, Arun Iyengar wrote:
> The RK3588 PHP GRF is clocked from pclk_php_root, which is gated when
> no PHP peripheral holds it. Allow the clock, so the syscon regmap
> enables it.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index e94c83d7c138..2525eb51f13b 100644
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

This is not understandable - two nested ifs, one even with negation.

If binding is too complex, it could be split.

Best regards,
Krzysztof

