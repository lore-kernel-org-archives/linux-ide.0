From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
   libata issue
Date: Sat, 27 May 2006 03:06:35 -0400
Message-ID: <4477FA7B.30602@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <20060527062950.GC23315@suse.de> <4477F363.7080105@garzik.org> <20060527070108.GA24988@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45033 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751434AbWE0HGl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 03:06:41 -0400
In-Reply-To: <20060527070108.GA24988@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Sat, May 27 2006, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> There was no real discussion on this issue yet. I think we all agree
>>> that the functionality of the patch (waiting for BSY clear on resume) is
>>> the right thing to do. This posted patch moved SCSI stuff into ata_piix,
>>> which isn't really very nice. Jeff wants to do it from the pci resume,
>>> which just seems wrong to me since it's a device (disk) condition not a
>> Wrong.  It is a _bus_ condition, not a device condition.
> 
> See my other mail.
> 
>>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>>> index fa476e7..ae7fac1 100644
>>> --- a/drivers/scsi/libata-core.c
>>> +++ b/drivers/scsi/libata-core.c
>>> @@ -4298,6 +4298,8 @@ int ata_device_resume(struct ata_port *a
>>> {
>>> 	if (ap->flags & ATA_FLAG_SUSPENDED) {
>>> 		ap->flags &= ~ATA_FLAG_SUSPENDED;
>>> +		if (ap->ops->port_resume)
>>> +			ap->ops->port_resume(ap);
>> This is even MORE broken!
>>
>> A port can have multiple devices hanging off of it.  With this 
>> silliness, you will be calling ->port_resume() for both master and slave 
>> devices...  or all devices attached to a port multiplier.
> 
> Worst case is the N-1 invocations basically being noops. Since
> 2.6.17-rc5 iirc doesn't even support port multipliers, I'd say this is a
> pretty weak case.

If N-1 invocations are no-ops, that is a clear sign you got the layering 
very wrong.  Backwards, in fact.

And if you had to do something other than test for BSY -- say for 
example powering the bus on -- then you would be doing N-1 needless 
resets and power-ons.


> What I care about is getting libata suspend/resume working, and so do a
> lot of people. So far you've done nothing but whine at the posted
> patches from the beginning and absolutely zero work on helping us get
> there in _your_ driver/sub system. If you think your posted patch is the
> best solution, by all means just put in there. Just make sure that we at
> least get _something_ in there that does for 2.6.17.

After describing what to do innumerable times to people actively working 
in the area, I did indeed write the simple and obvious patch.  As soon 
as positive results appear, its going in.  The relevant subject is 
"[PATCH] libata resume improvements"

	Jeff


