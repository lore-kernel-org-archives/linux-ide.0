From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: 2.6.23-rc9-git4: pata_pcmcia, disabling IRQ #9
Date: Fri, 05 Oct 2007 20:08:57 +0200
Message-ID: <47067DB9.80200@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:2250 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbXJESPl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 14:15:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Latest git, insert a CF card into cardbus slot gives:

pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xdea00000-0xdeafffff: excluding 0xdea00000-0xdeafffff
cs: memory probe 0xff600000-0xff6fffff: excluding 0xff600000-0xff60ffff 0xff6a0000-0xff6dffff 0xff6f0000-0xff6fffff
pcmcia: registering new device pcmcia0.0
irq 9: nobody cared (try booting with the "irqpoll" option)
  [<c01041f2>] show_trace_log_lvl+0x1a/0x2f
  [<c01042ed>] show_trace+0x12/0x14
  [<c0104ea0>] dump_stack+0x15/0x17
  [<c0133b48>] __report_bad_irq+0x39/0x79
  [<c0133d80>] note_interrupt+0x1f8/0x234
  [<c0134527>] handle_level_irq+0x8e/0xd1
  [<c0105a6d>] do_IRQ+0x92/0xad
  [<c0103f57>] common_interrupt+0x23/0x28
  [<c0134513>] handle_level_irq+0x7a/0xd1
  [<c0105a5e>] do_IRQ+0x83/0xad
  =======================
handlers:
[<c02a8a38>] (acpi_irq+0x0/0x18)
[<c03268e0>] (yenta_interrupt+0x0/0xb7)
[<c032b1d7>] (usb_hcd_irq+0x0/0x51)
[<c032b1d7>] (usb_hcd_irq+0x0/0x51)
[<c032b1d7>] (usb_hcd_irq+0x0/0x51)
[<c037c08c>] (snd_intel8x0_interrupt+0x0/0x1e8)
[<c02eeaff>] (e1000_intr+0x0/0xeb)
Disabling IRQ #9
scsi2 : pata_pcmcia
ata3: PATA max PIO0 cmd 0x0001d100 ctl 0x0001d10e bmdma 0x00000000 irq 9
ata3.00: qc timeout (cmd 0x91)
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)

However, if I rename pata_pcmcia.ko so that udev cannot autoload it, insert the
card and manually load pata_pcmcia.ko it works:

pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xdea00000-0xdeafffff: excluding 0xdea00000-0xdeafffff
cs: memory probe 0xff600000-0xff6fffff: excluding 0xff600000-0xff60ffff 0xff6a0000-0xff6dffff 0xff6f0000-0xff6fffff
pcmcia: registering new device pcmcia0.0

# insmod pata_pcmcia.ko

scsi2 : pata_pcmcia
ata3: PATA max PIO0 cmd 0x0001d100 ctl 0x0001d10e bmdma 0x00000000 irq 9
ata3.00: CFA: , verB2.10, max PIO2
ata3.00: 507904 sectors, multi 0: LBA
ata3.00: configured for PIO0
scsi 2:0:0:0: Direct-Access     ATA                       verB PQ: 0 ANSI: 5
sd 2:0:0:0: [sdb] 507904 512-byte hardware sectors (260 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdb] 507904 512-byte hardware sectors (260 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
  sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI removable disk
sd 2:0:0:0: Attached scsi generic sg2 type 0


System is a Vaio with ICH4 and TI PCI7420 Cardbus bridge.
If you need more info, please don't hesitate to ask.

Thank you,
	Manuel Lauss
