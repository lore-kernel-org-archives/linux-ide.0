From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/7] ATA: remove excess kernel-doc notation
Date: Fri, 31 Oct 2008 01:45:56 -0400
Message-ID: <490A9B94.2010805@pobox.com>
References: <20081029223508.c824f8dc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50946 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbYJaFqA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Oct 2008 01:46:00 -0400
In-Reply-To: <20081029223508.c824f8dc.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Remove excess kernel-doc function parameter notation from drivers/ata/:
> 
> Warning(drivers/ata/libata-core.c:1622): Excess function parameter or struct member 'fn' description in 'ata_pio_queue_task'
> Warning(drivers/ata/libata-core.c:4655): Excess function parameter or struct member 'err_mask' description in 'ata_qc_complete'
> Warning(drivers/ata/ata_piix.c:751): Excess function parameter or struct member 'udma' description in 'do_pata_set_dmamode'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/ata_piix.c    |    1 -
>  drivers/ata/libata-core.c |    2 --
>  2 files changed, 3 deletions(-)
> 
> --- lin2628-rc2.orig/drivers/ata/ata_piix.c
> +++ lin2628-rc2/drivers/ata/ata_piix.c
> @@ -738,7 +738,6 @@ static void piix_set_piomode(struct ata_
>   *	do_pata_set_dmamode - Initialize host controller PATA PIO timings
>   *	@ap: Port whose timings we are configuring
>   *	@adev: Drive in question
> - *	@udma: udma mode, 0 - 6
>   *	@isich: set if the chip is an ICH device
>   *
>   *	Set UDMA mode for device, in host controller PCI config space.
> --- lin2628-rc2.orig/drivers/ata/libata-core.c
> +++ lin2628-rc2/drivers/ata/libata-core.c
> @@ -1602,7 +1602,6 @@ unsigned long ata_id_xfermask(const u16 
>  /**
>   *	ata_pio_queue_task - Queue port_task
>   *	@ap: The ata_port to queue port_task for
> - *	@fn: workqueue function to be scheduled
>   *	@data: data for @fn to use
>   *	@delay: delay time in msecs for workqueue function
>   *
> @@ -4643,7 +4642,6 @@ static void ata_verify_xfer(struct ata_q
>  /**
>   *	ata_qc_complete - Complete an active ATA command
>   *	@qc: Command to complete
> - *	@err_mask: ATA Status register contents
>   *
>   *	Indicate to the mid and upper layers that an ATA

applied


