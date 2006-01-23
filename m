From: Mark Lord <liml@rtr.ca>
Subject: Re: Libata Driver
Date: Mon, 23 Jan 2006 15:53:14 -0500
Message-ID: <43D5423A.7010905@rtr.ca>
References: <867ae21dff5bea23500e8489161916d3@Netcell.com> <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com> <DF42C291-57BB-4645-99F5-ED86D7CF22FC@netcell.com> <43CFFBED.8030202@rtr.ca> <D72EBE1F-1A6E-48FE-B519-D672CFF7E2B3@netcell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3794 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932475AbWAWUxi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2006 15:53:38 -0500
In-Reply-To: <D72EBE1F-1A6E-48FE-B519-D672CFF7E2B3@netcell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Gillette <Matt.Gillette@netcell.com>
Cc: linux-ide@vger.kernel.org

Matt Gillette wrote:
> I'm still trying to understand what needs to be done, so please correct 
> me if I'm wrong.
> 
> The netcell card currently uses the ide-generic driver in the old ide 
> layer. This is incompatible with libata so a new driver is needed.
> 
> I don't see a driver in the scsi (libata) drivers that is as generic as 
> the ide driver was (all we needed to add was our vendor and device id).

Yeah, no generic driver (yet).  Probably because each chipset still seems
to invent it's own mechanism for programming the DMA/PIO timings (something
that ide-generic somewhat-unsafely relied on the BIOS to do).  So you need
a really simple driver, with code to set up the timings if needed,
and just a bunch of binding of standard libata functions to do everything else.
It all ends up being quite simple once figured out.

> Because there is no generic driver, I need to write a driver compatible 
> with libata. This new driver should be fairly simple since our card only 
> needs the standard IDE taskfile registers set up. Does anyone have 
> suggestions on which drivers that I should look at to help write our 
> driver (a driver close to being generic)?

I'll leave it for somebody else to recommend something.
Alan Cox is currently reimplementing libata support for most of the
existing IDE driver chipsets -- he could probably provide a nice
simple almost generic driver for you to hack.

Alan?

> If I do write a libata driver, will there be conflicts with the generic 
> ide driver? Do I need to remove our vendor id's from this?

Yes, and yes.

Cheers
