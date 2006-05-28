From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date: Sun, 28 May 2006 15:18:05 -0400
Message-ID: <4479F76D.40506@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org> <200605281128.00532.liml@rtr.ca> <20060528171424.GA12982@suse.de> <4479F487.5080507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:11230 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750872AbWE1TSG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 15:18:06 -0400
In-Reply-To: <4479F487.5080507@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> On Sun, May 28 2006, Mark Lord wrote:
>>>
..
>>>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>>>  {
>>>      if (ap->flags & ATA_FLAG_SUSPENDED) {
>>> +        ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>>>          ap->flags &= ~ATA_FLAG_SUSPENDED;
>>>          ata_set_mode(ap);
>>
>> Sorry for the unresponsiveness, still away and internet connectivity
>> spotty. Just tested the above, and it works for me! I think Marks
>> analisys wrt DRQ is completely correct and this validates it.
> 
> Does your box work without ATA_DRQ?

Without ATA_DRQ, we're back to the original Linus one-liner,
which Jens said did NOT work for him on Saturday.

Cheers
