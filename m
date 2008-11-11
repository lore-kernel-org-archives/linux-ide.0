From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sch slave devices
Date: Tue, 11 Nov 2008 03:02:31 -0500
Message-ID: <49193C17.2050905@garzik.org>
References: <1225976603.24291.8.camel@deneb.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32923 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411AbYKKICf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:02:35 -0500
In-Reply-To: <1225976603.24291.8.camel@deneb.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>

Mark Salter wrote:
> I posted this last month, but was prompted to do so again in bz#467457
> 
> Add capability flag to support slave devices with pata_sch driver.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
> diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
> index c8cc027..6aeeeeb 100644
> --- a/drivers/ata/pata_sch.c
> +++ b/drivers/ata/pata_sch.c
> @@ -83,7 +83,7 @@ static struct ata_port_operations sch_pata_ops = {
>  };
>  
>  static struct ata_port_info sch_port_info = {
> -	.flags		= 0,
> +	.flags		= ATA_FLAG_SLAVE_POSS,
>  	.pio_mask	= ATA_PIO4,   /* pio0-4 */
>  	.mwdma_mask	= ATA_MWDMA2, /* mwdma0-2 */
>  	.udma_mask	= ATA_UDMA5,  /* udma0-5 */

applied


