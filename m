From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: ahci sometimes fails to suspend controller
Date: Mon, 3 Aug 2009 10:30:16 +0200
Message-ID: <20090803103016.4305e098@pluto-lenny.milky.way>
References: <20090719220423.54e8c75d@uranus>
	<4A683755.60909@kernel.org>
	<20090727140612.27d176ca@pluto-lenny.milky.way>
	<4A6E6774.6030909@kernel.org>
	<C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com>
	<20090728061033.56394c6e@pluto-lenny.milky.way>
	<C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com>
	<20090802190838.4a8bd3b8@pluto-lenny.milky.way>
	<4A7629ED.4050103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753230AbZHCI1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 04:27:13 -0400
In-Reply-To: <4A7629ED.4050103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Hello Tejun

On Mon, 03 Aug 2009 09:06:05 +0900
Tejun Heo <tj@kernel.org> wrote:

> Can you please attach full log?  I'm curious what exactly went down.

Sure. Do you think the system should still be able to resume although 
the revalidation failed while suspending (see line [299208.016116])?

[299201.588616] PM: Entering mem sleep
[299201.588654] pci 0000:00:00.0: preparing suspend
[299201.588657] pci 0000:00:01.0: preparing suspend
[299201.588659] pcieport-driver 0000:00:0a.0: preparing suspend
[299201.588662] ahci 0000:00:11.0: preparing suspend
[299201.588665] ohci_hcd 0000:00:12.0: preparing suspend
[299201.588668] ohci_hcd 0000:00:12.1: preparing suspend
[299201.588670] ehci_hcd 0000:00:12.2: preparing suspend
[299201.588673] ohci_hcd 0000:00:13.0: preparing suspend
[299201.588675] ohci_hcd 0000:00:13.1: preparing suspend
[299201.588677] ehci_hcd 0000:00:13.2: preparing suspend
[299201.588680] piix4_smbus 0000:00:14.0: preparing suspend
[299201.588683] ATIIXP_IDE 0000:00:14.1: preparing suspend
[299201.588685] HDA Intel 0000:00:14.2: preparing suspend
[299201.588688] pci 0000:00:14.3: preparing suspend
[299201.588690] pci 0000:00:14.4: preparing suspend
[299201.588693] ohci_hcd 0000:00:14.5: preparing suspend
[299201.588695] pci 0000:00:18.0: preparing suspend
[299201.588697] pci 0000:00:18.1: preparing suspend
[299201.588700] pci 0000:00:18.2: preparing suspend
[299201.588702] pci 0000:00:18.3: preparing suspend
[299201.588704] pci 0000:01:05.0: preparing suspend
[299201.588707] HDA Intel 0000:01:05.1: preparing suspend
[299201.588710] r8169 0000:02:00.0: preparing suspend, may wakeup
[299201.588721] pcspkr pcspkr: preparing suspend
[299201.588745] serial8250 serial8250: preparing suspend
[299201.588759] i8042 i8042: preparing suspend
[299201.588765] usb usb1: preparing type suspend, may wakeup
[299201.588773] usb usb2: preparing type suspend, may wakeup
[299201.588781] usb 1-3: preparing type suspend, may wakeup
[299201.588789] usb usb3: preparing type suspend, may wakeup
[299201.588793] usb usb4: preparing type suspend, may wakeup
[299201.588797] usb usb5: preparing type suspend, may wakeup
[299201.588801] usb usb6: preparing type suspend, may wakeup
[299201.588806] usb usb7: preparing type suspend, may wakeup
[299201.588810] usb 3-1: preparing type suspend, may wakeup
[299201.588825] it87 it87.552: preparing suspend
[299201.588845] it87 it87.552: suspend
[299201.588852] usb 3-1: type suspend, may wakeup
[299201.604036] usb usb7: type suspend, may wakeup
[299201.604039] usb usb6: type suspend, may wakeup
[299201.604043] usb usb5: type suspend, may wakeup
[299201.604046] usb usb4: type suspend, may wakeup
[299201.604049] usb usb3: type suspend, may wakeup
[299201.604060] ide-cdrom 0.1: legacy suspend
[299201.604666] usb 1-3: type suspend, may wakeup
[299201.620036] sd 2:0:0:0: legacy suspend
[299201.620041] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[299201.620226] sd 2:0:0:0: [sda] Stopping disk
[299202.069047] usb usb2: type suspend, may wakeup
[299202.069052] usb usb1: type suspend, may wakeup
[299202.069063] rtc rtc0: legacy class suspend
[299202.069086] atkbd serio0: legacy suspend
[299202.536031] i8042 i8042: suspend
[299202.536051] serial8250 serial8250: suspend
[299202.536072] pcspkr pcspkr: suspend
[299202.536082] system 00:0b: legacy suspend
[299202.536089] system 00:0a: legacy suspend
[299202.536090] ACPI handle has no context!
[299202.536093] i8042 kbd 00:09: legacy suspend
[299202.536097] pnp 00:08: legacy suspend
[299202.536099] pnp 00:07: legacy suspend
[299202.536102] pnp 00:06: legacy suspend
[299202.536104] rtc_cmos 00:05: legacy suspend, may wakeup
[299202.536111] pnp 00:04: legacy suspend
[299202.536113] pnp 00:03: legacy suspend
[299202.536115] system 00:02: legacy suspend
[299202.536119] system 00:01: legacy suspend
[299202.536123] pnp 00:00: legacy suspend
[299202.536126] r8169 0000:02:00.0: suspend, may wakeup
[299202.536179] ACPI handle has no context!
[299202.536184] r8169 0000:02:00.0: PME# enabled
[299202.536225] ACPI handle has no context!
[299202.552032] HDA Intel 0000:01:05.1: suspend
[299202.552044] HDA Intel 0000:01:05.1: PCI INT B disabled
[299202.552095] ACPI handle has no context!
[299202.568031] pci 0000:01:05.0: suspend
[299202.568034] pci 0000:00:18.3: suspend
[299202.568036] pci 0000:00:18.2: suspend
[299202.568039] pci 0000:00:18.1: suspend
[299202.568041] pci 0000:00:18.0: suspend
[299202.568043] ohci_hcd 0000:00:14.5: suspend
[299202.568051] ohci_hcd 0000:00:14.5: PCI INT C disabled
[299202.568112] pci 0000:00:14.4: suspend
[299202.568115] pci 0000:00:14.3: suspend
[299202.568117] HDA Intel 0000:00:14.2: suspend
[299202.584049] HDA Intel 0000:00:14.2: PCI INT A disabled
[299202.600031] ATIIXP_IDE 0000:00:14.1: suspend
[299202.600066] ATIIXP_IDE 0000:00:14.1: PCI INT A disabled
[299202.600108] piix4_smbus 0000:00:14.0: suspend
[299202.600111] ehci_hcd 0000:00:13.2: suspend
[299202.600118] ehci_hcd 0000:00:13.2: PCI INT B disabled
[299202.600192] ehci_hcd 0000:00:13.2: PME# disabled
[299202.616031] ohci_hcd 0000:00:13.1: suspend
[299202.616038] ohci_hcd 0000:00:13.1: PCI INT A disabled
[299202.616100] ohci_hcd 0000:00:13.0: suspend
[299202.616107] ohci_hcd 0000:00:13.0: PCI INT A disabled
[299202.616168] ehci_hcd 0000:00:12.2: suspend
[299202.616175] ehci_hcd 0000:00:12.2: PCI INT B disabled
[299202.616249] ehci_hcd 0000:00:12.2: PME# disabled
[299202.632031] ohci_hcd 0000:00:12.1: suspend
[299202.632038] ohci_hcd 0000:00:12.1: PCI INT A disabled
[299202.632099] ohci_hcd 0000:00:12.0: suspend
[299202.632106] ohci_hcd 0000:00:12.0: PCI INT A disabled
[299202.632167] ahci 0000:00:11.0: suspend
[299203.016052] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[299208.016032] ata3.00: qc timeout (cmd 0xec)
[299208.016078] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299208.016116] ata3.00: revalidation failed (errno=-5)
[299208.336049] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[299218.336032] ata3.00: qc timeout (cmd 0xec)
[299218.336076] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299218.336114] ata3.00: revalidation failed (errno=-5)
[299218.336153] ata3: limiting SATA link speed to 1.5 Gbps
[299218.656050] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[299248.656030] ata3.00: qc timeout (cmd 0xec)
[299248.656074] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299248.656112] ata3.00: revalidation failed (errno=-5)
[299248.656149] ata3.00: disabled
[299248.656264] ahci 0000:00:11.0: PCI INT A disabled
[299248.656302] pcieport-driver 0000:00:0a.0: suspend
[299248.656306] pci 0000:00:01.0: suspend
[299248.656309] pci 0000:00:00.0: suspend
[299248.656312] acpi PNP0C14:00: legacy suspend
[299248.656314] acpi LNXTHERM:00: legacy suspend
[299248.656317] acpi PNP0C01:00: legacy suspend
[299248.656319] acpi PNP0C02:02: legacy suspend
[299248.656321] acpi device:21: legacy suspend
[299248.656323] acpi PNP0303:00: legacy suspend
[299248.656326] acpi PNP0700:00: legacy suspend
[299248.656328] acpi device:20: legacy suspend
[299248.656330] acpi device:1f: legacy suspend
[299248.656332] acpi device:1e: legacy suspend
[299248.656335] acpi device:1d: legacy suspend
[299248.656337] acpi device:1c: legacy suspend
[299248.656339] acpi device:1b: legacy suspend
[299248.656341] acpi device:1a: legacy suspend
[299248.656344] acpi device:19: legacy suspend
[299248.656346] acpi device:18: legacy suspend
[299248.656348] acpi device:17: legacy suspend
[299248.656350] acpi device:16: legacy suspend
[299248.656353] acpi device:15: legacy suspend
[299248.656355] acpi device:14: legacy suspend
[299248.656357] acpi device:13: legacy suspend
[299248.656360] acpi device:12: legacy suspend
[299248.656362] acpi device:11: legacy suspend
[299248.656364] acpi device:10: legacy suspend
[299248.656366] acpi device:0f: legacy suspend
[299248.656368] acpi PNP0C04:00: legacy suspend
[299248.656371] acpi PNP0800:00: legacy suspend
[299248.656373] acpi PNP0B00:00: legacy suspend
[299248.656375] acpi PNP0103:00: legacy suspend
[299248.656378] acpi PNP0100:00: legacy suspend
[299248.656380] acpi PNP0200:00: legacy suspend
[299248.656382] acpi PNP0000:00: legacy suspend
[299248.656385] pci_link PNP0C0F:07: legacy suspend
[299248.656387] pci_link PNP0C0F:06: legacy suspend
[299248.656390] pci_link PNP0C0F:05: legacy suspend
[299248.656392] pci_link PNP0C0F:04: legacy suspend
[299248.656395] pci_link PNP0C0F:03: legacy suspend
[299248.656397] pci_link PNP0C0F:02: legacy suspend
[299248.656400] pci_link PNP0C0F:01: legacy suspend
[299248.656402] pci_link PNP0C0F:00: legacy suspend
[299248.656404] acpi PNP0C02:01: legacy suspend
[299248.656407] acpi device:0e: legacy suspend
[299248.656409] acpi device:0d: legacy suspend
[299248.656411] acpi device:0c: legacy suspend
[299248.656414] acpi device:0b: legacy suspend
[299248.656416] acpi device:0a: legacy suspend
[299248.656418] acpi device:09: legacy suspend
[299248.656421] acpi device:08: legacy suspend
[299248.656423] acpi device:07: legacy suspend
[299248.656425] acpi device:06: legacy suspend
[299248.656428] acpi device:05: legacy suspend
[299248.656430] acpi device:04: legacy suspend
[299248.656432] acpi device:03: legacy suspend
[299248.656435] acpi device:02: legacy suspend
[299248.656437] acpi device:01: legacy suspend
[299248.656439] acpi PNP0C02:00: legacy suspend
[299248.656442] pci_root PNP0A03:00: legacy suspend
[299248.656445] button PNP0C0C:00: legacy suspend
[299248.656447] acpi device:00: legacy suspend
[299248.656450] processor ACPI_CPU:03: legacy suspend
[299248.656455] processor ACPI_CPU:02: legacy suspend
[299248.656458] processor ACPI_CPU:01: legacy suspend
[299248.656460] processor ACPI_CPU:00: legacy suspend
[299248.656463] button LNXPWRBN:00: legacy suspend
[299248.656465] acpi LNXSYSTM:00: legacy suspend
[299248.656874] it87 it87.552: LATE suspend
[299248.656888] i8042 i8042: LATE suspend
[299248.656893] serial8250 serial8250: LATE suspend
[299248.656900] pcspkr pcspkr: LATE suspend
[299248.656904] r8169 0000:02:00.0: LATE suspend, may wakeup
[299248.656907] HDA Intel 0000:01:05.1: LATE suspend
[299248.656910] pci 0000:01:05.0: LATE suspend
[299248.656926] pci 0000:00:18.3: LATE suspend
[299248.656933] pci 0000:00:18.2: LATE suspend
[299248.656938] pci 0000:00:18.1: LATE suspend
[299248.656944] pci 0000:00:18.0: LATE suspend
[299248.656951] ohci_hcd 0000:00:14.5: LATE suspend
[299248.656953] pci 0000:00:14.4: LATE suspend
[299248.656977] pci 0000:00:14.3: LATE suspend
[299248.657002] HDA Intel 0000:00:14.2: LATE suspend
[299248.657004] ATIIXP_IDE 0000:00:14.1: LATE suspend
[299248.657007] piix4_smbus 0000:00:14.0: LATE suspend
[299248.657038] ehci_hcd 0000:00:13.2: LATE suspend
[299248.657040] ohci_hcd 0000:00:13.1: LATE suspend
[299248.657043] ohci_hcd 0000:00:13.0: LATE suspend
[299248.657045] ehci_hcd 0000:00:12.2: LATE suspend
[299248.657047] ohci_hcd 0000:00:12.1: LATE suspend
[299248.657049] ohci_hcd 0000:00:12.0: LATE suspend
[299248.657052] ahci 0000:00:11.0: LATE suspend
[299248.657054] pcieport-driver 0000:00:0a.0: LATE suspend
[299248.657080] pci 0000:00:01.0: LATE suspend
[299248.657095] pci 0000:00:00.0: LATE suspend
[299248.657226] ACPI: Preparing to enter system sleep state S3
[299248.657654] Disabling non-boot CPUs ...
[299248.660214] kvm: disabling virtualization on CPU1
[299248.660269] CPU 1 is now offline
[299248.660349] SMP alternatives: switching to UP code
[299248.665159] CPU0 attaching NULL sched-domain.
[299248.665162] CPU1 attaching NULL sched-domain.
[299248.665244] CPU0 attaching NULL sched-domain.
[299248.665463] CPU1 is down
[299248.665508] Back to C!
[299248.665508] PCI-DMA: Resuming GART IOMMU
[299248.665508] PCI-DMA: Restoring GART aperture settings
[299248.665508] Enabling non-boot CPUs ...
[299248.666667] SMP alternatives: switching to SMP code
[299248.671158] Booting processor 1 APIC 0x1 ip 0x6000
[299248.664976] Initializing CPU#1
[299248.664976] Calibrating delay using timer specific routine.. 5010.89 BogoMIPS (lpj=10021787)
[299248.664976] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[299248.664976] CPU: L2 Cache: 512K (64 bytes/line)
[299248.664976] CPU 1/0x1 -> Node 0
[299248.664976] CPU: Physical Processor ID: 0
[299248.664976] CPU: Processor Core ID: 1
[299248.760137] CPU1: AMD Athlon(tm) Dual Core Processor 4850e stepping 02
[299248.760482] kvm: enabling virtualization on CPU1
[299248.760584] CPU0 attaching NULL sched-domain.
[299248.764521] Switched to high resolution mode on CPU 1
[299248.776103] CPU0 attaching sched-domain:
[299248.776107]  domain 0: span 0-1 level CPU
[299248.776110]   groups: 0 1
[299248.776114] CPU1 attaching sched-domain:
[299248.776117]  domain 0: span 0-1 level CPU
[299248.776119]   groups: 1 0
[299248.776516] CPU1 is up
[299248.776554] ACPI: Waking up from system sleep state S3
[299248.776843] pci 0000:00:00.0: EARLY resume
[299248.776860] pci 0000:00:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x2000)
[299248.776871] pci 0000:00:01.0: EARLY resume
[299248.776885] pcieport-driver 0000:00:0a.0: EARLY resume
[299248.776908] ahci 0000:00:11.0: EARLY resume
[299248.776938] ahci 0000:00:11.0: restoring config space at offset 0x2 (was 0x1018f00, writing 0x1060100)
[299248.776962] ahci 0000:00:11.0: set SATA to AHCI mode
[299248.776999] ohci_hcd 0000:00:12.0: EARLY resume
[299248.777024] ohci_hcd 0000:00:12.1: EARLY resume
[299248.777050] ehci_hcd 0000:00:12.2: EARLY resume
[299248.792536] ehci_hcd 0000:00:12.2: restoring config space at offset 0x1 (was 0x2b00000, writing 0x2b00012)
[299248.792550] ohci_hcd 0000:00:13.0: EARLY resume
[299248.792575] ohci_hcd 0000:00:13.1: EARLY resume
[299248.792600] ehci_hcd 0000:00:13.2: EARLY resume
[299248.808041] ehci_hcd 0000:00:13.2: restoring config space at offset 0x1 (was 0x2b00000, writing 0x2b00012)
[299248.808055] piix4_smbus 0000:00:14.0: EARLY resume
[299248.808087] ATIIXP_IDE 0000:00:14.1: EARLY resume
[299248.808119] HDA Intel 0000:00:14.2: EARLY resume
[299248.808129] HDA Intel 0000:00:14.2: restoring config space at offset 0xf (was 0x100, writing 0x5)
[299248.808148] HDA Intel 0000:00:14.2: restoring config space at offset 0x3 (was 0x0, writing 0x2001)
[299248.808161] pci 0000:00:14.3: EARLY resume
[299248.808186] pci 0000:00:14.4: EARLY resume
[299248.808210] ohci_hcd 0000:00:14.5: EARLY resume
[299248.808236] pci 0000:00:18.0: EARLY resume
[299248.808243] pci 0000:00:18.1: EARLY resume
[299248.808249] pci 0000:00:18.2: EARLY resume
[299248.808255] pci 0000:00:18.3: EARLY resume
[299248.808262] pci 0000:01:05.0: EARLY resume
[299248.808278] HDA Intel 0000:01:05.1: EARLY resume
[299248.808284] HDA Intel 0000:01:05.1: restoring config space at offset 0xf (was 0x2ff, writing 0x207)
[299248.808293] HDA Intel 0000:01:05.1: restoring config space at offset 0x4 (was 0x0, writing 0xfdffc000)
[299248.808297] HDA Intel 0000:01:05.1: restoring config space at offset 0x3 (was 0x800000, writing 0x800001)
[299248.808301] HDA Intel 0000:01:05.1: restoring config space at offset 0x1 (was 0x100000, writing 0x100002)
[299248.808308] r8169 0000:02:00.0: EARLY resume
[299248.808338] r8169 0000:02:00.0: restoring config space at offset 0x3 (was 0x1, writing 0x10)
[299248.808360] pcspkr pcspkr: EARLY resume
[299248.808367] serial8250 serial8250: EARLY resume
[299248.808371] i8042 i8042: EARLY resume
[299248.808383] it87 it87.552: EARLY resume
[299248.808570] acpi LNXSYSTM:00: legacy resume
[299248.808573] button LNXPWRBN:00: legacy resume
[299248.808576] processor ACPI_CPU:00: legacy resume
[299248.808580] processor ACPI_CPU:01: legacy resume
[299248.808582] processor ACPI_CPU:02: legacy resume
[299248.808585] processor ACPI_CPU:03: legacy resume
[299248.808587] acpi device:00: legacy resume
[299248.808589] button PNP0C0C:00: legacy resume
[299248.808592] pci_root PNP0A03:00: legacy resume
[299248.808594] acpi PNP0C02:00: legacy resume
[299248.808597] acpi device:01: legacy resume
[299248.808599] acpi device:02: legacy resume
[299248.808601] acpi device:03: legacy resume
[299248.808604] acpi device:04: legacy resume
[299248.808606] acpi device:05: legacy resume
[299248.808608] acpi device:06: legacy resume
[299248.808610] acpi device:07: legacy resume
[299248.808613] acpi device:08: legacy resume
[299248.808615] acpi device:09: legacy resume
[299248.808617] acpi device:0a: legacy resume
[299248.808619] acpi device:0b: legacy resume
[299248.808622] acpi device:0c: legacy resume
[299248.808624] acpi device:0d: legacy resume
[299248.808626] acpi device:0e: legacy resume
[299248.808629] acpi PNP0C02:01: legacy resume
[299248.808631] pci_link PNP0C0F:00: legacy resume
[299248.808634] pci_link PNP0C0F:01: legacy resume
[299248.808636] pci_link PNP0C0F:02: legacy resume
[299248.808638] pci_link PNP0C0F:03: legacy resume
[299248.808641] pci_link PNP0C0F:04: legacy resume
[299248.808643] pci_link PNP0C0F:05: legacy resume
[299248.808646] pci_link PNP0C0F:06: legacy resume
[299248.808648] pci_link PNP0C0F:07: legacy resume
[299248.808650] acpi PNP0000:00: legacy resume
[299248.808653] acpi PNP0200:00: legacy resume
[299248.808655] acpi PNP0100:00: legacy resume
[299248.808657] acpi PNP0103:00: legacy resume
[299248.808659] acpi PNP0B00:00: legacy resume
[299248.808662] acpi PNP0800:00: legacy resume
[299248.808664] acpi PNP0C04:00: legacy resume
[299248.808666] acpi device:0f: legacy resume
[299248.808669] acpi device:10: legacy resume
[299248.808671] acpi device:11: legacy resume
[299248.808673] acpi device:12: legacy resume
[299248.808676] acpi device:13: legacy resume
[299248.808678] acpi device:14: legacy resume
[299248.808680] acpi device:15: legacy resume
[299248.808682] acpi device:16: legacy resume
[299248.808685] acpi device:17: legacy resume
[299248.808687] acpi device:18: legacy resume
[299248.808689] acpi device:19: legacy resume
[299248.808692] acpi device:1a: legacy resume
[299248.808694] acpi device:1b: legacy resume
[299248.808696] acpi device:1c: legacy resume
[299248.808698] acpi device:1d: legacy resume
[299248.808701] acpi device:1e: legacy resume
[299248.808703] acpi device:1f: legacy resume
[299248.808705] acpi device:20: legacy resume
[299248.808708] acpi PNP0700:00: legacy resume
[299248.808710] acpi PNP0303:00: legacy resume
[299248.808712] acpi device:21: legacy resume
[299248.808715] acpi PNP0C02:02: legacy resume
[299248.808717] acpi PNP0C01:00: legacy resume
[299248.808719] acpi LNXTHERM:00: legacy resume
[299248.808722] acpi PNP0C14:00: legacy resume
[299248.808724] pci 0000:00:00.0: resume
[299248.808729] pci 0000:00:01.0: resume
[299248.808734] pcieport-driver 0000:00:0a.0: resume
[299248.808739] ahci 0000:00:11.0: resume
[299248.808788] ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[299248.808887] ohci_hcd 0000:00:12.0: resume
[299248.808926] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[299248.832015] ohci_hcd 0000:00:12.1: resume
[299248.832043] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[299248.856019] ehci_hcd 0000:00:12.2: resume
[299248.856078] ehci_hcd 0000:00:12.2: PME# disabled
[299248.856117] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[299248.856163] ehci_hcd 0000:00:12.2: PME# disabled
[299248.856202] ohci_hcd 0000:00:13.0: resume
[299248.856229] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[299248.880014] ohci_hcd 0000:00:13.1: resume
[299248.880041] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[299248.904013] ehci_hcd 0000:00:13.2: resume
[299248.904053] ehci_hcd 0000:00:13.2: PME# disabled
[299248.904091] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[299248.904137] ehci_hcd 0000:00:13.2: PME# disabled
[299248.904177] piix4_smbus 0000:00:14.0: resume
[299248.904180] ATIIXP_IDE 0000:00:14.1: resume
[299248.904185] ATIIXP_IDE 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[299248.904256] HDA Intel 0000:00:14.2: resume
[299248.904265] HDA Intel 0000:00:14.2: restoring config space at offset 0xf (was 0x105, writing 0x5)
[299248.904294] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[299249.000360] pci 0000:00:14.3: resume
[299249.000363] pci 0000:00:14.4: resume
[299249.000370] ohci_hcd 0000:00:14.5: resume
[299249.000409] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[299249.024014] pci 0000:00:18.0: resume
[299249.024017] pci 0000:00:18.1: resume
[299249.024019] pci 0000:00:18.2: resume
[299249.024022] pci 0000:00:18.3: resume
[299249.024024] pci 0000:01:05.0: resume
[299249.024027] pci 0000:01:05.0: PME# disabled
[299249.024063] HDA Intel 0000:01:05.1: resume
[299249.024080] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[299249.024121] HDA Intel 0000:01:05.1: setting latency timer to 64
[299249.024130] r8169 0000:02:00.0: resume
[299249.024177] r8169 0000:02:00.0: PME# disabled
[299249.024218] pnp 00:00: legacy resume
[299249.024221] system 00:01: legacy resume
[299249.024224] system 00:02: legacy resume
[299249.024226] pnp 00:03: legacy resume
[299249.024229] pnp 00:04: legacy resume
[299249.024231] rtc_cmos 00:05: legacy resume
[299249.024234] pnp 00:06: legacy resume
[299249.024236] pnp 00:07: legacy resume
[299249.024238] pnp 00:08: legacy resume
[299249.024241] i8042 kbd 00:09: legacy resume
[299249.024243] system 00:0a: legacy resume
[299249.024246] system 00:0b: legacy resume
[299249.024252] pcspkr pcspkr: resume
[299249.024274] serial8250 serial8250: resume
[299249.024287] i8042 i8042: resume
[299249.024309] atkbd serio0: legacy resume
[299249.024313] rtc rtc0: legacy class resume
[299249.024354] usb usb1: type resume
[299249.040043] r8169: eth0: link up
[299249.104043] usb usb2: type resume
[299249.128051] ata2: SATA link down (SStatus 0 SControl 300)
[299249.128117] ata4: SATA link down (SStatus 0 SControl 300)
[299249.128183] ata1: SATA link down (SStatus 0 SControl 300)
[299249.156033] sd 2:0:0:0: legacy resume
[299249.156037] sd 2:0:0:0: [sda] Starting disk
[299254.172018] ata3: link is slow to respond, please be patient (ready=0)
[299255.964034] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[299255.980044] sd 2:0:0:0: [sda] START_STOP FAILED
[299255.980081] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299255.980155] PM: Device 2:0:0:0 failed to resume: error 262144
[299255.980198] usb 1-3: type resume
[299255.983305] ide-cdrom 0.1: legacy resume
[299255.986180] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[299255.986992] hdb: UDMA/33 mode selected
[299255.987469] usb usb3: type resume
[299256.064043] usb usb4: type resume
[299256.092048] usb usb5: type resume
[299256.092053] usb usb6: type resume
[299256.092057] usb usb7: type resume
[299256.092061] usb 3-1: type resume
[299256.143095] it87 it87.552: resume
[299256.143116] it87 it87.552: completing resume
[299256.143123] usb 3-1: completing type resume
[299256.143127] usb usb7: completing type resume
[299256.143130] usb usb6: completing type resume
[299256.143134] usb usb5: completing type resume
[299256.143137] usb usb4: completing type resume
[299256.143141] usb usb3: completing type resume
[299256.143146] usb 1-3: completing type resume
[299256.143157] usb usb2: completing type resume
[299256.143166] usb usb1: completing type resume
[299256.143173] i8042 i8042: completing resume
[299256.143188] serial8250 serial8250: completing resume
[299256.143214] pcspkr pcspkr: completing resume
[299256.143226] r8169 0000:02:00.0: completing resume
[299256.143229] HDA Intel 0000:01:05.1: completing resume
[299256.143232] pci 0000:01:05.0: completing resume
[299256.143234] pci 0000:00:18.3: completing resume
[299256.143237] pci 0000:00:18.2: completing resume
[299256.143239] pci 0000:00:18.1: completing resume
[299256.143242] pci 0000:00:18.0: completing resume
[299256.143244] ohci_hcd 0000:00:14.5: completing resume
[299256.143247] pci 0000:00:14.4: completing resume
[299256.143249] pci 0000:00:14.3: completing resume
[299256.143251] HDA Intel 0000:00:14.2: completing resume
[299256.143254] ATIIXP_IDE 0000:00:14.1: completing resume
[299256.143257] piix4_smbus 0000:00:14.0: completing resume
[299256.143259] ehci_hcd 0000:00:13.2: completing resume
[299256.143262] ohci_hcd 0000:00:13.1: completing resume
[299256.143264] ohci_hcd 0000:00:13.0: completing resume
[299256.143267] ehci_hcd 0000:00:12.2: completing resume
[299256.143269] ohci_hcd 0000:00:12.1: completing resume
[299256.143271] ohci_hcd 0000:00:12.0: completing resume
[299256.143274] ahci 0000:00:11.0: completing resume
[299256.143277] pcieport-driver 0000:00:0a.0: completing resume
[299256.143279] pci 0000:00:01.0: completing resume
[299256.143282] pci 0000:00:00.0: completing resume
[299256.143316] PM: Finishing wakeup.
[299256.143317] Restarting tasks ... <6>sd 2:0:0:0: [sda] Unhandled error code
[299256.150609] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.150682] end_request: I/O error, dev sda, sector 57464531
[299256.150720] Buffer I/O error on device sda7, logical block 202816
[299256.150757] lost page write due to I/O error on sda7
[299256.150795] Buffer I/O error on device sda7, logical block 202817
[299256.150832] lost page write due to I/O error on sda7
[299256.150882] sd 2:0:0:0: [sda] Unhandled error code
[299256.150918] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.150988] end_request: I/O error, dev sda, sector 57464627
[299256.151026] Buffer I/O error on device sda7, logical block 202828
[299256.151062] lost page write due to I/O error on sda7
[299256.151099] Buffer I/O error on device sda7, logical block 202829
[299256.151136] lost page write due to I/O error on sda7
[299256.151175] sd 2:0:0:0: [sda] Unhandled error code
[299256.151211] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.151281] end_request: I/O error, dev sda, sector 57529531
[299256.151318] Buffer I/O error on device sda7, logical block 210941
[299256.151354] lost page write due to I/O error on sda7
[299256.151392] Buffer I/O error on device sda7, logical block 210942
[299256.151428] lost page write due to I/O error on sda7
[299256.151467] sd 2:0:0:0: [sda] Unhandled error code
[299256.151503] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.151574] end_request: I/O error, dev sda, sector 57530859
[299256.151610] Buffer I/O error on device sda7, logical block 211107
[299256.151647] lost page write due to I/O error on sda7
[299256.151685] sd 2:0:0:0: [sda] Unhandled error code
[299256.151721] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.151791] end_request: I/O error, dev sda, sector 57530867
[299256.151828] Buffer I/O error on device sda7, logical block 211108
[299256.151865] lost page write due to I/O error on sda7
[299256.151904] sd 2:0:0:0: [sda] Unhandled error code
[299256.151939] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.152014] end_request: I/O error, dev sda, sector 57532339
[299256.152055] Buffer I/O error on device sda7, logical block 211292
[299256.152092] lost page write due to I/O error on sda7
[299256.152129] Buffer I/O error on device sda7, logical block 211293
[299256.152166] lost page write due to I/O error on sda7
[299256.152969] sd 2:0:0:0: [sda] Unhandled error code
[299256.153012] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.153084] end_request: I/O error, dev sda, sector 55874491
[299256.153146] REISERFS abort (device sda7): Journal write error in flush_commit_list
[299256.153378] REISERFS warning (device sda7): clm-6006 reiserfs_dirty_inode: writing inode 407262 on readonly FS
[299256.283766] done.
[299261.141274] sd 2:0:0:0: [sda] Unhandled error code
[299261.141287] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141297] end_request: I/O error, dev sda, sector 84817109
[299261.141333] sd 2:0:0:0: [sda] Unhandled error code
[299261.141338] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141346] end_request: I/O error, dev sda, sector 84817733
[299261.141364] sd 2:0:0:0: [sda] Unhandled error code
[299261.141370] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141377] end_request: I/O error, dev sda, sector 84817877
[299261.141398] sd 2:0:0:0: [sda] Unhandled error code
[299261.141404] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141412] end_request: I/O error, dev sda, sector 84817917
[299261.141430] sd 2:0:0:0: [sda] Unhandled error code
[299261.141435] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141443] end_request: I/O error, dev sda, sector 84817925
[299261.141460] sd 2:0:0:0: [sda] Unhandled error code
[299261.141465] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141473] end_request: I/O error, dev sda, sector 84817893
[299261.141493] sd 2:0:0:0: [sda] Unhandled error code
[299261.141499] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141507] end_request: I/O error, dev sda, sector 84818061
[299261.141524] sd 2:0:0:0: [sda] Unhandled error code
[299261.141530] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141538] end_request: I/O error, dev sda, sector 84817765
[299261.141556] sd 2:0:0:0: [sda] Unhandled error code
[299261.141561] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141569] end_request: I/O error, dev sda, sector 84817909
[299261.141588] sd 2:0:0:0: [sda] Unhandled error code
[299261.141593] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141601] end_request: I/O error, dev sda, sector 84817933
[299261.141621] sd 2:0:0:0: [sda] Unhandled error code
[299261.141626] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141634] end_request: I/O error, dev sda, sector 84818069
[299261.141647] sd 2:0:0:0: [sda] Unhandled error code
[299261.141653] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141661] end_request: I/O error, dev sda, sector 84818197
[299261.141675] sd 2:0:0:0: [sda] Unhandled error code
[299261.141680] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141688] end_request: I/O error, dev sda, sector 84818205
[299261.141700] sd 2:0:0:0: [sda] Unhandled error code
[299261.141705] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141713] end_request: I/O error, dev sda, sector 84818333
[299261.141734] sd 2:0:0:0: [sda] Unhandled error code
[299261.141740] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141747] end_request: I/O error, dev sda, sector 84818077
[299261.141767] sd 2:0:0:0: [sda] Unhandled error code
[299261.141772] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141780] end_request: I/O error, dev sda, sector 84817949
[299261.141802] sd 2:0:0:0: [sda] Unhandled error code
[299261.141807] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141815] end_request: I/O error, dev sda, sector 84817989
[299261.141831] sd 2:0:0:0: [sda] Unhandled error code
[299261.141836] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141844] end_request: I/O error, dev sda, sector 84818109
[299261.141855] sd 2:0:0:0: [sda] Unhandled error code
[299261.141860] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141868] end_request: I/O error, dev sda, sector 84818213
[299261.141880] sd 2:0:0:0: [sda] Unhandled error code
[299261.141885] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141893] end_request: I/O error, dev sda, sector 84818373
[299261.141912] sd 2:0:0:0: [sda] Unhandled error code
[299261.141917] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141925] end_request: I/O error, dev sda, sector 84817885
[299261.141937] sd 2:0:0:0: [sda] Unhandled error code
[299261.141942] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141950] end_request: I/O error, dev sda, sector 84876213
[299261.141963] sd 2:0:0:0: [sda] Unhandled error code
[299261.141968] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.141976] end_request: I/O error, dev sda, sector 86184021
[299261.141988] sd 2:0:0:0: [sda] Unhandled error code
[299261.141993] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.142001] end_request: I/O error, dev sda, sector 89084733
[299261.142013] sd 2:0:0:0: [sda] Unhandled error code
[299261.142018] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.142027] end_request: I/O error, dev sda, sector 84397325
[299261.142042] sd 2:0:0:0: [sda] Unhandled error code
[299261.142047] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.142055] end_request: I/O error, dev sda, sector 84720813
[299261.142565] sd 2:0:0:0: [sda] Unhandled error code
[299261.142571] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299261.142579] end_request: I/O error, dev sda, sector 67622037
[299261.142717] REISERFS abort (device dm-0): Journal write error in flush_commit_list
[299291.140903] sd 2:0:0:0: [sda] Unhandled error code
[299291.140915] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.140926] end_request: I/O error, dev sda, sector 56939427
[299291.140935] __ratelimit: 42 callbacks suppressed
[299291.140942] Buffer I/O error on device sda7, logical block 137178
[299291.140949] lost page write due to I/O error on sda7
[299291.140979] sd 2:0:0:0: [sda] Unhandled error code
[299291.140984] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.140992] end_request: I/O error, dev sda, sector 56973483
[299291.140999] Buffer I/O error on device sda7, logical block 141435
[299291.141005] lost page write due to I/O error on sda7
[299291.141019] sd 2:0:0:0: [sda] Unhandled error code
[299291.141024] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141032] end_request: I/O error, dev sda, sector 64735675
[299291.141039] Buffer I/O error on device sda7, logical block 1111709
[299291.141044] lost page write due to I/O error on sda7
[299291.141056] sd 2:0:0:0: [sda] Unhandled error code
[299291.141061] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141069] end_request: I/O error, dev sda, sector 66644971
[299291.141076] Buffer I/O error on device sda7, logical block 1350371
[299291.141082] lost page write due to I/O error on sda7
[299291.141094] sd 2:0:0:0: [sda] Unhandled error code
[299291.141099] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141107] end_request: I/O error, dev sda, sector 64499459
[299291.141114] Buffer I/O error on device sda7, logical block 1082182
[299291.141119] lost page write due to I/O error on sda7
[299291.141131] sd 2:0:0:0: [sda] Unhandled error code
[299291.141136] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141144] end_request: I/O error, dev sda, sector 64705899
[299291.141150] Buffer I/O error on device sda7, logical block 1107987
[299291.141156] lost page write due to I/O error on sda7
[299291.141168] sd 2:0:0:0: [sda] Unhandled error code
[299291.141173] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141181] end_request: I/O error, dev sda, sector 64706243
[299291.141188] Buffer I/O error on device sda7, logical block 1108030
[299291.141193] lost page write due to I/O error on sda7
[299291.141205] sd 2:0:0:0: [sda] Unhandled error code
[299291.141210] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141218] end_request: I/O error, dev sda, sector 66569851
[299291.141224] Buffer I/O error on device sda7, logical block 1340981
[299291.141230] lost page write due to I/O error on sda7
[299291.141242] sd 2:0:0:0: [sda] Unhandled error code
[299291.141248] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141256] end_request: I/O error, dev sda, sector 78843021
[299291.141265] Buffer I/O error on device dm-0, logical block 1409148
[299291.141271] lost page write due to I/O error on dm-0
[299291.141283] sd 2:0:0:0: [sda] Unhandled error code
[299291.141288] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141296] end_request: I/O error, dev sda, sector 78928941
[299291.141303] Buffer I/O error on device dm-0, logical block 1419888
[299291.141309] lost page write due to I/O error on dm-0
[299291.141321] sd 2:0:0:0: [sda] Unhandled error code
[299291.141326] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141334] end_request: I/O error, dev sda, sector 84818389
[299291.141349] sd 2:0:0:0: [sda] Unhandled error code
[299291.141355] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141363] end_request: I/O error, dev sda, sector 64499467
[299291.141378] sd 2:0:0:0: [sda] Unhandled error code
[299291.141384] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141392] end_request: I/O error, dev sda, sector 84397333
[299291.141406] sd 2:0:0:0: [sda] Unhandled error code
[299291.141411] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141419] end_request: I/O error, dev sda, sector 84818005
[299291.141432] sd 2:0:0:0: [sda] Unhandled error code
[299291.141438] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141446] end_request: I/O error, dev sda, sector 84818213
[299291.141459] sd 2:0:0:0: [sda] Unhandled error code
[299291.141465] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141473] end_request: I/O error, dev sda, sector 84876213
[299291.141488] sd 2:0:0:0: [sda] Unhandled error code
[299291.141493] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299291.141501] end_request: I/O error, dev sda, sector 89084733
[299296.148088] sd 2:0:0:0: [sda] Unhandled error code
[299296.148099] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299296.148109] end_request: I/O error, dev sda, sector 84817757
[299296.148120] __ratelimit: 8 callbacks suppressed
[299296.148127] Buffer I/O error on device dm-0, logical block 2155990
[299296.148134] lost page write due to I/O error on dm-0
[299299.759754] sd 2:0:0:0: [sda] Unhandled error code
[299299.759768] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299299.759778] end_request: I/O error, dev sda, sector 77975389
[299299.759858] sd 2:0:0:0: [sda] Unhandled error code
[299299.759865] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299299.759873] end_request: I/O error, dev sda, sector 77975389
[299299.759883] Buffer I/O error on device dm-0, logical block 1300694
[299299.760004] sd 2:0:0:0: [sda] Unhandled error code
[299299.760011] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299299.760019] end_request: I/O error, dev sda, sector 77975389
[299299.760028] Buffer I/O error on device dm-0, logical block 1300694
[299326.144102] sd 2:0:0:0: [sda] Unhandled error code
[299326.144115] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299326.144125] end_request: I/O error, dev sda, sector 78843021
[299326.144137] Buffer I/O error on device dm-0, logical block 1409148
[299326.144143] lost page write due to I/O error on dm-0
[299326.144168] sd 2:0:0:0: [sda] Unhandled error code
[299326.144173] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299326.144181] end_request: I/O error, dev sda, sector 78928941
[299326.144189] Buffer I/O error on device dm-0, logical block 1419888
[299326.144195] lost page write due to I/O error on dm-0
[299361.144103] sd 2:0:0:0: [sda] Unhandled error code
[299361.144114] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299361.144125] end_request: I/O error, dev sda, sector 78928941
[299361.144137] Buffer I/O error on device dm-0, logical block 1419888
[299361.144143] lost page write due to I/O error on dm-0
[299361.144167] sd 2:0:0:0: [sda] Unhandled error code
[299361.144173] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299361.144181] end_request: I/O error, dev sda, sector 56939427
[299361.144189] Buffer I/O error on device sda7, logical block 137178
[299361.144195] lost page write due to I/O error on sda7
[299361.144208] sd 2:0:0:0: [sda] Unhandled error code
[299361.144213] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299361.144221] end_request: I/O error, dev sda, sector 78843021
[299361.144229] Buffer I/O error on device dm-0, logical block 1409148
[299361.144234] lost page write due to I/O error on dm-0
[299375.733423] REISERFS warning (device sda7): clm-6006 reiserfs_dirty_inode: writing inode 407262 on readonly FS
[299396.144087] sd 2:0:0:0: [sda] Unhandled error code
[299396.144099] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299396.144109] end_request: I/O error, dev sda, sector 78843021
[299396.144120] Buffer I/O error on device dm-0, logical block 1409148
[299396.144127] lost page write due to I/O error on dm-0
[299396.144151] sd 2:0:0:0: [sda] Unhandled error code
[299396.144157] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299396.144165] end_request: I/O error, dev sda, sector 78928941
[299396.144173] Buffer I/O error on device dm-0, logical block 1419888
[299396.144178] lost page write due to I/O error on dm-0


> > Does that mean the SATA MSI quirk won't solve my problem?
> 
> I think it's likely a different issue.  Can you please try to
> reproduce the problem and see how many tries it usually takes?

This time it were 79 successful resumes and the 80th one did not
succeed. 

Because I never shutdown my system I will reproduce it by force, 
but I am going to try to script a little bit to automatically
suspend and resume in order to get the next results faster.



By the way thanks for your continuing help.

Benjamin
