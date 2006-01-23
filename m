From: Matt Gillette <Matt.Gillette@netcell.com>
Subject: Libata Driver
Date: Mon, 23 Jan 2006 12:40:52 -0800
Message-ID: <D72EBE1F-1A6E-48FE-B519-D672CFF7E2B3@netcell.com>
References: <867ae21dff5bea23500e8489161916d3@Netcell.com> <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com> <DF42C291-57BB-4645-99F5-ED86D7CF22FC@netcell.com> <43CFFBED.8030202@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-60-240-146.cust.telepacific.net ([64.60.240.146]:46043 "EHLO
	Netcell.com") by vger.kernel.org with ESMTP id S932383AbWAWUkX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jan 2006 15:40:23 -0500
In-Reply-To: <43CFFBED.8030202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

I'm still trying to understand what needs to be done, so please  
correct me if I'm wrong.

The netcell card currently uses the ide-generic driver in the old ide  
layer. This is incompatible with libata so a new driver is needed.

I don't see a driver in the scsi (libata) drivers that is as generic  
as the ide driver was (all we needed to add was our vendor and device  
id). Because there is no generic driver, I need to write a driver  
compatible with libata. This new driver should be fairly simple since  
our card only needs the standard IDE taskfile registers set up. Does  
anyone have suggestions on which drivers that I should look at to  
help write our driver (a driver close to being generic)?

If I do write a libata driver, will there be conflicts with the  
generic ide driver? Do I need to remove our vendor id's from this?

Thank you,
Matt


On Jan 19, 2006, at 12:51 PM, Mark Lord wrote:

> Matt Gillette wrote:
> >
>> One question that I have is what's the difference between the  
>> older  ide drivers and libata. What is the future of the ide  
>> driver - is it  going to be phased out and replaced by libata, or  
>> will they both  remain in the kernel and developed in parallel.
>
> The older IDE layer, which I once wrote and maintained, is on the  
> way out.
> The original code there wasn't designed for a hotplug world, and  
> has lots
> of issues nowadays from years of neglect, bloat, and a changed world.
>
> Anything new should really target libata, or have its own native  
> block driver.
>
> Cheers
>
> Mark

