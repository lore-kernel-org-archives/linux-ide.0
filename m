From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new cleanup
Date: Fri, 01 Dec 2006 16:05:05 +0300
Message-ID: <45702881.6010107@ru.mvista.com>
References: <200611302151.33319.sshtylyov@ru.mvista.com> <20061201001321.1b946f0e@localhost.localdomain> <457021C2.3040703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3550 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S936483AbWLAND3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2006 08:03:29 -0500
In-Reply-To: <457021C2.3040703@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>> I believe this is completely the wrong thing to do. Adding a ton of
>> changes to the existing (and stable) life expired drivers/ide driver
>> rather than keeping new and risky stuff in the new libata code is bad.

>    The new and risky stuff is long agon in there.

>> The existing code *works*, its been rock solid since the reset drain fix

>    Don't make me laugh. pdc202xx_new certainly doesn't deserve these 
> compliments.  It has known PLL problems even on x86 if you have more 
> than 2 contorollers

    Oh, and I forgot to add that Ultra133 chips don't get the proper timings 
even on x86 -- they get overclocked b/c BIOS programs 133 MHz DPLL clock and 
the chip auto-loads the 100 MHz timings (overriding the driver's override).

>> I don't see the point in risking destabilising a good solid driver. I can
>> just about see justification for !X86 implementation of the PLL handling
>> but that is about it.

>    All in a good time.

    The main patches are gonna appear in a few days (at last).

>> Alan

WBR, Sergei
