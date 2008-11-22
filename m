From: Alexander Clausen <alex@gc-web.de>
Subject: Re: Suspend w/ sata_promise
Date: Sat, 22 Nov 2008 19:59:40 +0100
Message-ID: <4928569C.9080805@gc-web.de>
References: <49202CB0.60507@gc-web.de>	<18720.18615.938839.921189@harpo.it.uu.se>	<492060D9.20808@gc-web.de>	<18723.52001.559166.255589@harpo.it.uu.se> <18728.13696.418178.143954@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403020809080908020007"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:57246 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbYKVS7q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 13:59:46 -0500
In-Reply-To: <18728.13696.418178.143954@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020403020809080908020007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
>  > 
>  > Based on several other libata sata drivers I think handling suspend in
>  > sata_promise may be as simple as hooking ata_pci_device_{suspend,resume},
>  > which is what the patch below does. If this doesn't work then the most
>  > likely solution is to augment the ->resume op with a Promise-specific
>  > controller reset (again similar to several other sata drivers).
>  > 
>  > Care to give it a try? The patch is against 2.6.28-rc5 but should also
>  > work in 2.6.27.
> 
> Alexander, have you had a chance to test this? Preferably together
> with Tejun's hardreset improvement patch posted recently.
> <http://marc.info/?l=linux-ide&m=122724338905689&w=2>
> 
> With both this and Tejun's hardreset patch applied my Promise test
> machine survives several suspend/resume cycles without problems.

Did not work here. I applied both patches to 2.6.27.6, seems to behave exactly as before.
dmesg attached.

Alex

--------------020403020809080908020007
Content-Type: text/plain;
 name="gu-dmesg-with-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gu-dmesg-with-patch"

nds
[  251.267347] EXT3 FS on sdb1, internal journal
[  251.267432] EXT3-fs: mounted filesystem with ordered data mode.
[  284.935327] PM: Syncing filesystems ... done.
[  284.942293] PM: Preparing system for mem sleep
[  284.943220] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  284.943612] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  284.943776] PM: Entering mem sleep
[  284.943793] agpgart-amd64 0000:00:00.0: preparing suspend
[  284.943795] pci 0000:00:01.0: preparing suspend
[  284.943797] sata_via 0000:00:08.0: preparing suspend
[  284.943799] r8169 0000:00:0b.0: preparing suspend
[  284.943801] sata_promise 0000:00:0d.0: preparing suspend
[  284.943803] pci 0000:00:0e.0: preparing suspend
[  284.943805] sata_via 0000:00:0f.0: preparing suspend
[  284.943807] VIA_IDE 0000:00:0f.1: preparing suspend
[  284.943809] uhci_hcd 0000:00:10.0: preparing suspend
[  284.943811] uhci_hcd 0000:00:10.1: preparing suspend
[  284.943813] uhci_hcd 0000:00:10.2: preparing suspend
[  284.943815] uhci_hcd 0000:00:10.3: preparing suspend
[  284.943817] ehci_hcd 0000:00:10.4: preparing suspend
[  284.943819] pci 0000:00:11.0: preparing suspend
[  284.943821] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  284.943823] pci 0000:00:18.0: preparing suspend
[  284.943825] pci 0000:00:18.1: preparing suspend
[  284.943827] pci 0000:00:18.2: preparing suspend
[  284.943829] k8temp 0000:00:18.3: preparing suspend
[  284.943831] nvidia 0000:01:00.0: preparing suspend
[  284.943839] pcspkr pcspkr: preparing suspend
[  284.943842] platform vesafb.0: preparing suspend
[  284.943860] serial8250 serial8250: preparing suspend
[  284.943881] usb usb1: preparing type suspend, may wakeup
[  284.943885] usb usb2: preparing type suspend, may wakeup
[  284.943888] usb usb3: preparing type suspend, may wakeup
[  284.943891] usb usb4: preparing type suspend, may wakeup
[  284.943894] usb usb5: preparing type suspend, may wakeup
[  284.943896] usb 3-2: preparing type suspend, may wakeup
[  284.943900] i8042 i8042: preparing suspend
[  284.943907] platform floppy.0: preparing suspend
[  284.943918] usb 1-2: preparing type suspend
[  284.943924] sd 8:0:0:0: legacy suspend
[  284.943929] usb 1-2: type suspend
[  284.956032] rtc rtc0: legacy class suspend
[  284.956061] platform floppy.0: suspend
[  284.956064] ac97 0-0:ALC655: legacy suspend
[  284.956067] psmouse serio1: legacy suspend
[  285.419357] atkbd serio0: legacy suspend
[  285.964022] i8042 i8042: suspend
[  285.964032] usb 3-2: type suspend, may wakeup
[  285.980027] usb usb5: type suspend, may wakeup
[  285.980030] usb usb4: type suspend, may wakeup
[  285.980032] usb usb3: type suspend, may wakeup
[  285.980046] usb usb2: type suspend, may wakeup
[  285.980048] usb usb1: type suspend, may wakeup
[  285.980067] sd 1:0:0:0: legacy suspend
[  285.980070] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  285.980284] sd 1:0:0:0: [sda] Stopping disk
[  286.292755] serial8250 serial8250: suspend
[  286.292767] platform vesafb.0: suspend
[  286.292769] pcspkr pcspkr: suspend
[  286.292777] i8042 kbd 00:0a: legacy suspend
[  286.292795] i8042 aux 00:09: legacy suspend
[  286.292799] pnp 00:08: legacy suspend
[  286.292801] pnp 00:07: legacy suspend
[  286.292803] rtc_cmos 00:06: legacy suspend, may wakeup
[  286.292810] pnp 00:05: legacy suspend
[  286.292812] system 00:04: legacy suspend
[  286.292816] pnp 00:03: legacy suspend
[  286.292818] serial 00:02: legacy suspend
[  286.292972] serial 00:02: disabled
[  286.293038] pnp 00:01: legacy suspend
[  286.293040] pnp 00:00: legacy suspend
[  286.293042] nvidia 0000:01:00.0: suspend
[  286.293046] ACPI handle has no context!
[  286.293057] NVRM: RmPowerManagement: 4
[  286.368257] k8temp 0000:00:18.3: suspend
[  286.368265] pci 0000:00:18.2: suspend
[  286.368270] pci 0000:00:18.1: suspend
[  286.368275] pci 0000:00:18.0: suspend
[  286.368281] VIA 82xx Audio 0000:00:11.5: suspend
[  286.369014] VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
[  286.384028] pci 0000:00:11.0: suspend
[  286.384051] ehci_hcd 0000:00:10.4: suspend
[  286.384079] ehci_hcd 0000:00:10.4: PCI INT C disabled
[  286.400024] uhci_hcd 0000:00:10.3: suspend
[  286.400052] uhci_hcd 0000:00:10.3: PCI INT B disabled
[  286.416023] uhci_hcd 0000:00:10.2: suspend
[  286.416050] uhci_hcd 0000:00:10.2: PCI INT B disabled
[  286.432023] uhci_hcd 0000:00:10.1: suspend
[  286.432051] uhci_hcd 0000:00:10.1: PCI INT A disabled
[  286.448022] uhci_hcd 0000:00:10.0: suspend
[  286.448050] uhci_hcd 0000:00:10.0: PCI INT A disabled
[  286.464023] VIA_IDE 0000:00:0f.1: suspend
[  286.464047] sata_via 0000:00:0f.0: suspend
[  286.824051] sata_via 0000:00:0f.0: PCI INT B disabled
[  286.840027] pci 0000:00:0e.0: suspend
[  286.840050] sata_promise 0000:00:0d.0: suspend
[  286.840718] sata_promise 0000:00:0d.0: PCI INT A disabled
[  286.856027] r8169 0000:00:0b.0: suspend
[  286.856055] ACPI handle has no context!
[  286.856059] ACPI handle has no context!
[  286.872026] sata_via 0000:00:08.0: suspend
[  286.872090] sata_via 0000:00:08.0: PCI INT A disabled
[  286.888027] pci 0000:00:01.0: suspend
[  286.888046] agpgart-amd64 0000:00:00.0: suspend
[  286.888078] ACPI handle has no context!
[  286.904027] acpi LNXTHERM:00: legacy suspend
[  286.904029] button PNP0C0E:00: legacy suspend
[  286.904031] pci_link PNP0C0F:07: legacy suspend
[  286.904033] pci_link PNP0C0F:06: legacy suspend
[  286.904035] pci_link PNP0C0F:05: legacy suspend
[  286.904037] pci_link PNP0C0F:04: legacy suspend
[  286.904039] pci_link PNP0C0F:03: legacy suspend
[  286.904041] pci_link PNP0C0F:02: legacy suspend
[  286.904043] pci_link PNP0C0F:01: legacy suspend
[  286.904045] pci_link PNP0C0F:00: legacy suspend
[  286.904046] acpi device:13: legacy suspend
[  286.904048] acpi device:12: legacy suspend
[  286.904050] acpi device:11: legacy suspend
[  286.904052] acpi device:10: legacy suspend
[  286.904054] acpi device:0f: legacy suspend
[  286.904056] acpi device:0e: legacy suspend
[  286.904057] acpi device:0d: legacy suspend
[  286.904059] acpi device:0c: legacy suspend
[  286.904061] acpi device:0b: legacy suspend
[  286.904063] acpi device:0a: legacy suspend
[  286.904065] acpi device:09: legacy suspend
[  286.904066] acpi device:08: legacy suspend
[  286.904068] acpi PNP0303:00: legacy suspend
[  286.904070] acpi PNP0F13:00: legacy suspend
[  286.904072] acpi PNP0C04:00: legacy suspend
[  286.904074] acpi PNP0800:00: legacy suspend
[  286.904076] acpi PNP0B00:00: legacy suspend
[  286.904077] acpi PNP0100:00: legacy suspend
[  286.904079] acpi PNP0200:00: legacy suspend
[  286.904081] acpi PNP0C02:00: legacy suspend
[  286.904083] acpi device:07: legacy suspend
[  286.904085] acpi device:06: legacy suspend
[  286.904087] acpi device:05: legacy suspend
[  286.904089] acpi device:04: legacy suspend
[  286.904090] acpi device:03: legacy suspend
[  286.904092] acpi device:02: legacy suspend
[  286.904094] acpi device:01: legacy suspend
[  286.904096] power LNXPOWER:03: legacy suspend
[  286.904098] power LNXPOWER:02: legacy suspend
[  286.904100] power LNXPOWER:01: legacy suspend
[  286.904102] power LNXPOWER:00: legacy suspend
[  286.904104] acpi PNP0401:00: legacy suspend
[  286.904106] acpi PNP0501:00: legacy suspend
[  286.904107] acpi PNP0700:00: legacy suspend
[  286.904109] pci_root PNP0A03:00: legacy suspend
[  286.904111] button PNP0C0C:00: legacy suspend
[  286.904113] acpi device:00: legacy suspend
[  286.904115] processor ACPI0007:00: legacy suspend
[  286.904118] button LNXPWRBN:00: legacy suspend
[  286.904120] acpi LNXSYSTM:00: legacy suspend
[  286.904333] ACPI: Preparing to enter system sleep state S3
[  286.904729] platform floppy.0: LATE suspend
[  286.904733] i8042 i8042: LATE suspend
[  286.904745] serial8250 serial8250: LATE suspend
[  286.904753] platform vesafb.0: LATE suspend
[  286.904755] pcspkr pcspkr: LATE suspend
[  286.904759] nvidia 0000:01:00.0: LATE suspend
[  286.904762] k8temp 0000:00:18.3: LATE suspend
[  286.904764] pci 0000:00:18.2: LATE suspend
[  286.904765] pci 0000:00:18.1: LATE suspend
[  286.904767] pci 0000:00:18.0: LATE suspend
[  286.904769] VIA 82xx Audio 0000:00:11.5: LATE suspend
[  286.904771] pci 0000:00:11.0: LATE suspend
[  286.904773] ehci_hcd 0000:00:10.4: LATE suspend
[  286.904775] uhci_hcd 0000:00:10.3: LATE suspend
[  286.904776] uhci_hcd 0000:00:10.2: LATE suspend
[  286.904778] uhci_hcd 0000:00:10.1: LATE suspend
[  286.904780] uhci_hcd 0000:00:10.0: LATE suspend
[  286.904782] VIA_IDE 0000:00:0f.1: LATE suspend
[  286.904784] sata_via 0000:00:0f.0: LATE suspend
[  286.904785] pci 0000:00:0e.0: LATE suspend
[  286.904787] sata_promise 0000:00:0d.0: LATE suspend
[  286.904789] r8169 0000:00:0b.0: LATE suspend
[  286.904791] sata_via 0000:00:08.0: LATE suspend
[  286.904793] pci 0000:00:01.0: LATE suspend
[  286.904795] agpgart-amd64 0000:00:00.0: LATE suspend
[  286.908011]  hwsleep-0311 [00] enter_sleep_state     : Entering sleep state [S3]
[  286.908011] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  286.908011] Intel machine check architecture supported.
[  286.908011] Intel machine check reporting enabled on CPU#0.
[  286.908011] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[  286.908011] Back to C!
[  286.908011] agpgart-amd64 0000:00:00.0: EARLY resume
[  286.908011] pci 0000:00:01.0: EARLY resume
[  286.908011] sata_via 0000:00:08.0: EARLY resume
[  286.908011] r8169 0000:00:0b.0: EARLY resume
[  286.908011] sata_promise 0000:00:0d.0: EARLY resume
[  286.908011] pci 0000:00:0e.0: EARLY resume
[  286.908011] sata_via 0000:00:0f.0: EARLY resume
[  286.908011] VIA_IDE 0000:00:0f.1: EARLY resume
[  286.908011] uhci_hcd 0000:00:10.0: EARLY resume
[  286.908011] uhci_hcd 0000:00:10.1: EARLY resume
[  286.908011] uhci_hcd 0000:00:10.2: EARLY resume
[  286.908011] uhci_hcd 0000:00:10.3: EARLY resume
[  286.908011] ehci_hcd 0000:00:10.4: EARLY resume
[  286.908011] pci 0000:00:11.0: EARLY resume
[  286.908011] VIA 82xx Audio 0000:00:11.5: EARLY resume
[  286.908011] pci 0000:00:18.0: EARLY resume
[  286.908011] pci 0000:00:18.1: EARLY resume
[  286.908011] pci 0000:00:18.2: EARLY resume
[  286.908011] k8temp 0000:00:18.3: EARLY resume
[  286.908011] nvidia 0000:01:00.0: EARLY resume
[  286.908011] pcspkr pcspkr: EARLY resume
[  286.908011] platform vesafb.0: EARLY resume
[  286.908011] serial8250 serial8250: EARLY resume
[  286.908011] i8042 i8042: EARLY resume
[  286.908011] platform floppy.0: EARLY resume
[  286.908011] ACPI: Waking up from system sleep state S3
[  287.564153] acpi LNXSYSTM:00: legacy resume
[  287.564155] button LNXPWRBN:00: legacy resume
[  287.564157] processor ACPI0007:00: legacy resume
[  287.564160] acpi device:00: legacy resume
[  287.564161] button PNP0C0C:00: legacy resume
[  287.564163] pci_root PNP0A03:00: legacy resume
[  287.564165] acpi PNP0700:00: legacy resume
[  287.564167] acpi PNP0501:00: legacy resume
[  287.564169] acpi PNP0401:00: legacy resume
[  287.564171] power LNXPOWER:00: legacy resume
[  287.564196] power LNXPOWER:01: legacy resume
[  287.564220] power LNXPOWER:02: legacy resume
[  287.564243] power LNXPOWER:03: legacy resume
[  287.564267] acpi device:01: legacy resume
[  287.564268] acpi device:02: legacy resume
[  287.564270] acpi device:03: legacy resume
[  287.564272] acpi device:04: legacy resume
[  287.564274] acpi device:05: legacy resume
[  287.564276] acpi device:06: legacy resume
[  287.564278] acpi device:07: legacy resume
[  287.564279] acpi PNP0C02:00: legacy resume
[  287.564281] acpi PNP0200:00: legacy resume
[  287.564283] acpi PNP0100:00: legacy resume
[  287.564285] acpi PNP0B00:00: legacy resume
[  287.564286] acpi PNP0800:00: legacy resume
[  287.564288] acpi PNP0C04:00: legacy resume
[  287.564290] acpi PNP0F13:00: legacy resume
[  287.564292] acpi PNP0303:00: legacy resume
[  287.564294] acpi device:08: legacy resume
[  287.564295] acpi device:09: legacy resume
[  287.564297] acpi device:0a: legacy resume
[  287.564299] acpi device:0b: legacy resume
[  287.564301] acpi device:0c: legacy resume
[  287.564303] acpi device:0d: legacy resume
[  287.564304] acpi device:0e: legacy resume
[  287.564306] acpi device:0f: legacy resume
[  287.564308] acpi device:10: legacy resume
[  287.564310] acpi device:11: legacy resume
[  287.564311] acpi device:12: legacy resume
[  287.564313] acpi device:13: legacy resume
[  287.564315] pci_link PNP0C0F:00: legacy resume
[  287.564317] pci_link PNP0C0F:01: legacy resume
[  287.564319] pci_link PNP0C0F:02: legacy resume
[  287.564321] pci_link PNP0C0F:03: legacy resume
[  287.564323] pci_link PNP0C0F:04: legacy resume
[  287.564325] pci_link PNP0C0F:05: legacy resume
[  287.564326] pci_link PNP0C0F:06: legacy resume
[  287.564328] pci_link PNP0C0F:07: legacy resume
[  287.564330] button PNP0C0E:00: legacy resume
[  287.564332] acpi LNXTHERM:00: legacy resume
[  287.564334] agpgart-amd64 0000:00:00.0: resume
[  287.580056] pci 0000:00:01.0: resume
[  287.580080] pci 0000:00:01.0: setting latency timer to 64
[  287.580083] sata_via 0000:00:08.0: resume
[  287.596053] sata_via 0000:00:08.0: PCI INT A -> Link[LNKD] -> GSI 10 (level, low) -> IRQ 10
[  287.596244] r8169 0000:00:0b.0: resume
[  287.612042] r8169 0000:00:0b.0: restoring config space at offset 0x3 (was 0x2008, writing 0x4008)
[  287.612057] sata_promise 0000:00:0d.0: resume
[  287.628039] r8169: eth1: link up
[  287.628128] sata_promise 0000:00:0d.0: PCI INT A -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
[  287.628594] pci 0000:00:0e.0: resume
[  287.628617] sata_via 0000:00:0f.0: resume
[  287.644051] sata_via 0000:00:0f.0: PCI INT B -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
[  287.644119] VIA_IDE 0000:00:0f.1: resume
[  287.644125] VIA_IDE 0000:00:0f.1: restoring config space at offset 0xf (was 0x1ff, writing 0x10b)
[  287.644150] VIA_IDE 0000:00:0f.1: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  287.644211] uhci_hcd 0000:00:10.0: resume
[  287.660028] uhci_hcd 0000:00:10.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  287.660126] usb usb2: root hub lost power or was reset
[  287.660182] uhci_hcd 0000:00:10.1: resume
[  287.676028] uhci_hcd 0000:00:10.1: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  287.676128] usb usb3: root hub lost power or was reset
[  287.676183] uhci_hcd 0000:00:10.2: resume
[  287.692028] uhci_hcd 0000:00:10.2: PCI INT B -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
[  287.692122] usb usb4: root hub lost power or was reset
[  287.692178] uhci_hcd 0000:00:10.3: resume
[  287.708028] uhci_hcd 0000:00:10.3: PCI INT B -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
[  287.708124] usb usb5: root hub lost power or was reset
[  287.708180] ehci_hcd 0000:00:10.4: resume
[  287.724028] ehci_hcd 0000:00:10.4: PCI INT C -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[  287.724105] ehci_hcd 0000:00:10.4: restoring config space at offset 0x3 (was 0x802008, writing 0x802010)
[  287.724116] pci 0000:00:11.0: resume
[  287.724141] VIA 82xx Audio 0000:00:11.5: resume
[  287.740050] VIA 82xx Audio 0000:00:11.5: PCI INT C -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[  287.740119] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[  287.743062] pci 0000:00:18.0: resume
[  287.743069] pci 0000:00:18.1: resume
[  287.743074] pci 0000:00:18.2: resume
[  287.743080] k8temp 0000:00:18.3: resume
[  287.743085] nvidia 0000:01:00.0: resume
[  287.743100] NVRM: RmPowerManagement: 5
[  287.937261] ata5: SATA link down (SStatus 0 SControl 310)
[  287.937332] ata4: SATA link down (SStatus 0 SControl 310)
[  287.948092] ata1: SATA link down (SStatus 0 SControl 300)
[  288.104053] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  288.120510] ata2.00: configured for UDMA/133
[  288.120798] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  288.120858] sd 1:0:0:0: [sda] Write Protect is off
[  288.120906] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  288.120922] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  288.623918] pnp 00:00: legacy resume
[  288.623923] pnp 00:01: legacy resume
[  288.623925] serial 00:02: legacy resume
[  288.624705] serial 00:02: activated
[  288.624756] pnp 00:03: legacy resume
[  288.624758] system 00:04: legacy resume
[  288.624760] pnp 00:05: legacy resume
[  288.624762] rtc_cmos 00:06: legacy resume
[  288.624765] pnp 00:07: legacy resume
[  288.624766] pnp 00:08: legacy resume
[  288.624768] i8042 aux 00:09: legacy resume
[  288.624771] i8042 kbd 00:0a: legacy resume
[  288.624775] pcspkr pcspkr: resume
[  288.624778] platform vesafb.0: resume
[  288.624793] serial8250 serial8250: resume
[  288.624809] sd 1:0:0:0: legacy resume
[  288.624812] sd 1:0:0:0: [sda] Starting disk
[  288.630209] usb usb1: type resume
[  288.696044] usb usb2: type resume
[  288.696047] usb usb3: type resume
[  288.944027] usb usb4: type resume
[  288.944030] usb usb5: type resume
[  288.944032] usb 3-2: type resume
[  289.056029] usb 3-2: reset full speed USB device using uhci_hcd and address 2
[  289.202941] i8042 i8042: resume
[  289.202966] atkbd serio0: legacy resume
[  289.202969] psmouse serio1: legacy resume
[  289.202973] ac97 0-0:ALC655: legacy resume
[  289.202977] platform floppy.0: resume
[  289.202982] rtc rtc0: legacy class resume
[  289.203020] usb 1-2: type resume
[  289.248174] sd 8:0:0:0: legacy resume
[  289.248180] usb 1-2: completing type resume
[  289.248185] platform floppy.0: completing resume
[  289.248188] i8042 i8042: completing resume
[  289.248191] usb 3-2: completing type resume
[  289.248193] usb usb5: completing type resume
[  289.248195] usb usb4: completing type resume
[  289.248197] usb usb3: completing type resume
[  289.248199] usb usb2: completing type resume
[  289.248201] usb usb1: completing type resume
[  289.248212] serial8250 serial8250: completing resume
[  289.248220] platform vesafb.0: completing resume
[  289.248222] pcspkr pcspkr: completing resume
[  289.248227] nvidia 0000:01:00.0: completing resume
[  289.248229] k8temp 0000:00:18.3: completing resume
[  289.248231] pci 0000:00:18.2: completing resume
[  289.248233] pci 0000:00:18.1: completing resume
[  289.248234] pci 0000:00:18.0: completing resume
[  289.248237] VIA 82xx Audio 0000:00:11.5: completing resume
[  289.248239] pci 0000:00:11.0: completing resume
[  289.248241] ehci_hcd 0000:00:10.4: completing resume
[  289.248242] uhci_hcd 0000:00:10.3: completing resume
[  289.248244] uhci_hcd 0000:00:10.2: completing resume
[  289.248246] uhci_hcd 0000:00:10.1: completing resume
[  289.248248] uhci_hcd 0000:00:10.0: completing resume
[  289.248250] VIA_IDE 0000:00:0f.1: completing resume
[  289.248252] sata_via 0000:00:0f.0: completing resume
[  289.248254] pci 0000:00:0e.0: completing resume
[  289.248256] sata_promise 0000:00:0d.0: completing resume
[  289.248258] r8169 0000:00:0b.0: completing resume
[  289.248260] sata_via 0000:00:08.0: completing resume
[  289.248262] pci 0000:00:01.0: completing resume
[  289.248264] agpgart-amd64 0000:00:00.0: completing resume
[  289.248277] PM: Finishing wakeup.
[  289.248278] Restarting tasks ... done.
[  325.641151] PM: Syncing filesystems ... done.
[  325.659966] PM: Preparing system for mem sleep
[  325.660883] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  325.661281] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  325.661461] PM: Entering mem sleep
[  325.661479] agpgart-amd64 0000:00:00.0: preparing suspend
[  325.661481] pci 0000:00:01.0: preparing suspend
[  325.661483] sata_via 0000:00:08.0: preparing suspend
[  325.661485] r8169 0000:00:0b.0: preparing suspend
[  325.661487] sata_promise 0000:00:0d.0: preparing suspend
[  325.661489] pci 0000:00:0e.0: preparing suspend
[  325.661491] sata_via 0000:00:0f.0: preparing suspend
[  325.661493] VIA_IDE 0000:00:0f.1: preparing suspend
[  325.661495] uhci_hcd 0000:00:10.0: preparing suspend
[  325.661497] uhci_hcd 0000:00:10.1: preparing suspend
[  325.661499] uhci_hcd 0000:00:10.2: preparing suspend
[  325.661501] uhci_hcd 0000:00:10.3: preparing suspend
[  325.661503] ehci_hcd 0000:00:10.4: preparing suspend
[  325.661505] pci 0000:00:11.0: preparing suspend
[  325.661507] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  325.661509] pci 0000:00:18.0: preparing suspend
[  325.661511] pci 0000:00:18.1: preparing suspend
[  325.661513] pci 0000:00:18.2: preparing suspend
[  325.661515] k8temp 0000:00:18.3: preparing suspend
[  325.661517] nvidia 0000:01:00.0: preparing suspend
[  325.661525] pcspkr pcspkr: preparing suspend
[  325.661528] platform vesafb.0: preparing suspend
[  325.661545] serial8250 serial8250: preparing suspend
[  325.661566] usb usb1: preparing type suspend, may wakeup
[  325.661570] usb usb2: preparing type suspend, may wakeup
[  325.661573] usb usb3: preparing type suspend, may wakeup
[  325.661576] usb usb4: preparing type suspend, may wakeup
[  325.661579] usb usb5: preparing type suspend, may wakeup
[  325.661581] usb 3-2: preparing type suspend, may wakeup
[  325.661585] i8042 i8042: preparing suspend
[  325.661592] platform floppy.0: preparing suspend
[  325.661602] usb 1-2: preparing type suspend
[  325.661608] sd 8:0:0:0: legacy suspend
[  325.661614] usb 1-2: type suspend
[  325.676032] rtc rtc0: legacy class suspend
[  325.676061] platform floppy.0: suspend
[  325.676064] ac97 0-0:ALC655: legacy suspend
[  325.676067] psmouse serio1: legacy suspend
[  326.139718] atkbd serio0: legacy suspend
[  326.684026] i8042 i8042: suspend
[  326.684036] usb 3-2: type suspend, may wakeup
[  326.700028] usb usb5: type suspend, may wakeup
[  326.700030] usb usb4: type suspend, may wakeup
[  326.700033] usb usb3: type suspend, may wakeup
[  326.700047] usb usb2: type suspend, may wakeup
[  326.700049] usb usb1: type suspend, may wakeup
[  326.700068] sd 1:0:0:0: legacy suspend
[  326.700070] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  326.700270] sd 1:0:0:0: [sda] Stopping disk
[  356.700042] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  356.700097] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  356.700098]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  356.700204] ata2.00: status: { DRDY }
[  356.700259] ata2: hard resetting link
[  357.020040] ata2: SATA link down (SStatus 100 SControl 300)
[  357.201056] ata2: hard resetting link
[  357.676057] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.692923] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  357.692925] ata2.00: revalidation failed (errno=-2)
[  362.676030] ata2: hard resetting link
[  363.152055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  363.168527] ata2.00: configured for UDMA/133
[  363.168781] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  363.168832] ata2: hotplug_status 0x2
[  363.184526] ata2.00: configured for UDMA/133
[  363.184576] ata2: EH complete
[  393.184032] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  393.184085] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  393.184086]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  393.184195] ata2.00: status: { DRDY }
[  393.184247] ata2: hard resetting link
[  393.504040] ata2: SATA link down (SStatus 100 SControl 300)
[  393.685041] ata2: hard resetting link
[  394.160056] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  394.176527] ata2.00: configured for UDMA/133
[  394.176780] ata2: limiting SATA link speed to 1.5 Gbps
[  394.176829] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  394.176880] ata2: hotplug_status 0x2
[  394.176932] ata2: hard resetting link
[  395.056056] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  395.072921] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  395.072924] ata2.00: revalidation failed (errno=-2)
[  400.056032] ata2: hard resetting link
[  400.532056] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  400.548527] ata2.00: configured for UDMA/133
[  400.548576] ata2: EH complete
[  430.548035] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  430.548088] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  430.548089]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  430.548199] ata2.00: status: { DRDY }
[  430.548250] ata2: hard resetting link
[  430.868039] ata2: SATA link down (SStatus 100 SControl 300)
[  431.049048] ata2: hard resetting link
[  431.524055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  431.540528] ata2.00: configured for UDMA/133
[  431.540780] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  431.540830] ata2: hotplug_status 0x2
[  431.556523] ata2.00: configured for UDMA/133
[  431.556571] ata2: EH complete
[  461.556034] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  461.556087] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  461.556088]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  461.556196] ata2.00: status: { DRDY }
[  461.556251] ata2: hard resetting link
[  461.876041] ata2: SATA link down (SStatus 100 SControl 300)
[  462.057051] ata2: hard resetting link
[  462.532056] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  462.548527] ata2.00: configured for UDMA/133
[  462.548781] ata2.00: limiting speed to UDMA/100:PIO4
[  462.548829] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  462.548878] ata2: hotplug_status 0x2
[  462.548930] ata2: hard resetting link
[  463.428055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  463.444524] ata2.00: configured for UDMA/100
[  463.444573] ata2: EH complete
[  493.444034] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  493.444090] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  493.444091]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  493.444201] ata2.00: status: { DRDY }
[  493.444256] ata2: hard resetting link
[  493.764040] ata2: SATA link down (SStatus 100 SControl 300)
[  493.945059] ata2: hard resetting link
[  494.420057] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  494.436525] ata2.00: configured for UDMA/100
[  494.436780] ata2.00: limiting speed to UDMA/33:PIO4
[  494.436830] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  494.436880] ata2: hotplug_status 0x2
[  494.436941] ata2: hard resetting link
[  495.316055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  495.332525] ata2.00: configured for UDMA/33
[  495.332579] ata2: EH complete
[  525.332034] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  525.332087] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  525.332088]          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
[  525.332195] ata2.00: status: { DRDY }
[  525.332246] ata2: hard resetting link
[  525.652039] ata2: SATA link down (SStatus 100 SControl 300)
[  525.833043] ata2: hard resetting link
[  526.308055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  526.324527] ata2.00: configured for UDMA/33
[  526.324780] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  526.324830] ata2: hotplug_status 0x2
[  526.340526] ata2.00: configured for UDMA/33
[  526.340577] sd 1:0:0:0: [sda] START_STOP FAILED
[  526.340625] sd 1:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  526.340720] sd 1:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  526.340912] sd 1:0:0:0: [sda] Add. Sense: No additional sense information
[  526.341031] suspend_device(): scsi_bus_suspend+0x0/0x3f returns 134217730
[  526.341154] PM: Device 1:0:0:0 failed to suspend: error 134217730
[  526.341203] PM: Some devices failed to suspend
[  526.341280] usb usb1: type resume
[  526.369089] ata2: EH complete
[  526.369164] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  526.369226] sd 1:0:0:0: [sda] Write Protect is off
[  526.369275] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  526.369291] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  526.369369] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  526.369427] sd 1:0:0:0: [sda] Write Protect is off
[  526.369476] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  526.369491] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  526.408037] usb usb2: type resume
[  526.408040] usb usb3: type resume
[  526.448029] usb usb4: type resume
[  526.448032] usb usb5: type resume
[  526.448033] usb 3-2: type resume
[  526.499029] i8042 i8042: resume
[  526.499053] atkbd serio0: legacy resume
[  526.499056] psmouse serio1: legacy resume
[  526.499060] ac97 0-0:ALC655: legacy resume
[  526.499063] platform floppy.0: resume
[  526.499067] rtc rtc0: legacy class resume
[  526.499106] usb 1-2: type resume
[  526.544154] sd 8:0:0:0: legacy resume
[  526.544160] usb 1-2: completing type resume
[  526.544165] platform floppy.0: completing resume
[  526.544168] i8042 i8042: completing resume
[  526.544171] usb 3-2: completing type resume
[  526.544173] usb usb5: completing type resume
[  526.544175] usb usb4: completing type resume
[  526.544177] usb usb3: completing type resume
[  526.544180] usb usb2: completing type resume
[  526.544182] usb usb1: completing type resume
[  526.544194] serial8250 serial8250: completing resume
[  526.544206] platform vesafb.0: completing resume
[  526.544208] pcspkr pcspkr: completing resume
[  526.544214] nvidia 0000:01:00.0: completing resume
[  526.544216] k8temp 0000:00:18.3: completing resume
[  526.544218] pci 0000:00:18.2: completing resume
[  526.544220] pci 0000:00:18.1: completing resume
[  526.544221] pci 0000:00:18.0: completing resume
[  526.544223] VIA 82xx Audio 0000:00:11.5: completing resume
[  526.544225] pci 0000:00:11.0: completing resume
[  526.544227] ehci_hcd 0000:00:10.4: completing resume
[  526.544229] uhci_hcd 0000:00:10.3: completing resume
[  526.544231] uhci_hcd 0000:00:10.2: completing resume
[  526.544233] uhci_hcd 0000:00:10.1: completing resume
[  526.544234] uhci_hcd 0000:00:10.0: completing resume
[  526.544236] VIA_IDE 0000:00:0f.1: completing resume
[  526.544238] sata_via 0000:00:0f.0: completing resume
[  526.544240] pci 0000:00:0e.0: completing resume
[  526.544242] sata_promise 0000:00:0d.0: completing resume
[  526.544244] r8169 0000:00:0b.0: completing resume
[  526.544246] sata_via 0000:00:08.0: completing resume
[  526.544248] pci 0000:00:01.0: completing resume
[  526.544250] agpgart-amd64 0000:00:00.0: completing resume
[  526.544259] PM: Finishing wakeup.
[  526.544261] Restarting tasks ... done.
[  526.628454] PM: Removing info for No Bus:mouse0
[  526.640035] PM: Removing info for No Bus:event1
[  526.652039] PM: Removing info for No Bus:input1

--------------020403020809080908020007--
