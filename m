From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] SATA: rcar: add device tree support for r8a7792
Date: Thu, 25 Feb 2016 18:40:51 +0900
Message-ID: <20160225094051.GB28141@verge.net.au>
References: <1456362985-24137-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50437 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760365AbcBYJkz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 04:40:55 -0500
Content-Disposition: inline
In-Reply-To: <1456362985-24137-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org

On Thu, Feb 25, 2016 at 10:16:25AM +0900, Simon Horman wrote:
> Simply document new compatibility string.
> As a previous patch adds a generic R-Car Gen2 compatibility string
> there appears to be no need for a driver updates.
> 
> By documenting this compat sting it may be used in DTSs shipped, for
> example as part of ROMs. It must be used in conjunction with the Gen2
> fallback compat string. At this time there are no known differences between
> the r8a7792 IP block and that implemented by the driver for the Gen2
> fallback compat string. Thus there is no need to update the driver as the
> use of the Gen2 fallback compat string will activate the correct code in
> the current driver while leaving the option for r8a7792-specific driver
> code to be activated in an updated driver should the need arise.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/ata/sata_rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
>  Based on the for-next branch of the libata tree

I seem to have omitted the patch to add the fallback binding.
I'll respin. In the mean time please ignore this patch.

> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 0764f9ab63dc..539dbdfba8de 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -7,6 +7,7 @@ Required properties:
>  			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
>  			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
>  			  - "renesas,sata-r8a7791" for R-Car M2-W
> +			  - "renesas,sata-r8a7792" for R-Car V2H
>  			  - "renesas,sata-r8a7793" for R-Car M2-N
>  			  - "renesas,sata-r8a7795" for R-Car H3
>  - reg			: address and length of the SATA registers;
> -- 
> 2.7.0.rc3.207.g0ac5344
