From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Fri, 14 May 2010 01:22:26 +0400
Message-ID: <4BEC6D92.8080309@ru.mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>	<4BE6910D.9070504@ru.mvista.com>	<4BE69C81.2070703@gmail.com>	<4BE6BA74.10200@mvista.com>	<4BE74EEE.5060307@gmail.com>	<4BE7D714.9010006@ru.mvista.com>	<20100511105531.39670354@lxorguk.ukuu.org.uk>	<4BEB0FFD.1090701@ru.mvista.com> <20100513001315.149bbb66@lxorguk.ukuu.org.uk> <4BEB7B79.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39959 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab0EMVXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 May 2010 17:23:14 -0400
Received: by wwi18 with SMTP id 18so108340wwi.19
        for <linux-ide@vger.kernel.org>; Thu, 13 May 2010 14:23:12 -0700 (PDT)
In-Reply-To: <4BEB7B79.9050808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Graeme Russ wrote:

>>>> I don't think ide-platform matters in this case.

>>>    You've just supported a patch restoring feature parity between 
>>> pata_platform and ide-platfrom WRT IRQ flags. ;-)

>> Because it was trivial to do.

>>>    Yes, but this needs to be *done* too, preferrably by the author of 
>>> the original patch and simultaneously with it. We can't accept a single 
>>> patch that only touches pata_platform.

> I'm happy to expand the patch,  but why would we implement such a thing in a
> legacy driver.

    Because the drivers are intended to be interchangeable.

> Odds are that nobody would ever use it.

    As I said a choice of libata over IDE might not be so obvious 
advantage as some people tend to think. The ide-platfrom is still used 
in embedded, given that it's actually quite young driver.

> If I had developed
> my code prior to pata_platform and used the old IDE driver instead I would
> of

    Can't parse "would of" -- did you mean "would have"? :-)

> patched it then (and it may have been included in pata_platform).

    You'll be surprised to know that pata_platfrom actually *predates* 
ide-platfrom. ;-)

> If anyone requires this hook from today on, odds on it is for a new system and
> the old IDE driver will not even be considered for the task.

    Odds can be odd enough -- try measuring/comparing the performance 
you'll get with libata and IDE drivers for example.

> Besides, by
> only implementing these features in the latest (supported) drivers, it will
> encourage people to move away from the legacy drivers which is a Good Thing(tm)

    As Alan said, you should at least fail gracefully in the 
ide-platfrom, and not leave it ignorant of your change.

>> Sure - or support it in both. I've no problem with both supporting that
>> function, just with legacy code blocking progress.

>>>    Well, with 8250 we still don't allow for overriding things at the 
>>> board level, via the platform data callbacks.

>> Oh yes we do. Platform specific drivers can directly override the access
>> operators and they do some truely horrible platform specific stuff in the
>> overridden operators.

    That's something new to me. Looking at <linux/serial_8250.h>, you're 
right. But this got added only in January, due to Cavium.

>> And the great thing - nobody else has to know what the board vendors have
>> been on..

    Well, mainly SoC vendors...

> Exactly - This is good driver design. Implement the fundamentals for the
> majority of use-cases and provide overrides to allow individual
> implementations which can do anything weird and wonderful without polluting
> the code space of everyone else.

    You should have looked at 8250.c first -- there's still lot of 
pollution left because old accessors were all left in place, including 
the unfortunate Alchemy UART's ones. :-)

> Regards,

> Graeme

WBR, Sergei
