From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] sata_rcar: Add compatible string for r8a7795
Date: Fri, 20 Nov 2015 10:37:16 -0800
Message-ID: <20151120183714.GE29534@verge.net.au>
References: <1448022782-24231-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58095 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760548AbbKTShT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2015 13:37:19 -0500
Content-Disposition: inline
In-Reply-To: <1448022782-24231-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Fri, Nov 20, 2015 at 09:33:02PM +0900, Yoshihiro Kaneko wrote:
> From: Kouei Abe <kouei.abe.cp@renesas.com>
> 
> R-Car H3 SoC has compatible SATA controller with R-Car Gen2 SoCs.
> 
> Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> This patch is based on the for-next branch of Tejun's libata tree.
> 
>  Documentation/devicetree/bindings/ata/sata_rcar.txt | 1 +
>  drivers/ata/sata_rcar.c                             | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 2493a5a3..0764f9a 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -8,6 +8,7 @@ Required properties:
>  			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
>  			  - "renesas,sata-r8a7791" for R-Car M2-W
>  			  - "renesas,sata-r8a7793" for R-Car M2-N
> +			  - "renesas,sata-r8a7795" for R-Car H3
>  - reg			: address and length of the SATA registers;
>  - interrupts		: must consist of one interrupt specifier.
>  - clocks		: must contain a reference to the functional clock.
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 8804127..2b20b31 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -854,6 +854,10 @@ static struct of_device_id sata_rcar_match[] = {
>  		.compatible = "renesas,sata-r8a7793",
>  		.data = (void *)RCAR_GEN2_SATA
>  	},
> +	{
> +		.compatible = "renesas,sata-r8a7795",
> +		.data = (void *)RCAR_GEN2_SATA
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sata_rcar_match);
> -- 
> 1.9.1
> 
