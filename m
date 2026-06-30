Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B03A6B67;
	Tue, 30 Jun 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805270; cv=none; b=bI3HAvJ6Ui9MbZMSmqlqDlxDQp5dSuxMdCXjPMWoTmc3HLRFqMOE4OumHaOqkvNxKXIZpwlOKf3VJO2OBXKuUKS4LnzncMgODuADpzsBQA0fPN26WjUSUjnq4Pzk3yc+3h00ZuqvjAzBwNDIYf30ud+C/IHu1aS/tpyLZgScats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805270; c=relaxed/simple;
	bh=fIeqLsii7EqR6ptDww5EPG58fDO3h7LpBUbh1eKo2PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcNR62+GL81qI48FO6GWJa/sxx/pdsxUteod8w8Fz0w31GBKWPX5+ZyWLzVz2pQnZN2CyE5adshvyF/CbNyVSgjdlP3dusBLPDdPP6WK87vq87KrLXs6v9fMdkkVDDbmqN/DHDS0VogVm9ErkLzTYobSE85KxiFcABI5Eojv0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG0zTN1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG0zTN1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83121F000E9;
	Tue, 30 Jun 2026 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805268;
	bh=gEa8OkUnKXw3+MkpsByx3JNiEjNQwZNwA2KptUVdfvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iG0zTN1ea1ERhJlo5FXhZB6qjAkM5/hiOjgKSX0C1ZjWWNeJYjAtRgGgUvzIV9R7A
	 AdD+Z+VuQV34MVgvq6MKWIljbNyKKQzLP1BkDSOS4HZGjOHbO8TPup4+G33xvyAoiR
	 BVJtyAj5mLHkgs28d6sViReJNFcQ0tW7oxZGVeeSj7aBsxIWkRi1MpP0bR1JSVDUIQ
	 h3Nq2dp8CCK3b3uG5RLS7Eq/q8UUAhfGiOFkE/FukXVa53mwZ+BkPjcYbve+ESOJOr
	 yWrX5i2AXL+GaXHYiwxz6JmRXbwyYkIYddxK2kqz1hDd6/UDqtf/n/3YyI4GSuDA/+
	 BHjwhmFGa1NJQ==
Date: Tue, 30 Jun 2026 09:41:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Message-ID: <akNzEGgiYC5V3rtc@ryzen>
References: <20260628230310.1214770-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628230310.1214770-1-rosenp@gmail.com>

On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with platform_get_irq() in both
> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
> way to obtain IRQs for platform devices and provides better error
> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
> 
> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missing.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9a..35aa7f9acdf7 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -19,7 +19,6 @@
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
>  #include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/libata.h>
> @@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  				 struct sata_dwc_device *hsdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;

While this patch drops 'struct device_node *np = dev->of_node;' from
sata_dwc_dma_init_old() ...

>  
>  	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
>  	if (!hsdev->dma)
> @@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  	hsdev->dma->id = pdev->id;
>  
>  	/* Get SATA DMA interrupt number */
> -	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
> -	if (!hsdev->dma->irq) {
> -		dev_err(dev, "no SATA DMA irq\n");
> -		return -ENODEV;
> -	}
> +	hsdev->dma->irq = platform_get_irq(pdev, 1);
> +	if (hsdev->dma->irq < 0)
> +		return hsdev->dma->irq;
>  
>  	/* Get physical SATA DMA register base address */
>  	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)

it seems like you forgot to do the same for sata_dwc_probe().

Which results in a new warning:
https://lore.kernel.org/oe-kbuild-all/202606301243.9MrXM4WY-lkp@intel.com/T/#u

Damien, perhaps drop this patch and wait for a v2,
or fixup the patch to remove 'struct device_node *np = dev->of_node;'
also from sata_dwc_probe().


>  	sata_dwc_enable_interrupts(hsdev);
>  
>  	/* Get SATA interrupt number */
> -	irq = irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		dev_err(dev, "no SATA DMA irq\n");
> -		return -ENODEV;
> -	}
> +	irq = platform_get_irq(ofdev, 0);
> +	if (irq < 0)
> +		return irq;
>  
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>  	if (!of_property_present(np, "dmas")) {
> -- 
> 2.54.0
> 
