From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_vsc with iq3124h regression in 2.6.20
Date: Sat, 10 Feb 2007 09:58:36 -0500
Message-ID: <45CDDD9C.2030301@gmail.com>
References: <0C7297FA1D2D244A9C7F6959C0BF1E52015235BE@azsmsx413.amr.corp.intel.com> <45CCF6BD.9020404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:23611 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbXBJO7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 09:59:00 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1205760wri
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 06:58:59 -0800 (PST)
In-Reply-To: <45CCF6BD.9020404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, linux-ide@vger.kernel.org, jeremy@sgi.com, Mark Lord <liml@rtr.ca>

Jeff Garzik wrote:
> Williams, Dan J wrote:
>> When I fire up 2.6.20 with an iq3124h I get:
>>
>> ata1: SATA max UDMA/133 cmd 0xC8822200 ctl 0xC8822229 bmdma 0xC8822270
>> irq 25
>> ata2: SATA max UDMA/133 cmd 0xC8822400 ctl 0xC8822429 bmdma 0xC8822470
>> irq 25
>> ata3: SATA max UDMA/133 cmd 0xC8822600 ctl 0xC8822629 bmdma 0xC8822670
>> irq 25
>> ata4: SATA max UDMA/133 cmd 0xC8822800 ctl 0xC8822829 bmdma 0xC8822870
>> irq 25
>> scsi0 : sata_vsc
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> irq 25: nobody cared (try booting with the "irqpoll" option)
>> handlers:
>> [<c01796e0>] (vsc_sata_interrupt+0x0/0x194)
>> Disabling IRQ #25
>>
>> I did a git bisect and came up with: [PATCH] libata: always use polling
>> IDENTIFY (800b399669ad495ad4361d134df87401ae36f44f)
>>
>> I could probably cobble together a workaround to use irq-driven IDENTIFY
>> for this card but wanted to see if there was a better way.
> 
> As I recall, the 31244 and VSC-7174 always send an interrupt, so the 
> driver should account for this.  I thought we had code already in the 
> driver to handle this, but perhaps recent changes stomped that.
> 
> It would be good to standardize the way we handle these sorts of 
> controllers, because (I think) Mark Lord has the same problem on 
> sata_qstor (or pdc_adma?).

Yeah, it seems we need ATA_FLAG_LISTEN_IRQ_WHILE_POLLING or 
ATA_FLAG_BROKEN_NIEN or something.

-- 
tejun
