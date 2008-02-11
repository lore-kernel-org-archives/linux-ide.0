From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Mon, 11 Feb 2008 08:57:01 +0100
Message-ID: <871w7k9b8y.fsf@denkblock.local>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:50198 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbYBKH5O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 02:57:14 -0500
In-Reply-To: <47AFD7C1.7070204@gmail.com> (Tejun Heo's message of "Mon, 11 Feb
	2008 14:06:09 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Elias Oltmanns wrote:
>> Hi Tejun,
>> 
>> due to your commit 31cc23b34913bc173680bdc87af79e551bf8cc0d libata now
>> sets max_host_blocked and max_device_blocked to 1 for all devices it
>> manages. Under certain conditions this may lead to system lockups due to
>> infinite recursion as I have explained to James on the scsi list (kept
>> you cc-ed). James told me that it was the business of libata to make
>> sure that such a recursion cannot happen.
>> 
>> In my discussion with James I imprudently claimed that this was easy to
>> fix in libata. However, after giving the matter some thought, I'm not at
>> all sure as to what exactly should be done about it. The easy bit is
>> that max_host_blocked and max_device_blocked should be left alone as
>> long as the low level driver does not provide the ->qc_defer() callback.
>> But even if the driver has defined this callback, ata_std_qc_defer() for
>> one will not prevent this recursion on a uniprocessor, whereas things
>> might work out well on an SMP system due to the lock fiddling in the
>> scsi midlayer.
>> 
>> As a conclusion, the current implementation makes it imperative to leave
>> max_host_blocked and max_device_blocked alone on a uniprocessor system.
>> For SMP systems the current implementation might just be fine but even
>> there it might just as well be a good idea to make the adjustment
>> depending on ->qc_defer != NULL.
>
> Hmmm... The reason why max_host_blocked and max_device_blocked are set
> to 1 is to let libata re-consider status after each command completion
> as blocked status can be rather complex w/ PMP.  I haven't really
> followed the code yet but you're saying that blocked count of 2 should
> be used for that behavior, right?

Not quite. On an SMP system the current implementation will probably do
exactly what you had in mind. In particular, setting max_device_blocked
and max_host_blocked to 1 seems to be the right thing to do in this
case.

>
> Another strange thing is that there hasn't been any such lock up /
> infinite recursion report till now although ->qc_defer mechanism bas
> been used widely for some time now.  Can you reproduce the problem w/o
> the disk shock protection?

No, unfortunately, I'm unable to reproduce this without the patch on my
machine. This is for purely technical reasons though because I'm using
ata_piix. Running a vanilla kernel, I'd expect everything to work just
fine except for one case: A non-SMP system using a driver that provides
the ->qc_defer() callback. Currently, the ->qc_defer() callback is the
only thing that can possibly send a non zero return value to the scsi
midlayer. Once it does, however, the driver will only get a chance to
complete some qcs before ->qc_defer() is called again provided that
multithreading is supported.

So, what I'm saying is this: If the low level driver doesn't provide a
->qc_defer() callback, there is no (obvious) reason why
max_device_blocked and max_host_blocked should be set to 1 since libata
won't gain anything by it. However, it is not a bug either, even though
James considers it suboptimal and I will have to think about a solution
for my patch. On the other hand, once a driver defines the ->qc_defer()
callback, we really have a bug because things will go wrong once
->qc_defer() returns non zero on a uniprocessor. So, in this case
max_device_blocked and max_host_blocked should be set to 1 on an SMP
system and *have to* be bigger than 1 otherwise.

Regards,

Elias
