From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: Another SATA device with spurious NCQ completions
Date: Tue, 03 Jul 2007 14:41:11 +0200
Message-ID: <468A43E7.2030001@ans.pl>
References: <46800AD3.7050803@redhat.com> <4689FDE6.2080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pigeon.axelspringer.pl ([195.177.210.68]:54931 "EHLO
	mx1.axelspringer.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbXGCNFE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 09:05:04 -0400
In-Reply-To: <4689FDE6.2080806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2007-07-03 09:42, Tejun Heo wrote:
> Chuck Ebbert wrote:
>> From:
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D245512
>>
>>
>> The following error consistently appears at apparently random interv=
als in syslog:
>>
>> kernel: ata1.00: exception Emask 0x2 SAct 0x1001 SErr 0x0 action 0x2=
 frozen
>> kernel: ata1.00: (spurious completions during NCQ issue=3D0x0 SAct=3D=
0x1001
>> FIS=3D004040a1:00000800)
>> kernel: ata1.00: cmd 61/08:00:39:2b:cc/00:00:08:00:00/40 tag 0 cdb 0=
x0 data 4096 out
>> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (=
HSM violation)
>> kernel: ata1.00: cmd 61/08:60:e1:2b:cc/00:00:08:00:00/40 tag 12 cdb =
0x0 data
>> 4096 out
>> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (=
HSM violation)
>>
>> Controller is ATI SB600 using the AHCI driver.
>> 64-bit DMA is disabled.
>> Disk is:
>> ata1.00: ATA-7: ST3160812AS, 3.ADJ, max UDMA/133
>>
>>
>> Can't we just turn off NCQ automatically when this happens?
>=20
> After sever such occasions, NCQ will be turned off automatically.
> Hmm... It's a bit surprising to see this on a Seagate drive tho.  Can
> someone crosscheck this by attaching the drive to an intel ahci?
>=20

After upgradin kernel on one of my firewallas (2.6.14->2.6.20) I notice=
d=20
similar problem with another Seagate: ST380817AS connected to ICH6.

ata1: soft resetting port
ata1: hard resetting port
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
ata2: soft resetting port
ata2: hard resetting port
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
ata1: soft resetting port
ata1: hard resetting port
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
ata1: soft resetting port
ata1: hard resetting port
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
ata2: soft resetting port
ata2: hard resetting port
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA

Disks are working in software (MD) mirror. Disabling NCQ for both disk=20
by adding '{ "ST380817AS",    NULL,     ATA_HORKAGE_NONCQ, },' solved m=
y=20
issue - there are no more resets.

Part of dmesg:
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl=20
SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xE0802100 ctl 0x0 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xE0802180 ctl 0x0 bmdma 0x0 irq 18
ata3: SATA max UDMA/133 cmd 0xE0802200 ctl 0x0 bmdma 0x0 irq 18
ata4: SATA max UDMA/133 cmd 0xE0802280 ctl 0x0 bmdma 0x0 irq 18
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (not used)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (not used)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 AN=
SI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 AN=
SI: 5
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0

Best regards,

			Krzysztof Ol=EAdzki
