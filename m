From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Fri, 25 Apr 2008 00:47:53 -0400
Message-ID: <48116279.6080302@garzik.org>
References: <480F231A.7020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46545 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbYDYEr4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:47:56 -0400
In-Reply-To: <480F231A.7020401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>

Tejun Heo wrote:
> Some chips need AHCI_EN set more than once to actually set it.  Try a
> few times before giving up and spitting out WARN_ON().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Peer Chen <pchen@nvidia.com>
> Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
> ---
> drivers/ata/ahci.c |   15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 739ba3f..711b5d7 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -556,16 +556,27 @@ static inline void __iomem *ahci_port_base(struct 
> ata_port *ap)
> 
> static void ahci_enable_ahci(void __iomem *mmio)
> {
> +    int i;
>     u32 tmp;
> 
>     /* turn on AHCI_EN */
>     tmp = readl(mmio + HOST_CTL);
> -    if (!(tmp & HOST_AHCI_EN)) {
> +    if (tmp & HOST_AHCI_EN)
> +        return;
> +
> +    /* Some controllers need AHCI_EN to be written multiple times.
> +     * Try a few times before giving up.
> +     */
> +    for (i = 0; i < 5; i++) {
>         tmp |= HOST_AHCI_EN;
>         writel(tmp, mmio + HOST_CTL);
>         tmp = readl(mmio + HOST_CTL);    /* flush && sanity check */
> -        WARN_ON(!(tmp & HOST_AHCI_EN));
> +        if (tmp & HOST_AHCI_EN)
> +            return;
> +        msleep(10);
>     }
> +
> +    WARN_ON(1);
> }

applied


