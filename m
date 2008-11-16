From: Alexander Clausen <alex@gc-web.de>
Subject: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 15:22:40 +0100
Message-ID: <49202CB0.60507@gc-web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060008000003050109080703"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:50353 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbYKPOWp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 09:22:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.gc-web.de (Postfix) with ESMTP id 38B448A0005
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 15:22:43 +0100 (CET)
Received: from mail.gc-web.de ([127.0.0.1])
	by localhost (server2.gc-web.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z6DSPXkTRPIT for <linux-ide@vger.kernel.org>;
	Sun, 16 Nov 2008 15:22:41 +0100 (CET)
Received: from [192.168.0.62] (p57990E22.dip.t-dialin.net [87.153.14.34])
	by mail.gc-web.de (Postfix) with ESMTP id A32058A0001
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 15:22:40 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008000003050109080703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
I'm trying to get suspend to ram working on one of the desktop systems here. The mainboard is a
MSI K8T Neo FIS2R with a Promise PDC20378 (FastTrak 378/SATA 378) (rev 02).
When trying to suspend the first time, everything works just fine, but when trying to suspend a
second time, the computer is unresponsive for a long time and does not complete the suspend
operation. After that, the file systems are not accessible any more, programs don't start etc...
So, then I saw on the wiki that suspend is not supported on sata_promise. Is this still the case, or
am I hitting a bug in the suspend code?

Alex

--------------060008000003050109080703
Content-Type: text/plain;
 name="dmesg-gu-2nd-suspend-fail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-gu-2nd-suspend-fail"

[   52.994486] agpgart-amd64 0000:00:00.0: AGP 3.0 bridge
[   52.994498] agpgart-amd64 0000:00:00.0: putting AGP V3 device into 8x mode
[   52.994554] nvidia 0000:01:00.0: putting AGP V3 device into 8x mode
[   53.514297] PM: Adding info for No Bus:i2c-1
[   53.515835] PM: Adding info for No Bus:i2c-1
[   53.515980] PM: Adding info for No Bus:i2c-2
[   53.516079] PM: Adding info for No Bus:i2c-2
[   53.516139] PM: Adding info for No Bus:i2c-3
[   53.516202] PM: Adding info for No Bus:i2c-3
[  138.457436] PM: Syncing filesystems ... done.
[  138.513505] PM: Preparing system for mem sleep
[  138.514373] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  138.597300] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  138.685471] PM: Entering mem sleep
[  138.685488] agpgart-amd64 0000:00:00.0: preparing suspend
[  138.685490] pci 0000:00:01.0: preparing suspend
[  138.685492] r8169 0000:00:0b.0: preparing suspend
[  138.685495] sata_promise 0000:00:0d.0: preparing suspend
[  138.685497] pci 0000:00:0e.0: preparing suspend
[  138.685499] sata_via 0000:00:0f.0: preparing suspend

[  138.685501] VIA_IDE 0000:00:0f.1: preparing suspend
[  138.685503] uhci_hcd 0000:00:10.0: preparing suspend
[  138.685505] uhci_hcd 0000:00:10.1: preparing suspend
[  138.685507] uhci_hcd 0000:00:10.2: preparing suspend
[  138.685509] uhci_hcd 0000:00:10.3: preparing suspend
[  138.685511] ehci_hcd 0000:00:10.4: preparing suspend
[  138.685513] pci 0000:00:11.0: preparing suspend
[  138.685515] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  138.685517] pci 0000:00:18.0: preparing suspend
[  138.685519] pci 0000:00:18.1: preparing suspend
[  138.685521] pci 0000:00:18.2: preparing suspend
[  138.685523] k8temp 0000:00:18.3: preparing suspend
[  138.685525] nvidia 0000:01:00.0: preparing suspend
[  138.685533] pcspkr pcspkr: preparing suspend
[  138.685536] platform vesafb.0: preparing suspend
[  138.685553] serial8250 serial8250: preparing suspend
[  138.685575] usb usb1: preparing type suspend, may wakeup
[  138.685578] usb usb2: preparing type suspend, may wakeup
[  138.685581] usb usb3: preparing type suspend, may wakeup
[  138.685584] usb usb4: preparing type suspend, may wakeup
[  138.685586] usb 3-2: preparing type suspend, may wakeup
[  138.685590] usb usb5: preparing type suspend, may wakeup
[  138.685594] i8042 i8042: preparing suspend
[  138.685602] platform floppy.0: preparing suspend
[  138.685615] rtc rtc0: legacy class suspend
[  138.685642] platform floppy.0: suspend
[  138.685645] ac97 0-0:ALC655: legacy suspend
[  138.685648] psmouse serio1: legacy suspend
[  139.143835] atkbd serio0: legacy suspend
[  139.688026] i8042 i8042: suspend
[  139.688037] usb usb5: type suspend, may wakeup
[  139.688040] usb 3-2: type suspend, may wakeup
[  139.704029] usb usb4: type suspend, may wakeup
[  139.704032] usb usb3: type suspend, may wakeup
[  139.704046] usb usb2: type suspend, may wakeup
[  139.704049] usb usb1: type suspend, may wakeup
[  139.704052] sd 1:0:0:0: legacy suspend
[  139.704057] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  139.765726] sd 1:0:0:0: [sda] Stopping disk
[  140.118347] ide-cdrom 0.0: legacy suspend
[  140.118370] serial8250 serial8250: suspend
[  140.118383] platform vesafb.0: suspend
[  140.118385] pcspkr pcspkr: suspend
[  140.118393] i8042 kbd 00:0a: legacy suspend
[  140.118412] i8042 aux 00:09: legacy suspend
[  140.118416] pnp 00:08: legacy suspend
[  140.118417] pnp 00:07: legacy suspend
[  140.118419] rtc_cmos 00:06: legacy suspend, may wakeup
[  140.118427] pnp 00:05: legacy suspend
[  140.118429] system 00:04: legacy suspend
[  140.118432] pnp 00:03: legacy suspend
[  140.118434] serial 00:02: legacy suspend
[  140.118597] serial 00:02: disabled
[  140.118827] pnp 00:01: legacy suspend
[  140.118829] pnp 00:00: legacy suspend
[  140.118831] nvidia 0000:01:00.0: suspend
[  140.118835] ACPI handle has no context!
[  140.118844] NVRM: RmPowerManagement: 4
[  140.194220] k8temp 0000:00:18.3: suspend
[  140.194228] pci 0000:00:18.2: suspend
[  140.194233] pci 0000:00:18.1: suspend
[  140.194238] pci 0000:00:18.0: suspend
[  140.194244] VIA 82xx Audio 0000:00:11.5: suspend
[  140.194978] VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
[  140.208032] pci 0000:00:11.0: suspend


[  140.208055] ehci_hcd 0000:00:10.4: suspend
[  140.208083] ehci_hcd 0000:00:10.4: PCI INT C disabled
[  140.224028] uhci_hcd 0000:00:10.3: suspend
[  140.224055] uhci_hcd 0000:00:10.3: PCI INT B disabled
[  140.240027] uhci_hcd 0000:00:10.2: suspend
[  140.240054] uhci_hcd 0000:00:10.2: PCI INT B disabled
[  140.256028] uhci_hcd 0000:00:10.1: suspend
[  140.256055] uhci_hcd 0000:00:10.1: PCI INT A disabled
[  140.272027] uhci_hcd 0000:00:10.0: suspend
[  140.272054] uhci_hcd 0000:00:10.0: PCI INT A disabled
[  140.288026] VIA_IDE 0000:00:0f.1: suspend
[  140.288050] sata_via 0000:00:0f.0: suspend
[  140.648051] sata_via 0000:00:0f.0: PCI INT B disabled
[  140.664027] pci 0000:00:0e.0: suspend
[  140.664050] sata_promise 0000:00:0d.0: suspend
[  140.664073] r8169 0000:00:0b.0: suspend
[  140.664100] ACPI handle has no context!
[  140.664104] ACPI handle has no context!
[  140.680026] pci 0000:00:01.0: suspend
[  140.680044] agpgart-amd64 0000:00:00.0: suspend
[  140.680075] ACPI handle has no context!
[  140.696027] acpi LNXTHERM:00: legacy suspend
[  140.696030] button PNP0C0E:00: legacy suspend
[  140.696032] pci_link PNP0C0F:07: legacy suspend
[  140.696034] pci_link PNP0C0F:06: legacy suspend
[  140.696036] pci_link PNP0C0F:05: legacy suspend
[  140.696038] pci_link PNP0C0F:04: legacy suspend
[  140.696040] pci_link PNP0C0F:03: legacy suspend
[  140.696042] pci_link PNP0C0F:02: legacy suspend
[  140.696043] pci_link PNP0C0F:01: legacy suspend
[  140.696045] pci_link PNP0C0F:00: legacy suspend
[  140.696047] acpi device:13: legacy suspend
[  140.696049] acpi device:12: legacy suspend
[  140.696051] acpi device:11: legacy suspend
[  140.696053] acpi device:10: legacy suspend
[  140.696055] acpi device:0f: legacy suspend
[  140.696056] acpi device:0e: legacy suspend
[  140.696058] acpi device:0d: legacy suspend
[  140.696060] acpi device:0c: legacy suspend
[  140.696062] acpi device:0b: legacy suspend
[  140.696064] acpi device:0a: legacy suspend
[  140.696065] acpi device:09: legacy suspend
[  140.696067] acpi device:08: legacy suspend
[  140.696069] acpi PNP0303:00: legacy suspend
[  140.696071] acpi PNP0F13:00: legacy suspend
[  140.696073] acpi PNP0C04:00: legacy suspend
[  140.696075] acpi PNP0800:00: legacy suspend
[  140.696077] acpi PNP0B00:00: legacy suspend
[  140.696079] acpi PNP0100:00: legacy suspend
[  140.696081] acpi PNP0200:00: legacy suspend
[  140.696082] acpi PNP0C02:00: legacy suspend
[  140.696084] acpi device:07: legacy suspend
[  140.696086] acpi device:06: legacy suspend
[  140.696088] acpi device:05: legacy suspend
[  140.696090] acpi device:04: legacy suspend
[  140.696092] acpi device:03: legacy suspend
[  140.696094] acpi device:02: legacy suspend
[  140.696095] acpi device:01: legacy suspend
[  140.696097] power LNXPOWER:03: legacy suspend
[  140.696099] power LNXPOWER:02: legacy suspend
[  140.696101] power LNXPOWER:01: legacy suspend
[  140.696103] power LNXPOWER:00: legacy suspend
[  140.696105] acpi PNP0401:00: legacy suspend
[  140.696107] acpi PNP0501:00: legacy suspend
[  140.696109] acpi PNP0700:00: legacy suspend


[  140.696111] pci_root PNP0A03:00: legacy suspend
[  140.696113] button PNP0C0C:00: legacy suspend
[  140.696115] acpi device:00: legacy suspend
[  140.696117] processor ACPI0007:00: legacy suspend
[  140.696119] button LNXPWRBN:00: legacy suspend
[  140.696121] acpi LNXSYSTM:00: legacy suspend
[  140.696339] ACPI: Preparing to enter system sleep state S3
[  140.696898] platform floppy.0: LATE suspend
[  140.696903] i8042 i8042: LATE suspend
[  140.696913] serial8250 serial8250: LATE suspend
[  140.696921] platform vesafb.0: LATE suspend
[  140.696923] pcspkr pcspkr: LATE suspend
[  140.696927] nvidia 0000:01:00.0: LATE suspend
[  140.696930] k8temp 0000:00:18.3: LATE suspend
[  140.696931] pci 0000:00:18.2: LATE suspend
[  140.696933] pci 0000:00:18.1: LATE suspend
[  140.696935] pci 0000:00:18.0: LATE suspend
[  140.696937] VIA 82xx Audio 0000:00:11.5: LATE suspend
[  140.696939] pci 0000:00:11.0: LATE suspend
[  140.696940] ehci_hcd 0000:00:10.4: LATE suspend
[  140.696942] uhci_hcd 0000:00:10.3: LATE suspend
[  140.696944] uhci_hcd 0000:00:10.2: LATE suspend
[  140.696946] uhci_hcd 0000:00:10.1: LATE suspend
[  140.696948] uhci_hcd 0000:00:10.0: LATE suspend
[  140.696949] VIA_IDE 0000:00:0f.1: LATE suspend
[  140.696951] sata_via 0000:00:0f.0: LATE suspend
[  140.696953] pci 0000:00:0e.0: LATE suspend
[  140.696955] sata_promise 0000:00:0d.0: LATE suspend
[  140.696957] r8169 0000:00:0b.0: LATE suspend
[  140.696959] pci 0000:00:01.0: LATE suspend
[  140.696960] agpgart-amd64 0000:00:00.0: LATE suspend
[  140.700011]  hwsleep-0311 [00] enter_sleep_state     : Entering sleep state [S3]
[  140.700011] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  140.700011] Intel machine check architecture supported.
[  140.700011] Intel machine check reporting enabled on CPU#0.
[  140.700011] evxfevnt-0079 [00] enable                : System is already in ACPI mode
[  140.700011] Back to C!
[  140.700011] agpgart-amd64 0000:00:00.0: EARLY resume
[  140.700011] pci 0000:00:01.0: EARLY resume
[  140.700011] r8169 0000:00:0b.0: EARLY resume
[  140.700011] sata_promise 0000:00:0d.0: EARLY resume
[  140.700011] pci 0000:00:0e.0: EARLY resume
[  140.700011] sata_via 0000:00:0f.0: EARLY resume
[  140.700011] VIA_IDE 0000:00:0f.1: EARLY resume
[  140.700011] uhci_hcd 0000:00:10.0: EARLY resume
[  140.700011] uhci_hcd 0000:00:10.1: EARLY resume
[  140.700011] uhci_hcd 0000:00:10.2: EARLY resume
[  140.700011] uhci_hcd 0000:00:10.3: EARLY resume
[  140.700011] ehci_hcd 0000:00:10.4: EARLY resume
[  140.700011] pci 0000:00:11.0: EARLY resume
[  140.700011] VIA 82xx Audio 0000:00:11.5: EARLY resume
[  140.700011] pci 0000:00:18.0: EARLY resume
[  140.700011] pci 0000:00:18.1: EARLY resume
[  140.700011] pci 0000:00:18.2: EARLY resume
[  140.700011] k8temp 0000:00:18.3: EARLY resume
[  140.700011] nvidia 0000:01:00.0: EARLY resume
[  140.700011] pcspkr pcspkr: EARLY resume
[  140.700011] platform vesafb.0: EARLY resume
[  140.700011] serial8250 serial8250: EARLY resume
[  140.700011] i8042 i8042: EARLY resume
[  140.700011] platform floppy.0: EARLY resume
[  140.700011] ACPI: Waking up from system sleep state S3
[  142.748155] acpi LNXSYSTM:00: legacy resume
[  142.748158] button LNXPWRBN:00: legacy resume
[  142.748160] processor ACPI0007:00: legacy resume

[  142.748162] acpi device:00: legacy resume
[  142.748164] button PNP0C0C:00: legacy resume
[  142.748166] pci_root PNP0A03:00: legacy resume
[  142.748168] acpi PNP0700:00: legacy resume
[  142.748170] acpi PNP0501:00: legacy resume
[  142.748172] acpi PNP0401:00: legacy resume
[  142.748174] power LNXPOWER:00: legacy resume
[  142.748199] power LNXPOWER:01: legacy resume
[  142.748223] power LNXPOWER:02: legacy resume
[  142.748247] power LNXPOWER:03: legacy resume
[  142.748270] acpi device:01: legacy resume
[  142.748272] acpi device:02: legacy resume
[  142.748274] acpi device:03: legacy resume
[  142.748276] acpi device:04: legacy resume
[  142.748278] acpi device:05: legacy resume
[  142.748280] acpi device:06: legacy resume
[  142.748281] acpi device:07: legacy resume
[  142.748283] acpi PNP0C02:00: legacy resume
[  142.748285] acpi PNP0200:00: legacy resume
[  142.748287] acpi PNP0100:00: legacy resume
[  142.748289] acpi PNP0B00:00: legacy resume
[  142.748291] acpi PNP0800:00: legacy resume
[  142.748292] acpi PNP0C04:00: legacy resume
[  142.748294] acpi PNP0F13:00: legacy resume
[  142.748296] acpi PNP0303:00: legacy resume
[  142.748298] acpi device:08: legacy resume
[  142.748300] acpi device:09: legacy resume
[  142.748301] acpi device:0a: legacy resume
[  142.748303] acpi device:0b: legacy resume
[  142.748305] acpi device:0c: legacy resume
[  142.748307] acpi device:0d: legacy resume
[  142.748309] acpi device:0e: legacy resume
[  142.748310] acpi device:0f: legacy resume
[  142.748312] acpi device:10: legacy resume
[  142.748314] acpi device:11: legacy resume
[  142.748316] acpi device:12: legacy resume
[  142.748318] acpi device:13: legacy resume
[  142.748320] pci_link PNP0C0F:00: legacy resume
[  142.748322] pci_link PNP0C0F:01: legacy resume
[  142.748323] pci_link PNP0C0F:02: legacy resume
[  142.748325] pci_link PNP0C0F:03: legacy resume
[  142.748327] pci_link PNP0C0F:04: legacy resume
[  142.748329] pci_link PNP0C0F:05: legacy resume
[  142.748331] pci_link PNP0C0F:06: legacy resume
[  142.748333] pci_link PNP0C0F:07: legacy resume
[  142.748335] button PNP0C0E:00: legacy resume
[  142.748337] acpi LNXTHERM:00: legacy resume
[  142.748339] agpgart-amd64 0000:00:00.0: resume
[  142.764056] pci 0000:00:01.0: resume
[  142.764080] pci 0000:00:01.0: setting latency timer to 64
[  142.764083] r8169 0000:00:0b.0: resume
[  142.780042] r8169 0000:00:0b.0: restoring config space at offset 0x3 (was 0x2008, writing 0x4008)
[  142.780057] sata_promise 0000:00:0d.0: resume
[  142.780087] sata_promise 0000:00:0d.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[  145.114325] r8169: eth1: link up
[  145.988842] pci 0000:00:0e.0: resume
[  145.988865] sata_via 0000:00:0f.0: resume
[  146.004047] sata_via 0000:00:0f.0: PCI INT B -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[  148.246044] VIA_IDE 0000:00:0f.1: resume
[  148.246051] VIA_IDE 0000:00:0f.1: restoring config space at offset 0xf (was 0x1ff, writing 0x10b)
[  148.246077] VIA_IDE 0000:00:0f.1: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  150.470285] uhci_hcd 0000:00:10.0: resume
[  150.484025] uhci_hcd 0000:00:10.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  152.725863] usb usb2: root hub lost power or was reset
[  154.100316] uhci_hcd 0000:00:10.1: resume

[  154.116025] uhci_hcd 0000:00:10.1: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
[  156.357833] usb usb3: root hub lost power or was reset
[  157.728539] uhci_hcd 0000:00:10.2: resume
[  157.744025] uhci_hcd 0000:00:10.2: PCI INT B -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[  159.985834] usb usb4: root hub lost power or was reset
[  161.372505] uhci_hcd 0000:00:10.3: resume
[  161.388025] uhci_hcd 0000:00:10.3: PCI INT B -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[  163.621579] usb usb5: root hub lost power or was reset
[  165.008255] ehci_hcd 0000:00:10.4: resume
[  165.024025] ehci_hcd 0000:00:10.4: PCI INT C -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[  167.203570] ehci_hcd 0000:00:10.4: restoring config space at offset 0x3 (was 0x802008, writing 0x802010)
[  167.203581] pci 0000:00:11.0: resume
[  167.203604] VIA 82xx Audio 0000:00:11.5: resume
[  167.216047] VIA 82xx Audio 0000:00:11.5: PCI INT C -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[  169.537609] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[  169.540565] pci 0000:00:18.0: resume
[  169.540571] pci 0000:00:18.1: resume
[  169.540576] pci 0000:00:18.2: resume
[  169.540581] k8temp 0000:00:18.3: resume
[  169.540586] nvidia 0000:01:00.0: resume
[  169.540602] NVRM: RmPowerManagement: 5
[  171.417511] pnp 00:00: legacy resume
[  171.417515] pnp 00:01: legacy resume
[  171.417518] serial 00:02: legacy resume
[  171.418302] serial 00:02: activated
[  172.365880] pnp 00:03: legacy resume
[  172.365882] system 00:04: legacy resume
[  172.365884] pnp 00:05: legacy resume
[  172.365886] rtc_cmos 00:06: legacy resume
[  172.365889] pnp 00:07: legacy resume
[  172.365891] pnp 00:08: legacy resume
[  172.365892] i8042 aux 00:09: legacy resume
[  172.365895] i8042 kbd 00:0a: legacy resume
[  172.365900] pcspkr pcspkr: resume
[  172.365902] platform vesafb.0: resume
[  172.365918] serial8250 serial8250: resume
[  172.365934] ide-cdrom 0.0: legacy resume
[  172.367939] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[  172.373384] hda: UDMA/33 mode selected
[  173.379285] sd 1:0:0:0: legacy resume
[  173.379288] sd 1:0:0:0: [sda] Starting disk
[  174.518083] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0xe frozen
[  176.551848] ata2.00: hotplug_status 0x20
[  177.602899] ata2: SError: { 10B8B Dispar }
[  178.712237] ata2.00: cmd 40/00:01:00:00:00/00:00:00:00:00/e0 tag 0
[  178.712239]          res 50/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
[  182.525313] ata2.00: status: { DRDY }
[  183.519109] ata2: hard resetting link
[  185.236056] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  186.908531] ata2.00: configured for UDMA/133
[  188.064092] ata2: EH complete
[  188.882146] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  190.798590] usb usb1: type resume
[  190.826617] sd 1:0:0:0: [sda] Write Protect is off
[  192.120892] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  192.121610] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  194.542384] usb usb2: type resume
[  194.542388] usb usb3: type resume
[  194.788029] usb usb4: type resume
[  194.788031] usb 3-2: type resume
[  194.900030] usb 3-2: reset full speed USB device using uhci_hcd and address 2
[  196.966474] usb usb5: type resume
[  196.966477] i8042 i8042: resume
[  196.966502] atkbd serio0: legacy resume
[  196.966505] psmouse serio1: legacy resume

[  196.966510] ac97 0-0:ALC655: legacy resume
[  196.966514] platform floppy.0: resume
[  196.966517] rtc rtc0: legacy class resume
[  196.966561] platform floppy.0: completing resume
[  196.966565] i8042 i8042: completing resume
[  196.966568] usb usb5: completing type resume
[  196.966570] usb 3-2: completing type resume
[  196.966572] usb usb4: completing type resume
[  196.966575] usb usb3: completing type resume
[  196.966577] usb usb2: completing type resume
[  196.966580] usb usb1: completing type resume
[  196.966593] serial8250 serial8250: completing resume
[  196.966605] platform vesafb.0: completing resume
[  196.966608] pcspkr pcspkr: completing resume
[  196.966613] nvidia 0000:01:00.0: completing resume
[  196.966616] k8temp 0000:00:18.3: completing resume
[  196.966618] pci 0000:00:18.2: completing resume
[  196.966620] pci 0000:00:18.1: completing resume
[  196.966622] pci 0000:00:18.0: completing resume
[  196.966624] VIA 82xx Audio 0000:00:11.5: completing resume
[  196.966626] pci 0000:00:11.0: completing resume
[  196.966628] ehci_hcd 0000:00:10.4: completing resume
[  196.966630] uhci_hcd 0000:00:10.3: completing resume
[  196.966632] uhci_hcd 0000:00:10.2: completing resume
[  196.966634] uhci_hcd 0000:00:10.1: completing resume
[  196.966636] uhci_hcd 0000:00:10.0: completing resume
[  196.966638] VIA_IDE 0000:00:0f.1: completing resume
[  196.966640] sata_via 0000:00:0f.0: completing resume
[  196.966642] pci 0000:00:0e.0: completing resume
[  196.966644] sata_promise 0000:00:0d.0: completing resume
[  196.966647] r8169 0000:00:0b.0: completing resume
[  196.966649] pci 0000:00:01.0: completing resume
[  196.966651] agpgart-amd64 0000:00:00.0: completing resume
[  196.966664] PM: Finishing wakeup.
[  196.966666] Restarting tasks ... done.
[  544.108189] PM: Syncing filesystems ... done.
[  545.279162] PM: Preparing system for mem sleep
[  545.280042] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  547.181546] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  549.203386] PM: Entering mem sleep
[  549.203404] agpgart-amd64 0000:00:00.0: preparing suspend
[  549.203407] pci 0000:00:01.0: preparing suspend
[  549.203409] r8169 0000:00:0b.0: preparing suspend
[  549.203411] sata_promise 0000:00:0d.0: preparing suspend
[  549.203413] pci 0000:00:0e.0: preparing suspend
[  549.203415] sata_via 0000:00:0f.0: preparing suspend
[  549.203417] VIA_IDE 0000:00:0f.1: preparing suspend
[  549.203419] uhci_hcd 0000:00:10.0: preparing suspend
[  549.203421] uhci_hcd 0000:00:10.1: preparing suspend
[  549.203423] uhci_hcd 0000:00:10.2: preparing suspend
[  549.203425] uhci_hcd 0000:00:10.3: preparing suspend
[  549.203428] ehci_hcd 0000:00:10.4: preparing suspend
[  549.203430] pci 0000:00:11.0: preparing suspend
[  549.203432] VIA 82xx Audio 0000:00:11.5: preparing suspend
[  549.203434] pci 0000:00:18.0: preparing suspend
[  549.203436] pci 0000:00:18.1: preparing suspend
[  549.203438] pci 0000:00:18.2: preparing suspend
[  549.203440] k8temp 0000:00:18.3: preparing suspend
[  549.203442] nvidia 0000:01:00.0: preparing suspend
[  549.203450] pcspkr pcspkr: preparing suspend
[  549.203453] platform vesafb.0: preparing suspend
[  549.203471] serial8250 serial8250: preparing suspend
[  549.203492] usb usb1: preparing type suspend, may wakeup
[  549.203495] usb usb2: preparing type suspend, may wakeup
[  549.203498] usb usb3: preparing type suspend, may wakeup

[  549.203501] usb usb4: preparing type suspend, may wakeup
[  549.203504] usb 3-2: preparing type suspend, may wakeup
[  549.203507] usb usb5: preparing type suspend, may wakeup
[  549.203510] i8042 i8042: preparing suspend
[  549.203518] platform floppy.0: preparing suspend
[  549.203532] rtc rtc0: legacy class suspend
[  549.203559] platform floppy.0: suspend
[  549.203562] ac97 0-0:ALC655: legacy suspend
[  549.203565] psmouse serio1: legacy suspend
[  549.664161] atkbd serio0: legacy suspend
[  550.208027] i8042 i8042: suspend
[  550.208038] usb usb5: type suspend, may wakeup
[  550.208040] usb 3-2: type suspend, may wakeup
[  550.224030] usb usb4: type suspend, may wakeup
[  550.224033] usb usb3: type suspend, may wakeup
[  550.224047] usb usb2: type suspend, may wakeup
[  550.224049] usb usb1: type suspend, may wakeup
[  550.224053] sd 1:0:0:0: legacy suspend
[  550.224057] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  551.610971] sd 1:0:0:0: [sda] Stopping disk
[  582.736042] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  584.604223] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  584.604224]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  588.255569] ata2.00: status: { DRDY }
[  589.249364] ata2: hard resetting link
[  590.560041] ata2: SATA link down (SStatus 100 SControl 300)
[  592.045597] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  593.709580] ata2.00: revalidation failed (errno=-5)
[  597.044030] ata2: hard resetting link
[  598.332055] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  600.008911] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  600.008914] ata2.00: revalidation failed (errno=-2)
[  604.992030] ata2: hard resetting link
[  606.280054] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  607.936527] ata2.00: configured for UDMA/133
[  609.092304] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  610.848729] ata2: hotplug_status 0x22
[  611.840527] ata2.00: configured for UDMA/133
[  612.996089] ata2: EH complete
[  643.804035] ata2: limiting SATA link speed to 1.5 Gbps
[  645.145309] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  647.040408] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  647.040409]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  650.691733] ata2.00: status: { DRDY }
[  651.685525] ata2: hard resetting link
[  652.996041] ata2: SATA link down (SStatus 100 SControl 300)
[  654.498285] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  656.162268] ata2.00: revalidation failed (errno=-5)
[  659.496029] ata2: hard resetting link
[  660.808053] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

[  662.464524] ata2.00: configured for UDMA/133
[  663.620303] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  665.366383] ata2: hotplug_status 0x22
[  666.376530] ata2.00: configured for UDMA/133
[  667.532089] ata2: EH complete
[  698.340034] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  700.189577] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  700.189579]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  703.840933] ata2.00: status: { DRDY }
[  704.834725] ata2: hard resetting link
[  706.148039] ata2: SATA link down (SStatus 100 SControl 300)
[  707.630942] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  709.294937] ata2.00: revalidation failed (errno=-5)
[  712.628030] ata2: hard resetting link
[  713.916054] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  715.572529] ata2.00: configured for UDMA/133
[  716.728295] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  718.484729] ata2: hotplug_status 0x22
[  719.476527] ata2.00: configured for UDMA/133
[  720.632086] ata2: EH complete
[  751.440034] ata2.00: limiting speed to UDMA/100:PIO4
[  752.734670] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  754.629761] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  754.629762]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  758.281054] ata2.00: status: { DRDY }
[  759.274845] ata2: hard resetting link
[  760.588039] ata2: SATA link down (SStatus 100 SControl 300)
[  762.067176] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  763.731159] ata2.00: revalidation failed (errno=-5)
[  767.064030] ata2: hard resetting link
[  768.376053] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  770.036535] ata2.00: configured for UDMA/100
[  771.192301] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  772.932649] ata2: hotplug_status 0x22
[  773.940527] ata2.00: configured for UDMA/100
[  775.096099] ata2: EH complete
[  805.904035] ata2.00: limiting speed to UDMA/33:PIO4
[  807.187990] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  809.083091] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  809.083092]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  812.734415] ata2.00: status: { DRDY }
[  813.728207] ata2: hard resetting link
[  815.040040] ata2: SATA link down (SStatus 100 SControl 300)
[  816.542275] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  818.206266] ata2.00: revalidation failed (errno=-5)
[  821.540030] ata2: hard resetting link
[  822.852053] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  824.532526] ata2.00: configured for UDMA/33
[  825.665194] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  827.409070] ata2: hotplug_status 0x22
[  828.416528] ata2.00: configured for UDMA/33
[  829.548977] ata2: EH complete
[  860.356030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  862.209157] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  862.209159]          res 40/00:01:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
[  865.860530] ata2.00: status: { DRDY }
[  866.854323] ata2: hard resetting link
[  868.168034] ata2: SATA link down (SStatus 100 SControl 300)
[  869.650517] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  871.314513] ata2.00: revalidation failed (errno=-5)
[  874.648024] ata2: hard resetting link
[  875.936048] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  877.592515] ata2.00: configured for UDMA/33
[  878.725170] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  880.481606] ata2: hotplug_status 0x22

[  881.464917] ata2.00: both IDENTIFYs aborted, assuming NODEV
[  881.464919] ata2.00: revalidation failed (errno=-2)
[  882.782252] ata2: hard resetting link
[  884.500049] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  886.164517] ata2.00: configured for UDMA/33
[  887.296970] sd 1:0:0:0: [sda] START_STOP FAILED
[  888.521875] ata2: EH complete
[  889.316941] sd 1:0:0:0: [sda] <5>sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  891.743650] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  893.499833] sd 1:0:0:0: [sda] Write Protect is off
[  894.794071] sd 1:0:0:0: [sda] <7>sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  896.666090] Sense Key : Aborted Command <5>sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  899.832033] [current] <5>sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  902.073568] [descriptor]<5>sd 1:0:0:0: [sda] Write Protect is off
[  903.737610] 
[  904.153645] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  904.153661] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  906.580005] sd 1:0:0:0: [sda] Add. Sense: No additional sense information
[  908.452067] suspend_device(): scsi_bus_suspend+0x0/0x3f returns 134217730
[  910.323879] PM: Device 1:0:0:0 failed to suspend: error 134217730
[  911.964768] PM: Some devices failed to suspend
[  913.166292] usb usb1: type resume
[  913.232039] usb usb2: type resume
[  913.232042] usb usb3: type resume
[  913.272029] usb usb4: type resume
[  913.272031] usb 3-2: type resume
[  913.323029] usb usb5: type resume
[  913.323033] i8042 i8042: resume
[  913.323058] atkbd serio0: legacy resume
[  913.323060] psmouse serio1: legacy resume
[  913.323065] ac97 0-0:ALC655: legacy resume
[  913.323068] platform floppy.0: resume
[  913.323071] rtc rtc0: legacy class resume
[  913.323115] platform floppy.0: completing resume
[  913.323119] i8042 i8042: completing resume
[  913.323122] usb usb5: completing type resume
[  913.323124] usb 3-2: completing type resume
[  913.323127] usb usb4: completing type resume
[  913.323129] usb usb3: completing type resume
[  913.323131] usb usb2: completing type resume
[  913.323134] usb usb1: completing type resume
[  913.323148] serial8250 serial8250: completing resume
[  913.323160] platform vesafb.0: completing resume
[  913.323163] pcspkr pcspkr: completing resume
[  913.323169] nvidia 0000:01:00.0: completing resume
[  913.323171] k8temp 0000:00:18.3: completing resume
[  913.323173] pci 0000:00:18.2: completing resume
[  913.323175] pci 0000:00:18.1: completing resume
[  913.323177] pci 0000:00:18.0: completing resume
[  913.323179] VIA 82xx Audio 0000:00:11.5: completing resume
[  913.323181] pci 0000:00:11.0: completing resume
[  913.323183] ehci_hcd 0000:00:10.4: completing resume
[  913.323185] uhci_hcd 0000:00:10.3: completing resume
[  913.323187] uhci_hcd 0000:00:10.2: completing resume
[  913.323189] uhci_hcd 0000:00:10.1: completing resume
[  913.323191] uhci_hcd 0000:00:10.0: completing resume
[  913.323193] VIA_IDE 0000:00:0f.1: completing resume
[  913.323195] sata_via 0000:00:0f.0: completing resume
[  913.323197] pci 0000:00:0e.0: completing resume
[  913.323199] sata_promise 0000:00:0d.0: completing resume
[  913.323201] r8169 0000:00:0b.0: completing resume
[  913.323203] pci 0000:00:01.0: completing resume
[  913.323205] agpgart-amd64 0000:00:00.0: completing resume
[  913.323217] PM: Finishing wakeup.
[  913.323218] Restarting tasks ... done.

--------------060008000003050109080703--
