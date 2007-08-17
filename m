From: Bryan Wu <bryan.wu@analog.com>
Subject: Re: [PATCH take #5] [libata] libata driver for bf548 on chip ATAPI
	controller.
Date: Fri, 17 Aug 2007 10:18:26 +0800
Message-ID: <1187317106.12314.6.camel@roc-desktop>
References: <1187169256.31383.3.camel@sevens.analog.com>
	 <46C3F6FB.2070909@garzik.org>
	 <8bd0f97a0708160927s625fd5ax84cd6d12a693d9ad@mail.gmail.com>
	 <46C49A0D.5080002@garzik.org>
	 <8bd0f97a0708161146l70eeea69jd5fdedbaa8486590@mail.gmail.com>
	 <46C49DD6.9050508@garzik.org>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:12190 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764877AbXHQCT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 22:19:56 -0400
In-Reply-To: <46C49DD6.9050508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Sonic Zhang <sonic.adi@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Bryan Wu <bryan.wu@analog.com>

On Thu, 2007-08-16 at 14:56 -0400, Jeff Garzik wrote:
> Mike Frysinger wrote:
> > On 8/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> >> Mike Frysinger wrote:
> >>> On 8/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> >>>> Sonic Zhang wrote:
> >>>>> +static void bfin_set_piomode(struct ata_port *ap, struct ata_device *adev)
> >>>>> +{
> >>>>> +     int mode = adev->pio_mode - XFER_PIO_0;
> >>>>> +     unsigned long base = (unsigned long)ap->ioaddr.ctl_addr;
> >>>> (added Bryan Wu to CC)
> >>>>
> >>>> Someone needs to need fix the bfin architecture:  the addresses on the
> >>>> bfin_read/bfin_write functions should be 'void __iomem *' not unsigned long.
> >>> there are no address pointers anymore, so there is nothing to cast ...
> >>> the bfin_read/bfin_write macros are done in sexy asm:
> >>> #define bfin_write8(addr,val) __asm__ __volatile__("b[%0] = %1;" ::
> >>> "a"(addr), "d"(val))
> >>> or i'm misunderstanding what you mean ...
> >>>
> >>> where do you see (unsigned long) ?
> >> Look up (into the message you quoted).
> > 
> > yes, you quoted the driver, not the Blackfin core parts
> > 
> >> Regardless of the implementation, the C type system should be employed
> >> to ensure that 'addr' is known to the compiler as 'void __iomem *'
> >> rather than unsigned long.
> > 
> > i agree the specific pata driver should be declared the way you
> > described, however i dont see how that has bearing on the
> > bfin_read/bfin_write macros as you seemed to indicate
> 
> Macros completely ignore the C type system.  Look at other architectures 
> if you cannot figure out how to implement a static inline with stronger 
> typing.
> 
> 	Jeff
> 

Yes, Jeff is right. Type checking in C is very useful.

So,
a) our register access function: bfin_read8/16/32 and bfin_write8/16/32
macros should be change to inline functions. 
b) the "addr" should be defined as "void __iomem *"
c) in these functions it may use the sexy asm stuff

How do you think of this, Mike? And am I right, Jeff?

Thanks
- Bryan Wu
> 
