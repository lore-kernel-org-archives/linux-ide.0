From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 16:03:37 -0500
Message-ID: <456CA429.9020507@garzik.org>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2456 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1755510AbWK1VDj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 16:03:39 -0500
In-Reply-To: <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

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

Does jgarzik/libata-dev.git#upstream (don't pull, just test) work for you?

Or -mm, which includes #upstream?

I'm pretty sure this is already fixed, by the polling IDENTIFY for 
ata_piix patchset.

	Jeff


