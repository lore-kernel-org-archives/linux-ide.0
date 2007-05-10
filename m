From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-mm1 2/2] sata_promise: SATAII-150/300 TX4 port
 numbering fix
Date: Wed, 09 May 2007 20:16:58 -0400
Message-ID: <4642647A.5010901@garzik.org>
References: <200705062014.l46KE1U3026752@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50589 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357AbXEJARB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:17:01 -0400
In-Reply-To: <200705062014.l46KE1U3026752@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> There is a known problem with sata_promise on SATAII-150/300 TX4
> controller cards: it enumerates drives in an order that differs
> from the port numbers printed on the controller cards. However,
> Promise's BIOS and Linux driver both get the order right.
> 
> I investigated Promise's Linux driver (v1.01.0.23), and found
> that it explicitly changes the mapping from logical port number
> to ATA engine MMIO address on the SATAII TX4 cards. It does this
> on all SATAII TX4 cards, without inspecting revision etc. The
> SATAII TX2plus cards continue to use the same mapping that was
> used for the first-generation chips.
> 
> This patch updates sata_promise to use the new port number to
> ATA engine mapping on SATAII TX4 cards, which fixes the drive
> enumeration order problem on those cards. Tested on several
> 1st and 2nd generation TX2plus and TX4 chips.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
> Changes since previous submission: ported to libata#ALL and the
> new init model, updated to apply after the fix for the 2nd error
> decode regression.
> 
>  drivers/ata/sata_promise.c |   22 ++++++++++++++++++----
>  1 files changed, 18 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.21-mm1/drivers/ata/sata_promise.c.~1~	2007-05-06 20:29:28.000000000 +0200
> +++ linux-2.6.21-mm1/drivers/ata/sata_promise.c	2007-05-06 20:30:39.000000000 +0200
> @@ -45,7 +45,7 @@
>  #include "sata_promise.h"
>  
>  #define DRV_NAME	"sata_promise"
> -#define DRV_VERSION	"2.06"
> +#define DRV_VERSION	"2.07"
>  
>  
>  enum {
> @@ -926,6 +926,7 @@ static int pdc_ata_init_one (struct pci_
>  	struct ata_host *host;
>  	void __iomem *base;
>  	int n_ports, i, rc;
> +	int is_sataii_tx4;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
> @@ -964,10 +965,23 @@ static int pdc_ata_init_one (struct pci_
>  	}
>  	host->iomap = pcim_iomap_table(pdev);
>  
> -	for (i = 0; i < host->n_ports; i++)
> +	is_sataii_tx4 = 0;
> +	if ((pi->flags & (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) == (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) {
> +		is_sataii_tx4 = 1;
> +		dev_printk(KERN_INFO, &pdev->dev, "applying SATAII TX4 port numbering workaround\n");

   ...though I'm not sure the printk is really wanted.  nonetheless, I 
applied it.


