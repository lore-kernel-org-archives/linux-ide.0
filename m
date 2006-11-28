From: Mark Lord <liml@rtr.ca>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 12:37:28 -0500
Message-ID: <456C73D8.3050803@rtr.ca>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39431 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S935955AbWK1Rha (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 12:37:30 -0500
In-Reply-To: <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Linus Torvalds wrote:
> [ You may or may not have gotten my previous email. The kernel stayed 
>   working, but due to the IO errors the filesystem got re-mounted 
>   read-only, and I'm not sure that the email I sent out in that state 
>   actually ever made it out. I suspect it didn't. ]
> 
> Jeff,
>  I just had a scary thing on my nice new Intel i965 box (all Intel 
> chipsets apart from some strange Marvell IDE interface that I'm not using 
> and that no driver even detected, and a TI firewire thing that I'm 
> similarly not using).
> 
> The machine basically froze for about a minute or so (well, things worked 
> surprisingly well, considering that apparently no disk IO happened - I 
> initially thought it was just firefox that had frozen up, since my mail 
> session seemed to be fine), and after it came back the filesystem was 
> mounted read-only and nothing really worked any more..
> 
> I have no idea what status 0xD0 means: it looks like ATA_BUSY + ATA_DRDY + 
> "bit#4", but what is bit#4?

Bit #4, when actually implemented, is a rotational seek indicator,
which can be used for timing purposes.

But when BUSY (bit #7) is set, the rest are generally nonsense.
 
> And clearly, the soft-reset isn't doing squat.

Tejun ?

