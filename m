From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Fri, 04 Aug 2006 12:09:13 -0400
Message-ID: <44D37129.9030100@rtr.ca>
References: <44D336EE.5000907@gmail.com> <44D36823.7020406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:25506 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161275AbWHDQJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Aug 2006 12:09:15 -0400
In-Reply-To: <44D36823.7020406@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> [adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
>> [ata_port_flush_task ] ENTER
>> [ata_port_flush_task ] flush #1
>> ata1: ata_port_flush_task: flush #2
>> ata1: ata_port_flush_task: EXIT
>> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> 
> 
> AC_ERR_HSM comes from the call to ac_err_mask().  Given a Status of 
> 0x58, it would appear that DRQ is asserted.
> 
> So if I had to guess, I would say that the above interrupt is the 
> DRQ-is-asserted indication, which would imply perhaps that this driver 
> should not bother with PIO polling.

I think this illustrates just how few people (Tejun) actually have
these chips and use them with Linux.  :)

I don't have a system to test this with today (long story),
but I'm trying to piece one together for later.

Is this "IDENTIFY using IRQs rather than polling" a newish feature?
Because I just don't see how it could work with the the existing
adma_intr_mmio routine --> that code is only correct for non-data
commands, and IDENTIFY definitely has data.

Borken driver, for sure.
