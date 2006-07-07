From: "Yan Luo" <zaizailuo@gmail.com>
Subject: Re: Re: Via IDE Bus Master controller IRQ number?
Date: Thu, 6 Jul 2006 23:11:36 -0400
Message-ID: <2f9b85b70607062011g1b0ba42bu7fb7ce520b82cd0e@mail.gmail.com>
References: <2f9b85b70607041831kaccea64o8d1a4b2309ce03d0@mail.gmail.com>
	 <44ABCCCE.1010005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:53365 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751165AbWGGDLg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jul 2006 23:11:36 -0400
Received: by py-out-1112.google.com with SMTP id 57so456358pya
        for <linux-ide@vger.kernel.org>; Thu, 06 Jul 2006 20:11:36 -0700 (PDT)
In-Reply-To: <44ABCCCE.1010005@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Sergei, Thanks for your reply.

I am still confused about the IDE interrupt and DMA interrupt. I
noticed that writing the command (ATA_COMMAND_READ_DMA) to the IDE
command register triggered an interrupt, but the DMA transfer did not.
My SECTOR_COUNT is 32, but PRD table has only 16 buffers, so I expect
two DMA transfers and two interrupts. However I saw only one
interrupt, which I suspect it triggered by the ATA_COMMAND_READ_DMA
command, not by DMA transfer completion.

I did the following in read() of my device driver.
1) fill SECTOR_COUNT, LBA address etc to IDE registers. (This is
actually done outside read(), only once for one read request)
2) disable ATA interrupt
3) write ATA_COMMAND_READ_DMA to IDE command register
4) build PRD table (yes, my PRD table is correct now because I got the
correct data)
5) clear INTR and ERR in DMA status register
6) wait until DRQ set in IDE status register
7) start DMA by write '1' to the last bit of DMA command register
8) enable ATA interrupt
9) read out all IDE registers for debugging purpose.
10) wait for semaphore (DMA done?)
11) updated buffer pointer

I have the following in my interrupt handler (#14):
1) stop DMA transfer by writing '0' to DMA command register
2) check if any IDE error in IDE status register or DMA error in DMA
status register
3) release semaphore (notify driver the interrupt of DMA_done).

I can get the driver working occasionally so I think I am almost
there. I need some help on clearing my thoughts. Please point out
where I did wrong.

Thank you very much,
Yan

On 7/5/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Yan Luo wrote:
> > Hello,
> >
> > I have a question on enabling DMA access to IDE hard disk using VIA
> > vt82c686 chipset. My platform is a single board computer AAEON
> > PCM-6892 (VIA C3 CPU, via vt82c686b chipset). I am working on a
> > IDE-DMA port to RTEMS.
>
> > I am trying to find which irq number the IDE bus master controller
> > (part of the vt82c686 chipset) uses. I read out PCI_INTERRUPT_PIN and
> > PCI_INTERRUPT_LINE from its PCI configuration space. The
> > PCI_INTERRUPT_PIN is found to be '0', and PCI_INTERRUPT_LINE as 'FF'. Does
> > it mean this controller does not support interrupt? If so, who do I
> > tell if the DMA transfer finishes??
>
>     It just means that it supports the "legacy" interrupts, i. e. IRQ14 for
> primary and IRQ15 for the scondary channel. This should be indicated by the
> bits 0 and 2 of its programming interface register in the PCI config. space
> being set to zero.
>
> > The experiment I did is to send ATA_COMMAND_READ_DMA to IDE0 command
> > register (I/O address  0x1F7) and then write '1' to the last bit of
> > IDE BM controller's command register (first register in the BM IDE I/O
> > space) to start DMA transfer. But the DMA transfer hangs the system. I
> > have installed an interrupt handler for IRQ 14, which seems not
> > triggered.
>
>     Have you also set up the PRD list and written its address to the
> corresponding BM IDE register?
>
> > Please advise.
>
> WBR, Sergei
>
