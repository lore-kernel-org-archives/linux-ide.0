From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: disable PMP for marvell ahcis
Date: Mon, 08 Sep 2008 12:16:36 -0400
Message-ID: <48C54FE4.6010903@garzik.org>
References: <48B801CF.6010703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37763 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbYIHQQk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:16:40 -0400
In-Reply-To: <48B801CF.6010703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, kueihuan.chen@gmail.com, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Marvell ahcis don't play nicely with PMPs.  Disable it.
> 
> Reported by KueiHuan Chen in the following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/33296
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: KueiHuan Chen <kueihuan.chen@gmail.com>
> Cc: Mark Lord <mlord@pobox.com>
> ---
>  drivers/ata/ahci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index dc7596f..2806366 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -420,7 +420,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  	/* board_ahci_mv */
>  	{
>  		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
> -				 AHCI_HFLAG_MV_PATA),
> +				 AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
>  		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,

applied


