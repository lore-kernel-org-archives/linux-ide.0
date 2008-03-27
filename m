From: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [patch for 2.6.25? 1/1] pata_sil680: only enable MMIO on Cell
	blades
Date: Thu, 27 Mar 2008 18:48:21 +1100
Message-ID: <1206604101.10388.2.camel@pasglop>
References: <200803270746.m2R7kjIL024193@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41582 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbYC0Hsw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Mar 2008 03:48:52 -0400
In-Reply-To: <200803270746.m2R7kjIL024193@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com


On Thu, 2008-03-27 at 00:46 -0700, akpm@linux-foundation.org wrote:
> From: Benjamin Herrenschmidt <benh@ozlabs.org>
> 
> There have been reported regressions of the SIL 680 driver when using MMIO, so
> this makes it only try MMIO on Cell blades where it's known to be necessary
> (the host bridge doesn't do PIO on these).

This should go in .25 please.

Cheers,
Ben.

> We'll try to find the root problem with MMIO separately.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_sil680.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/ata/pata_sil680.c~pata_sil680-only-enable-mmio-on-cell-blades drivers/ata/pata_sil680.c
> --- a/drivers/ata/pata_sil680.c~pata_sil680-only-enable-mmio-on-cell-blades
> +++ a/drivers/ata/pata_sil680.c
> @@ -229,7 +229,11 @@ static u8 sil680_init_chip(struct pci_de
>  	dev_dbg(&pdev->dev, "sil680: BA5_EN = %d clock = %02X\n",
>  		tmpbyte & 1, tmpbyte & 0x30);
>  
> -	*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
> +	*try_mmio = 0;
> +#ifdef CONFIG_PPC
> +	if (machine_is(cell))
> +		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
> +#endif
>  
>  	switch(tmpbyte & 0x30) {
>  		case 0x00:
> _

