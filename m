From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/6] sata_sil: new interrupt handler
Date: Tue, 23 May 2006 07:50:56 -0700
Message-ID: <44732150.7020804@gmail.com>
References: <11480530904130-git-send-email-htejun@gmail.com> <446DE85B.2090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56034 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932401AbWEWVzW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:22 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1673597nzo
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:21 -0700 (PDT)
In-Reply-To: <446DE85B.2090809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +    /* ack bmdma irq events */
>> +    ap->ops->irq_clear(ap);
> 
> Don't use hook in LLDD

Okay.

>> +    spin_lock_irqsave(&host_set->lock, flags);
>> +
>> +    for (i = 0; i < host_set->n_ports; i++) {
>> +        struct ata_port *ap = host_set->ports[i];
>> +        u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
>> +
>> +        if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
>> +            continue;
>> +
>> +        if (!(bmdma2 & SIL_DMA_COMPLETE))
>> +            continue;
>> +
>> +        sil_host_intr(ap, bmdma2);
>> +        handled = 1;
>> +    }
>> +
>> +    spin_unlock_irqrestore(&host_set->lock, flags);
> 
> NAK, unconditionally use spin_lock() and spin_unlock() on this hardware.

Can you explain more on this?  We almost never use those in libata and I 
don't see what's different for sata_sil.

-- 
tejun

