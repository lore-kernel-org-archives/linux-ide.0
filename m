From: echo6 <echo6_uk@yahoo.com>
Subject: sata_inic162x
Date: Thu, 21 Aug 2008 17:58:21 +0100
Message-ID: <48AD9EAD.1010204@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm experiencing difficulties with this controller

04:00.0 SATA controller: Initio Corporation INI-1623 PCI SATA-II
Controller (rev 02) (prog-if 00 [Vendor specific])
	Subsystem: Initio Corporation Unknown device 1626
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at 8c420000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 8c400000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Branded as an A.C.Ryan, http://www.acryan.com

I'm using Ubuntu 8.04;
Linux toshiba 2.6.24-16-generic
Linux toshiba 2.6.24-19-generic
Produces an error
[  608.944941] pccard: CardBus card inserted into slot 0
[  609.062663] sata_inic162x 0000:04:00.0: version 0.3
[  609.062933] PCI: Enabling device 0000:04:00.0 (0000 -> 0003)
[  609.062945] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 21 (level,
low) -> IRQ 18
[  609.062977] ACPI: PCI interrupt for device 0000:04:00.0 disabled
[  609.063615] sata_inic162x: probe of 0000:04:00.0 failed with error -22
filename:
/lib/modules/2.6.24-19-generic/kernel/drivers/ata/sata_inic162x.ko
version:        0.3
license:        GPL v2
description:    low-level driver for Initio 162x SATA
author:         Tejun Heo
srcversion:     EC2EF894C85619AF3EEF6DC
alias:          pci:v00001101d00001622sv*sd*bc*sc*i*
depends:        libata
vermagic:       2.6.24-19-generic SMP mod_unload 586

I also have custom compiled kernel using 2.6.26, on that the moment I
shove the sata pcmcia card into my laptop the system freezes.
filename:
/lib/modules/2.6.26-forensic/kernel/drivers/ata/sata_inic162x.ko
version:        0.4
license:        GPL v2
description:    low-level driver for Initio 162x SATA
author:         Tejun Heo
srcversion:     7D4EAD0887CA9157DA8B449
alias:          pci:v00001101d00001622sv*sd*bc*sc*i*
depends:
vermagic:       2.6.26-forensic SMP mod_unload modversions PENTIUM4

I'm very keen to fix this, any suggestions?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIrZ6tbSv1saVS9ucRAnYMAKCk0veCis0Z4F3lE+Raz/oc1M5KbACcCyyx
iN7OCjwih59i0QoerqHto9s=
=ve5y
-----END PGP SIGNATURE-----
