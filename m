From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement port_task
Date: Sun, 05 Mar 2006 11:09:08 -0500
Message-ID: <440B0D24.7080501@pobox.com>
References: <11415401491000-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21715 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932170AbWCEQJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 11:09:13 -0500
In-Reply-To: <11415401491000-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement port_task.  LLDD's can schedule a function to be executed
> with context after specified delay.  libata core takes care of
> synchronization against EH.  This is generalized form of pio_task and
> packet_task which are tied to PIO hsm implementation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   77 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-scsi.c |    2 +
>  drivers/scsi/libata.h      |    1 +
>  include/linux/libata.h     |    4 ++
>  4 files changed, 84 insertions(+), 0 deletions(-)
> 
> 4d83950873856672ed469f25c6421de1eb98ba97
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index b710fc4..3575d68 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -721,6 +721,81 @@ static unsigned int ata_pio_modes(const 
>  	   timing API will get this right anyway */
>  }
>  
> +/**
> + *	ata_port_queue_task - Queue port_task
> + *	@ap: The ata_port to queue port_task for
> + *
> + *	Schedule @fn(@data) for execution after @delay jiffies using
> + *	port_task.  There is one port_task per port and it's the
> + *	user(low level driver)'s responsibility to make sure that only
> + *	one task is active at any given time.
> + *
> + *	libata core layer takes care of synchronization between
> + *	port_task and EH.  ata_port_queue_task() may be ignored for EH
> + *	synchronization.
> + *
> + *	LOCKING:
> + *	Inherited from caller.
> + */
> +void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *), void *data,
> +			 unsigned long delay)
> +{
> +	int rc;
> +
> +	if (ap->flags & ATA_FLAG_FLUSH_PIO_TASK)
> +		return;
> +
> +	PREPARE_WORK(&ap->port_task, fn, data);
> +
> +	if (!delay)
> +		rc = queue_work(ata_wq, &ap->port_task);
> +	else
> +		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);

Two worries here, though not quite a NAK:

1) This is abuse of the PREPARE_WORK(), which is usually not used 
because INIT_WORK() took care of the initialization.  However, it should 
be OK if...

2) This will fall apart if anything tries to queue a task while a 
previous task is still pending.  Are you certain a double-queue never 
ever happens?

	Jeff



