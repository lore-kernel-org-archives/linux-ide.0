From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Mon, 11 Jan 2010 16:12:39 +1100
Message-ID: <1263186759.724.132.camel@pasglop>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55349 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab0AKFQz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 00:16:55 -0500
In-Reply-To: <19254.17766.674348.933702@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Sat, 2009-12-26 at 18:18 +0100, Mikael Pettersson wrote:
> I decided to give the new pata_macio a try on my old PMac G3 (Beige).
> None of the disks are connected to the PMAC IDE controller, but the
> CD-drive is.

Hrm, I dug out a Beige G3 and cannot reproduce.

However, Tejun or Jeff may have something to say there:

It looks like we are taking an interrupt on the spin_unlock_irqrestore()
of ata_eh_freeze_port() which has just called ->freeze which is
ata_sff_freeze().

What seem to happen is that we get that interrupt over and over again
(don't bother about the dmesg saying it's an edge interrupt, it's not
but that's isn't a big deal, though the Apple interrupt controller is
weird like that, I might fix it some day...).

Now the later has a comment about the fact that NIEN manipulation might
cause an interrupt. So we "clear" it... except that for -some- reason
that doesn't work in your case, ie, the interrupt remains asserted.

The interrupt handler does nothing in libata (and thus doesn't read the
status to try to bring the IRQ down) neither.

I wonder if the problem is that the IRQ line off the drive is floating,
possibly due to the HW reset that was done before, and remains so until
at least one command has been sent or that sort of thing...

Now I remember seeing that sort of weird thing related to NIEN on the
wallstreet in the old days but this didn't seem to happen with libata on
the one I have here when I ported the driver. I'm not sure what's going
on, it's possible that the interrupt line is floating, though I would
hope not ... we haven't started the reset after all 

Tejun, what's your take here ? It looks like reading the status reg
is not enough to bring the interrupt down. We could try to disable_irq
in freeze() (we know we don't share interrupts in the case of macio)
and re-enable it right after firing off the first taskfile maybe ?

Mikael: Can you try commenting out the code in pata_macio_reset_hw()
that calles ppc_mc.feature_call(PMAC_FTR_IDE_RESET,...) ? Keep the
ENABLE calls but comment out the reset ones, and let us know if that
makes a difference. These calls basically toggle the HW reset line of
the drive.

Cheers,
Ben.

> 2.6.32 with legacy IDE detects things nicely:
> 
> ide-pmac: Found Apple Heathrow ATA controller (macio), bus ID 0, irq 30
> Probing IDE interface ide0...
> hda: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
> hda: host max PIO4 wanted PIO255(auto-tune) selected PIO3
> hda: MWDMA1 mode selected
> ide0 at 0xf1018000-0xf1018070,0xf1018160 on irq 30
> ide-pmac: Found Apple Heathrow ATA controller (macio), bus ID 1, irq 34
> Probing IDE interface ide1...
> ide1 at 0xf1020000-0xf1020070,0xf1020160 on irq 34
> ide-gd driver 1.18
> ...
> ide-cd driver 5.00
> ide-cd: hda: ATAPI 24X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.20
> 
> but 2.6.33-rc2 with pata_macio does not:
> 
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
> ata1.00: qc timeout (cmd 0xa0)
> ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
> ata1.00: configured for MWDMA1
> ata1.00: qc timeout (cmd 0xa0)
> ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
> ata1.00: limiting speed to MWDMA1:PIO2
> ata1.00: configured for MWDMA1
> ata1.00: qc timeout (cmd 0xa0)
> ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
> ata1.00: disabled
> ata1: soft resetting link
> ata1: EH complete
> 
> /Mikael


