From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 20:16:44 +0300
Message-ID: <4B42227C.2070600@ru.mvista.com>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <20100104151637.559c4780@lxorguk.ukuu.org.uk> <4B420A27.9060407@garzik.org> <20100104154406.GB18335@flint.arm.linux.org.uk> <20100104155544.0c7dbfaa@lxorguk.ukuu.org.uk> <20100104161537.GC18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:35441 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752193Ab0ADROc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:14:32 -0500
In-Reply-To: <20100104161537.GC18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello.

Russell King wrote:

>>>That's not the problem here - with the printk's I've added, there's no
>>>way for the IO read/writes to come that fast.  Slowing down the IO
>>>accesses made no difference what so ever.

>>Doing it within 400nS of command setup is suspect at the ATA level and
>>can trivially fixed.

>>Sane PCI controllers (and quite a few less than sane ones) all implement
>>an AltStatus which can be checked for busy bits with DMA running or stall
>>that access until the DMA completes (wrongly in some CMD64x cases).

>>The 20246 implements its own magic 'am I busy' flag which old IDE
>>supports and libata doesn't. So as well as the ndelay(400) fix for PIO
>>controllers it needs pdc202xx_test_irq porting over to complete the fix.

> Yes, but please use a non-buggy version of pdc202xx_test_irq() as per
> my recent patch.  Testing for the DMA FIFOs being non-empty to qualify
> an interrupt is Very Bad News too.

    Sorry about that -- I was the author of pdc202xx_test_irq()...

> It's interesting to note that SFF 8038 suggests an approach to dealing
> with IDE interrupts connected to a SFF compatible host interface:

> 3) Software issues the appropriate DMA transfer command to the disk device.
> 4) Engage the bus master function by writing a '1' to the Start bit in the
>    Bus Master IDE Command Register for the appropriate channel.
> 5) The controller transfers data to/from memory responding to DMA requests
>    from the IDE device.
> 6) at the end of the transfer the IDE device signals an interrupt .
> 7) In response to the interrupt, software resets the Start/Stop bit in the
>    command register. It then reads the controller status and then the drive
>    status to determine if the transfer completed successfully.

> It goes on to say that the interrupt status bit in the BM-DMA status
> register will only be set after buffered data has been transferred -
> which means reading the altstatus register to determine when the device
> has finished would give a premature indication and doesn't take any
> account of the BM-DMA buffering.

    Yes.

> So I think Jeff is not right on the "must read altstatus" point.

    Frankly speaking, I'm not sure why Jeff insisted on that, at least for 
the DMA case...

> I would not be surprised if lots of host controllers were actually buggy
> in respect of reading any ATA device register mid-transfer - firstly a
> started UDMA operation can't be stopped before at least one word has been
> transferred, nor can it be stopped without first transferring the CRC
> bytes.  That's an awful lot of logic (and overhead) to be randomly
> interacting with due to other shared devices interrupt activity.

> Reading the BM-DMA status register (or equivalent on hosts) seems to be
> the right way to tell if an interrupt is pending.

    Except the BMDMA interrupt bit (generally) doesn't get  set for the PIO 
transfers. Anyway, the IDE core eventually reads that register for the DMA 
transfers. I'm sure libata also does eventually read it; looking at the code 
in ata_sff_host_intr(), it even reads the BMDMA status first, before 
touching any of the IDE status registers.

MBR, Sergei
