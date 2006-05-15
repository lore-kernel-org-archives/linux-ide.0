From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
 interfaces
Date: Mon, 15 May 2006 20:05:54 +0400
Message-ID: <4468A6E2.5060305@ru.mvista.com>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>	 <1131818615.18258.6.camel@localhost.localdomain>	 <446890F0.3020408@ru.mvista.com> <1147706716.26686.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:5357 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751603AbWEOQHD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 12:07:03 -0400
In-Reply-To: <1147706716.26686.64.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> On Llu, 2006-05-15 at 18:32 +0400, Sergei Shtylyov wrote:

>>    Heh, this driver also tries to cache the single PCI register per-channel 
>>like hpt366.c... This buglet concerns using fast PIO timings and is probably 
>>harmless though but needs to be fixed -- I'll send a patch soon...
>>    I wonder what is otherwise wrong with using 2 channels concurrently?

> I've not got any dual channel devices to test, and in fact I couldn't
> find anyone with dual channel stuff at all.

    Hm, I thought they're all dual channel, at least from W83C553F docs. We 
have this chip on several embedded boards -- I'll try to gain access to one of 
them when I get to this driver...

> The caching is one bug, the
> fact the reset hits both channels is the other I know about.

    Ah, that register 0x7E reset? Strangely, W83C55[34]F datasheets don't even 
mention it. :-/

> Otherwise the libata driver is fairly similar

    Found it, looking...

> although the timing is
> pre-computed from the documentation for the DMA modes.

    As these chips lack 66 MHz PCI support, this should be quite enough, I 
think... :-)

MBR, Sergei
