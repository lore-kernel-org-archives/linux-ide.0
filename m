From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Sun, 27 Dec 2009 07:52:28 +1100
Message-ID: <1261860748.2173.207.camel@pasglop>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55396 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZLZUxB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Dec 2009 15:53:01 -0500
In-Reply-To: <19254.17766.674348.933702@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Sat, 2009-12-26 at 18:18 +0100, Mikael Pettersson wrote:

> pata-macio 0.00020000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 0
> scsi1 : pata_macio
> ata1: PATA max MWDMA2 irq 30
> irq 30: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [ef87bc40] [c00094a0] show_stack+0x74/0x1a8 (unreliable)
> [ef87bc70] [c006049c] __report_bad_irq+0x40/0xd4
> [ef87bc90] [c0060728] note_interrupt+0x1f8/0x254
> [ef87bcc0] [c0061144] handle_edge_irq+0xe4/0x1ac
> [ef87bce0] [c0007004] do_IRQ+0xa8/0xcc
> [ef87bd00] [c00142cc] ret_from_except+0x0/0x14
> --- Exception: 501 at ata_eh_freeze_port+0x34/0x48
>     LR = ata_eh_freeze_port+0x30/0x48
> [ef87bdd0] [c01a8f34] ata_eh_reset+0x370/0xd90
> [ef87be50] [c01aabfc] ata_eh_recover+0x300/0x115c
> [ef87bee0] [c01abc60] ata_do_eh+0x54/0xc8
> [ef87bf10] [c01adcb0] ata_sff_error_handler+0x144/0x228
> [ef87bf30] [c01ac5ec] ata_scsi_error+0x320/0x548
> [ef87bf60] [c017e4b4] scsi_error_handler+0x174/0x444
> [ef87bfc0] [c0046b88] kthread+0x80/0x84
> [ef87bff0] [c0013a44] kernel_thread+0x4c/0x68
> handlers:
> [<c01afc68>] (ata_sff_interrupt+0x0/0x12c)
> Disabling IRQ #30
> ata1.00: ATAPI: MATSHITA CR-585, ZS20, max MWDMA1
> ata1.00: configured for MWDMA1
> pata-macio 0.00021000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 1
> scsi2 : pata_macio
> ata2: PATA max MWDMA2 irq 34
> ...

Ok so it looks to me like the drive is firing off an unexpected
interrupt early on, causing the IRQ line to be disabled by the
kernel. Later on, the drive is properly reset but ... the IRQ
isn't working and things timeout.

I've had a few bad cases in the past of IRQs firing at unexpected
times with the earlier versions of those chipsets, especially with
the ATAPI drives. We might need to change some bits of libata to
cope better, I'm not too sure. It definitely works with drivers/ide
but then drivers/ide does some very unnatural things to the irq line
during probe...

Cheers,
Ben.


