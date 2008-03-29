From: Ric Wheeler <ric@emc.com>
Subject: Re: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sat, 29 Mar 2008 11:34:12 -0400
Message-ID: <47EE6174.8020206@emc.com>
References: <20080328093055.GA16736@basil.nowhere.org> <47EDECE5.50309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:35362 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYC2Pen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 11:34:43 -0400
In-Reply-To: <47EDECE5.50309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, all.
> 
> Andi Kleen wrote:
>  >
>  > I'm attaching them.  They are huge, sorry.
>  >
>  > This was over multiple attempts with different kernels. Initially
>  > it failed just on mounting, then later also developed problems
>  > on scanning. I also tried to switch the port around so you see
>  > it moving. There were two identical disk on the box, only
>  > one failed.
>  >
>  > I think it started when I hard powered off the machine at some point,
>  > the result was a large corrupted chunk in the inode table on the
>  > disk (didn't Linus run into a similar problem recently?)
> 
> Heh.. that disk is completely toasted.  Probing itself was okay.
> Errors occur when someone is trying to access the data on platter -
> reading the partition, udev trying to determine persistent names.
> Several things to note.
> 
> (While writing, the message developed into discussion material, cc'ing
>  relevant people.  The log is quite large and can be accessed from
>  http://htj.dyndns.org/export/libata-eh.log).
> 
> 1. Currently timeout for reads and writes is 30secs which is a bit too
>    long.  This long default timeout is one of the reasons why IO
>    errors take so long to get detected and acted upon.  I think it
>    should be in the range of 10-15 second.

I agree that 10-15 seconds is a more reasonable default timeout.

For the extremely unusual case where the device does respond with 
success after more than 15 seconds, what would it look like to us when 
we have timed it out?

> 
> 2. In the first error case in the log, the device goes offline after
>    timing out.  When the device keeps its link up but doesn't respond
>    at all, libata takes slightly over 1 minutes before it gives up.
>    Combined with the initial 30sec timeout, this can feel quite long.
>    This timing is determined by ata_eh_timeouts[] table in
>    drivers/ata/libata-eh.c and the current timeout table is the
>    shortest it can get while allowing the theoretical worst case with
>    a bit of margin.  There are several factors at play here.
> 
>    ATA resets are allowed to take up to 30 secs.  Don't ask me why.
>    That's the spec.  This is to allow the device to postpone replying
>    to reset while spinning up, which simply is a bad design.
> 
>    Waiting blindly for 30 + margin seconds for each try doesn't work
>    too well because during hotplug or after PHY events, reset protocol
>    could get a bit unreliable and the response from device can get
>    lost.  In addition, some devices might not respond to reset if it's
>    issued before the device indicated readiness (SRST) and some
>    controllers can only wait for the initial readiness notificaiton
>    from the drive after SRST.  The combined result is that even when
>    everything is done right there are times when the driver misses
>    reset completion.
> 
>    So, to handle the common cases better, libata EH times out resets
>    quickly.  The first two tries are 10 seconds each and most devices
>    get reset properly before it hits the end of the second reset try
>    even if it needs to spin up.  What takes the longest is the third
>    try, for which the timeout is 35secs.  This is to allow dumb
>    devices which require long silent period after reset is issued and
>    have at least one reset try with the timeout suggested by the spec.
>    I haven't actually seen such device and it could be that we could
>    be paying too much for a problem which doesn't exist.
> 
>    If we can lift the 35 sec reset try, we can give up resetting in
>    slightly over 30 seconds.  If we reduce the command timeout, the
>    whole thing from command issue to device disablement could be done
>    in around 50 seconds.

I think that this is also reasonable. We should try to respond with a 
failure in that 30 second window when we can.

> 
> 3. Another possible source of delay is command retries after failure.
>    sd currently sets retry count to five so every failed IO command is
>    retried five times.  I agree with Mark that there isn't much sense
>    in retrying a command when the drive already told us that it
>    couldn't accomplish it due to media problem.  So, retrying commands
>    failed with media error five times is probably not the best action
>    to take.

I definitely agree with you and Mark on this - no reason to retry media 
errors (or some other less popular errors).  We run with the retry logic 
neutered and have not seen an issue with a very large population of 
S-ATA drives in the field...

> 
> What do you guys think?
> 
> Thanks.
> 

One thought that is related to this is that we could really, really use 
a target mode S-ATA (or ATA) device. I am pretty sure that some of the 
Marvell parts support target mode. Their original (non-libata) driver 
had target mode support coded in as well if I remember correctly.

With that base, we could program the target driver to inject errors and 
give us a much more complete testing of the error injection code. Maybe 
even really test the debated error during CACHE_FLUSH sequence ;-)

It is really, really hard to find flaky drives that are not totally dead 
which means we are left using common sense and intuition around this 
kind of thing...

ric
