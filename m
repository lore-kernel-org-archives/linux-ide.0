From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Thu, 28 Jun 2007 21:15:26 -0400
Message-ID: <46845D2E.4050102@rtr.ca>
References: <4683DCD3.1040303@gmail.com> <4683F4CD.2090106@rtr.ca> <4683F51C.3060404@garzik.org> <4683F5B1.7090507@gmail.com> <4683F626.9040401@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4766 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764390AbXF2BP1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 21:15:27 -0400
In-Reply-To: <4683F626.9040401@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Mark Lord wrote:
>>>> Tejun Heo wrote:
>>>>> sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
>>>>> reduce confusion.
>>>> Why not whine only when an affected device is actually present?
>>> That's sorta that I think...
>>
>> That was me being lazy.  I'll just ban > LBA28 disks on the controller.
> 
> Sounds better to me...  I certainly prefer that to clipping-to-1xxGB, 
> especially given the shaky state of the overall driver.

I wonder if PIO works for LBA48 on that chipset (very, *very* likely).

Maybe just fall back to PIO for an LBA48 drive.
Or even better, fall back to PIO only for sectors beyond 128GB.

???

Or wait for a more stable driver..
