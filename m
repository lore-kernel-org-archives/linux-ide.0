From: Andrew_hall <andrew.a.hall@gmail.com>
Subject: CF flash IDE failure to attach with 2.6.20+
Date: Mon, 18 Jun 2007 03:02:32 -0700 (PDT)
Message-ID: <11172839.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:58056 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762079AbXFRKCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 06:02:33 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1I0E48-0005Lb-N3
	for linux-ide@vger.kernel.org; Mon, 18 Jun 2007 03:02:32 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


We have a series of machines that use CF as a boot media. Since upgrading to
2.6.20 (tried .9-.14), system will boot (from the flash media) but then fail
to initialise the same media. Here is the dmesg from 2.6.20.14:

ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFA00 ctl 0xF902 bmdma 0xF600 irq 19
ata2: SATA max UDMA/133 cmd 0xF800 ctl 0xF702 bmdma 0xF608 irq 19
scsi0 : ata_piix
ata1.00: ATA-0, max MWDMA2, 990864 sectors: LBA
ata1.00: ata1: dev 0 multi count 0
ata1.00: applying bridge limits
ata1.00: configured for MWDMA2
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0xF807
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
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: EH complete

At this point the CF is inoperable. I've had no issue prior to 2.6.20. Is
this a known issue? Is there a fix?
-- 
View this message in context: http://www.nabble.com/CF-flash-IDE-failure-to-attach-with-2.6.20%2B-tf3939321.html#a11172839
Sent from the linux-ide mailing list archive at Nabble.com.

