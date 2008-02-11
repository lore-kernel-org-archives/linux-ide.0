From: Tejun Heo <htejun@gmail.com>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Mon, 11 Feb 2008 17:43:13 +0900
Message-ID: <47B00AA1.3010104@gmail.com>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com> <871w7k9b8y.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:31019 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYBKInT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 03:43:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2036778wah.23
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 00:43:18 -0800 (PST)
In-Reply-To: <871w7k9b8y.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hello,

Elias Oltmanns wrote:
>> Hmmm... The reason why max_host_blocked and max_device_blocked are set
>> to 1 is to let libata re-consider status after each command completion
>> as blocked status can be rather complex w/ PMP.  I haven't really
>> followed the code yet but you're saying that blocked count of 2 should
>> be used for that behavior, right?
> 
> Not quite. On an SMP system the current implementation will probably do
> exactly what you had in mind. In particular, setting max_device_blocked
> and max_host_blocked to 1 seems to be the right thing to do in this
> case.

I currently can't test the code but SMP or not doesn't make much
difference if your analysis is correct.  You're saying the the code will
infinitely recurse if qc_defer returns non-zero but on SMP the recursion
will be terminated by another CPU finishing a pending request, right?  I
don't think things will fan out that way.  The recursing thread will
have much more than enough time to overflow the stack before any IO
event comes to stop the recursion.

I don't think such infinite recursions can happen because
blk_run_queue() doesn't allow recursing more than once.

>> Another strange thing is that there hasn't been any such lock up /
>> infinite recursion report till now although ->qc_defer mechanism bas
>> been used widely for some time now.  Can you reproduce the problem w/o
>> the disk shock protection?
> 
> No, unfortunately, I'm unable to reproduce this without the patch on my
> machine. This is for purely technical reasons though because I'm using
> ata_piix. Running a vanilla kernel, I'd expect everything to work just
> fine except for one case: A non-SMP system using a driver that provides
> the ->qc_defer() callback. Currently, the ->qc_defer() callback is the
> only thing that can possibly send a non zero return value to the scsi
> midlayer. Once it does, however, the driver will only get a chance to
> complete some qcs before ->qc_defer() is called again provided that
> multithreading is supported.
> 
> So, what I'm saying is this: If the low level driver doesn't provide a
> ->qc_defer() callback, there is no (obvious) reason why
> max_device_blocked and max_host_blocked should be set to 1 since libata
> won't gain anything by it. However, it is not a bug either, even though
> James considers it suboptimal and I will have to think about a solution
> for my patch. On the other hand, once a driver defines the ->qc_defer()
> callback, we really have a bug because things will go wrong once
> ->qc_defer() returns non zero on a uniprocessor. So, in this case
> max_device_blocked and max_host_blocked should be set to 1 on an SMP
> system and *have to* be bigger than 1 otherwise.

Well, we need to support ->qc_defer on UP systems too.  I'm still very
skeptical that the scenario you described can happen.  The mechanism is
just used too widely for such problem to go unnoticed.  For example,
deferring is exercised when FLUSH is issued to a driver which have
in-flight NCQ commands.  If you have barrier enabled FS mounted on an
NCQ enabled hard drive, such events will happen regularly but we haven't
heard of any similar lock up or stack overflow till now.

Feel free to add ->qc_defer to ata_piix and let it defer commands (say
every 20th or any other criteria you seem fit for testing) but I think
the worst can happen is somewhat inefficient deferring sequence like the
following.

1. ->qc_defer returns DEVICE BUSY
2. device_blocked set to 1
3. scsi_queue_insert() ends up calling blk_run_queue()
4. blk_run_queue() recurses, device_blocked cleared and queue processing
   starts again.
5. ->qc_defer returns DEVICE BUSY again
6. device_blocked set to 1
7. scsi_queue_insert() ends up calling blk_run_queue()
8. blk_run_queue() detects it's recursing the second time and veils.

At this point, although it went through unnecessary loop through queue
processing, everything is well.

Thanks.

-- 
tejun
