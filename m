From: Mark Lord <liml@rtr.ca>
Subject: Re: Port-Multiplier hotplug support: ATA_FLAG_AN
Date: Tue, 13 May 2008 22:50:29 -0400
Message-ID: <482A5375.1010808@rtr.ca>
References: <482A1B41.50507@rtr.ca> <482A2384.8000306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4017 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853AbYENCuc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 22:50:32 -0400
In-Reply-To: <482A2384.8000306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
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
> Did you check ATAPI or just PMP AN?
..

sata_mv does not (yet) support ATAPI for anything.

-ml
