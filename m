From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Sat, 05 Aug 2006 01:26:01 +0900
Message-ID: <44D37519.1020908@gmail.com>
References: <44D336EE.5000907@gmail.com> <44D36823.7020406@pobox.com> <44D37129.9030100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:49128 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161284AbWHDQ0E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 12:26:04 -0400
Received: by py-out-1112.google.com with SMTP id t32so370053pyc
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 09:26:03 -0700 (PDT)
In-Reply-To: <44D37129.9030100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> [adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
>>> [ata_port_flush_task ] ENTER
>>> [ata_port_flush_task ] flush #1
>>> ata1: ata_port_flush_task: flush #2
>>> ata1: ata_port_flush_task: EXIT
>>> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
>>
>>
>> AC_ERR_HSM comes from the call to ac_err_mask().  Given a Status of 
>> 0x58, it would appear that DRQ is asserted.
>>
>> So if I had to guess, I would say that the above interrupt is the 
>> DRQ-is-asserted indication, which would imply perhaps that this driver 
>> should not bother with PIO polling.
> 
> I think this illustrates just how few people (Tejun) actually have
> these chips and use them with Linux.  :)

Thanks to you. :-)  Pretty cards though.

> I don't have a system to test this with today (long story),
> but I'm trying to piece one together for later.
> 
> Is this "IDENTIFY using IRQs rather than polling" a newish feature?
> Because I just don't see how it could work with the the existing
> adma_intr_mmio routine --> that code is only correct for non-data
> commands, and IDENTIFY definitely has data.

IDENTIFY w/ IRQs came with Albert Lee's irq-pio which was merged into 
mainline together with new EH.

-- 
tejun
