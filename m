From: Mark Lord <liml@rtr.ca>
Subject: Re: ATA passthrough questions
Date: Thu, 19 Jan 2006 15:51:57 -0500
Message-ID: <43CFFBED.8030202@rtr.ca>
References: <867ae21dff5bea23500e8489161916d3@Netcell.com> <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com> <DF42C291-57BB-4645-99F5-ED86D7CF22FC@netcell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:37340 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161422AbWASUwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2006 15:52:13 -0500
In-Reply-To: <DF42C291-57BB-4645-99F5-ED86D7CF22FC@netcell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Gillette <Matt.Gillette@netcell.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Matt Gillette wrote:
 >
> One question that I have is what's the difference between the older  ide 
> drivers and libata. What is the future of the ide driver - is it  going 
> to be phased out and replaced by libata, or will they both  remain in 
> the kernel and developed in parallel.

The older IDE layer, which I once wrote and maintained, is on the way out.
The original code there wasn't designed for a hotplug world, and has lots
of issues nowadays from years of neglect, bloat, and a changed world.

Anything new should really target libata, or have its own native block driver.

Cheers

Mark
