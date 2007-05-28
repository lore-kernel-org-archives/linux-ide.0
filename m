From: "George T. Joseph \(development\)" <gtj.devel@peakin.com>
Subject: RE: [PATCH] Add Marvell 6141 PATA support to AHCI driver
Date: Mon, 28 May 2007 13:24:25 -0600
Message-ID: <22E26940476D1E48AA6F292B5316C9C33827@bes1.peakin.com>
References: <20070527030954.GA18974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmail136075.authsmtp.net ([62.13.136.75]:64952 "EHLO
	outmail136075.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbXE1TnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 15:43:20 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070527030954.GA18974@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Jeff,

Any news from Marvell on the msi and ncq issues?  

Environment:
Intel 975XBX2 w/ Marvell 6145 with BIOS at 1.1.0.34
 (the pata port is n/c on this board)
2x Seagate 7200.10 320g
2x WD WD2500KS 250g
Drives and cables work fine on the ICH7.

With MSI enabled...

ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 5 ports 3 Gbps 0x1f impl SATA
mode
ahci 0000:03:00.0: flags: 64bit ncq stag pmp slum part 
PCI: Setting latency timer of device 0000:03:00.0 to 64
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
scsi7 : ahci
scsi8 : ahci
ata5: SATA max UDMA/133 cmd 0xf8822100 ctl 0x00000000 bmdma 0x00000000
irq 0
ata6: SATA max UDMA/133 cmd 0xf8822180 ctl 0x00000000 bmdma 0x00000000
irq 0
ata7: SATA max UDMA/133 cmd 0xf8822200 ctl 0x00000000 bmdma 0x00000000
irq 0
ata8: SATA max UDMA/133 cmd 0xf8822280 ctl 0x00000000 bmdma 0x00000000
irq 0
ata9: PATA max UDMA/133 cmd 0xf8822300 ctl 0x00000000 bmdma 0x00000000
irq 0
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
irq 16: nobody cared (try booting with the "irqpoll" option)
 [<c01036df>] show_trace_log_lvl+0x1a/0x2f
 [<c01041c9>] show_trace+0x12/0x14
 [<c0104250>] dump_stack+0x16/0x18
 [<c0141bc0>] __report_bad_irq+0x39/0x79
 [<c0141da0>] note_interrupt+0x1a0/0x1dc
 [<c0142348>] handle_fasteoi_irq+0x91/0xb6
 [<c0104928>] do_IRQ+0xb7/0xe3
 =======================
handlers:
[<c02713e6>] (usb_hcd_irq+0x0/0x52)
Disabling IRQ #16
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ATA: abnormal status 0x58 on port 0x00000000
ATA: abnormal status 0x58 on port 0x00000000
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata5.00: limiting speed to UDMA7:PIO5
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ATA: abnormal status 0x58 on port 0x00000000
ATA: abnormal status 0x58 on port 0x00000000
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  <repeated for each drive connected>

With MSI disabled and NCQ enabled (a few minutes into a load test)...

ata6.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x2 frozen
ata6.00: cmd 60/40:00:80:94:69/00:00:00:00:00/40 tag 0 cdb 0x0 data
32768 in
         res 40/00:40:f8:fd:88/00:00:00:00:00/40 Emask 0x4 (timeout)
ata6.00: cmd 60/40:08:c0:94:69/00:00:00:00:00/40 tag 1 cdb 0x0 data
32768 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: cmd 60/80:10:00:95:69/00:00:00:00:00/40 tag 2 cdb 0x0 data
65536 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6: soft resetting port
ata6: softreset failed (1st FIS failed)
ata6: reset failed (errno=-5), retrying in 10 secs
ata6: hard resetting port
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6.00: revalidation failed (errno=-5)
ata6: failed to recover some devices, retrying in 5 secs
ata6: hard resetting port
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6.00: revalidation failed (errno=-5)
ata6.00: limiting speed to UDMA/133:PIO3
ata6: failed to recover some devices, retrying in 5 secs
ata6: hard resetting port
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6.00: revalidation failed (errno=-5)
ata6.00: disabled
ata6: EH complete





> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Jeff Garzik
> Sent: Saturday, May 26, 2007 9:10 PM
> To: linux-ide@vger.kernel.org
> Cc: LKML; Alan Cox
> Subject: [PATCH] Add Marvell 6141 PATA support to AHCI driver
> 
> 
> Here is a patch against 2.6.22-rc3 that adds support for both the PATA
> and SATA portions of the Marvell AHCI-like chip.
> 
> The architecture for PATA is quite nice, mimicing AHCI very closely.
> Basic port scanning, interrupt handling, freezing and thawing is the
> same, and uses the same register offets.
> 
> This is completely untested code.  But it looks like it should work :)
> 
> Engineering questions I need to bounce back to Marvell:
> * do I need to worry about PIO/UDMA timing?  I don't see any registers
>   or other knobs dealing with timing.  Maybe the controller snoops?
> * it appears that I don't have to worry about device selection, that
>   the controller will handle this for me.  But I want to make sure.
> * figure out controller commands. these are poorly documented.
>   controller commands are how one directly accesses the PATA device's
>   command and control registers, and are necessary to do things like
>   SRST.  Currently the driver only does hard reset.
> 
> This is checked into the 'mv-ahci-pata' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
