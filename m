From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH Linux 2.6.12 07/09] NCQ: stop dma before reset
Date: Tue, 26 Jul 2005 17:12:42 -0400
Message-ID: <42E6A74A.80709@pobox.com>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050626152105.F3C5D2FC@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17084 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262088AbVGZVMu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2005 17:12:50 -0400
In-Reply-To: <20050626152105.F3C5D2FC@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 07_NCQ_ahci-stop-dma-before-reset.patch
> 
> 	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
> 	original code didn't and it resulted in occasional lockup of
> 	the controller during EH recovery.  This patch fixes the
> 	problem.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  ahci.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> Index: work/drivers/scsi/ahci.c
> ===================================================================
> --- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
> +++ work/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
> @@ -474,7 +474,9 @@ static void ahci_phy_reset(struct ata_po
>  	struct ata_device *dev = &ap->device[0];
>  	u32 tmp;
>  
> +	ahci_stop_dma(ap);
>  	__sata_phy_reset(ap);
> +	ahci_start_dma(ap);

This is a bit worrisome, because we really shouldn't be calling 
ahci_phy_reset() when DMA is -not- stopped.  That's a violation of the 
state machine.

	Jeff



