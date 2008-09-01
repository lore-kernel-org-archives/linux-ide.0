From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: Implement disk shock protection support
Date: Mon, 01 Sep 2008 18:43:36 +0200
Message-ID: <48BC1BB8.2030007@gmail.com>
References: <87wshzplvk.fsf@denkblock.local>	<20080829211345.4355.89284.stgit@denkblock.local>	<48B913E6.1000104@gmail.com> <87k5dym5t9.fsf@denkblock.local>	<48BA638B.2030001@gmail.com> <87ej45mlp3.fsf@denkblock.local>	<48BA969C.4060207@gmail.com> <87abetmaap.fsf@denkblock.local>	<48BBA8D1.8020604@gmail.com> <87myirly1p.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:64228 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYIAQos (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Sep 2008 12:44:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1136185tic.23
        for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 09:44:46 -0700 (PDT)
In-Reply-To: <87myirly1p.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
>> I'm not particularly against pm_notifiers.  I just can't see what
>> advantages it have given the added complexity.  The only race window
>> it closes is the one between suspend start and userland task freeze,
>> which is a relatively short one and there are other much larger gaping
>> holes there, so I don't really see much benefit in the particular
>> pm_notifiers usage.  Maybe we need to keep the task running till the
>> power is pulled?  If we can do that in sane manner which is no easy
>> feat I agree, that can also solve the problem with hibernation.
> 
> I doubt that is feasible without substantial work especially as long as
> part of it all is implemented in user space.

For STR, I think it shouldn't be too difficult.  For STD, it's more
difficult but it would be easy if we used a kexec kernel for
hiberation but that's whole different story.

> With regard to the pm_notifiers, I'll try to figure out exactly what
> the problem was without them (I thought it was related to timers not
> firing anymore after process freezing, but Pavel doubts that and I'm
> not too sure anymore).

Hmm... I don't think pm notifiers would be necessary to prevent things
like that.  Anyways, please investigate and let us know.

>> Really, it doesn't matter at all.  That's just an over optimization.
>> The whole EH machinery pretty much expects spurious EH events and
>> schedules and deals with them quite well.  No need to add extra
>> protection.
> 
> ... because of its complexity it is hard for me to estimate timing
> impacts and constraints. The questions I'm concerned about are: What is
> the average and worst case time it takes to get the heads parked and
> what can I do if not to improve either of them, then at least not to make
> things worse. In particular, I don't really have a clue about how much
> time it takes to go through EH if no action is requested in comparison
> to, say, the average read / write command. Obviously, I don't want to
> schedule EH unnecessarily if that would mean that I won't be able to
> issue another head unload for considerably longer than during normal I/O
> or, indeed, on an idle system. Arguably, I don't even want to do
> anything that causes more logging than absolutely necessary because this
> will ultimately result in the disk spinning up from standby. But then I
> believe that I only came across this logging issue when I was still
> playing around with eh_revalidate and the like. So, can you set my mind
> at rest that timing is no issue with spurious EH sequences? Now that I
> come to think of it, I suppose it would harm performance anyway, so
> everybody would care about such a delay, right?

I can't tell you the exact delays, but sans times for actual actions,
there is no real delay.  It just involves scheduling a few times and
jumps through various functions in EH.  I don't think that would be
anything measureable.

Also, generating duplicate events.  Events would be duplicate only
when those events occur during EH is in progress, right?  In that
case, as EH finishes it would see that there's another EH action
requested and re-enter EH.  The second invocation of EH would go
through the diagnostic steps (doesn't involve issuing any command,
just checks data structures) and find out that there's nothing to do
and just exit.  For those bogus runs, EH won't print out anything
either.  So, really, nothing to worry about there.

If that's not enough assurance, even ATAPI CHECK SENSE is done via EH.
That is, many ATAPI commands invoke EH after completion but nobody
really notices or pays attention to it.

>> Heh... then again, it's not much different from your original code.  I
>> won't object strongly to the original code but I still prefer just
>> setting deadline and kicking EH from the userside instead of directly
>> manipulating the timer.  That way, implementation is more separate
>> from the interface and to me it seems easier to follow the code.
> 
> That's fine with me. All I want is that my code doesn't end up leaving
> the system in an unresponsive state (to a head unload request, that is)
> more often than before by spuriously scheduling EH. If that is not a
> problem, I'm content.

No, it won't leave the system unresponsive to unload request or
anything else.  If it does, it's a bug in EH core and should be fixed.
So, there should be no problem in making the implementation simple.

Thanks.

-- 
tejun
