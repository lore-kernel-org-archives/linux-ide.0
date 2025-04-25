Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C0217648;
	Fri, 25 Apr 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568017; cv=none; b=oCEP/iGcwUZWzrZWDwyakUAc3wuLUOmHU7Edq5saOHOkR+OOKl3XlmWRp9C+gMru007nhK6wkXukhrJLr3DmtYWEu3Bid2Fpi/po0dYxU7oQpw3wUmjoTS/Grk3l21Hb19g1GS7o8zXeLLamV0HjuGYDC6jUNFDZysEEhYtv+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568017; c=relaxed/simple;
	bh=erqJqGRXXM7MQJf6wrEuF5NDmvnYTzOgQlAxA2Yswo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt7s5zq/GpjWdEStCn0zptUek9gaGwcG0Eg9MAQ4M87Gddo0wNdYuRthySFVo6HYY7vOzpAxktzIo/jdnWNfCRDWuTZrJ+YYR69G1MC0oL8UCgeSdN24iULjnDLagWX3q4Npxnr/5LwndfBB9GEJKmaocqw12Ynx3v3LPszfVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcOxh7pU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcOxh7pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2FC4CEE4;
	Fri, 25 Apr 2025 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568016;
	bh=erqJqGRXXM7MQJf6wrEuF5NDmvnYTzOgQlAxA2Yswo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcOxh7pUaiPLiLCU7eu7Ap0wNFksdYoCZR6ofN13HHRhOgvqds6tLCP+3+kFrj4ec
	 jD0cvBj+Sxb4rK/S/u2lfOZiQ9lu6C4x2L5o/z3FTNEV2OYCTYBA1D0Z/FPBJNcB5J
	 fmr1fWjtROPSeKi+brDdMOmD6LYFf1SCBZcgxyZcEO0pEcJWuL/uNmGZT+XJGV+571
	 kq90kwXgPGz7KIC+7mndRQwc37oXN+jkUkIOVtGkfu1X7xjdN3Q+qOhFksEz/nolqm
	 WJRH4xJseQgvM/Xq9I5uftgYr8tHa4JKgizwFYJAXKmqUxjh2LLLT5ur2N0w4LAdMK
	 EZ5tYkyYwxKlQ==
Date: Fri, 25 Apr 2025 10:00:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Serge Semin <fancer.lancer@gmail.com>, kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ata: rockchip-dwc-ahci: add RK3576
 compatible
Message-ID: <aAtBCgthlNieNUx5@ryzen>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
 <20250424-rk3576-sata-v1-1-23ee89c939fe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-rk3576-sata-v1-1-23ee89c939fe@collabora.com>

On Thu, Apr 24, 2025 at 08:52:22PM +0200, Nicolas Frattaroli wrote:
> The Rockchip RK3576 has two SATA controllers. They work the same as the
> RK3568 SATA controllers, having the same number of clocks and ports.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> index 13eaa8d9a16e5a4bd43b3e184f9277494acf27a1..b5ecaabfe2e2537afe6093558fb0ab975dcf6058 100644
> --- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> @@ -20,6 +20,7 @@ select:
>        contains:
>          enum:
>            - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3576-dwc-ahci
>            - rockchip,rk3588-dwc-ahci
>    required:
>      - compatible
> @@ -29,6 +30,7 @@ properties:
>      items:
>        - enum:
>            - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3576-dwc-ahci
>            - rockchip,rk3588-dwc-ahci
>        - const: snps,dwc-ahci
>  
> @@ -83,6 +85,7 @@ allOf:
>            contains:
>              enum:
>                - rockchip,rk3568-dwc-ahci
> +              - rockchip,rk3576-dwc-ahci
>      then:
>        properties:
>          clocks:
> 
> -- 
> 2.49.0
> 

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
