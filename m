From: Mark Lord <liml@rtr.ca>
Subject: Re: Port-Multiplier hotplug support: ATA_FLAG_AN
Date: Wed, 14 May 2008 08:46:11 -0400
Message-ID: <482ADF13.7020701@rtr.ca>
References: <482A1B41.50507@rtr.ca> <482A582A.7090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1820 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762300AbYENMqM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 08:46:12 -0400
In-Reply-To: <482A582A.7090108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun,
>>
>> Apparently the newer (GenIIe) sata_mv chips *can* support asynchronous
>> notification without problems.  Some/all of the older ones cannot 
>> (errata).
>>
>> So, I've done the one-liner change in sata_mv, to add ATA_FLAG_AN to
>> the 7042 and 6042 chips, and it all seems to work rather nicely.
>>
>> Am I missing something?  Is there any other local code to sata_mv
>> that should be provided before setting ATA_FLAG_AN ?
>>
>> Like I said, it works, but I just want to check whether any other
>> pieces are expected to be present?
> 
> You need to call sata_async_notification() from interrupt handler after 
> AN FIS is received.  sata_async_notification() is responsible for 
> discerning between ATAPI and PMP ANs using SNotification and schedule 
> appropriate actions.  If SNotification is not available && PMP is 
> attached, it just calls ata_port_schedule_eh().  That's probably why it 
> just worked by setting ATA_FLAG_AN.
..

Okay, that's cool.  So mv_err_intr() now just calls sata_async_notification(),
and then bails out without further action (if no other errors coincided),
and the EH then runs for just that one PM link, rather than the whole port.

(tested, working).

Cool!
