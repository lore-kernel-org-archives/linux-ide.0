Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06D8F6A;
	Fri, 12 Jul 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817564; cv=none; b=c5W9RC7qA16wdKJxEvuwAFwifRDz0bqNC1s9cOY5AHfIIIP10a0qQAQTLb2Pv/9Pqif/o8+23U9SCb4h3DmNDj9R9hh52ZrjokK5/PYVG+3SxlGg5BowPoH5uhg9dVn8oJGvxnsimP5qaSYUImHMSXBXD/1ztZ8oy2FT9giPBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817564; c=relaxed/simple;
	bh=Vz026jv5Z1unOsWoMBG5L1EFGzAuxoABHy8IOuHg3BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK/ZjlkJunLazegJWjajixG0qT1yKKsyOUPuyQ5NPOp2S2ocQC59e/tRvESNdW1JUCJTNVjzeqgw7/oA/hojS9ghqU19KsMpZ+Wwoo7cbZJpfgQA0JdrTw8iekz/aA6RDuMmGreph+CyA4RUJ2jbHz02pVTVAK+6QmIRVRb2UsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmmL8+uC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmmL8+uC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28299C32782;
	Fri, 12 Jul 2024 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720817564;
	bh=Vz026jv5Z1unOsWoMBG5L1EFGzAuxoABHy8IOuHg3BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmmL8+uCq7+KjhgbyYmLS/qzapks9jmBvGeLMfZcgGDl6z+bIlGANEOKLlCOrO6ui
	 phf0gcFUpqXub2CifSKAkttjL6KQvazyzX+7RxuBtIbdy/gm7iLjdC11QTMn/7TkVW
	 NZrafrjmgFHbfGBFXD9GeJI6S8Ot9imfW3unpFp78ifFSE9jNLxrp7kEP+gUbE0fSi
	 t0mibGkFKeAQINIp/iTGxVA2St4valIDaasj/7WEt03T0eTwwJInFJ0Qpz5lhQloiF
	 mHNsEm//lmxKW4cbINVuozrK3EGNShG0f75KxB+9GPgJBiq8TH0cm4CI3Ap4fR1B/H
	 aO9FQIYGX4OIQ==
Date: Fri, 12 Jul 2024 22:52:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpGXl7W4h-sCjeGz@ryzen.lan>
References: <20240712185740.3819170-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712185740.3819170-1-Frank.Li@nxp.com>

On Fri, Jul 12, 2024 at 02:57:40PM -0400, Frank Li wrote:
> Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> 'fsl,ls1043a-ahci'.
> 
> Fix below CHECK_DTB warnings
> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long

These lines should have been wrapped to 75 lines IMO.
I will fixup when applying.

> 
> Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - Add rob's review tag
> - Sort compatible string list
> - Add fix tag
> - Add two warnings in commit message.
> - Add - description: sata controller for ls1012a
> 
> Change from v1 to v2
> - rework commit message to show fix CHECK_DTB warning.
> ---
>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> index 162b3bb5427ed..b58ea5a183082 100644
> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> @@ -11,13 +11,19 @@ maintainers:
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
> +      - description: sata controller for ls1012a

SATA should have been capitalized.
I will fixup when applying.


Kind regards,
Niklas
