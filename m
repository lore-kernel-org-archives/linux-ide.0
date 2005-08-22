From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata:upstream] fix atapi_packet_task vs. intr race
Date: Mon, 22 Aug 2005 00:15:18 -0400
Message-ID: <43095156.7080500@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com> <20050822035956.GB28721@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:63885 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932174AbVHVWzn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:55:43 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M4FP4k011111
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 21:15:25 -0700
In-Reply-To: <20050822035956.GB28721@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Interrupts from devices sharing the same IRQ could cause
> ata_host_intr to finish commands being processed by atapi_packet_task
> if the commands are using ATA_PROT_ATAPI_NODATA or ATA_PROT_ATAPI_DMA
> protocol.  This is because libata interrupt handler is unaware that
> interrupts are not expected during that period.  This patch adds
> ATA_FLAG_NOINTR flag to tell the interrupt handler that we're not
> expecting interrupts.
> 
>  Note that once proper HSM is implemented for interrupt-driven PIO,
> this should be merged into it and this flag will be removed.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Looks good except for two things:

* use spin_lock_irqsave()/spin_unlock_irqrestore(), not spin_lock_irq()

* need to audit every driver[1].  if it implements its own 
->irq_handler() hook, then you likely need to update the driver.

	Jeff


[1] drivers/scsi/ahci.c drivers/scsi/ata_*.c drivers/scsi/sata_*.[ch]
