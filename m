From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/2] pata_atiixp: simplex clear
Date: Sat, 29 Mar 2008 12:15:40 -0400
Message-ID: <47EE6B2C.5010903@garzik.org>
References: <200803282133.m2SLXupx011467@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38332 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbYC2QPs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 12:15:48 -0400
In-Reply-To: <200803282133.m2SLXupx011467@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com, Tejun Heo <htejun@gmail.com>

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Some of the other quirks changes seem to have left some users with the simplex
> bits mis-set by the time the driver loads.  Clear simplex mode before we probe
> the controller therefore.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_atiixp.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear drivers/ata/pata_atiixp.c
> --- a/drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear
> +++ a/drivers/ata/pata_atiixp.c
> @@ -22,7 +22,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME "pata_atiixp"
> -#define DRV_VERSION "0.4.6"
> +#define DRV_VERSION "0.4.7"
>  
>  enum {
>  	ATIIXP_IDE_PIO_TIMING	= 0x40,
> @@ -243,6 +243,9 @@ static int atiixp_init_one(struct pci_de
>  		.port_ops = &atiixp_port_ops
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
> +	/* Some of the quirk reconfiguration messes up the simplex
> +	   flag, so clear it again */
> +	ata_pci_clear_simplex(dev);
>  	return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);

This patch triggered an audit which led me to... bug city.

1) This call occurs before resources are guaranteed to be present, which 
happens when pci[m]_enable_device() is called.

2) Auditing the other ata_pci_clear_simplex() uses, it seems the others 
are equally broken.

3) Further, looking at pata_amd, I notice that the resume code twiddles 
bits before the PCI device is even bought into D0 state!

4) ata_pci_clear_simplex() does its work before resources are mapped, 
and assumes PCI IDE and PCI BAR #4 behavior.  This works at present, but 
is less robust than it could be.


Anyway, my suggestion would be to add a "post-enable" function pointer 
to ata_pci_init_one() arguments, and call ata_pci_clear_simplex() from 
that hook.  That would permit this patch and other 
ata_pci_clear_simplex() callsites to be fixed.

	Jeff


