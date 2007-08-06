From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.23-rc2 regression: check_irq_resend() warning from cmd64x
Date: Mon, 6 Aug 2007 11:15:43 +0200
Message-ID: <200708061115.43704.bzolnier@gmail.com>
References: <200708052128.l75LSlN6009111@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:8398 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760221AbXHFJRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 05:17:33 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1993076mue
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 02:17:33 -0700 (PDT)
In-Reply-To: <200708052128.l75LSlN6009111@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>


commit 0fc4969b866671dfe39b1a9119d0fdc7ea0f63e5

Linus, please revert it.

On Sunday 05 August 2007, Mikael Pettersson wrote:
> This is on a sparc64 ultra5 with a rev 3 CMD646. Starting with kernel
> 2.6.23-rc2, each boot triggers a WARNING from kernel/irq/resend.c:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> CMD646: IDE controller at PCI slot 0000:01:03.0
> CMD646: chipset revision 3
> CMD646: MultiWord DMA force limited
> CMD646: 100% native mode on irq 14
>     ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: ST320420A, ATA DISK drive
> hda: selected mode 0x22
> ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> Probing IDE interface ide1...
> hdc: CRD-8483B, ATAPI CD/DVD-ROM drive
> WARNING: at kernel/irq/resend.c:70 check_irq_resend()
> Call Trace:
>  [0000000000475a84] enable_irq+0x9c/0xc8
>  [0000000000560438] probe_hwif+0x7bc/0x934
>  [0000000000560dbc] probe_hwif_init_with_fixup+0x10/0xc4
>  [0000000000563454] ide_setup_pci_device+0x94/0x9c
>  [00000000005581f4] cmd64x_init_one+0x40/0x4c
>  [0000000000680670] ide_scan_pcidev+0x48/0x84
>  [00000000006806e0] ide_scan_pcibus+0x34/0x100
>  [000000000068061c] ide_init+0x60/0x6c
>  [0000000000670200] kernel_init+0xf0/0x270
>  [0000000000427344] kernel_thread+0x38/0x48
>  [00000000005c5fd8] rest_init+0x18/0x5c
> hdc: selected mode 0x22
> ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
> hda: max request size: 128KiB
> hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, (U)DMA
> hda: cache flushes not supported
>  hda: hda1 hda2 hda3 hda4 hda5
