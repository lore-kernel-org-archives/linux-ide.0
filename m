From: James McMechan <James_McMechan@hotmail.com>
Subject: problems with siimage.c
Date: Sun, 15 Jan 2006 17:43:51 -0800
Message-ID: <200601151743.52068.James_McMechan@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.sea.safepages.com ([216.127.148.222]:10448 "EHLO
	mail2.sea.safepages.com") by vger.kernel.org with ESMTP
	id S932158AbWAPBzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jan 2006 20:55:47 -0500
Received: from [192.168.1.46] (pool-71-105-49-236.lsanca.dsl-w.verizon.net [71.105.49.236])
	by mail2.sea.safepages.com (Postfix) with ESMTP id 975A8CC033
	for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2006 01:44:55 +0000 (GMT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have googled for this but it does not seem to have any resolution I can 
find

When I do a modprobe siimage if I have a drive on the second channel of the 
last card I get several "Disabling IRQ #10"s on the display.

What I am guessing happens is that the first channel is setup and then the 
interrupts are enabled but the second channel is not yet set up, or does 
not have its interrupt service routine registered yet.

Then the second channel has a interrupt that is never serviced the irq is 
disabled and then the first channel fails with lost interrupt.

Note I am using a standard IDE disk not a SATA disk, and the other 
controllers start fine, I have swaped disks, cables and controllers and 
the problem remains, I am guessing the BIOS does not finish setting up 
this controller and the linux driver does not either.

here are what I think is the interesting bits of 8 __report_bad_irq dumps
they are in order
1) Probing IDE interface ide8...
   hdq: Maxtor 6B200R0, ATA DISK drive
   irq 10: nobody cared!
2) Disabling IRQ #10
   ide8 at 0xd088a080-0xd088a087,0xd088a08a on irq 10
   hdq: max request size: 64KiB
   hdq: lost interrupt
   irq 10: nobody cared!
3) Disabling IRQ #10
   hdq: lost interrupt
   irq 10: nobody cared!
4) Disabling IRQ #10
   hdq: lost interrupt
   irq 10: nobody cared!
5) Disabling IRQ #10
   hdq: lost interrupt
   irq 10: nobody cared!
6) Disabling IRQ #10
   hdq: 398297088 sectors (203928 MB) w/16384KiB Cache, CHS=24792/255/63, 
UDMA(133)
   hdq: lost interrupt
   irq 10: nobody cared!
7) Disabling IRQ #10
   hdq: cache flushes supported
   hdq:<4>hdq: dma_timer_expiry: dma status == 0x24
   hdq: DMA interrupt recovery
   hdq: lost interrupt
   irq 10: nobody cared!
8) Disabling IRQ #10
   unknown partition table
   hdq: lost interrupt
   irq 10: nobody cared!

And then it tries the second channel which comes right up no problems...
here is the fist one with its backtrace

SiI680: IDE controller at PCI slot 0000:00:0b.0
PCI: Found IRQ 10 for device 0000:00:0b.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 10
ide8: MMIO-DMA , BIOS settings: hdq:pio, hdr:pio
ide9: MMIO-DMA , BIOS settings: hds:pio, hdt:pio
Probing IDE interface ide8...
hdq: Maxtor 6B200R0, ATA DISK drive
irq 10: nobody cared!
[<c01383aa>] __report_bad_irq+0x2a/0x90
[<c0137ea0>] handle_IRQ_event+0[<c02339d9>] init_irq+0x149/0x3d0
[<c022fbe0>] ide_intr+0x0/0x130
[<c023412c>] hwif_init+0xdc/0x250
[<c023690f>] do_ide_setup_pci_device+0x8f/0x160
[<d088e780>] siimage_fixup+0x0/0x50 [siimage]
[<c023364c>] probe_hwif_init_with_fixup+0x2c/0x90
[<c0236a43>] ide_setup_pci_device+0x63/0xb0
[<d088e780>] siimage_fixup+0x0/0x50 [siimage]
[<c01c2e82>] pci_device_probe_static+0x52/0x70
[<c01c2edb>] __pci_device_probe+0x3b/0x50
[<c01c2f1c>] pci_device_probe+0x2c/0x50
[<c0217e6f>] driver_probe_device+0x2f/0x80
[<c0217fb9>] driver_attach+0x59/0x90
[<c02184b8>] bus_add_driver+0x98/0xd0
[<c01c31cb>] pci_register_driver+0x6b/0x90
[<d088ea2f>] siimage_ide_init+0xf/0x14 [siimage]
[<c0136077>] sys_init_module+0x137/0x1c0
[<c0103095>] syscall_call+0x7/0xb
handlers:
[<c022fbe0>] (ide_intr+0x0/0x130)
Disabling IRQ #10
ide8 at 0xd088a080-0xd088a087,0xd088a08a on irq 10
hdq: max request size: 64KiB
hdq: lost interrupt
irq 10: nobody cared!
