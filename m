From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH take #5] [libata] libata driver for bf548 on chip ATAPI controller.
Date: Thu, 16 Aug 2007 14:46:26 -0400
Message-ID: <8bd0f97a0708161146l70eeea69jd5fdedbaa8486590@mail.gmail.com>
References: <1187169256.31383.3.camel@sevens.analog.com>
	 <46C3F6FB.2070909@garzik.org>
	 <8bd0f97a0708160927s625fd5ax84cd6d12a693d9ad@mail.gmail.com>
	 <46C49A0D.5080002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:31118 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbXHPSq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 14:46:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so270222rvb
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 11:46:27 -0700 (PDT)
In-Reply-To: <46C49A0D.5080002@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sonic Zhang <sonic.adi@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Bryan Wu <bryan.wu@analog.com>

On 8/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> Mike Frysinger wrote:
> > On 8/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> >> Sonic Zhang wrote:
> >>> +static void bfin_set_piomode(struct ata_port *ap, struct ata_device *adev)
> >>> +{
> >>> +     int mode = adev->pio_mode - XFER_PIO_0;
> >>> +     unsigned long base = (unsigned long)ap->ioaddr.ctl_addr;
> >>
> >> (added Bryan Wu to CC)
> >>
> >> Someone needs to need fix the bfin architecture:  the addresses on the
> >> bfin_read/bfin_write functions should be 'void __iomem *' not unsigned long.
> >
> > there are no address pointers anymore, so there is nothing to cast ...
> > the bfin_read/bfin_write macros are done in sexy asm:
> > #define bfin_write8(addr,val) __asm__ __volatile__("b[%0] = %1;" ::
> > "a"(addr), "d"(val))
> > or i'm misunderstanding what you mean ...
> >
> > where do you see (unsigned long) ?
>
> Look up (into the message you quoted).

yes, you quoted the driver, not the Blackfin core parts

> Regardless of the implementation, the C type system should be employed
> to ensure that 'addr' is known to the compiler as 'void __iomem *'
> rather than unsigned long.

i agree the specific pata driver should be declared the way you
described, however i dont see how that has bearing on the
bfin_read/bfin_write macros as you seemed to indicate
-mike
