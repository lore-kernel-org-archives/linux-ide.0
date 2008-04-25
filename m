From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Fri, 25 Apr 2008 04:40:22 +0200
Message-ID: <200804250440.22307.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com> <200804250317.16396.volker.armin.hemmann@tu-clausthal.de> <48113AE6.6060904@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WSUEIO4e3u1bMqx"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:57425 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbYDYCk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 22:40:27 -0400
In-Reply-To: <48113AE6.6060904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

--Boundary-00=_WSUEIO4e3u1bMqx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 25. April 2008, Tejun Heo wrote:
> Volker Armin Hemmann wrote:
> >  static void ahci_enable_ahci(void __iomem *mmio)
> >  {
> > +       int i;
> >         u32 tmp;
> >
> >         /* turn on AHCI_EN */
> >         tmp =3D readl(mmio + HOST_CTL);
> > -       if (!(tmp & HOST_AHCI_EN)) {
> > +       if (tmp & HOST_AHCI_EN)
> > +               return;
> > +
> > +       /* Some controllers need AHCI_EN to be written multiple times.
> > +        * Try a few times before giving up.
> > +        */
> > +       for (i =3D 0; i < 5; i++) {
> >                 tmp |=3D HOST_AHCI_EN;
> >                 writel(tmp, mmio + HOST_CTL);
> >                 tmp =3D readl(mmio + HOST_CTL);   /* flush && sanity ch=
eck
> > */ -               WARN_ON(!(tmp & HOST_AHCI_EN));
> > +               if (tmp & HOST_AHCI_EN)
> > +                       return;
> > +               msleep(10);
> >         }
> > +
> > +       WARN_ON(1);
> >  }
>
> Heh... your patch is white-space broken.  Just save whole mail to a file
> and use filterdiff to extract patch.  Copy & pasting doesn't always work.

ok, that did it. Sorry for the noise.

I built the kernel without SFF support.

With AHCI+pci=3Dnomsi
[    0.360530] Driver 'sd' needs updating - please use bus_type methods
[    0.360544] ahci 0000:00:0a.0: version 3.0
[    0.360544] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.360544] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23=
=20
(level, low) -> IRQ 23
[    1.378226] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f=20
impl SATA mode
[    1.378226] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio
[    1.378226] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.378227] scsi0 : ahci
[    1.378238] scsi1 : ahci
[    1.378247] scsi2 : ahci
[    1.378257] scsi3 : ahci
[    1.378264] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc10=
0=20
irq 23
[    1.378264] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc18=
0=20
irq 23
[    1.378264] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc20=
0=20
irq 23
[    1.378264] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc28=
0=20
irq 23
[    1.501537] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.502030] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.502030] ata1.00: 312581808 sectors, multi 16: LBA48
[    1.502569] ata1.00: configured for UDMA/133
[    1.821226] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.841716] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.841716] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.843630] ata2.00: configured for UDMA/133
[    2.160921] ata3: SATA link down (SStatus 0 SControl 300)
[    2.480790] ata4: SATA link down (SStatus 0 SControl 300)
[    2.678264] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10=
=2E0=20
PQ: 0 ANSI: 5
[    2.678278] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.678278] sd 0:0:0:0: [sda] Write Protect is off
[    2.678278] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.678278] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.678278] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.678278] sd 0:0:0:0: [sda] Write Protect is off
[    2.678278] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.678278] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.678278]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.510704] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.510715] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.510721] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR=
10=20
PQ: 0 ANSI: 5
[    2.510728] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.510728] sd 1:0:0:0: [sdb] Write Protect is off
[    2.510728] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.510728] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.510728] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.510728] sd 1:0:0:0: [sdb] Write Protect is off
[    2.510728] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.510728] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.510728]  sdb: sdb1 sdb2
[    2.520253] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.520263] sd 1:0:0:0: Attached scsi generic sg1 type 0

with AHCI and msi enabled:=20
hang, no disks found, like usual.

with NON-RAID + pci=3Dnomsi:
[    0.363843] Driver 'sd' needs updating - please use bus_type methods
[    0.363857] ahci 0000:00:0a.0: version 3.0
[    0.363857] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.363857] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23=
=20
(level, low) -> IRQ 23
[    1.367189] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f=20
impl IDE mode
[    1.367189] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio
[    1.367189] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.367191] scsi0 : ahci
[    1.367201] scsi1 : ahci
[    1.367210] scsi2 : ahci
[    1.367220] scsi3 : ahci
[    1.367226] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc10=
0=20
irq 23
[    1.367226] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc18=
0=20
irq 23
[    1.367226] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc20=
0=20
irq 23
[    1.367226] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc28=
0=20
irq 23
[    1.489044] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.489540] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.489540] ata1.00: 312581808 sectors, multi 16: LBA48
[    1.490087] ata1.00: configured for UDMA/133
[    1.808738] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.829236] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.829236] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.831155] ata2.00: configured for UDMA/133
[    2.148423] ata3: SATA link down (SStatus 0 SControl 300)
[    2.468291] ata4: SATA link down (SStatus 0 SControl 300)
[    2.667219] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10=
=2E0=20
PQ: 0 ANSI: 5
[    2.667232] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.667232] sd 0:0:0:0: [sda] Write Protect is off
[    2.667232] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.667232] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.667232] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.667232] sd 0:0:0:0: [sda] Write Protect is off
[    2.667232] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.667232] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.667232]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.504269] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.504280] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.504286] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR=
10=20
PQ: 0 ANSI: 5
[    2.504293] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.504293] sd 1:0:0:0: [sdb] Write Protect is off
[    2.504293] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.504293] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.504293] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.504293] sd 1:0:0:0: [sdb] Write Protect is off
[    2.504293] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.504293] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.504293]  sdb: sdb1 sdb2
[    2.564438] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.564448] sd 1:0:0:0: Attached scsi generic sg1 type 0

with NON-RAID + msi:
[    0.357204] Driver 'sd' needs updating - please use bus_type methods
[    0.357218] ahci 0000:00:0a.0: version 3.0
[    0.357218] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.357218] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23=
=20
(level, low) -> IRQ 23
[    1.360550] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f=20
impl IDE mode
[    1.360550] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio
[    1.360550] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.360552] scsi0 : ahci
[    1.360562] scsi1 : ahci
[    1.360572] scsi2 : ahci
[    1.360581] scsi3 : ahci
[    1.360589] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc10=
0=20
irq 315
[    1.360589] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc18=
0=20
irq 315
[    1.360589] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc20=
0=20
irq 315
[    1.360589] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc28=
0=20
irq 315
[    1.478990] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.479483] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.479483] ata1.00: 312581808 sectors, multi 16: LBA48
[    1.480030] ata1.00: configured for UDMA/133
[    1.798679] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.815646] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.815646] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.817568] ata2.00: configured for UDMA/133
[    2.135041] ata3: SATA link down (SStatus 0 SControl 300)
[    2.454910] ata4: SATA link down (SStatus 0 SControl 300)
[    2.657257] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10=
=2E0=20
PQ: 0 ANSI: 5
[    2.657270] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.657270] sd 0:0:0:0: [sda] Write Protect is off
[    2.657270] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.657270] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.657270] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2=20
MB)
[    2.657270] sd 0:0:0:0: [sda] Write Protect is off
[    2.657270] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.657270] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.657270]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.489404] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.489464] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.489598] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR=
10=20
PQ: 0 ANSI: 5
[    2.489730] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.489779] sd 1:0:0:0: [sdb] Write Protect is off
[    2.489817] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.489832] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.489910] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8=20
MB)
[    2.489956] sd 1:0:0:0: [sdb] Write Protect is off
[    2.489994] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.490008] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
=20
doesn't support DPO or FUA
[    2.490057]  sdb: sdb1 sdb2
[    2.521193] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.521203] sd 1:0:0:0: Attached scsi generic sg1 type 0

all three 'working' setups booted without any delay (but it were only reboo=
ts,=20
no cold boots).

complete dmesgs are attached.

Btw, when I edit the grub boot prompt, crap was/is attached. That crap show=
s=20
up in the non-raid+msi dmesg. And it made the kernel panic on reboot. Apart=
=20
from that it doesn't seem to have any influence.=20

Reiser4 was not patched in.

Gl=FCck Auf,
Volker

--Boundary-00=_WSUEIO4e3u1bMqx
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg_libata-dev_ahci_nomsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_libata-dev_ahci_nomsi"

[    0.000000] Linux version 2.6.25libata-dev-01060-g48feb3c-dirty (root@energy) (gcc version 4.2.3 (Gentoo 4.2.3 p1.0)) #1 SMP Fri Apr 25 04:11:13 CEST 2008
[    0.000000] Command line: pci=nomsi root=/dev/sda3 nmi_watchdog=0 console=tty6
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffb0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffb0000 - 00000000cffc0000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffc0000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of 256 used
[    0.000000] end_pfn_map = 1245184
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F98F0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT CFFB0000, 003C (r1 A M I  OEMRSDT   1000822 MSFT       97)
[    0.000000] ACPI: FACP CFFB0200, 0084 (r2 A_M_I  OEMFACP  12000601 MSFT       97)
[    0.000000] ACPI: DSDT CFFB0450, 4FFA (r1  ASR19 ASR19192      192 INTL 20051117)
[    0.000000] ACPI: FACS CFFC0000, 0040
[    0.000000] ACPI: APIC CFFB0390, 0080 (r1 A M I  OEMAPIC   1000822 MSFT       97)
[    0.000000] ACPI: MCFG CFFB0410, 003C (r1 A M I  OEMMCFG   1000822 MSFT       97)
[    0.000000] ACPI: OEMB CFFC0040, 0060 (r1 A M I  AMI_OEM   1000822 MSFT       97)
[    0.000000] ACPI: HPET CFFB5450, 0038 (r1 A M I  OEMHPET0  1000822 MSFT       97)
[    0.000000] ACPI: SSDT CFFB5490, 030E (r1 A M I  POWERNOW        1 AMD         1)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of 256 used
[    0.000000] early res: 0 [0-fff] BIOS data page
[    0.000000] early res: 1 [6000-7fff] SMP_TRAMPOLINE
[    0.000000] early res: 2 [200000-546213] TEXT DATA BSS
[    0.000000] early res: 3 [9fc00-a0bff] EBDA
[    0.000000] early res: 4 [8000-dfff] PGTABLE
[    0.000000] No mptable found.
[    0.000000]  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
[    0.000000]  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
[    0.000000]  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
[    0.000000]  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
[    0.000000]  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 on node 0
[    0.000000]  [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 on node 0
[    0.000000]  [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 on node 0
[    0.000000]  [ffffe20000e00000-ffffe20000ffffff] PMD ->ffff810002e00000 on node 0
[    0.000000]  [ffffe20001000000-ffffe200011fffff] PMD ->ffff810003200000 on node 0
[    0.000000]  [ffffe20001200000-ffffe200013fffff] PMD ->ffff810003600000 on node 0
[    0.000000]  [ffffe20001400000-ffffe200015fffff] PMD ->ffff810003a00000 on node 0
[    0.000000]  [ffffe20001600000-ffffe200017fffff] PMD ->ffff810003e00000 on node 0
[    0.000000]  [ffffe20001800000-ffffe200019fffff] PMD ->ffff810004200000 on node 0
[    0.000000]  [ffffe20001a00000-ffffe20001bfffff] PMD ->ffff810004600000 on node 0
[    0.000000]  [ffffe20001c00000-ffffe20001dfffff] PMD ->ffff810004a00000 on node 0
[    0.000000]  [ffffe20001e00000-ffffe20001ffffff] PMD ->ffff810004e00000 on node 0
[    0.000000]  [ffffe20002000000-ffffe200021fffff] PMD ->ffff810005200000 on node 0
[    0.000000]  [ffffe20002200000-ffffe200023fffff] PMD ->ffff810005600000 on node 0
[    0.000000]  [ffffe20002400000-ffffe200025fffff] PMD ->ffff810005a00000 on node 0
[    0.000000]  [ffffe20002600000-ffffe200027fffff] PMD ->ffff810005e00000 on node 0
[    0.000000]  [ffffe20002800000-ffffe200029fffff] PMD ->ffff810006200000 on node 0
[    0.000000]  [ffffe20002a00000-ffffe20002bfffff] PMD ->ffff810006600000 on node 0
[    0.000000]  [ffffe20002c00000-ffffe20002dfffff] PMD ->ffff810006a00000 on node 0
[    0.000000]  [ffffe20002e00000-ffffe20002ffffff] PMD ->ffff810006e00000 on node 0
[    0.000000]  [ffffe20003000000-ffffe200031fffff] PMD ->ffff810007200000 on node 0
[    0.000000]  [ffffe20003200000-ffffe200033fffff] PMD ->ffff810007600000 on node 0
[    0.000000]  [ffffe20003400000-ffffe200035fffff] PMD ->ffff810007a00000 on node 0
[    0.000000]  [ffffe20003600000-ffffe200037fffff] PMD ->ffff810007e00000 on node 0
[    0.000000]  [ffffe20003800000-ffffe200039fffff] PMD ->ffff810008200000 on node 0
[    0.000000]  [ffffe20003a00000-ffffe20003bfffff] PMD ->ffff810008600000 on node 0
[    0.000000]  [ffffe20003c00000-ffffe20003dfffff] PMD ->ffff810008a00000 on node 0
[    0.000000]  [ffffe20003e00000-ffffe20003ffffff] PMD ->ffff810008e00000 on node 0
[    0.000000]  [ffffe20004000000-ffffe200041fffff] PMD ->ffff810009200000 on node 0
[    0.000000]  [ffffe20004200000-ffffe200043fffff] PMD ->ffff810009600000 on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   851888
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] On node 0 totalpages: 1048399
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 848 pages reserved
[    0.000000]   DMA zone: 3095 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833512 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Detected use of extended apic ids on hypertransport bus
[    0.000000] ACPI: PM-Timer IO Port: 0x2008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cffb0000 - 00000000cffc0000
[    0.000000] PM: Registered nosave memory: 00000000cffc0000 - 00000000cfff0000
[    0.000000] PM: Registered nosave memory: 00000000cfff0000 - 00000000d0000000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fef00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000000ff380000
[    0.000000] PM: Registered nosave memory: 00000000ff380000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d4000000 (gap: d0000000:2ec00000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 32584 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1030527
[    0.000000] Kernel command line: pci=nomsi root=/dev/sda3 nmi_watchdog=0 console=tty6
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[    0.000002] time.c: Detected 3013.874 MHz processor.
[    0.000011] spurious 8259A interrupt: IRQ7.
[    0.003333] Console: colour VGA+ 80x25
[    0.003333] console [tty6] enabled
[    0.003333] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003333] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.003333] Checking aperture...
[    0.003333] Node 0: aperture @ c000000 size 32 MB
[    0.003333] Aperture pointing to e820 RAM. Ignoring.
[    0.003333] No AGP bridge found
[    0.003333] Your BIOS doesn't leave a aperture memory hole
[    0.003333] Please enable the IOMMU option in the BIOS setup
[    0.003333] This costs you 64 MB of RAM
[    0.003333] Mapping aperture over 65536 KB of RAM @ c000000
[    0.003333] PM: Registered nosave memory: 000000000c000000 - 0000000010000000
[    0.003333] Memory: 4047784k/4980736k available (1974k kernel code, 145104k reserved, 860k data, 192k init)
[    0.003333] CPA: page pool initialized 1 of 1 pages preallocated
[    0.003333] SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[    0.003333] hpet clockevent registered
[    0.083330] Calibrating delay using timer specific routine.. 6034.71 BogoMIPS (lpj=10053943)
[    0.083419] Mount-cache hash table entries: 256
[    0.083536] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.083576] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.083614] CPU: Physical Processor ID: 0
[    0.083650] CPU: Processor Core ID: 0
[    0.083699] ACPI: Core revision 20070126
[    0.122333] Using local APIC timer interrupts.
[    0.123326] APIC timer calibration result 12557810
[    0.123327] Detected 12.557 MHz APIC timer.
[    0.123431] Booting processor 1/2 APIC 0x1
[    0.003333] Initializing CPU#1
[    0.003333] Calibrating delay using timer specific routine.. 6030.96 BogoMIPS (lpj=10046336)
[    0.003333] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.003333] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.003333] CPU: Physical Processor ID: 0
[    0.003333] CPU: Processor Core ID: 1
[    0.003333] AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ stepping 03
[    0.216846] Brought up 2 CPUs
[    0.217292] net_namespace: 296 bytes
[    0.217411] NET: Registered protocol family 16
[    0.217506] No dock devices found.
[    0.217568] ACPI: bus type pci registered
[    0.217644] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.217683] PCI: Not using MMCONFIG.
[    0.217719] PCI: Using configuration type 1
[    0.220781] ACPI: EC: Look up EC in DSDT
[    0.225043] ACPI: Interpreter enabled
[    0.225080] ACPI: (supports S0 S1 S3 S4 S5)
[    0.225251] ACPI: Using IOAPIC for interrupt routing
[    0.225425] ACPI: Error attaching device data
[    0.225465] ACPI: Error attaching device data
[    0.225505] ACPI: Error attaching device data
[    0.225545] ACPI: Error attaching device data
[    0.231206] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.231721] PCI: Transparent bridge - 0000:00:08.0
[    0.231972] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.232119] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.232229] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR10._PRT]
[    0.232293] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.232362] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR13._PRT]
[    0.232430] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.236981] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *11
[    0.237343] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *5
[    0.237702] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
[    0.238087] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
[    0.238473] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disabled.
[    0.238858] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.239218] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disabled.
[    0.239604] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *10
[    0.240080] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *5
[    0.240439] ACPI: PCI Interrupt Link [LMAD] (IRQs 20 21 22 23) *0, disabled.
[    0.240827] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *7
[    0.241187] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
[    0.241574] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *0, disabled.
[    0.241960] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[    0.242320] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disabled.
[    0.242706] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.243067] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *0, disabled.
[    0.243488] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
[    0.243875] ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *0, disabled.
[    0.244261] ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *0, disabled.
[    0.244588] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.244636] pnp: PnP ACPI init
[    0.244674] ACPI: bus type pnp registered
[    0.247828] pnp: PnP ACPI: found 13 devices
[    0.247865] ACPI: ACPI bus type pnp unregistered
[    0.247968] SCSI subsystem initialized
[    0.248040] libata version 3.00 loaded.
[    0.248079] usbcore: registered new interface driver usbfs
[    0.248129] usbcore: registered new interface driver hub
[    0.248184] usbcore: registered new device driver usb
[    0.248263] PCI: Using ACPI for IRQ routing
[    0.248301] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.266649] PCI-DMA: Disabling AGP.
[    0.266649] PCI-DMA: aperture base @ c000000 size 65536 KB
[    0.266649] PCI-DMA: using GART IOMMU.
[    0.266649] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.266649] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.266649] hpet0: 3 32-bit timers, 25000000 Hz
[    0.266659] Switched to high resolution mode on CPU 0
[    0.060448] Switched to high resolution mode on CPU 1
[    0.280020] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[    0.280020] system 00:05: ioport range 0x800-0x80f has been reserved
[    0.280020] system 00:05: ioport range 0x2000-0x207f has been reserved
[    0.280020] system 00:05: ioport range 0x2080-0x20ff has been reserved
[    0.280020] system 00:05: ioport range 0x2400-0x247f has been reserved
[    0.280020] system 00:05: ioport range 0x2480-0x24ff has been reserved
[    0.280020] system 00:05: ioport range 0x2800-0x287f has been reserved
[    0.280020] system 00:05: ioport range 0x2880-0x28ff has been reserved
[    0.280022] system 00:05: ioport range 0x2c00-0x2c7f has been reserved
[    0.280062] system 00:05: ioport range 0x2c80-0x2cff has been reserved
[    0.280102] system 00:05: iomem range 0x0-0x0 could not be reserved
[    0.280142] system 00:05: iomem range 0xfee01000-0xfeefffff has been reserved
[    0.280186] system 00:07: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.280234] system 00:07: iomem range 0xfee00000-0xfee00fff could not be reserved
[    0.280286] system 00:0a: ioport range 0x290-0x29f has been reserved
[    0.280328] system 00:0b: iomem range 0xe0000000-0xefffffff has been reserved
[    0.280372] system 00:0c: iomem range 0x0-0x9ffff could not be reserved
[    0.280411] system 00:0c: iomem range 0xc0000-0xcffff has been reserved
[    0.280451] system 00:0c: iomem range 0xe0000-0xfffff could not be reserved
[    0.280492] system 00:0c: iomem range 0x100000-0xcfffffff could not be reserved
[    0.280540] system 00:0c: iomem range 0xff380000-0xffffffff could not be reserved
[    0.280991] PCI: Bridge: 0000:00:08.0
[    0.281028]   IO window: d000-dfff
[    0.281066]   MEM window: 0xf9f00000-0xf9ffffff
[    0.281104]   PREFETCH window: 0x00000000f0000000-0x00000000f00fffff
[    0.281145] PCI: Bridge: 0000:00:0b.0
[    0.281181]   IO window: c000-cfff
[    0.281218]   MEM window: 0xf9e00000-0xf9efffff
[    0.281256]   PREFETCH window: disabled.
[    0.281293] PCI: Bridge: 0000:00:0c.0
[    0.281330]   IO window: disabled.
[    0.281366]   MEM window: disabled.
[    0.281403]   PREFETCH window: disabled.
[    0.281441] PCI: Bridge: 0000:00:0d.0
[    0.281477]   IO window: e000-efff
[    0.281514]   MEM window: 0xfa000000-0xfebfffff
[    0.281552]   PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
[    0.281592] PCI: Bridge: 0000:00:0e.0
[    0.281628]   IO window: disabled.
[    0.281665]   MEM window: disabled.
[    0.281701]   PREFETCH window: disabled.
[    0.281744] PCI: Setting latency timer of device 0000:00:08.0 to 64
[    0.281753] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.281758] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.281763] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.281768] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.281775] NET: Registered protocol family 2
[    0.316685] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.316685] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.316685] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.316685] TCP: Hash tables configured (established 262144 bind 65536)
[    0.316685] TCP reno registered
[    0.327001] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    0.327001] io scheduler noop registered
[    0.327001] io scheduler cfq registered (default)
[    0.327001] pci 0000:00:00.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:08.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:0a.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:0b.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:0c.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:0d.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:00:0e.0: Enabling HT MSI Mapping
[    0.327001] pci 0000:04:00.0: Boot video device
[    0.327009] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.327009] assign_interrupt_mode Found MSI capability
[    0.327009] Allocate Port Service[0000:00:0b.0:pcie00]
[    0.327017] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.327017] assign_interrupt_mode Found MSI capability
[    0.327017] Allocate Port Service[0000:00:0c.0:pcie00]
[    0.327024] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.327024] assign_interrupt_mode Found MSI capability
[    0.327024] Allocate Port Service[0000:00:0d.0:pcie00]
[    0.327031] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.327031] assign_interrupt_mode Found MSI capability
[    0.327031] Allocate Port Service[0000:00:0e.0:pcie00]
[    0.327073] input: Power Button (FF) as /class/input/input0
[    0.327073] ACPI: Power Button (FF) [PWRF]
[    0.327080] input: Power Button (CM) as /class/input/input1
[    0.327080] ACPI: Power Button (CM) [PWRB]
[    0.327115] ACPI: ACPI0007:00 is registered as cooling_device0
[    0.327122] ACPI: ACPI0007:01 is registered as cooling_device1
[    0.360497] Real Time Clock Driver v1.12ac
[    0.360501] hpet_resources: 0xfed00000 is busy
[    0.360509] Linux agpgart interface v0.103
[    0.360530] Driver 'sd' needs updating - please use bus_type methods
[    0.360544] ahci 0000:00:0a.0: version 3.0
[    0.360544] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.360544] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 23
[    1.378226] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    1.378226] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio 
[    1.378226] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.378227] scsi0 : ahci
[    1.378238] scsi1 : ahci
[    1.378247] scsi2 : ahci
[    1.378257] scsi3 : ahci
[    1.378264] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc100 irq 23
[    1.378264] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc180 irq 23
[    1.378264] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc200 irq 23
[    1.378264] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc280 irq 23
[    1.501537] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.502030] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.502030] ata1.00: 312581808 sectors, multi 16: LBA48 
[    1.502569] ata1.00: configured for UDMA/133
[    1.821226] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.841716] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.841716] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.843630] ata2.00: configured for UDMA/133
[    2.160921] ata3: SATA link down (SStatus 0 SControl 300)
[    2.480790] ata4: SATA link down (SStatus 0 SControl 300)
[    2.678264] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10.0 PQ: 0 ANSI: 5
[    2.678278] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    2.678278] sd 0:0:0:0: [sda] Write Protect is off
[    2.678278] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.678278] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.678278] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    2.678278] sd 0:0:0:0: [sda] Write Protect is off
[    2.678278] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.678278] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.678278]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.510704] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.510715] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.510721] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
[    2.510728] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
[    2.510728] sd 1:0:0:0: [sdb] Write Protect is off
[    2.510728] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.510728] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.510728] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
[    2.510728] sd 1:0:0:0: [sdb] Write Protect is off
[    2.510728] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.510728] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.510728]  sdb: sdb1 sdb2
[    2.520253] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.520263] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.520277] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.522965] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.523005] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.556954] usbcore: registered new interface driver usbhid
[    2.556954] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    2.556954] TCP cubic registered
[    2.556954] NET: Registered protocol family 1
[    2.556959] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ processors (2 cpu cores) (version 2.20.00)
[    2.750069] powernow-k8:    0 : fid 0x16 (3000 MHz), vid 0x6
[    2.750069] powernow-k8:    1 : fid 0x14 (2800 MHz), vid 0x8
[    2.750069] powernow-k8:    2 : fid 0x12 (2600 MHz), vid 0xa
[    2.750069] powernow-k8:    3 : fid 0x10 (2400 MHz), vid 0xc
[    2.750069] powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xe
[    2.750069] powernow-k8:    5 : fid 0xc (2000 MHz), vid 0x10
[    2.750069] powernow-k8:    6 : fid 0xa (1800 MHz), vid 0x10
[    2.750069] powernow-k8:    7 : fid 0x2 (1000 MHz), vid 0x12
[    2.587054] input: AT Translated Set 2 keyboard as /class/input/input2
[    2.680916] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[    2.680934] ReiserFS: sda3: using ordered data mode
[    2.692512] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[    2.692512] ReiserFS: sda3: checking transaction log (sda3)
[    2.736122] ReiserFS: sda3: Using r5 hash to sort names
[    2.736122] VFS: Mounted root (reiserfs filesystem) readonly.
[    2.736122] Freeing unused kernel memory: 192k freed
[    2.966745] Clocksource tsc unstable (delta = -168646404 ns)
[    6.926935] r8169 Gigabit Ethernet driver 2.2LK loaded
[    6.927168] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 19
[    6.927173] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNEB] -> GSI 19 (level, low) -> IRQ 19
[    6.927181] PCI: Setting latency timer of device 0000:01:00.0 to 64
[    6.927190] r8169 0000:01:00.0: no MSI. Back to INTx.
[    6.927336] eth0: RTL8168b/8111b at 0xffffc20000170000, 00:19:66:47:f3:cb, XID 38000000 IRQ 19
[    6.964819] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[    6.964824] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUB2] -> GSI 22 (level, low) -> IRQ 22
[    6.964832] PCI: Setting latency timer of device 0000:00:02.1 to 64
[    6.964833] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    6.964926] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
[    6.964948] ehci_hcd 0000:00:02.1: debug port 1
[    6.964951] PCI: cache line size of 64 is not supported by device 0000:00:02.1
[    6.964958] ehci_hcd 0000:00:02.1: irq 22, io mem 0xf9dfec00
[    6.977281] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    6.977355] usb usb1: configuration #1 chosen from 1 choice
[    6.977371] hub 1-0:1.0: USB hub found
[    6.977376] hub 1-0:1.0: 10 ports detected
[    7.352941] usb 1-3: new high speed USB device using ehci_hcd and address 2
[    7.485015] usb 1-3: configuration #1 chosen from 1 choice
[    7.485059] hub 1-3:1.0: USB hub found
[    7.485231] hub 1-3:1.0: 4 ports detected
[    7.795352] usb 1-3.1: new low speed USB device using ehci_hcd and address 3
[    7.889504] usb 1-3.1: configuration #1 chosen from 1 choice
[    7.900591] input: Logitech USB Receiver as /class/input/input3
[    7.918729] input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:02.1-3.1
[    7.924769] input: Logitech USB Receiver as /class/input/input4
[    7.966096] input: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:02.1-3.1
[    8.062097] mice: PS/2 mouse device common for all mice
[    9.673213] ReiserFS: sda3: switching to journaled data mode
[    9.965499] Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1 across:1951888k
[   10.942836] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 18
[   10.942841] ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKB] -> GSI 18 (level, low) -> IRQ 18
[   10.946147] Audigy2 value: Special config.
[   10.995908] r8169: eth0: link up
[   10.995908] r8169: eth0: link up
[   12.146961] i2c /dev entries driver
[   11.971803] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x2d00
[   11.971829] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x2e00
[   12.269028] w83627ehf: Found W83627EHG chip at 0x290

--Boundary-00=_WSUEIO4e3u1bMqx
Content-Type: application/octet-stream;
  name="dmesg_libata-dev_non_raid_msi"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_libata-dev_non_raid_msi"

[    0.000000] Linux version 2.6.25libata-dev-01060-g48feb3c-dirty (root@en=
ergy) (gcc version 4.2.3 (Gentoo 4.2.3 p1.0)) #1 SMP Fri Apr 25 04:11:13 CE=
ST 2008
[    0.000000] Command line: root=3D/dev/sda3 nmi_watchdog=3D0 console=3Dtt=
y69=CDL=0FM=C0H=0FN=CD=E8=88=F0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffb0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffb0000 - 00000000cffc0000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffc0000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 u=
sed
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of =
256 used
[    0.000000] end_pfn_map =3D 1245184
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F98F0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT CFFB0000, 003C (r1 A M I  OEMRSDT   1000822 MSFT =
      97)
[    0.000000] ACPI: FACP CFFB0200, 0084 (r2 A_M_I  OEMFACP  12000601 MSFT =
      97)
[    0.000000] ACPI: DSDT CFFB0450, 4FFA (r1  ASR19 ASR19192      192 INTL =
20051117)
[    0.000000] ACPI: FACS CFFC0000, 0040
[    0.000000] ACPI: APIC CFFB0390, 0080 (r1 A M I  OEMAPIC   1000822 MSFT =
      97)
[    0.000000] ACPI: MCFG CFFB0410, 003C (r1 A M I  OEMMCFG   1000822 MSFT =
      97)
[    0.000000] ACPI: OEMB CFFC0040, 0060 (r1 A M I  AMI_OEM   1000822 MSFT =
      97)
[    0.000000] ACPI: HPET CFFB5450, 0038 (r1 A M I  OEMHPET0  1000822 MSFT =
      97)
[    0.000000] ACPI: SSDT CFFB5490, 030E (r1 A M I  POWERNOW        1 AMD  =
       1)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 u=
sed
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of =
256 used
[    0.000000] early res: 0 [0-fff] BIOS data page
[    0.000000] early res: 1 [6000-7fff] SMP_TRAMPOLINE
[    0.000000] early res: 2 [200000-546213] TEXT DATA BSS
[    0.000000] early res: 3 [9fc00-a0bff] EBDA
[    0.000000] early res: 4 [8000-dfff] PGTABLE
[    0.000000] No mptable found.
[    0.000000]  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 =
on node 0
[    0.000000]  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 =
on node 0
[    0.000000]  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 =
on node 0
[    0.000000]  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 =
on node 0
[    0.000000]  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 =
on node 0
[    0.000000]  [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 =
on node 0
[    0.000000]  [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 =
on node 0
[    0.000000]  [ffffe20000e00000-ffffe20000ffffff] PMD ->ffff810002e00000 =
on node 0
[    0.000000]  [ffffe20001000000-ffffe200011fffff] PMD ->ffff810003200000 =
on node 0
[    0.000000]  [ffffe20001200000-ffffe200013fffff] PMD ->ffff810003600000 =
on node 0
[    0.000000]  [ffffe20001400000-ffffe200015fffff] PMD ->ffff810003a00000 =
on node 0
[    0.000000]  [ffffe20001600000-ffffe200017fffff] PMD ->ffff810003e00000 =
on node 0
[    0.000000]  [ffffe20001800000-ffffe200019fffff] PMD ->ffff810004200000 =
on node 0
[    0.000000]  [ffffe20001a00000-ffffe20001bfffff] PMD ->ffff810004600000 =
on node 0
[    0.000000]  [ffffe20001c00000-ffffe20001dfffff] PMD ->ffff810004a00000 =
on node 0
[    0.000000]  [ffffe20001e00000-ffffe20001ffffff] PMD ->ffff810004e00000 =
on node 0
[    0.000000]  [ffffe20002000000-ffffe200021fffff] PMD ->ffff810005200000 =
on node 0
[    0.000000]  [ffffe20002200000-ffffe200023fffff] PMD ->ffff810005600000 =
on node 0
[    0.000000]  [ffffe20002400000-ffffe200025fffff] PMD ->ffff810005a00000 =
on node 0
[    0.000000]  [ffffe20002600000-ffffe200027fffff] PMD ->ffff810005e00000 =
on node 0
[    0.000000]  [ffffe20002800000-ffffe200029fffff] PMD ->ffff810006200000 =
on node 0
[    0.000000]  [ffffe20002a00000-ffffe20002bfffff] PMD ->ffff810006600000 =
on node 0
[    0.000000]  [ffffe20002c00000-ffffe20002dfffff] PMD ->ffff810006a00000 =
on node 0
[    0.000000]  [ffffe20002e00000-ffffe20002ffffff] PMD ->ffff810006e00000 =
on node 0
[    0.000000]  [ffffe20003000000-ffffe200031fffff] PMD ->ffff810007200000 =
on node 0
[    0.000000]  [ffffe20003200000-ffffe200033fffff] PMD ->ffff810007600000 =
on node 0
[    0.000000]  [ffffe20003400000-ffffe200035fffff] PMD ->ffff810007a00000 =
on node 0
[    0.000000]  [ffffe20003600000-ffffe200037fffff] PMD ->ffff810007e00000 =
on node 0
[    0.000000]  [ffffe20003800000-ffffe200039fffff] PMD ->ffff810008200000 =
on node 0
[    0.000000]  [ffffe20003a00000-ffffe20003bfffff] PMD ->ffff810008600000 =
on node 0
[    0.000000]  [ffffe20003c00000-ffffe20003dfffff] PMD ->ffff810008a00000 =
on node 0
[    0.000000]  [ffffe20003e00000-ffffe20003ffffff] PMD ->ffff810008e00000 =
on node 0
[    0.000000]  [ffffe20004000000-ffffe200041fffff] PMD ->ffff810009200000 =
on node 0
[    0.000000]  [ffffe20004200000-ffffe200043fffff] PMD ->ffff810009600000 =
on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   851888
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] On node 0 totalpages: 1048399
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 848 pages reserved
[    0.000000]   DMA zone: 3095 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833512 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Detected use of extended apic ids on hypertransport bus
[    0.000000] ACPI: PM-Timer IO Port: 0x2008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000cffb0000 - 00000000cff=
c0000
[    0.000000] PM: Registered nosave memory: 00000000cffc0000 - 00000000cff=
f0000
[    0.000000] PM: Registered nosave memory: 00000000cfff0000 - 00000000d00=
00000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000000ff3=
80000
[    0.000000] PM: Registered nosave memory: 00000000ff380000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at d4000000 (gap: d0000000=
:2ec00000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 32584 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 1030527
[    0.000000] Kernel command line: root=3D/dev/sda3 nmi_watchdog=3D0 conso=
le=3Dtty69=CDL=0FM=C0H=0FN=CD=E8=88=F0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[    0.000002] time.c: Detected 3013.883 MHz processor.
[    0.000011] spurious 8259A interrupt: IRQ7.
[    0.003333] Console: colour VGA+ 80x25
[    0.003333] console [tty69] enabled
[    0.003333] Dentry cache hash table entries: 524288 (order: 10, 4194304 =
bytes)
[    0.003333] Inode-cache hash table entries: 262144 (order: 9, 2097152 by=
tes)
[    0.003333] Checking aperture...
[    0.003333] Node 0: aperture @ c000000 size 32 MB
[    0.003333] Aperture pointing to e820 RAM. Ignoring.
[    0.003333] No AGP bridge found
[    0.003333] Your BIOS doesn't leave a aperture memory hole
[    0.003333] Please enable the IOMMU option in the BIOS setup
[    0.003333] This costs you 64 MB of RAM
[    0.003333] Mapping aperture over 65536 KB of RAM @ c000000
[    0.003333] PM: Registered nosave memory: 000000000c000000 - 00000000100=
00000
[    0.003333] Memory: 4047784k/4980736k available (1974k kernel code, 1451=
04k reserved, 860k data, 192k init)
[    0.003333] CPA: page pool initialized 1 of 1 pages preallocated
[    0.003333] SLUB: Genslabs=3D12, HWalign=3D64, Order=3D0-1, MinObjects=
=3D4, CPUs=3D2, Nodes=3D1
[    0.003333] hpet clockevent registered
[    0.083330] Calibrating delay using timer specific routine.. 6034.70 Bog=
oMIPS (lpj=3D10053927)
[    0.083419] Mount-cache hash table entries: 256
[    0.083536] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.083576] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.083614] CPU: Physical Processor ID: 0
[    0.083650] CPU: Processor Core ID: 0
[    0.083699] ACPI: Core revision 20070126
[    0.122334] Using local APIC timer interrupts.
[    0.123326] APIC timer calibration result 12557848
[    0.123327] Detected 12.557 MHz APIC timer.
[    0.123430] Booting processor 1/2 APIC 0x1
[    0.003333] Initializing CPU#1
[    0.003333] Calibrating delay using timer specific routine.. 6030.95 Bog=
oMIPS (lpj=3D10046333)
[    0.003333] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.003333] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.003333] CPU: Physical Processor ID: 0
[    0.003333] CPU: Processor Core ID: 1
[    0.003333] AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ stepping 03
[    0.216846] Brought up 2 CPUs
[    0.217291] net_namespace: 296 bytes
[    0.217410] NET: Registered protocol family 16
[    0.217505] No dock devices found.
[    0.217567] ACPI: bus type pci registered
[    0.217643] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.217682] PCI: Not using MMCONFIG.
[    0.217718] PCI: Using configuration type 1
[    0.220779] ACPI: EC: Look up EC in DSDT
[    0.225041] ACPI: Interpreter enabled
[    0.225078] ACPI: (supports S0 S1 S3 S4 S5)
[    0.225249] ACPI: Using IOAPIC for interrupt routing
[    0.225422] ACPI: Error attaching device data
[    0.225462] ACPI: Error attaching device data
[    0.225502] ACPI: Error attaching device data
[    0.225542] ACPI: Error attaching device data
[    0.231204] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.231718] PCI: Transparent bridge - 0000:00:08.0
[    0.231970] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.232117] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.232227] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR10._PRT]
[    0.232291] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.232359] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR13._PRT]
[    0.232427] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.236980] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *11
[    0.237341] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *5
[    0.237700] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238084] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238469] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238853] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.239213] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.239597] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *10
[    0.240072] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *5
[    0.240431] ACPI: PCI Interrupt Link [LMAD] (IRQs 20 21 22 23) *0, disab=
led.
[    0.240819] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *7
[    0.241178] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disab=
led.
[    0.241564] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.241949] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[    0.242309] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.242695] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.243055] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *0, disab=
led.
[    0.243475] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.243862] ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *0, disab=
led.
[    0.244248] ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *0, disab=
led.
[    0.244574] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.244621] pnp: PnP ACPI init
[    0.244660] ACPI: bus type pnp registered
[    0.249983] pnp: PnP ACPI: found 13 devices
[    0.249983] ACPI: ACPI bus type pnp unregistered
[    0.249983] SCSI subsystem initialized
[    0.249983] libata version 3.00 loaded.
[    0.249983] usbcore: registered new interface driver usbfs
[    0.249983] usbcore: registered new interface driver hub
[    0.249983] usbcore: registered new device driver usb
[    0.249983] PCI: Using ACPI for IRQ routing
[    0.249983] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =
helps, post a report
[    0.266664] PCI-DMA: Disabling AGP.
[    0.266664] PCI-DMA: aperture base @ c000000 size 65536 KB
[    0.266664] PCI-DMA: using GART IOMMU.
[    0.266664] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.266664] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.266664] hpet0: 3 32-bit timers, 25000000 Hz
[    0.266674] Switched to high resolution mode on CPU 0
[    0.057117] Switched to high resolution mode on CPU 1
[    0.276702] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[    0.276702] system 00:05: ioport range 0x800-0x80f has been reserved
[    0.276702] system 00:05: ioport range 0x2000-0x207f has been reserved
[    0.276702] system 00:05: ioport range 0x2080-0x20ff has been reserved
[    0.276702] system 00:05: ioport range 0x2400-0x247f has been reserved
[    0.276702] system 00:05: ioport range 0x2480-0x24ff has been reserved
[    0.276702] system 00:05: ioport range 0x2800-0x287f has been reserved
[    0.276702] system 00:05: ioport range 0x2880-0x28ff has been reserved
[    0.276702] system 00:05: ioport range 0x2c00-0x2c7f has been reserved
[    0.276705] system 00:05: ioport range 0x2c80-0x2cff has been reserved
[    0.276745] system 00:05: iomem range 0x0-0x0 could not be reserved
[    0.276785] system 00:05: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.276829] system 00:07: iomem range 0xfec00000-0xfec00fff could not be=
 reserved
[    0.276876] system 00:07: iomem range 0xfee00000-0xfee00fff could not be=
 reserved
[    0.276928] system 00:0a: ioport range 0x290-0x29f has been reserved
[    0.276971] system 00:0b: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.277014] system 00:0c: iomem range 0x0-0x9ffff could not be reserved
[    0.277053] system 00:0c: iomem range 0xc0000-0xcffff has been reserved
[    0.277093] system 00:0c: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.277138] system 00:0c: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.277186] system 00:0c: iomem range 0xff380000-0xffffffff could not be=
 reserved
[    0.277641] PCI: Bridge: 0000:00:08.0
[    0.277678]   IO window: d000-dfff
[    0.277716]   MEM window: 0xf9f00000-0xf9ffffff
[    0.277754]   PREFETCH window: 0x00000000f0000000-0x00000000f00fffff
[    0.277795] PCI: Bridge: 0000:00:0b.0
[    0.277831]   IO window: c000-cfff
[    0.277868]   MEM window: 0xf9e00000-0xf9efffff
[    0.277906]   PREFETCH window: disabled.
[    0.277943] PCI: Bridge: 0000:00:0c.0
[    0.277979]   IO window: disabled.
[    0.278016]   MEM window: disabled.
[    0.278052]   PREFETCH window: disabled.
[    0.278090] PCI: Bridge: 0000:00:0d.0
[    0.278127]   IO window: e000-efff
[    0.278164]   MEM window: 0xfa000000-0xfebfffff
[    0.278202]   PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
[    0.278241] PCI: Bridge: 0000:00:0e.0
[    0.278277]   IO window: disabled.
[    0.278314]   MEM window: disabled.
[    0.278351]   PREFETCH window: disabled.
[    0.278394] PCI: Setting latency timer of device 0000:00:08.0 to 64
[    0.278402] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.278408] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.278413] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.278417] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.278424] NET: Registered protocol family 2
[    0.313369] IP route cache hash table entries: 131072 (order: 8, 1048576=
 bytes)
[    0.313369] TCP established hash table entries: 262144 (order: 10, 41943=
04 bytes)
[    0.313369] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.313369] TCP: Hash tables configured (established 262144 bind 65536)
[    0.313369] TCP reno registered
[    0.323685] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 254)
[    0.323685] io scheduler noop registered
[    0.323685] io scheduler cfq registered (default)
[    0.323685] pci 0000:00:00.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:08.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:0a.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:0b.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:0c.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:0d.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:00:0e.0: Enabling HT MSI Mapping
[    0.323685] pci 0000:04:00.0: Boot video device
[    0.323693] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.323693] assign_interrupt_mode Found MSI capability
[    0.323693] Allocate Port Service[0000:00:0b.0:pcie00]
[    0.323701] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.323701] assign_interrupt_mode Found MSI capability
[    0.323701] Allocate Port Service[0000:00:0c.0:pcie00]
[    0.323708] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.323708] assign_interrupt_mode Found MSI capability
[    0.323708] Allocate Port Service[0000:00:0d.0:pcie00]
[    0.323714] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.323714] assign_interrupt_mode Found MSI capability
[    0.323714] Allocate Port Service[0000:00:0e.0:pcie00]
[    0.323756] input: Power Button (FF) as /class/input/input0
[    0.323756] ACPI: Power Button (FF) [PWRF]
[    0.323763] input: Power Button (CM) as /class/input/input1
[    0.323763] ACPI: Power Button (CM) [PWRB]
[    0.323797] ACPI: ACPI0007:00 is registered as cooling_device0
[    0.323804] ACPI: ACPI0007:01 is registered as cooling_device1
[    0.357172] Real Time Clock Driver v1.12ac
[    0.357176] hpet_resources: 0xfed00000 is busy
[    0.357183] Linux agpgart interface v0.103
[    0.357204] Driver 'sd' needs updating - please use bus_type methods
[    0.357218] ahci 0000:00:0a.0: version 3.0
[    0.357218] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.357218] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23=
 (level, low) -> IRQ 23
[    1.360550] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f impl IDE mode
[    1.360550] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio=20
[    1.360550] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.360552] scsi0 : ahci
[    1.360562] scsi1 : ahci
[    1.360572] scsi2 : ahci
[    1.360581] scsi3 : ahci
[    1.360589] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc10=
0 irq 315
[    1.360589] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc18=
0 irq 315
[    1.360589] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc20=
0 irq 315
[    1.360589] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc28=
0 irq 315
[    1.478990] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.479483] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.479483] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    1.480030] ata1.00: configured for UDMA/133
[    1.798679] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.815646] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.815646] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.817568] ata2.00: configured for UDMA/133
[    2.135041] ata3: SATA link down (SStatus 0 SControl 300)
[    2.454910] ata4: SATA link down (SStatus 0 SControl 300)
[    2.657257] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10=
=2E0 PQ: 0 ANSI: 5
[    2.657270] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2 MB)
[    2.657270] sd 0:0:0:0: [sda] Write Protect is off
[    2.657270] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.657270] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.657270] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2 MB)
[    2.657270] sd 0:0:0:0: [sda] Write Protect is off
[    2.657270] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.657270] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.657270]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.489404] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.489464] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.489598] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR=
10 PQ: 0 ANSI: 5
[    2.489730] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8 MB)
[    2.489779] sd 1:0:0:0: [sdb] Write Protect is off
[    2.489817] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.489832] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.489910] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8 MB)
[    2.489956] sd 1:0:0:0: [sdb] Write Protect is off
[    2.489994] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.490008] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.490057]  sdb: sdb1 sdb2
[    2.521193] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.521203] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.521213] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x6=
4 irq 1,12
[    2.522811] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.522851] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.551241] usbcore: registered new interface driver usbhid
[    2.551241] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    2.551241] TCP cubic registered
[    2.551241] NET: Registered protocol family 1
[    2.551247] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processo=
r 6000+ processors (2 cpu cores) (version 2.20.00)
[    2.750168] powernow-k8:    0 : fid 0x16 (3000 MHz), vid 0x6
[    2.750168] powernow-k8:    1 : fid 0x14 (2800 MHz), vid 0x8
[    2.750168] powernow-k8:    2 : fid 0x12 (2600 MHz), vid 0xa
[    2.750168] powernow-k8:    3 : fid 0x10 (2400 MHz), vid 0xc
[    2.750168] powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xe
[    2.750168] powernow-k8:    5 : fid 0xc (2000 MHz), vid 0x10
[    2.750168] powernow-k8:    6 : fid 0xa (1800 MHz), vid 0x10
[    2.750168] powernow-k8:    7 : fid 0x2 (1000 MHz), vid 0x12
[    2.580379] input: AT Translated Set 2 keyboard as /class/input/input2
[    2.679544] ReiserFS: sda3: found reiserfs format "3.6" with standard jo=
urnal
[    2.679544] ReiserFS: sda3: using ordered data mode
[    2.691925] ReiserFS: sda3: journal params: device sda3, size 8192, jour=
nal first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax trans age 30
[    2.692334] ReiserFS: sda3: checking transaction log (sda3)
[    2.730293] ReiserFS: sda3: Using r5 hash to sort names
[    2.730293] VFS: Mounted root (reiserfs filesystem) readonly.
[    2.730293] Freeing unused kernel memory: 192k freed
[    2.730293] release_dev: bad idx when trying to free (tty69)
[    2.730293] Warning: unable to open an initial console.
[    2.996453] Clocksource tsc unstable (delta =3D -168648296 ns)
[    2.933161] Warning: dev (tty69) tty->count(2) !=3D #fd's(1) in tty_open
[    2.933161] Warning: dev (tty69) tty->count(2) !=3D #fd's(1) in release_=
dev
[    2.933161] release_dev: bad idx when trying to free (tty69)
[    6.163376] r8169 Gigabit Ethernet driver 2.2LK loaded
[    6.163612] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 19
[    6.163617] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNEB] -> GSI 19=
 (level, low) -> IRQ 19
[    6.163626] PCI: Setting latency timer of device 0000:01:00.0 to 64
[    6.163793] eth0: RTL8168b/8111b at 0xffffc20000170000, 00:19:66:47:f3:c=
b, XID 38000000 IRQ 314
[    6.209527] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[    6.209533] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUB2] -> GSI 22=
 (level, low) -> IRQ 22
[    6.209540] PCI: Setting latency timer of device 0000:00:02.1 to 64
[    6.209542] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    6.212466] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    6.212490] ehci_hcd 0000:00:02.1: debug port 1
[    6.212492] PCI: cache line size of 64 is not supported by device 0000:0=
0:02.1
[    6.212500] ehci_hcd 0000:00:02.1: irq 22, io mem 0xf9dfec00
[    6.225386] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10=
 Dec 2004
[    6.225386] usb usb1: configuration #1 chosen from 1 choice
[    6.225386] hub 1-0:1.0: USB hub found
[    6.225386] hub 1-0:1.0: 10 ports detected
[    6.735655] usb 1-3: new high speed USB device using ehci_hcd and addres=
s 2
[    6.708874] usb 1-3: configuration #1 chosen from 1 choice
[    6.708929] hub 1-3:1.0: USB hub found
[    6.709058] hub 1-3:1.0: 4 ports detected
[    7.018045] usb 1-3.1: new low speed USB device using ehci_hcd and addre=
ss 3
[    7.112115] usb 1-3.1: configuration #1 chosen from 1 choice
[    7.124394] input: Logitech USB Receiver as /class/input/input3
[    7.143525] input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-00=
00:00:02.1-3.1
[    7.148037] input: Logitech USB Receiver as /class/input/input4
[    7.196328] input: USB HID v1.11 Device [Logitech USB Receiver] on usb-0=
000:00:02.1-3.1
[    7.265445] mice: PS/2 mouse device common for all mice
[    8.887538] ReiserFS: sda3: switching to journaled data mode
[    9.066489] Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1 ac=
ross:1951888k
[   10.225867] r8169: eth0: link up
[   10.225867] r8169: eth0: link up
[   10.278379] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 18
[   10.278385] ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKB] -> GSI 18=
 (level, low) -> IRQ 18
[   10.281701] Audigy2 value: Special config.
[   11.264826] i2c /dev entries driver
[   11.352546] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x2d00
[   11.352580] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x2e00
[   11.738236] w83627ehf: Found W83627EHG chip at 0x290
[   16.841538] release_dev: bad idx when trying to free (tty69)

--Boundary-00=_WSUEIO4e3u1bMqx
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg_libata-dev_non_raid_nomsi"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_libata-dev_non_raid_nomsi"

[    0.000000] Linux version 2.6.25libata-dev-01060-g48feb3c-dirty (root@en=
ergy) (gcc version 4.2.3 (Gentoo 4.2.3 p1.0)) #1 SMP Fri Apr 25 04:11:13 CE=
ST 2008
[    0.000000] Command line: pci=3Dnomsi root=3D/dev/sda3 nmi_watchdog=3D0 =
console=3Dtty6=E8=88=F0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffb0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffb0000 - 00000000cffc0000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffc0000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 u=
sed
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of =
256 used
[    0.000000] end_pfn_map =3D 1245184
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F98F0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT CFFB0000, 003C (r1 A M I  OEMRSDT   1000822 MSFT =
      97)
[    0.000000] ACPI: FACP CFFB0200, 0084 (r2 A_M_I  OEMFACP  12000601 MSFT =
      97)
[    0.000000] ACPI: DSDT CFFB0450, 4FFA (r1  ASR19 ASR19192      192 INTL =
20051117)
[    0.000000] ACPI: FACS CFFC0000, 0040
[    0.000000] ACPI: APIC CFFB0390, 0080 (r1 A M I  OEMAPIC   1000822 MSFT =
      97)
[    0.000000] ACPI: MCFG CFFB0410, 003C (r1 A M I  OEMMCFG   1000822 MSFT =
      97)
[    0.000000] ACPI: OEMB CFFC0040, 0060 (r1 A M I  AMI_OEM   1000822 MSFT =
      97)
[    0.000000] ACPI: HPET CFFB5450, 0038 (r1 A M I  OEMHPET0  1000822 MSFT =
      97)
[    0.000000] ACPI: SSDT CFFB5490, 030E (r1 A M I  POWERNOW        1 AMD  =
       1)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 851888) 1 entries of 256 u=
sed
[    0.000000] Entering add_active_range(0, 1048576, 1245184) 2 entries of =
256 used
[    0.000000] early res: 0 [0-fff] BIOS data page
[    0.000000] early res: 1 [6000-7fff] SMP_TRAMPOLINE
[    0.000000] early res: 2 [200000-546213] TEXT DATA BSS
[    0.000000] early res: 3 [9fc00-a0bff] EBDA
[    0.000000] early res: 4 [8000-dfff] PGTABLE
[    0.000000] No mptable found.
[    0.000000]  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 =
on node 0
[    0.000000]  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 =
on node 0
[    0.000000]  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 =
on node 0
[    0.000000]  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 =
on node 0
[    0.000000]  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 =
on node 0
[    0.000000]  [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 =
on node 0
[    0.000000]  [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 =
on node 0
[    0.000000]  [ffffe20000e00000-ffffe20000ffffff] PMD ->ffff810002e00000 =
on node 0
[    0.000000]  [ffffe20001000000-ffffe200011fffff] PMD ->ffff810003200000 =
on node 0
[    0.000000]  [ffffe20001200000-ffffe200013fffff] PMD ->ffff810003600000 =
on node 0
[    0.000000]  [ffffe20001400000-ffffe200015fffff] PMD ->ffff810003a00000 =
on node 0
[    0.000000]  [ffffe20001600000-ffffe200017fffff] PMD ->ffff810003e00000 =
on node 0
[    0.000000]  [ffffe20001800000-ffffe200019fffff] PMD ->ffff810004200000 =
on node 0
[    0.000000]  [ffffe20001a00000-ffffe20001bfffff] PMD ->ffff810004600000 =
on node 0
[    0.000000]  [ffffe20001c00000-ffffe20001dfffff] PMD ->ffff810004a00000 =
on node 0
[    0.000000]  [ffffe20001e00000-ffffe20001ffffff] PMD ->ffff810004e00000 =
on node 0
[    0.000000]  [ffffe20002000000-ffffe200021fffff] PMD ->ffff810005200000 =
on node 0
[    0.000000]  [ffffe20002200000-ffffe200023fffff] PMD ->ffff810005600000 =
on node 0
[    0.000000]  [ffffe20002400000-ffffe200025fffff] PMD ->ffff810005a00000 =
on node 0
[    0.000000]  [ffffe20002600000-ffffe200027fffff] PMD ->ffff810005e00000 =
on node 0
[    0.000000]  [ffffe20002800000-ffffe200029fffff] PMD ->ffff810006200000 =
on node 0
[    0.000000]  [ffffe20002a00000-ffffe20002bfffff] PMD ->ffff810006600000 =
on node 0
[    0.000000]  [ffffe20002c00000-ffffe20002dfffff] PMD ->ffff810006a00000 =
on node 0
[    0.000000]  [ffffe20002e00000-ffffe20002ffffff] PMD ->ffff810006e00000 =
on node 0
[    0.000000]  [ffffe20003000000-ffffe200031fffff] PMD ->ffff810007200000 =
on node 0
[    0.000000]  [ffffe20003200000-ffffe200033fffff] PMD ->ffff810007600000 =
on node 0
[    0.000000]  [ffffe20003400000-ffffe200035fffff] PMD ->ffff810007a00000 =
on node 0
[    0.000000]  [ffffe20003600000-ffffe200037fffff] PMD ->ffff810007e00000 =
on node 0
[    0.000000]  [ffffe20003800000-ffffe200039fffff] PMD ->ffff810008200000 =
on node 0
[    0.000000]  [ffffe20003a00000-ffffe20003bfffff] PMD ->ffff810008600000 =
on node 0
[    0.000000]  [ffffe20003c00000-ffffe20003dfffff] PMD ->ffff810008a00000 =
on node 0
[    0.000000]  [ffffe20003e00000-ffffe20003ffffff] PMD ->ffff810008e00000 =
on node 0
[    0.000000]  [ffffe20004000000-ffffe200041fffff] PMD ->ffff810009200000 =
on node 0
[    0.000000]  [ffffe20004200000-ffffe200043fffff] PMD ->ffff810009600000 =
on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1245184
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   851888
[    0.000000]     0:  1048576 ->  1245184
[    0.000000] On node 0 totalpages: 1048399
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 848 pages reserved
[    0.000000]   DMA zone: 3095 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833512 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Detected use of extended apic ids on hypertransport bus
[    0.000000] ACPI: PM-Timer IO Port: 0x2008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000cffb0000 - 00000000cff=
c0000
[    0.000000] PM: Registered nosave memory: 00000000cffc0000 - 00000000cff=
f0000
[    0.000000] PM: Registered nosave memory: 00000000cfff0000 - 00000000d00=
00000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000000ff3=
80000
[    0.000000] PM: Registered nosave memory: 00000000ff380000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at d4000000 (gap: d0000000=
:2ec00000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 32584 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 1030527
[    0.000000] Kernel command line: pci=3Dnomsi root=3D/dev/sda3 nmi_watchd=
og=3D0 console=3Dtty6=E8=88=F0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[    0.000002] time.c: Detected 3013.886 MHz processor.
[    0.000011] spurious 8259A interrupt: IRQ7.
[    0.003333] Console: colour VGA+ 80x25
[    0.003333] console [tty6] enabled
[    0.003333] Dentry cache hash table entries: 524288 (order: 10, 4194304 =
bytes)
[    0.003333] Inode-cache hash table entries: 262144 (order: 9, 2097152 by=
tes)
[    0.003333] Checking aperture...
[    0.003333] Node 0: aperture @ c000000 size 32 MB
[    0.003333] Aperture pointing to e820 RAM. Ignoring.
[    0.003333] No AGP bridge found
[    0.003333] Your BIOS doesn't leave a aperture memory hole
[    0.003333] Please enable the IOMMU option in the BIOS setup
[    0.003333] This costs you 64 MB of RAM
[    0.003333] Mapping aperture over 65536 KB of RAM @ c000000
[    0.003333] PM: Registered nosave memory: 000000000c000000 - 00000000100=
00000
[    0.003333] Memory: 4047784k/4980736k available (1974k kernel code, 1451=
04k reserved, 860k data, 192k init)
[    0.003333] CPA: page pool initialized 1 of 1 pages preallocated
[    0.003333] SLUB: Genslabs=3D12, HWalign=3D64, Order=3D0-1, MinObjects=
=3D4, CPUs=3D2, Nodes=3D1
[    0.003333] hpet clockevent registered
[    0.083330] Calibrating delay using timer specific routine.. 6034.71 Bog=
oMIPS (lpj=3D10053945)
[    0.083419] Mount-cache hash table entries: 256
[    0.083536] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.083576] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.083613] CPU: Physical Processor ID: 0
[    0.083650] CPU: Processor Core ID: 0
[    0.083699] ACPI: Core revision 20070126
[    0.122332] Using local APIC timer interrupts.
[    0.123326] APIC timer calibration result 12557859
[    0.123327] Detected 12.557 MHz APIC timer.
[    0.123430] Booting processor 1/2 APIC 0x1
[    0.003333] Initializing CPU#1
[    0.003333] Calibrating delay using timer specific routine.. 6030.95 Bog=
oMIPS (lpj=3D10046328)
[    0.003333] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[    0.003333] CPU: L2 Cache: 1024K (64 bytes/line)
[    0.003333] CPU: Physical Processor ID: 0
[    0.003333] CPU: Processor Core ID: 1
[    0.003333] AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ stepping 03
[    0.216846] Brought up 2 CPUs
[    0.217293] net_namespace: 296 bytes
[    0.217412] NET: Registered protocol family 16
[    0.217507] No dock devices found.
[    0.217569] ACPI: bus type pci registered
[    0.217645] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.217684] PCI: Not using MMCONFIG.
[    0.217721] PCI: Using configuration type 1
[    0.220782] ACPI: EC: Look up EC in DSDT
[    0.225062] ACPI: Interpreter enabled
[    0.225100] ACPI: (supports S0 S1 S3 S4 S5)
[    0.225271] ACPI: Using IOAPIC for interrupt routing
[    0.225444] ACPI: Error attaching device data
[    0.225484] ACPI: Error attaching device data
[    0.225524] ACPI: Error attaching device data
[    0.225564] ACPI: Error attaching device data
[    0.231214] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.231730] PCI: Transparent bridge - 0000:00:08.0
[    0.231980] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.232127] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.232237] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR10._PRT]
[    0.232301] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.232369] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR13._PRT]
[    0.232438] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.237077] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *11
[    0.237439] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *5
[    0.237799] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238186] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238572] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disab=
led.
[    0.238958] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *10
[    0.239318] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disab=
led.
[    0.239704] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *10
[    0.240131] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *5
[    0.240490] ACPI: PCI Interrupt Link [LMAD] (IRQs 20 21 22 23) *0, disab=
led.
[    0.240879] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *7
[    0.241239] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disab=
led.
[    0.241626] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.242012] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[    0.242373] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disab=
led.
[    0.242760] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *15
[    0.243120] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *0, disab=
led.
[    0.243549] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disab=
led.
[    0.243936] ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *0, disab=
led.
[    0.244323] ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *0, disab=
led.
[    0.244650] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.244698] pnp: PnP ACPI init
[    0.244737] ACPI: bus type pnp registered
[    0.247933] pnp: PnP ACPI: found 13 devices
[    0.247970] ACPI: ACPI bus type pnp unregistered
[    0.248110] SCSI subsystem initialized
[    0.248179] libata version 3.00 loaded.
[    0.248241] usbcore: registered new interface driver usbfs
[    0.248300] usbcore: registered new interface driver hub
[    0.248363] usbcore: registered new device driver usb
[    0.248473] PCI: Using ACPI for IRQ routing
[    0.248511] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =
helps, post a report
[    0.266663] PCI-DMA: Disabling AGP.
[    0.266663] PCI-DMA: aperture base @ c000000 size 65536 KB
[    0.266663] PCI-DMA: using GART IOMMU.
[    0.266663] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.266663] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.266663] hpet0: 3 32-bit timers, 25000000 Hz
[    0.266672] Switched to high resolution mode on CPU 0
[    0.060512] Switched to high resolution mode on CPU 1
[    0.280033] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[    0.280033] system 00:05: ioport range 0x800-0x80f has been reserved
[    0.280033] system 00:05: ioport range 0x2000-0x207f has been reserved
[    0.280033] system 00:05: ioport range 0x2080-0x20ff has been reserved
[    0.280033] system 00:05: ioport range 0x2400-0x247f has been reserved
[    0.280033] system 00:05: ioport range 0x2480-0x24ff has been reserved
[    0.280033] system 00:05: ioport range 0x2800-0x287f has been reserved
[    0.280033] system 00:05: ioport range 0x2880-0x28ff has been reserved
[    0.280036] system 00:05: ioport range 0x2c00-0x2c7f has been reserved
[    0.280075] system 00:05: ioport range 0x2c80-0x2cff has been reserved
[    0.280116] system 00:05: iomem range 0x0-0x0 could not be reserved
[    0.280156] system 00:05: iomem range 0xfee01000-0xfeefffff has been res=
erved
[    0.280200] system 00:07: iomem range 0xfec00000-0xfec00fff could not be=
 reserved
[    0.280247] system 00:07: iomem range 0xfee00000-0xfee00fff could not be=
 reserved
[    0.280299] system 00:0a: ioport range 0x290-0x29f has been reserved
[    0.280342] system 00:0b: iomem range 0xe0000000-0xefffffff has been res=
erved
[    0.280385] system 00:0c: iomem range 0x0-0x9ffff could not be reserved
[    0.280425] system 00:0c: iomem range 0xc0000-0xcffff has been reserved
[    0.280464] system 00:0c: iomem range 0xe0000-0xfffff could not be reser=
ved
[    0.280510] system 00:0c: iomem range 0x100000-0xcfffffff could not be r=
eserved
[    0.280557] system 00:0c: iomem range 0xff380000-0xffffffff could not be=
 reserved
[    0.281011] PCI: Bridge: 0000:00:08.0
[    0.281049]   IO window: d000-dfff
[    0.281086]   MEM window: 0xf9f00000-0xf9ffffff
[    0.281125]   PREFETCH window: 0x00000000f0000000-0x00000000f00fffff
[    0.281165] PCI: Bridge: 0000:00:0b.0
[    0.281202]   IO window: c000-cfff
[    0.281239]   MEM window: 0xf9e00000-0xf9efffff
[    0.281276]   PREFETCH window: disabled.
[    0.281314] PCI: Bridge: 0000:00:0c.0
[    0.281350]   IO window: disabled.
[    0.281387]   MEM window: disabled.
[    0.281423]   PREFETCH window: disabled.
[    0.281461] PCI: Bridge: 0000:00:0d.0
[    0.281498]   IO window: e000-efff
[    0.281535]   MEM window: 0xfa000000-0xfebfffff
[    0.281573]   PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
[    0.281612] PCI: Bridge: 0000:00:0e.0
[    0.281648]   IO window: disabled.
[    0.281685]   MEM window: disabled.
[    0.281722]   PREFETCH window: disabled.
[    0.281765] PCI: Setting latency timer of device 0000:00:08.0 to 64
[    0.281774] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.281779] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.281784] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.281789] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.281795] NET: Registered protocol family 2
[    0.316698] IP route cache hash table entries: 131072 (order: 8, 1048576=
 bytes)
[    0.316698] TCP established hash table entries: 262144 (order: 10, 41943=
04 bytes)
[    0.316698] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.316698] TCP: Hash tables configured (established 262144 bind 65536)
[    0.316698] TCP reno registered
[    0.327011] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 254)
[    0.327011] io scheduler noop registered
[    0.327011] io scheduler cfq registered (default)
[    0.327011] pci 0000:00:00.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:08.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:0a.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:0b.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:0c.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:0d.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:00:0e.0: Enabling HT MSI Mapping
[    0.327011] pci 0000:04:00.0: Boot video device
[    0.327020] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    0.327020] assign_interrupt_mode Found MSI capability
[    0.327020] Allocate Port Service[0000:00:0b.0:pcie00]
[    0.327027] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.327027] assign_interrupt_mode Found MSI capability
[    0.327027] Allocate Port Service[0000:00:0c.0:pcie00]
[    0.327034] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[    0.327034] assign_interrupt_mode Found MSI capability
[    0.327034] Allocate Port Service[0000:00:0d.0:pcie00]
[    0.327040] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    0.327040] assign_interrupt_mode Found MSI capability
[    0.327040] Allocate Port Service[0000:00:0e.0:pcie00]
[    0.327082] input: Power Button (FF) as /class/input/input0
[    0.327082] ACPI: Power Button (FF) [PWRF]
[    0.327089] input: Power Button (CM) as /class/input/input1
[    0.327089] ACPI: Power Button (CM) [PWRB]
[    0.327123] ACPI: ACPI0007:00 is registered as cooling_device0
[    0.327130] ACPI: ACPI0007:01 is registered as cooling_device1
[    0.363812] Real Time Clock Driver v1.12ac
[    0.363816] hpet_resources: 0xfed00000 is busy
[    0.363823] Linux agpgart interface v0.103
[    0.363843] Driver 'sd' needs updating - please use bus_type methods
[    0.363857] ahci 0000:00:0a.0: version 3.0
[    0.363857] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
[    0.363857] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LSA0] -> GSI 23=
 (level, low) -> IRQ 23
[    1.367189] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f impl IDE mode
[    1.367189] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio=20
[    1.367189] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[    1.367191] scsi0 : ahci
[    1.367201] scsi1 : ahci
[    1.367210] scsi2 : ahci
[    1.367220] scsi3 : ahci
[    1.367226] ata1: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc10=
0 irq 23
[    1.367226] ata2: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc18=
0 irq 23
[    1.367226] ata3: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc20=
0 irq 23
[    1.367226] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc28=
0 irq 23
[    1.489044] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.489540] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max UDMA/133
[    1.489540] ata1.00: 312581808 sectors, multi 16: LBA48=20
[    1.490087] ata1.00: configured for UDMA/133
[    1.808738] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.829236] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
[    1.829236] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.831155] ata2.00: configured for UDMA/133
[    2.148423] ata3: SATA link down (SStatus 0 SControl 300)
[    2.468291] ata4: SATA link down (SStatus 0 SControl 300)
[    2.667219] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600JS-00M 10=
=2E0 PQ: 0 ANSI: 5
[    2.667232] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2 MB)
[    2.667232] sd 0:0:0:0: [sda] Write Protect is off
[    2.667232] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.667232] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.667232] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (16004=
2 MB)
[    2.667232] sd 0:0:0:0: [sda] Write Protect is off
[    2.667232] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.667232] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.667232]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    2.504269] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.504280] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.504286] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR=
10 PQ: 0 ANSI: 5
[    2.504293] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8 MB)
[    2.504293] sd 1:0:0:0: [sdb] Write Protect is off
[    2.504293] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.504293] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.504293] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (50010=
8 MB)
[    2.504293] sd 1:0:0:0: [sdb] Write Protect is off
[    2.504293] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.504293] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.504293]  sdb: sdb1 sdb2
[    2.564438] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.564448] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.564458] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x6=
4 irq 1,12
[    2.564730] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.564770] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.594576] usbcore: registered new interface driver usbhid
[    2.594576] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    2.594576] TCP cubic registered
[    2.594576] NET: Registered protocol family 1
[    2.594581] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processo=
r 6000+ processors (2 cpu cores) (version 2.20.00)
[    2.792617] powernow-k8:    0 : fid 0x16 (3000 MHz), vid 0x6
[    2.792617] powernow-k8:    1 : fid 0x14 (2800 MHz), vid 0x8
[    2.792617] powernow-k8:    2 : fid 0x12 (2600 MHz), vid 0xa
[    2.792617] powernow-k8:    3 : fid 0x10 (2400 MHz), vid 0xc
[    2.792617] powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xe
[    2.792617] powernow-k8:    5 : fid 0xc (2000 MHz), vid 0x10
[    2.792617] powernow-k8:    6 : fid 0xa (1800 MHz), vid 0x10
[    2.792617] powernow-k8:    7 : fid 0x2 (1000 MHz), vid 0x12
[    2.626516] input: AT Translated Set 2 keyboard as /class/input/input2
[    2.724027] ReiserFS: sda3: found reiserfs format "3.6" with standard jo=
urnal
[    2.724071] ReiserFS: sda3: using ordered data mode
[    2.735086] ReiserFS: sda3: journal params: device sda3, size 8192, jour=
nal first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax trans age 30
[    2.735768] ReiserFS: sda3: checking transaction log (sda3)
[    2.799567] ReiserFS: sda3: replayed 5 transactions in 0 seconds
[    2.813951] ReiserFS: sda3: Using r5 hash to sort names
[    2.813951] VFS: Mounted root (reiserfs filesystem) readonly.
[    2.813951] Freeing unused kernel memory: 192k freed
[    4.060555] Clocksource tsc unstable (delta =3D -133084514 ns)
[    6.671885] r8169 Gigabit Ethernet driver 2.2LK loaded
[    6.673510] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 19
[    6.673515] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNEB] -> GSI 19=
 (level, low) -> IRQ 19
[    6.673523] PCI: Setting latency timer of device 0000:01:00.0 to 64
[    6.673532] r8169 0000:01:00.0: no MSI. Back to INTx.
[    6.673675] eth0: RTL8168b/8111b at 0xffffc20000170000, 00:19:66:47:f3:c=
b, XID 38000000 IRQ 19
[    6.743637] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[    6.743643] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUB2] -> GSI 22=
 (level, low) -> IRQ 22
[    6.743650] PCI: Setting latency timer of device 0000:00:02.1 to 64
[    6.743652] ehci_hcd 0000:00:02.1: EHCI Host Controller
[    6.743985] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus =
number 1
[    6.744008] ehci_hcd 0000:00:02.1: debug port 1
[    6.744011] PCI: cache line size of 64 is not supported by device 0000:0=
0:02.1
[    6.744018] ehci_hcd 0000:00:02.1: irq 22, io mem 0xf9dfec00
[    6.756790] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10=
 Dec 2004
[    6.756863] usb usb1: configuration #1 chosen from 1 choice
[    6.756879] hub 1-0:1.0: USB hub found
[    6.756885] hub 1-0:1.0: 10 ports detected
[    7.376514] usb 1-3: new high speed USB device using ehci_hcd and addres=
s 2
[    7.248627] usb 1-3: configuration #1 chosen from 1 choice
[    7.248627] hub 1-3:1.0: USB hub found
[    7.248730] hub 1-3:1.0: 4 ports detected
[    7.555518] usb 1-3.1: new low speed USB device using ehci_hcd and addre=
ss 3
[    7.652037] usb 1-3.1: configuration #1 chosen from 1 choice
[    7.663429] input: Logitech USB Receiver as /class/input/input3
[    7.692090] input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-00=
00:00:02.1-3.1
[    7.698836] input: Logitech USB Receiver as /class/input/input4
[    7.751318] input: USB HID v1.11 Device [Logitech USB Receiver] on usb-0=
000:00:02.1-3.1
[    7.835820] mice: PS/2 mouse device common for all mice
[    9.484728] ReiserFS: sda3: switching to journaled data mode
[    9.485517] ReiserFS: sda3: Removing [2003093 2207029 0x0 SD]..done
[    9.485612] ReiserFS: sda3: Removing [2003093 2207028 0x0 SD]..done
[    9.485666] ReiserFS: sda3: Removing [2003093 2207025 0x0 SD]..done
[    9.485717] ReiserFS: sda3: There were 3 uncompleted unlinks/truncates. =
Completed
[    9.758347] Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1 ac=
ross:1951888k
[   10.769073] r8169: eth0: link up
[   10.769076] r8169: eth0: link up
[   10.832081] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 18
[   10.832087] ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKB] -> GSI 18=
 (level, low) -> IRQ 18
[   10.835404] Audigy2 value: Special config.
[   12.199273] i2c /dev entries driver
[   12.183838] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x2d00
[   12.183838] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x2e00
[   13.050865] w83627ehf: Found W83627EHG chip at 0x290

--Boundary-00=_WSUEIO4e3u1bMqx--
