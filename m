Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7674409;
	Mon, 22 Jul 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610920; cv=none; b=LF9KHv2e+uuAnFN0pUka29fLfv3OY9i368GkNVD75lVjlcKmRz6Z2jhLaLfZ4wo0DQeJ7SgPtqi59NF50rPoA2DppZkt4o5PFQfLBqwLJghQClrhO6oWAqqvdGdMfvMRYjzyZKWE+pdEtZc0GMN+EtorIQdxSPNWef3cDNspc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610920; c=relaxed/simple;
	bh=aobF+UkeWrx3ppzGnDAWwY8QvfrDJ5/qVY+DYcIeGFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJkyEArCsuqzrCVgRUMxl7qgr7OcHl9styRJMsa4eU6URsG+Fk1ott54ygoiBsFAl1JTEBu2ap2M+GAMF5PasencVmhcy7AHBOPmns5zNYHUYndWahRBmrY22GGDz1bnCSt+83UjIUFnayYVCXI2xyo7ScJ/J4Fgao/8+LHM/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWlypUHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWlypUHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940B8C116B1;
	Mon, 22 Jul 2024 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721610920;
	bh=aobF+UkeWrx3ppzGnDAWwY8QvfrDJ5/qVY+DYcIeGFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VWlypUHiNZ9LuCURWQJ+2ncdv9C1K6aV9ZD/ydW3AMCw911jD/6vnnKCV0btxIDhQ
	 HEp4Dij8xTZOrf3Leyeme2fZGA3F36ci7KRCpeM5Le9CPfd/XthDjUJd97q5UUApkb
	 n/6k9RMOanm+GaM+IbpdwR411urHeLZr70Xa4nYQzaOfxnk1rWfIJHYs6eySLdK53q
	 lmupJ8rSGrZoJ2HvRfUfEdd4wFUFV7SJm5i7zyd8BaszjAbAQ9m8LgGiTIrjNFMst5
	 JDtS1ay/bjDez4+KWyuVlygROdfSCGwwLkpBYdwELux0vjno2WsF5a1ryt2gMdjmJ1
	 UkcAE//Ms5/Xg==
Message-ID: <c0e65581-0f05-4143-bc45-0b681ef2bff6@kernel.org>
Date: Mon, 22 Jul 2024 10:15:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: rockchip-dwc-ahci: add missing
 power-domains
To: Heiko Stuebner <heiko@sntech.de>, cassel@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 sebastian.reichel@collabora.com, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com
References: <20240720205705.776384-1-heiko@sntech.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240720205705.776384-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/24 05:57, Heiko Stuebner wrote:
> The Rockchip variant of the dwc-ahci controller does have and need power-
> domains to work, though the binding does not mention them, making dtccheck
> quite unhappy:
> 
>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb
> /home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: sata@fc800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>         from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
> 
> Fix that by adding the missing power-domain property to the binding.
> 
> Fixes: 85b0e13b19c2 ("dt-bindings: ata: dwc-ahci: add Rockchip RK3588")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I queued this as a fix for 6.11. Will send it out once rc1 is out. Thanks !

> ---
>  Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> index b5e5767d86988..13eaa8d9a16e5 100644
> --- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> @@ -35,6 +35,9 @@ properties:
>    ports-implemented:
>      const: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    sata-port@0:
>      $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
>  

-- 
Damien Le Moal
Western Digital Research

