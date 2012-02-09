From: Matt Sealey <matt@genesi-usa.com>
Subject: Braindead newbie questions, DMA-backed PIO
Date: Thu, 9 Feb 2012 13:43:01 -0600
Message-ID: <CAKGA1b=XvOS_dk3HV8H7-S1Ppc76FoW51xgnvKX2XWzCpfH4xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod7og114.obsmtp.com ([64.18.2.215]:46894 "EHLO
	exprod7og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758496Ab2BITtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2012 14:49:03 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so3807459obc.33
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2012 11:49:01 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi guys,

I have some probably quite simple questions which I am having a hard
time figuring out.

I am working on improving DMA support for the pata_imx driver. While
supporting normal MWDMA and UDMA modes is fairly easy (the SoC
DMA controller handles it almost transparently), for PIO mode I intend
to enhance it by replacing ata_sff_data_xfer with something that is
backed with a little more involved on DMA (basically using the DMA
unit to transfer data to the 16-bit drive data register).

However, I can't figure out (because there are no solid examples) if I
can act on the buffer data in the same way as I would in a DMA
function
by mapping sg's and doing a standard dmaengine slave transfer then
waiting for it to complete (thus relieving us of having to do
expensive
16-bit CPU I/O to a device register, and hopefully allowing the kernel
or userspace to do something else like play audio or whatever while we
wait for the slave transfer to complete). I assume it should all be
fine, but I just want to be super sure before I start scratching my
head over
something fundamentally impossible.

The other question semi-related is whether I really need to, as in the
current implementation, use the ata_sff_data_xfer_noirq (or a
derivative of
it) variant as this causes some incredible stuttering in the system
and impacts things like audio. What exactly are we protecting against
here,
an occurance of any system IRQ that might steal from the transfer, or
just the occurance of the ATA IRQ? With the drive interrupt enabled
(the manual just states that when it happens the drive is looking for
attention) is this going to cause some insanity with the transfer with
libata
servicing the interrupt behind my back and doing something odd? The
default interrupt handler in libata seems to be fairly safe and checks
if
the controller is busy or not, but since there are a lot of drivers
that use _noirq variant for PIO I am just curious what they are
looking to avoid
happening, perhaps if this is a legacy behavior nobody bothered to
change since libata got more advanced?

I also have another small question, is there any benefit to having
set_piomode, set_dmamode and set_mode all implemented? What's the
precise reason to implement set_mode, I assume just to handle any odd
tweaks like dma mask registers that are not ATA standard before
(or after?) the set_???mode functions are called? The pata_platform.c
driver which pata_imx.c was derived from implements it but does not
implement any other pio/dma mode setting. pata_imx sets up iordy
behavior for higher transfer rates (for some reason, it doesn't
actually have
any support for the timings) in this function. What is the recommended
way to do this these days? My current internal implementation removes
this and uses set_piomode and set_dmamode to implement drive timings
and set iordy, and I just want to check that this is correct.

Thanks for any answers..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
