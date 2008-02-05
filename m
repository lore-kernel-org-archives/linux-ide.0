From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Tue, 05 Feb 2008 12:40:04 +0000
Message-ID: <47A86734.76E4.0078.0@novell.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
 <47A71538.50803@gmail.com> <47A8228B.76E4.0078.0@novell.com>
 <47A854AE.5070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:13889
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995AbYBEMjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 07:39:48 -0500
In-Reply-To: <47A854AE.5070403@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>>> Tejun Heo <htejun@gmail.com> 05.02.08 13:21 >>>
>Jan Beulich wrote:
>>> Yes, we can be more smart if necessary.  I don't know.  The hardwar=
e is
>>> clearly violating the spec which requires those two values to agree=
=2E
>>=20
>> So are you saying the ESB2 spec is violating a higher level spec? I =
know
>> almost nothing about AHCI, so please forgive that question...
>
>n_ports and PI should agree with each other.  That's what the ahci spe=
c
>requires.  If ESB2 spec has different opinion about n_ports, it's in
>violation of AHCI spec but I don't think it explicitly state such
>things, does it?

It does, in the description for bits 4:0 of the host capabilities regis=
ter:
"Number of Ports (NPS) =E2=80=93 RO. Hardwired to 5h to indicate suppor=
t for 6
ports. Note that the number of ports indicated in this field may be mor=
e
than the number of ports indicated in the PI (ABAR + 0Ch) register."

>I'd like to see more output including leading controller detection but
>yeah, it seems there's no silicon implemented for the last port.  The
>SStatus value 4 indicates that PHY is offline which usually happens wh=
en
>the PHY is turned off from SControl.  Hmm... weird.  How many ports do=
es
>the machine actually have?  I agree we'll need to adjust PI handling f=
or
>the controller.

<7>libata version 2.00 loaded.
<7>ahci 0000:00:1f.2: version 2.0
<6>ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 66
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x1f impl =
SATA mode
<6>ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part=20
<6>ata1: SATA max UDMA/133 cmd 0xF882E100 ctl 0x0 bmdma 0x0 irq 66
<6>ata2: SATA max UDMA/133 cmd 0xF882E180 ctl 0x0 bmdma 0x0 irq 66
<6>ata3: SATA max UDMA/133 cmd 0xF882E200 ctl 0x0 bmdma 0x0 irq 66
<6>ata4: SATA max UDMA/133 cmd 0xF882E280 ctl 0x0 bmdma 0x0 irq 66
<6>ata5: SATA max UDMA/133 cmd 0xF882E300 ctl 0x0 bmdma 0x0 irq 66
<6>ata6: SATA max UDMA/133 cmd 0xF882E380 ctl 0x0 bmdma 0x0 irq 66
<6>scsi0 : ahci
<6>ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata1.00: ATA-7, max UDMA/133, 312500000 sectors: LBA48 NCQ (depth 31=
/32)
<6>ata1.00: configured for UDMA/133
<6>scsi1 : ahci
<6>ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata2.00: ATA-7, max UDMA/133, 312500000 sectors: LBA48 NCQ (depth 31=
/32)
<6>ata2.00: configured for UDMA/133
<6>scsi2 : ahci
<6>ata3: SATA link down (SStatus 0 SControl 300)
<6>scsi3 : ahci
<6>ata4: SATA link down (SStatus 0 SControl 300)
<6>scsi4 : ahci
<6>ata5: SATA link down (SStatus 4 SControl 300)
<6>scsi5 : ahci
<6>ata6: SATA link down (SStatus 0 SControl 0)
<5>  Vendor: ATA       Model: ST3160815AS       Rev: 3.AD
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
<5>sd 0:0:0:0: Attached scsi disk sda
<5>  Vendor: ATA       Model: ST3160815AS       Rev: 3.AD
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<5>SCSI device sdb: 312500000 512-byte hdwr sectors (160000 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write back
<5>SCSI device sdb: 312500000 512-byte hdwr sectors (160000 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write back
<6> sdb: sdb1
<5>sd 1:0:0:0: Attached scsi disk sdb
<5>sd 1:0:0:0: Attached scsi generic sg1 type 0

Jan
