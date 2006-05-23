From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/6] sata_sil: new interrupt handler
Date: Tue, 23 May 2006 15:07:14 -0700
Message-ID: <44738792.10909@gmail.com>
References: <11480530904130-git-send-email-htejun@gmail.com> <446DE85B.2090809@pobox.com> <44732150.7020804@gmail.com> <447386D3.5060109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:37852 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932458AbWEWWH1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 18:07:27 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1675323nzo
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 15:07:26 -0700 (PDT)
In-Reply-To: <447386D3.5060109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>>> +    /* ack bmdma irq events */
>>>> +    ap->ops->irq_clear(ap);
>>>
>>> Don't use hook in LLDD
>>
>> Okay.
>>
>>>> +    spin_lock_irqsave(&host_set->lock, flags);
>>>> +
>>>> +    for (i = 0; i < host_set->n_ports; i++) {
>>>> +        struct ata_port *ap = host_set->ports[i];
>>>> +        u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
>>>> +
>>>> +        if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
>>>> +            continue;
>>>> +
>>>> +        if (!(bmdma2 & SIL_DMA_COMPLETE))
>>>> +            continue;
>>>> +
>>>> +        sil_host_intr(ap, bmdma2);
>>>> +        handled = 1;
>>>> +    }
>>>> +
>>>> +    spin_unlock_irqrestore(&host_set->lock, flags);
>>>
>>> NAK, unconditionally use spin_lock() and spin_unlock() on this hardware.
>>
>> Can you explain more on this?  We almost never use those in libata and 
>> I don't see what's different for sata_sil.
> 
> er, huh?  _Most_ libata drivers use spin_lock().
> 
> The only case where spin_lock_irqsave() should be used is when you are 
> dealing with multiple independent interrupts, i.e. the legacy case of 
> irqs 14/15.
> 
> Thus, the core uses the safe-in-all-cases version, and drivers that 
> implement their own interrupt handler can implement the better version.
> 
> [jgarzik@pretzel linux-2.6]$ grep -wl spin_lock drivers/scsi/ahci.c 
> drivers/scsi/pdc_adma.c drivers/scsi/sata_*.c
> drivers/scsi/ahci.c
> drivers/scsi/pdc_adma.c
> drivers/scsi/sata_mv.c
> drivers/scsi/sata_promise.c
> drivers/scsi/sata_qstor.c
> drivers/scsi/sata_sil24.c
> drivers/scsi/sata_sx4.c
> drivers/scsi/sata_vsc.c
> 

Ouch, you're right.  Sorry about the noise.

-- 
tejun
