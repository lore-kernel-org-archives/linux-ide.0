Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657618B47E;
	Mon, 18 Nov 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930183; cv=none; b=hOiqZQY9llHpn/SPSbC8hgy6gwLe2o+caPGTyRpkwNEfJ34kXUIhjntPdSgF0mqpBPyTdirWyZyqaFd/8qiMK/a01PMaBkv6Wow4RVLlvthPHFJu27HU9uC5vrXFWuBuUQNx5wWiwxn4NNQJ6U2PerJKS4arj/2rcC/dBAdJhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930183; c=relaxed/simple;
	bh=1Mu1Oe4up2k7/Ym+0BclLRPliMzcmd4nehsjMkkiK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkpC6zcLndqvMj+cuKRCXo/BKLPe/l2M7yw+mfZ6HHhqQFIE8261tXujIjvaQEdyJn8tv74wB3TCMr+UilcAGqIGMhQRC+6gaola4svQ9EXWf/Yi6/PMgkqrkV5LQI/+awgiyMIivpCSAzidCfO14zIL2HTLIV5d8V5cTak1r10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5znzDYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5znzDYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D219C4CECC;
	Mon, 18 Nov 2024 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731930182;
	bh=1Mu1Oe4up2k7/Ym+0BclLRPliMzcmd4nehsjMkkiK+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5znzDYcfP7e/PkaQyn1TGyrHDIDHQVZ4sMoTAWqMVz7weOcUZOtx6BsHL362pNaF
	 qSU0Cxnwls+yj0MtELD6fjB7C2Kegp4uhxQnIaf5MOlggl4P3OPXzQ7iW0uhZAID4T
	 dJV2z9oQ8nLoUEL/wUYzQ0cCcgTrySqH32vYAw6yIf1zuLXofm2G0TQ1krRUglscwm
	 phtgPlk3JnODOUB5S0m1R04UjvsFZgz9bErEW929ZXpOqci73BYvHq+E1y6/8ZNlvt
	 zXiH3qIh8JKqbdfM7oUTjWQ0Z9Vx+UKjVm8y0WBViPRxRJY4mY+Bq0cfK2atH920wv
	 15XlMts+gMx5w==
Date: Mon, 18 Nov 2024 12:42:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: Constify struct pci_device_id
Message-ID: <ZzsoQlOaDP4FJ8G-@ryzen>
References: <8bddfee7f6f0f90eeb6da7156e30ab3bd553deb1.1731704917.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bddfee7f6f0f90eeb6da7156e30ab3bd553deb1.1731704917.git.christophe.jaillet@wanadoo.fr>

On Fri, Nov 15, 2024 at 10:08:55PM +0100, Christophe JAILLET wrote:
> 'struct pci_device_id' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4245	   1454	      4	   5703	   1647	drivers/ata/ata_generic.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    4725	    974	      4	   5703	   1647	drivers/ata/ata_generic.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
> ---
>  drivers/ata/ata_generic.c  | 2 +-
>  drivers/ata/pata_atp867x.c | 2 +-
>  drivers/ata/pata_piccolo.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index 2f57ec00ab82..e70b6c089cf1 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
> @@ -209,7 +209,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>  	return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
>  }
>  
> -static struct pci_device_id ata_generic[] = {
> +static const struct pci_device_id ata_generic[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F), },
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index aaef5924f636..308f86f9e2f0 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -525,7 +525,7 @@ static int atp867x_reinit_one(struct pci_dev *pdev)
>  }
>  #endif
>  
> -static struct pci_device_id atp867x_pci_tbl[] = {
> +static const struct pci_device_id atp867x_pci_tbl[] = {
>  	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
>  	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867B),	0 },
>  	{ },
> diff --git a/drivers/ata/pata_piccolo.c b/drivers/ata/pata_piccolo.c
> index ced906bf56be..beb53bd990be 100644
> --- a/drivers/ata/pata_piccolo.c
> +++ b/drivers/ata/pata_piccolo.c
> @@ -97,7 +97,7 @@ static int ata_tosh_init_one(struct pci_dev *dev, const struct pci_device_id *id
>  	return ata_pci_bmdma_init_one(dev, ppi, &tosh_sht, NULL, 0);
>  }
>  
> -static struct pci_device_id ata_tosh[] = {
> +static const struct pci_device_id ata_tosh[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
> -- 
> 2.47.0
> 

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

However, since we are in the middle of the merge window, expect to wait
until 6.13-rc1 is out until this is picked up.


Kind regards,
Niklas
