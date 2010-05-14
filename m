From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Fri, 14 May 2010 14:37:00 +1000
Message-ID: <AANLkTillRYVG8VBiJPHDHSnl86jj4akfm-gUdZaQKTPP@mail.gmail.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>
	 <4BE69C81.2070703@gmail.com> <4BE6BA74.10200@mvista.com>
	 <4BE74EEE.5060307@gmail.com> <4BE7D714.9010006@ru.mvista.com>
	 <20100511105531.39670354@lxorguk.ukuu.org.uk>
	 <4BEB0FFD.1090701@ru.mvista.com>
	 <20100513001315.149bbb66@lxorguk.ukuu.org.uk>
	 <4BEB7B79.9050808@gmail.com> <4BEC6D92.8080309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65355 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab0ENEhD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 00:37:03 -0400
Received: by vws16 with SMTP id 16so628203vws.19
        for <linux-ide@vger.kernel.org>; Thu, 13 May 2010 21:37:01 -0700 (PDT)
In-Reply-To: <4BEC6D92.8080309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Fri, May 14, 2010 at 7:22 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Graeme Russ wrote:
>
>>>>> I don't think ide-platform matters in this case.
>
>>>>   You've just supported a patch restoring feature parity between
>>>> pata_platform and ide-platfrom WRT IRQ flags. ;-)
>
>>> Because it was trivial to do.
>
>>>>   Yes, but this needs to be *done* too, preferrably by the author of the
>>>> original patch and simultaneously with it. We can't accept a single patch
>>>> that only touches pata_platform.
>
>> I'm happy to expand the patch,  but why would we implement such a thing in
>> a
>> legacy driver.
>
>   Because the drivers are intended to be interchangeable.

I thought the whole purpose of marking a driver 'legacy' was to no longer
enhance its features and encourage people to migrate away from it so that
one day it can be removed entirely.

I also think I have a massive understanding gap with the idea of
interchangeability between IDE and ATA (please excuse me for that) - I
thought that the pata_platform driver is designed to be 'hard-wired' for
embedded systems (i.e. the board developer explicitly sets up address
ranges etc used for initialization in the board init function). I didn't
think interchangeability with another driver platform was a goal.

>
>> Odds are that nobody would ever use it.
>
>   As I said a choice of libata over IDE might not be so obvious advantage as
> some people tend to think. The ide-platfrom is still used in embedded, given
> that it's actually quite young driver.
>
>> If I had developed
>> my code prior to pata_platform and used the old IDE driver instead I would
>> of
>
>   Can't parse "would of" -- did you mean "would have"? :-)

Yes, (Aussie English) ;-)

>
>> patched it then (and it may have been included in pata_platform).
>
>   You'll be surprised to know that pata_platfrom actually *predates*
> ide-platfrom. ;-)
>

Yes, I am

>> If anyone requires this hook from today on, odds on it is for a new system
>> and
>> the old IDE driver will not even be considered for the task.
>
>   Odds can be odd enough -- try measuring/comparing the performance you'll
> get with libata and IDE drivers for example.
>
>> Besides, by
>> only implementing these features in the latest (supported) drivers, it
>> will
>> encourage people to move away from the legacy drivers which is a Good
>> Thing(tm)
>
>   As Alan said, you should at least fail gracefully in the ide-platfrom, and
> not leave it ignorant of your change.
>
>>> Sure - or support it in both. I've no problem with both supporting that
>>> function, just with legacy code blocking progress.
>
>>>>   Well, with 8250 we still don't allow for overriding things at the
>>>> board level, via the platform data callbacks.
>
>>> Oh yes we do. Platform specific drivers can directly override the access
>>> operators and they do some truely horrible platform specific stuff in the
>>> overridden operators.
>
>   That's something new to me. Looking at <linux/serial_8250.h>, you're
> right. But this got added only in January, due to Cavium.
>
>>> And the great thing - nobody else has to know what the board vendors have
>>> been on..
>
>   Well, mainly SoC vendors...
>
>> Exactly - This is good driver design. Implement the fundamentals for the
>> majority of use-cases and provide overrides to allow individual
>> implementations which can do anything weird and wonderful without
>> polluting
>> the code space of everyone else.
>
>   You should have looked at 8250.c first -- there's still lot of pollution
> left because old accessors were all left in place, including the unfortunate
> Alchemy UART's ones. :-)

I've had a quick look at 8250 and, yes, the serial_in / serial_out overrides
are exactly what I have proposed for PATA Platform. I do not see how this
could be considered bad driver design IMHO. As I said before, provide
baseline functionality for the majority (80%), designed-in extensibility
for the minority (15%) and force the last 5% into writing their own driver
as a lesson to them for poor hardware design decisions ;)


Regards,

Graeme
