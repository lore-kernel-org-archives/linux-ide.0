Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F01179AA;
	Fri, 12 Jul 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779447; cv=none; b=TDxOctQTBQiCIiFtozTULer4pW6dVZ929J9IbPhzEa4T0kFhTVygPa3LgeAzSTFgUpkWExcqqnJZ5i0pT/uXykXmptIRhr4jTDhT5IOfR4mp4PHBLklXUYSBpi2OmoxkZlA85IbOxUAFbd79Zo8Nf8L74q4KaI92gqP0cqdbMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779447; c=relaxed/simple;
	bh=k+12JrJcwlPHxwOcQuMgYDvLeH/luxPbX/wCoxHA094=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2m7U8HtXNt6rgA97ZdiMsqzB5MKXOQAiTuzxZwFvTXUE7G7dv6FfZxs4sBzcYPLPjCDQ/+z93JQtBuAuWdhq3gaT1twRXLuvluGyG7KOheq2J7K8Dt0SQdHRLiCgeKB/1dPg6x7S9AAPbqNzHPDrV2rg8++iRaymTvei3GjY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpdfebqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpdfebqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189EBC32782;
	Fri, 12 Jul 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779447;
	bh=k+12JrJcwlPHxwOcQuMgYDvLeH/luxPbX/wCoxHA094=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpdfebqIpGb2gBlG2fLlOrQMUaudFqIZ/9vuw/bwVEHve5yYCXO7EGZxstRcHyMfX
	 r2W8JgW59PLEPFTISBJUqG2kVajQ8VqxZUaWRPfWJPQy+AkyNkrYF2/HJqb5mkaHTM
	 7mkWbI60H9hph1iigbG9GtKHjoY4Cg1ILvsqrtkdapdo6N8WksATgHqCFfG7myDP5m
	 wIQUC3WI3NkONCOW0nR1hAuznabNv4OxuxTlLk26x0BvDtUD2B3K8eYRsp8UclRpSX
	 6Z8sjuu3+AHwVQ9Si3Sl5ygSDogIE3e4HC33fNtVNXUwPzoFYT1Mo4k4JDxbcupK1S
	 IkppNCcXi5kYg==
Date: Fri, 12 Jul 2024 12:17:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpECsX92IXxVdYrc@ryzen.lan>
References: <20240625205752.4007067-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625205752.4007067-1-Frank.Li@nxp.com>

On Tue, Jun 25, 2024 at 04:57:52PM -0400, Frank Li wrote:
> Add compatible string 'fsl,ls1046a-ahci' and 'fsl,ls1012a-ahci' compatible
> string. Allow 'fsl,ls1012a-ahci' fallback to 'fsl,ls1043a-ahci'.
> 
> ls1046a ahci ecc disable bit is difference with other chips.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
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
>  
>    reg:
>      minItems: 1
> -- 
> 2.34.1
> 

Frank,

if the check_dts warning is still there,
will you submit a new patch with a better commit message that explains that
the patch fixes the initial commit that converted the binding to yaml?

Such that DT maintainers can review your v2 patch.


Kind regards,
Niklas
