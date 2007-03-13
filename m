From: =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Tue, 13 Mar 2007 21:56:35 +0100
Message-ID: <45F71003.4030003@crans.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de> <45EE9E39.3010800@garzik.org> <45F20541.9090208@crans.org> <45F53B60.8020908@gmail.com> <45F69989.70702@crans.org> <45F69C02.2020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933333AbXCMU4n@vger.kernel.org>
In-Reply-To: <45F69C02.2020206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo a =C3=A9crit :
> Can you apply the attached patch and report what the kernel says with
> ACPI turned on?
>
>  =20
Hi,
I got this:
[   13.523816] SCSI subsystem initialized
[   13.528914] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
low) -> IRQ 19
[   14.529383] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5
Gbps 0x5 impl IDE mode
[   14.529439] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
[   14.529565] ata1: SATA max UDMA/133 cmd 0xf8824d00 ctl 0x00000000
bmdma 0x00000000 irq 19
[   14.529683] ata2: SATA max UDMA/133 cmd 0xf8824d80 ctl 0x00000000
bmdma 0x00000000 irq 19
[   14.529801] ata3: SATA max UDMA/133 cmd 0xf8824e00 ctl 0x00000000
bmdma 0x00000000 irq 19
[   14.529921] ata4: SATA max UDMA/133 cmd 0xf8824e80 ctl 0x00000000
bmdma 0x00000000 irq 19
[   14.529984] scsi0 : ahci
[   14.987273] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   15.031823] ata1.00: taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 0=
0
00 a0 ef
[   15.032119] ata1.00: ATA-7: HTS541010G9SA00, MBZOC60D, max UDMA/100
[   15.032168] ata1.00: 195371568 sectors, multi 0: LBA48 NCQ (depth 31=
/32)
[   15.034170] ata1.00: taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 0=
0
00 a0 ef
[   15.034464] ata1.00: configured for UDMA/100
[   15.034515] scsi1 : ahci
[   15.337188] ata2: SATA link down (SStatus 0 SControl 0)
[   15.337241] scsi2 : ahci
[   15.640125] ata3: SATA link down (SStatus 0 SControl 300)
[   15.640178] scsi3 : ahci
[   15.943062] ata4: SATA link down (SStatus 0 SControl 0)
[   15.943191] scsi 0:0:0:0: Direct-Access     ATA      HTS541010G9SA00=
=20
MBZO PQ: 0 ANSI: 5

and for each ata errors:
[   47.089624] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x=
2
frozen
[   47.089682] ata1.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0
cdb 0x0 data 4096 in
[   47.089684]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   47.392549] ata1: soft resetting port
[   47.547533] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   47.549756] ata1.00: taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 0=
0
00 a0 ef
[   47.552600] ata1.00: taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 0=
0
00 a0 ef
[   47.552969] ata1.00: configured for UDMA/100
[   47.553022] ata1: EH complete
[   47.553104] SCSI device sda: 195371568 512-byte hdwr sectors (100030=
 MB)
[   47.553160] sda: Write Protect is off
[   47.553226] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA

--=20
Mathieu
