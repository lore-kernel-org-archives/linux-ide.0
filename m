From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new cleanup
Date: Sat, 02 Dec 2006 18:40:07 +0300
Message-ID: <45719E57.7040006@ru.mvista.com>
References: <200611302151.33319.sshtylyov@ru.mvista.com> <20061201001321.1b946f0e@localhost.localdomain> <457021C2.3040703@ru.mvista.com> <45702881.6010107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54004 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1759383AbWLBPij
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 10:38:39 -0500
In-Reply-To: <45702881.6010107@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>> I believe this is completely the wrong thing to do. Adding a ton of
>>> changes to the existing (and stable) life expired drivers/ide driver
>>> rather than keeping new and risky stuff in the new libata code is bad.

>>    The new and risky stuff is long agon in there.

    So, they're neither that new nor risky...
    The question is why I have to push the drivers/ide/pcu/pdc202xx_new 
changes which are now 1.5 years old already into the -mm tree again.

>>> The existing code *works*, its been rock solid since the reset drain fix

>>    Don't make me laugh. pdc202xx_new certainly doesn't deserve these 
>> compliments.  It has known PLL problems even on x86 if you have more 
>> than 2 contorollers

>    Oh, and I forgot to add that Ultra133 chips don't get the proper 
> timings even on x86 -- they get overclocked b/c BIOS programs 133 MHz 
> DPLL clock and the chip auto-loads the 100 MHz timings (overriding the 
> driver's override).

   I must admit that I've gona a bit too far here, having forgotten how 
Promise BIOSes setup the chips. The overclocking only happens if you have at 
least one UltraDMA/133 capable drive plugged in -- in this cases, PIO modes 
will be overclocked for this drives and any modes for the non-UltraDMA/133 
drives if you also have those plugged in...

>>> I don't see the point in risking destabilising a good solid driver. I can

    Risk of destablilizing the driver in the experimental tree? Isn't that why 
it came into being at all?
    Also, can you point me out the parts of the cleaup patch which you 
consider risky?

>>> just about see justification for !X86 implementation of the PLL handling
>>> but that is about it.

>>    All in a good time.

>    The main patches are gonna appear in a few days (at last).

>>> Alan

WBR, Sergei
