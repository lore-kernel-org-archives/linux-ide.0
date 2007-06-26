From: Mark Lord <liml@rtr.ca>
Subject: Re: CF flash PATA on libata failure to attach
Date: Tue, 26 Jun 2007 14:50:28 -0400
Message-ID: <46815FF4.9040001@rtr.ca>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1129 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430AbXFZSua (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 14:50:30 -0400
In-Reply-To: <4680d387.24528c0a.3634.69bd@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>, robert.de.rooy@gmail.com
Cc: 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

Andrew Hall wrote:
> Hello,
> 
> I have been wrestling now for several days trying to get a Compact Flash
> (IDE) card detected and mounted properly under any version of Linux 2.6.x.
> using ICH8 hardware. My understanding is that this hardware uses a SATA to
> PATA bridge, and so I have tried unsuccessfully to use the newer Intel ESB,
> ICH, PIIX3, PIIX4 PATA/SATA drivers and the older Intel PATA old PIIX
> drivers with and without the older standard ATA support compiled in.
...
> <5>Linux version 2.6.22-rc6 (root@localhost) (gcc version 4.1.1 20070105
...
> <7>ata_piix 0000:00:1f.2: version 2.11
> <6>ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> <6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> <7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
> <6>scsi0 : ata_piix
> <6>scsi1 : ata_piix
> <6>ata1: SATA max UDMA/133 cmd 0x0001fa00 ctl 0x0001f902 bmdma 0x0001f600
> irq 0
> <6>ata2: SATA max UDMA/133 cmd 0x0001f800 ctl 0x0001f702 bmdma 0x0001f608
> irq 0
> <6>ata1.00: ATA-0: CF CARD 512MB, 20070131, max MWDMA2
> <6>ata1.00: 990864 sectors, multi 0: LBA 
> <6>ata1.00: applying bridge limits
> <6>ata1.00: configured for MWDMA2
> <4>ATA: abnormal status 0x7F on port 0x0001f807
> <5>scsi 0:0:0:0: Direct-Access     ATA      CF CARD 512MB    2007 PQ: 0
> ANSI: 5
> <5>sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
> <5>sd 0:0:0:0: [sda] Write Protect is off
> <7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> <5>sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> <5>sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
> <5>sd 0:0:0:0: [sda] Write Protect is off
> <7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> <5>sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> <6> sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> <3>ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096
> in
> <4>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> <4>ata1: port is slow to respond, please be patient (Status 0xd0)
> <4>ata1: device not ready (errno=-16), forcing hardreset
> <3>ata1: BUG: prereset() requested invalid reset type
> <6>ata1: soft resetting port
> <4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> <3>ata1.00: revalidation failed (errno=-5)
> <4>ata1: failed to recover some devices, retrying in 5 secs
> <6>ata1: soft resetting port
> <4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> <3>ata1.00: revalidation failed (errno=-5)
> <4>ata1.00: limiting speed to MWDMA2:PIO3
> <4>ata1: failed to recover some devices, retrying in 5 secs
> <6>ata1: soft resetting port
> <4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> <3>ata1.00: revalidation failed (errno=-5)
> <4>ata1.00: disabled
> <6>ata1: EH complete
> <6>sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> <4>end_request: I/O error, dev sda, sector 0
> <3>Buffer I/O error on device sda, logical block 0
> <6>sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> <4>end_request: I/O error, dev sda, sector 0
> <3>Buffer I/O error on device sda, logical block 0
> <4> unable to read partition table
> <5>sd 0:0:0:0: [sda] Attached SCSI disk
> <5>sd 0:0:0:0: Attached scsi generic sg0 type 0
> <6>ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
> <6>ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
> <7>PCI: Setting latency timer of device 0000:00:1f.5 to 64
> <6>scsi2 : ata_piix
> <6>scsi3 : ata_piix
> <6>ata3: SATA max UDMA/133 cmd 0x0001f300 ctl 0x0001f202 bmdma 0x0001ef00
> irq 0
> <6>ata4: SATA max UDMA/133 cmd 0x0001f100 ctl 0x0001f002 bmdma 0x0001ef08
> irq 0
> <4>ATA: abnormal status 0x7F on port 0x0001f307
> <4>ATA: abnormal status 0x7F on port 0x0001f107

This looks a lot like the other CF-card problem that was being debugged
here over the past week -- the one where POLLING had to be turned on.
Robert de Rooy (copied) was the reporter for that one.
Perhaps you two could compare notes ?

Cheers

