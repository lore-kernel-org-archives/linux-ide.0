From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH take #5] [libata] libata driver for bf548 on chip ATAPI
 controller.
Date: Thu, 16 Aug 2007 14:40:13 -0400
Message-ID: <46C49A0D.5080002@garzik.org>
References: <1187169256.31383.3.camel@sevens.analog.com>	 <46C3F6FB.2070909@garzik.org> <8bd0f97a0708160927s625fd5ax84cd6d12a693d9ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52069 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374AbXHPSkR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 14:40:17 -0400
In-Reply-To: <8bd0f97a0708160927s625fd5ax84cd6d12a693d9ad@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Sonic Zhang <sonic.adi@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Bryan Wu <bryan.wu@analog.com>

Mike Frysinger wrote:
> On 8/16/07, Jeff Garzik <jeff@garzik.org> wrote:
>> Sonic Zhang wrote:
>>> +static void bfin_set_piomode(struct ata_port *ap, struct ata_device *adev)
>>> +{
>>> +     int mode = adev->pio_mode - XFER_PIO_0;
>>> +     unsigned long base = (unsigned long)ap->ioaddr.ctl_addr;
>>
>> (added Bryan Wu to CC)
>>
>> Someone needs to need fix the bfin architecture:  the addresses on the
>> bfin_read/bfin_write functions should be 'void __iomem *' not unsigned long.
> 
> there are no address pointers anymore, so there is nothing to cast ...
> the bfin_read/bfin_write macros are done in sexy asm:
> #define bfin_write8(addr,val) __asm__ __volatile__("b[%0] = %1;" ::
> "a"(addr), "d"(val))
> or i'm misunderstanding what you mean ...
> 
> where do you see (unsigned long) ?

Look up (into the message you quoted).

Regardless of the implementation, the C type system should be employed 
to ensure that 'addr' is known to the compiler as 'void __iomem *' 
rather than unsigned long.

	Jeff



