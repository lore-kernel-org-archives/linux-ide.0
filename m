Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606A440C;
	Fri, 12 Jul 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797580; cv=none; b=tV3PFAacjUG1+Rf8MLX1MbvuWioB2bjRt41ZCgRItmqY3UvvEWV/qhfQaEiJWyfA5XndPv2ldiaud3ZyO85s+mlRaptKSnSiTijaVwAxTEKqqvx7906AWyQ2HcsXMHvEX9Oe2HlY+idx5iiSBc9Mr22GD+OyI2fgzx0tuUcOZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797580; c=relaxed/simple;
	bh=1aWPDrLVCK4aP22T5tyX3D1uSz8ajQJ3TSOvHn2sEaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBNk5KvxySktviXtCNhwi1bzdlZIzZ9qMa6/dd+fL0i7FoUCcdVWQq//u9gvTPR2Lv/xP+kvNpRtxhQSpFsmY2gtujIVZ1c1Yd3oeJup3JXkazCdKmgOS8QRQdgvLpYPKQq1ti7w/jb1N7MGNh8sg66jrXZKBGgRFS+fbxP3n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPqJSl4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPqJSl4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1CC32782;
	Fri, 12 Jul 2024 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720797580;
	bh=1aWPDrLVCK4aP22T5tyX3D1uSz8ajQJ3TSOvHn2sEaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPqJSl4ZPIKlj453qNkRZRUX2zQm5FoN4ZiR86uVW2Zqd+Q/KD/q7ATFwcJMPe/oq
	 Fvd++Xx7nfTB+bUqHkHASiDP3dK2avToCzQRUx/s4kW26VxqtShcgv67RcJk6lvFWX
	 afbUvQUPNwE369ES4D4oHMyPmjfB+zAUbN6JoKOichEGylcKzbNaWSaQxzIwBC2IUR
	 PCfRBWWwxNpys8CSvbW6ZqkT2DKNVTqnRtWiyyg0zEl9QzXy9Mv3zWzAXpGUNfJk8m
	 qOzeOPjh7BsIm0vyoIyTh6M0BfCAj80jXhLCeJOt/iQZD/nAOGvAy2phNxZp7sEKd2
	 sqvFSdO9ywBuA==
Date: Fri, 12 Jul 2024 17:19:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpFJhk_HgQhGAQMU@ryzen.lan>
References: <20240712142922.3292722-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712142922.3292722-1-Frank.Li@nxp.com>

On Fri, Jul 12, 2024 at 10:29:22AM -0400, Frank Li wrote:
> Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> 'fsl,ls1043a-ahci'.
> 
> Fix below CHECK_DTB warnings
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - rework commit message to show fix CHECK_DTB warning.
> ---
>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> index 162b3bb5427ed..a244bc603549d 100644
> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> @@ -11,13 +11,18 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,ls1021a-ahci
> -      - fsl,ls1043a-ahci
> -      - fsl,ls1028a-ahci
> -      - fsl,ls1088a-ahci
> -      - fsl,ls2080a-ahci
> -      - fsl,lx2160a-ahci
> +    oneOf:
> +      - items:
> +          - const: fsl,ls1012a-ahci
> +          - const: fsl,ls1043a-ahci
> +      - enum:
> +          - fsl,ls1021a-ahci
> +          - fsl,ls1043a-ahci
> +          - fsl,ls1046a-ahci
> +          - fsl,ls1028a-ahci
> +          - fsl,ls1088a-ahci
> +          - fsl,ls2080a-ahci
> +          - fsl,lx2160a-ahci

I think that you should add the following Fixes-tag:
Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")

Considering that the commit that your are fixing is only in libata for-6.11,
and has thus never been in a released kernel version, perhaps the following
patch would be better (if it also solves the warnings):

diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
index 162b3bb5427e..8953b1847305 100644
--- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
@@ -12,8 +12,10 @@ maintainers:
 properties:
   compatible:
     enum:
+      - fsl,ls1012a-ahci
       - fsl,ls1021a-ahci
       - fsl,ls1043a-ahci
+      - fsl,ls1046a-ahci
       - fsl,ls1028a-ahci
       - fsl,ls1088a-ahci
       - fsl,ls2080a-ahci


This assumes that we can get the patch included before 6.11 final is released,
but considering that the merge window hasn't even opened yet, that should be
doable.


Thoughts from DT maintainers?



Kind regards,
Niklas
