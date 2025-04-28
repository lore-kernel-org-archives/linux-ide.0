Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AF3C3C;
	Mon, 28 Apr 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828898; cv=none; b=j5UejdQsH1psUWShpjWWfreb5qxBlxi0d3eP64lHIBZMiTLUUn14xR/BAQu8tfu0iVmLD9f1kBWao/60G5KyQ3hAqHWHyJ53q3CPDqR6UN0WbH4btEXSWFm2zlgbLbkuwg7929zQQ6OQH/KnS3Wi/HMqD+NcxaauqM4ENK0TBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828898; c=relaxed/simple;
	bh=ay1sGqMLLXsxFuARu/F9cw+9JCB2xo4TRuqASGpOyn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5+QX8TjUZSgD/Czr5SP/6ERj87REOSmIfw6a75L3ErIA9PQdtHL5wkPHltjM8sAHv4ssIkh1RBM91pNFBFYReKUiFDGkoYP7spGstmpxOWCk+0KDJdJJwQE2fp/5C3f175jri8OvIHJB2yOtAkB95Op54WfbuBU1WVx27U+UtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJVNyZQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJVNyZQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50208C4CEE4;
	Mon, 28 Apr 2025 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828897;
	bh=ay1sGqMLLXsxFuARu/F9cw+9JCB2xo4TRuqASGpOyn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJVNyZQSz2Nv9WHNFl0z/dkO0H4bi+6+KUIjeGJD1mE9fWtjmrkqexNOVqJp1RMU7
	 2MIk4RqL+qcgt5OF/qPh7xzOvxiBNLwHbgLWEpv6wImGvhPjNBvvsViWWKXTw16nfI
	 B73eRUKWFn1fEn3TCip0sz5KxpM8MNx63PnMAkbGhiIqN1TU1RjFnIFiOTFkgvuQuH
	 nI3Mx4e78EftMUh/3Ozb3zEaAlgfqy9mm/VI2dK1CGCKx1iEatQXss1jxSB5RsxjWO
	 1PCgARg+twom2ixOA9ks0+tiPj8mmdRVB+A7ubWAYabPhyt+hGzj1hpfIg9PnSG3fe
	 Br/IKb+Ucc6yg==
Date: Mon, 28 Apr 2025 10:28:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Serge Semin <fancer.lancer@gmail.com>, kernel@collabora.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ata: rockchip-dwc-ahci: add RK3576
 compatible
Message-ID: <20250428-vengeful-outgoing-pudu-b19b8e@kuoka>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
 <20250424-rk3576-sata-v1-1-23ee89c939fe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424-rk3576-sata-v1-1-23ee89c939fe@collabora.com>

On Thu, Apr 24, 2025 at 08:52:22PM GMT, Nicolas Frattaroli wrote:
> The Rockchip RK3576 has two SATA controllers. They work the same as the
> RK3568 SATA controllers, having the same number of clocks and ports.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

