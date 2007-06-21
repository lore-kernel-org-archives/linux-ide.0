From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Thu, 21 Jun 2007 11:05:43 +1000
Message-ID: <4679cefc.06d7720a.0280.ffff9cce@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:55892 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbXFUBGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jun 2007 21:06:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so128303wah
        for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 18:06:05 -0700 (PDT)
In-Reply-To: <46776306.5030300@gmail.com>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

> I suppose you were using ata_piix too in older kernel, right?  Can you
> post the boot dmesg of 2.6.19?  We used to ignore mwdma mode before and
> enabled it at some point after that.  That may be the cause here.
> 
> Also, please try the attached patch on top of 2.6.20.

Sorry guys, I've actually got it wrong. The hardware that I have been
testing on has a different chipset: Intel ICH8, to what I was using
previously with success with 2.6.19 (this was ICH4 based hardware) - so the
driver is actually different now. 

Tejun, your patch for 2.6.20 failed with the same errors.

For completeness I have tested the newer ICH8 hardware with everything from
2.6.15 through to 2.6.21.5 using the ata_piix drivers and it (the Compact
Flash) fails in all kernels. Here is the (relevant) dmesg from 2.6.21.5
showing the CF being disabled:

ata_piix 0000:00:1f.2: version 2.10ac1
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x0001fa00 ctl 0x0001f902 bmdma 0x0001f600 irq
19
ata2: SATA max UDMA/133 cmd 0x0001f800 ctl 0x0001f702 bmdma 0x0001f608 irq
19
scsi0 : ata_piix
ata1.00: ATA-0: CF CARD 512MB, 20070131, max MWDMA2
ata1.00: 990864 sectors, multi 0: LBA
ata1.00: applying bridge limits
ata1.00: configured for MWDMA2
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x0001f807
scsi 0:0:0:0: Direct-Access     ATA      CF CARD 512MB    2007 PQ: 0 ANSI: 5
SCSI device sda: 990864 512-byte hdwr sectors (507 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support
DPO or FUA
SCSI device sda: 990864 512-byte hdwr sectors (507 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support
DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1.00: limiting speed to MWDMA2:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: EH complete
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 0

Here is the lspci -v for the controller:

00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA
IDE Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corporation 82801H (ICH8 Family) 4 port SATA IDE
Controller
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
        I/O ports at fa00 [size=8]
        I/O ports at f900 [size=4]
        I/O ports at f800 [size=8]
        I/O ports at f700 [size=4]
        I/O ports at f600 [size=16]
        I/O ports at f500 [size=16]
        Capabilities: [70] Power Management version 3

Please let me know if there is any further information I can provide to help
fix this issue.

Thanks,

