From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 15:30:32 +0100
Message-ID: <4B5B0808.3070906@infernix.net>
References: <4B591D61.8030003@infernix.net>	<4B593128.1040104@gmail.com>	<4B59A0CD.4000801@infernix.net>	<4B5A4F7A.4040709@gmail.com>	<4B5A5F09.1070300@infernix.net>	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>	<4B5AF4DF.4020100@infernix.net> <20100123133831.7f24ae95@lxorguk.ukuu.org.uk> <4B5B0400.6020306@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:39937 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0AWOai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2010 09:30:38 -0500
In-Reply-To: <4B5B0400.6020306@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 23/01/10 15:13, infernix wrote:
> On 23/01/10 14:38, Alan Cox wrote:
>>> PATA_LEGACY Depends on: ATA [=3Dy]&& ATA_SFF [=3Dy]&& ISA [=3Dn]&&
>>> EXPERIMENTAL [=3Dy] =E2=94=82
>>>
>>> So I have to turn on ISA for it to build. But that's not possible o=
n
>>> x86_64 because it depends on X86_32. I'll try a 32bit build later, =
but
>>> I'd really like to be able to stay on x86_64. Is there a workaround=
?
>>
>> Remove the&& ISA in Kconfig - that's bogus.
>
> Aha. I'll try that later tonight, have some errands to run now.

Couldn't resist. It works! Dmesg output follows :)

However, speed seems like its just as slow as with the legacy IDE drive=
r:

ss4200:~# hdparm -tT /dev/sda

/dev/sda:
  Timing cached reads:   790 MB in  2.00 seconds =3D 395.04 MB/sec
  Timing buffered disk reads:    6 MB in  3.30 seconds =3D   1.82 MB/se=
c

I'll do some better speed measurements tonight.


[    0.264038] pci_root PNP0A08:00: ignoring host bridge windows from=20
ACPI; boot with "pci=3Duse_crs" to use them
[    0.268946] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by=20
ICH6 ACPI/GPIO/TCO
[    0.272006] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by=20
ICH6 GPIO
[    0.276003] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at=20
0a00 (mask 00ff)
[    0.280408] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.284202] pci 0000:00:1c.2: PCI bridge to [bus 02-02]
[    0.288063] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive=
=20
decode)
=2E..
[    1.606562] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> I=
RQ 19
[    1.613460] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbp=
s=20
0xf impl SATA mode
[    1.621533] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum =
part
[    1.628674] scsi0 : ahci
[    1.631363] scsi1 : ahci
[    1.633985] scsi2 : ahci
[    1.636577] scsi3 : ahci
[    1.639247] ata1: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fd00 irq 26
[    1.646625] ata2: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fd80 irq 26
[    1.653997] ata3: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fe00 irq 26
[    1.661369] ata4: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fe80 irq 26
[    1.668831] sata_sil24 0000:02:00.0: PCI INT A -> GSI 18 (level, low=
)=20
-> IRQ 18
[    1.676501] scsi4 : sata_sil24
[    1.679635] scsi5 : sata_sil24
[    1.682737] ata5: SATA max UDMA/100 host m128@0xff8ffc00 port=20
0xff8f8000 irq 18
[    1.690032] ata6: SATA max UDMA/100 host m128@0xff8ffc00 port=20
0xff8fa000 irq 18
[    1.697548] scsi6 : pata_legacy
[    1.700733] ata7: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[    1.868361] ata7.00: CFA: TRANSCEND, 20071207, max UDMA/66
[    1.873834] ata7.00: 7831152 sectors, multi 0: LBA
[    1.878709] ata7.00: configured for PIO
[    2.008043] ata3: SATA link down (SStatus 0 SControl 300)
[    2.013440] ata4: SATA link down (SStatus 0 SControl 300)
[    2.018835] ata2: SATA link down (SStatus 0 SControl 300)
[    2.024229] ata1: SATA link down (SStatus 0 SControl 300)
[    3.776040] ata5: SATA link down (SStatus 0 SControl 0)
[    5.860039] ata6: SATA link down (SStatus 0 SControl 0)
[    5.865363] scsi 6:0:0:0: Direct-Access     ATA      TRANSCEND=20
  2007 PQ: 0 ANSI: 5
[    5.873646] sd 6:0:0:0: [sda] 7831152 512-byte logical blocks: (4.00=
=20
GB/3.73 GiB)
[    5.881164] sd 6:0:0:0: [sda] Write Protect is off
[    5.885970] sd 6:0:0:0: [sda] Write cache: disabled, read cache:=20
enabled, doesn't support DPO or FUA
[    5.895228]  sda: sda1
[    5.900195] sd 6:0:0:0: [sda] Attached SCSI disk
[    5.904901] scsi7 : pata_legacy
[    5.908083] ata8: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
=2E..
