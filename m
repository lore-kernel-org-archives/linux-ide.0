From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 19:03:12 -0400
Message-ID: <4478DAB0.5090200@garzik.org>
References: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org> <20060527223523.GD364@suse.de> <4478D82E.4030704@garzik.org> <4478D90D.4080901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2454 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965010AbWE0XDS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 19:03:18 -0400
In-Reply-To: <4478D90D.4080901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> index b80d2e7..80fb1f9 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -742,7 +742,7 @@ static inline u8 ata_busy_wait(struct at
>>>  
>>>  static inline u8 ata_wait_idle(struct ata_port *ap)
>>>  {
>>> -    u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
>>> +    u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>>
>>
>> Ouch.  That will slow down boot for a lot of otherwise-untouched users, 
> 
> Really?  If a drive claims to be BUSY, then it shouldn't accept a new 
> command.
> 
> But yes, this may be a bit too mainline to risk at this point,
> given controller quirks and the like that may be spoofing the status.

All the other patches only affected ata_piix users using suspend, which 
is a very small subset.  That's why we could be cavalier about the 
delay.  Plus, I would expect resume to require a higher-than-normal delay.

In contrast, the above patch affects most users, on all platforms. 
Cases which would previously error out in 10ms now take much longer to 
error out.  Slows boot, slows multi-path, and other fun stuff.

	Jeff



