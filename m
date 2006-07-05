From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Via IDE Bus Master controller IRQ number?
Date: Wed, 05 Jul 2006 18:29:34 +0400
Message-ID: <44ABCCCE.1010005@ru.mvista.com>
References: <2f9b85b70607041831kaccea64o8d1a4b2309ce03d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32204 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S964887AbWGEOal (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2006 10:30:41 -0400
In-Reply-To: <2f9b85b70607041831kaccea64o8d1a4b2309ce03d0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Luo <zaizailuo@gmail.com>, linux-ide@vger.kernel.org

Yan Luo wrote:
> Hello,
> 
> I have a question on enabling DMA access to IDE hard disk using VIA
> vt82c686 chipset. My platform is a single board computer AAEON
> PCM-6892 (VIA C3 CPU, via vt82c686b chipset). I am working on a
> IDE-DMA port to RTEMS.

> I am trying to find which irq number the IDE bus master controller
> (part of the vt82c686 chipset) uses. I read out PCI_INTERRUPT_PIN and
> PCI_INTERRUPT_LINE from its PCI configuration space. The
> PCI_INTERRUPT_PIN is found to be '0', and PCI_INTERRUPT_LINE as 'FF'. Does
> it mean this controller does not support interrupt? If so, who do I
> tell if the DMA transfer finishes??

    It just means that it supports the "legacy" interrupts, i. e. IRQ14 for 
primary and IRQ15 for the scondary channel. This should be indicated by the 
bits 0 and 2 of its programming interface register in the PCI config. space 
being set to zero.

> The experiment I did is to send ATA_COMMAND_READ_DMA to IDE0 command
> register (I/O address  0x1F7) and then write '1' to the last bit of
> IDE BM controller's command register (first register in the BM IDE I/O
> space) to start DMA transfer. But the DMA transfer hangs the system. I
> have installed an interrupt handler for IRQ 14, which seems not
> triggered.

    Have you also set up the PRD list and written its address to the 
corresponding BM IDE register?

> Please advise.

WBR, Sergei
