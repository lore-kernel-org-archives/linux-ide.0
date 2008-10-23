From: Valerio Passini <valerio.passini@unicam.it>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Thu, 23 Oct 2008 15:53:44 +0200
Message-ID: <200810231553.44827.valerio.passini@unicam.it>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810230020.15257.valerio.passini@unicam.it> <20081023060932.GA20217@gollum.tnic>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oHIAJ2Kr3KWRhL1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.unicam.it ([193.204.8.1]:45497 "HELO unicam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbYJWNx4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 09:53:56 -0400
In-Reply-To: <20081023060932.GA20217@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, bzolnier@gmail.com

--Boundary-00=_oHIAJ2Kr3KWRhL1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Alle giovedì 23 ottobre 2008, Borislav Petkov ha scritto:
> Hi Valerio,
> 
> please do not remove people from the CC list because they're following the
> discussion too, thanks.
Hi Boris,

I just supposed to avoid redundancy because I thought that everybody would receive my answer just being subscribed to linux-ide.

> Next time just save the email in a text file and then try applying the patch in
> it - I think this way works.
Let's see otherwise I can access the text of a patch through the mailing list. 

> Can you now try this new patch I've attached below (before that revert the old
> one by doing "patch -p1 -R < [file.patch]" recompile the kernel with it, reboot),
> start simulated burning on your machine and then cancel it shortly thereafter.
> Now do
> 
> dmesg > log.msg
> 
> and send me the _whole_ file so that we can see the messages you get while
> burning.
> 
> Thanks.

I have made what you told me to do. Here I attach the results: there are two dmesg logs one earlier, where you can still see boot messages, and one that comes a little later that is full only of error messages related to dma. I hope that I've made them in a useful way, otherwise I will restart the test. Ciao

Valerio





--Boundary-00=_oHIAJ2Kr3KWRhL1
Content-Type: text/plain;
  charset="iso 8859-15";
  name="log_early.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log_early.msg"

1 of 1 pages preallocated
[    0.000999] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000999] hpet clockevent registered
[    0.000999] Calibrating delay loop (skipped), value calculated using timer frequency.. 3666.86 BogoMIPS (lpj=1833433)
[    0.000999] Security Framework initialized
[    0.000999] SELinux:  Disabled at boot.
[    0.000999] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003539] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.005090] Mount-cache hash table entries: 256
[    0.005296] Initializing cgroup subsys ns
[    0.005301] Initializing cgroup subsys cpuacct
[    0.005303] Initializing cgroup subsys devices
[    0.005328] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.005330] CPU: L2 cache: 2048K
[    0.005333] CPU 0/0 -> Node 0
[    0.005335] CPU: Physical Processor ID: 0
[    0.005336] CPU: Processor Core ID: 0
[    0.005343] CPU0: Thermal monitoring handled by SMI
[    0.005345] using mwait in idle threads.
[    0.006404] ACPI: Core revision 20080609
[    0.020437] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.030548] CPU0: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
[    0.030551] Using local APIC timer interrupts.
[    0.030996] APIC timer calibration result 10417242
[    0.030998] Detected 10.417 MHz APIC timer.
[    0.031111] Booting processor 1/1 ip 6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 3666.84 BogoMIPS (lpj=1833422)
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 2048K
[    0.000999] CPU 1/1 -> Node 0
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] CPU1: Thermal monitoring enabled (TM2)
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.103261] CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
[    0.103288] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.104002] Brought up 2 CPUs
[    0.104004] Total of 2 processors activated (7333.71 BogoMIPS).
[    0.104086] net_namespace: 856 bytes
[    0.104086] Booting paravirtualized kernel on bare hardware
[    0.104183] NET: Registered protocol family 16
[    0.104201] No dock devices found.
[    0.105015] ACPI: bus type pci registered
[    0.105027] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.105030] PCI: MCFG area at e0000000 reserved in E820
[    0.112694] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.112696] PCI: Using configuration type 1 for base access
[    0.114417] ACPI: EC: Look up EC in DSDT
[    0.118673] ACPI: BIOS _OSI(Linux) query ignored via DMI
[    0.119628] ACPI: Interpreter enabled
[    0.119630] ACPI: (supports S0 S3 S4 S5)
[    0.119645] ACPI: Using IOAPIC for interrupt routing
[    0.120076] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.621929] ACPI: EC: missing confirmations, switch off interrupt mode.
[    0.695051] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
[    0.695054] ACPI: EC: driver started in poll mode
[    0.695074] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.695074] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.695074] pci 0000:00:01.0: PME# disabled
[    0.695105] PCI: 0000:00:1a.0 reg 20 io port: [1800, 181f]
[    0.695171] PCI: 0000:00:1a.1 reg 20 io port: [1820, 183f]
[    0.695931] PCI: 0000:00:1a.7 reg 10 32bit mmio: [f3504800, f3504bff]
[    0.695989] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.695995] pci 0000:00:1a.7: PME# disabled
[    0.696042] PCI: 0000:00:1b.0 reg 10 64bit mmio: [f3500000, f3503fff]
[    0.696097] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.696102] pci 0000:00:1b.0: PME# disabled
[    0.696175] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.696179] pci 0000:00:1c.0: PME# disabled
[    0.696256] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.696261] pci 0000:00:1c.3: PME# disabled
[    0.696335] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.696340] pci 0000:00:1c.5: PME# disabled
[    0.696389] PCI: 0000:00:1d.0 reg 20 io port: [1840, 185f]
[    0.696458] PCI: 0000:00:1d.1 reg 20 io port: [1860, 187f]
[    0.696524] PCI: 0000:00:1d.2 reg 20 io port: [1880, 189f]
[    0.696595] PCI: 0000:00:1d.7 reg 10 32bit mmio: [f3504c00, f3504fff]
[    0.696654] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.696659] pci 0000:00:1d.7: PME# disabled
[    0.696826] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.696831] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.696861] PCI: 0000:00:1f.1 reg 10 io port: [0, 7]
[    0.696869] PCI: 0000:00:1f.1 reg 14 io port: [0, 3]
[    0.696877] PCI: 0000:00:1f.1 reg 18 io port: [0, 7]
[    0.696885] PCI: 0000:00:1f.1 reg 1c io port: [0, 3]
[    0.696892] PCI: 0000:00:1f.1 reg 20 io port: [18a0, 18af]
[    0.696971] PCI: 0000:00:1f.2 reg 10 io port: [18d8, 18df]
[    0.696979] PCI: 0000:00:1f.2 reg 14 io port: [18cc, 18cf]
[    0.696987] PCI: 0000:00:1f.2 reg 18 io port: [18d0, 18d7]
[    0.696995] PCI: 0000:00:1f.2 reg 1c io port: [18c8, 18cb]
[    0.697003] PCI: 0000:00:1f.2 reg 20 io port: [18e0, 18ff]
[    0.697011] PCI: 0000:00:1f.2 reg 24 32bit mmio: [f3504000, f35047ff]
[    0.697045] pci 0000:00:1f.2: PME# supported from D3hot
[    0.697050] pci 0000:00:1f.2: PME# disabled
[    0.697071] PCI: 0000:00:1f.3 reg 10 32bit mmio: [0, ff]
[    0.697097] PCI: 0000:00:1f.3 reg 20 io port: [1c00, 1c1f]
[    0.697174] PCI: 0000:01:00.0 reg 10 32bit mmio: [f2000000, f2ffffff]
[    0.697183] PCI: 0000:01:00.0 reg 14 32bit mmio: [d0000000, dfffffff]
[    0.697206] PCI: 0000:01:00.0 reg 1c 64bit mmio: [f0000000, f1ffffff]
[    0.697216] PCI: 0000:01:00.0 reg 24 io port: [2000, 207f]
[    0.697224] PCI: 0000:01:00.0 reg 30 32bit mmio: [0, 1ffff]
[    0.697303] PCI: bridge 0000:00:01.0 io port: [2000, 2fff]
[    0.697306] PCI: bridge 0000:00:01.0 32bit mmio: [f0000000, f2ffffff]
[    0.697311] PCI: bridge 0000:00:01.0 64bit mmio pref: [d0000000, dfffffff]
[    0.697373] PCI: bridge 0000:00:1c.0 io port: [0, fff]
[    0.697377] PCI: bridge 0000:00:1c.0 32bit mmio: [0, fffff]
[    0.697386] PCI: bridge 0000:00:1c.0 64bit mmio pref: [0, fffff]
[    0.697573] PCI: 0000:06:00.0 reg 10 32bit mmio: [0, fff]
[    0.697783] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.697795] pci 0000:06:00.0: PME# disabled
[    0.697849] PCI: bridge 0000:00:1c.3 io port: [0, fff]
[    0.697854] PCI: bridge 0000:00:1c.3 32bit mmio: [0, fffff]
[    0.697862] PCI: bridge 0000:00:1c.3 64bit mmio pref: [0, fffff]
[    0.698093] PCI: 0000:08:00.0 reg 10 64bit mmio: [0, ffff]
[    0.698248] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    0.698259] pci 0000:08:00.0: PME# disabled
[    0.698313] PCI: bridge 0000:00:1c.5 io port: [0, fff]
[    0.698318] PCI: bridge 0000:00:1c.5 32bit mmio: [0, fffff]
[    0.698326] PCI: bridge 0000:00:1c.5 64bit mmio pref: [0, fffff]
[    0.698388] PCI: 0000:0a:09.0 reg 10 32bit mmio: [f3200000, f32007ff]
[    0.698445] pci 0000:0a:09.0: supports D1
[    0.698446] pci 0000:0a:09.0: supports D2
[    0.698448] pci 0000:0a:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.698454] pci 0000:0a:09.0: PME# disabled
[    0.698491] PCI: 0000:0a:09.1 reg 10 32bit mmio: [f3200800, f32008ff]
[    0.698551] pci 0000:0a:09.1: supports D1
[    0.698552] pci 0000:0a:09.1: supports D2
[    0.698554] pci 0000:0a:09.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.698559] pci 0000:0a:09.1: PME# disabled
[    0.698597] PCI: 0000:0a:09.2 reg 10 32bit mmio: [f3200c00, f3200cff]
[    0.698654] pci 0000:0a:09.2: supports D1
[    0.698656] pci 0000:0a:09.2: supports D2
[    0.698657] pci 0000:0a:09.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.698662] pci 0000:0a:09.2: PME# disabled
[    0.698700] PCI: 0000:0a:09.3 reg 10 32bit mmio: [f3201000, f32010ff]
[    0.698758] pci 0000:0a:09.3: supports D1
[    0.698759] pci 0000:0a:09.3: supports D2
[    0.698761] pci 0000:0a:09.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.698766] pci 0000:0a:09.3: PME# disabled
[    0.698804] PCI: 0000:0a:09.4 reg 10 32bit mmio: [f3201400, f32014ff]
[    0.698862] pci 0000:0a:09.4: supports D1
[    0.698863] pci 0000:0a:09.4: supports D2
[    0.698865] pci 0000:0a:09.4: PME# supported from D0 D1 D2 D3hot D3cold
[    0.698870] pci 0000:0a:09.4: PME# disabled
[    0.698920] pci 0000:00:1e.0: transparent bridge
[    0.698931] PCI: bridge 0000:00:1e.0 32bit mmio: [f3200000, f32fffff]
[    0.698974] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.699419] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[    0.699579] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.699732] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.699880] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.700055] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.714044] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    0.714174] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.714300] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.715020] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.715147] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.715273] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.715398] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.715523] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *7 11 12 14 15)
[    0.715596] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.715596] pnp: PnP ACPI init
[    0.715596] ACPI: bus type pnp registered
[    0.715596] pnp 00:00: parse allocated resources
[    0.716482] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.716523] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.716523] pnp 00:01: parse allocated resources
[    0.716523] pnp 00:01:   add mem 0xfed1c000-0xfed1ffff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed14000-0xfed17fff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed18000-0xfed18fff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed19000-0xfed19fff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xe0000000-0xefffffff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed20000-0xfed3ffff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed40000-0xfed44fff flags 0x1
[    0.716523] pnp 00:01:   add mem 0xfed45000-0xfed8ffff flags 0x1
[    0.716523] pnp 00:01: PNP0c02: calling quirk_system_pci_resources+0x0/0x200
[    0.716523] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.717936] pnp 00:02: parse allocated resources
[    0.717942] pnp 00:02:   add io  0x0-0x1f flags 0x1
[    0.717944] pnp 00:02:   add io  0x81-0x91 flags 0x1
[    0.717945] pnp 00:02:   add io  0x93-0x9f flags 0x1
[    0.717947] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    0.717949] pnp 00:02:   add dma 4 flags 0x1
[    0.717979] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.717979] pnp 00:03: parse allocated resources
[    0.717979] pnp 00:03:   add mem 0xff000000-0xffffffff flags 0x0
[    0.717979] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.717996] pnp 00:04: parse allocated resources
[    0.718093] pnp 00:04:   add mem 0xfed00000-0xfed003ff flags 0x0
[    0.718097] pnp 00:04: PNP0c01: calling quirk_system_pci_resources+0x0/0x200
[    0.718150] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    0.718150] pnp 00:05: parse allocated resources
[    0.718150] pnp 00:05:   add io  0xf0-0xf0 flags 0x1
[    0.718150] pnp 00:05:   add irq 13 flags 0x1
[    0.718150] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.718150] pnp 00:06: parse allocated resources
[    0.718150] pnp 00:06:   add io  0x2e-0x2f flags 0x1
[    0.718150] pnp 00:06:   add io  0x4e-0x4f flags 0x1
[    0.718150] pnp 00:06:   add io  0x61-0x61 flags 0x1
[    0.718150] pnp 00:06:   add io  0x63-0x63 flags 0x1
[    0.718150] pnp 00:06:   add io  0x65-0x65 flags 0x1
[    0.718150] pnp 00:06:   add io  0x67-0x67 flags 0x1
[    0.718150] pnp 00:06:   add io  0x68-0x6f flags 0x1
[    0.718150] pnp 00:06:   add io  0x80-0x80 flags 0x1
[    0.718150] pnp 00:06:   add io  0x92-0x92 flags 0x1
[    0.718150] pnp 00:06:   add io  0xb2-0xb3 flags 0x1
[    0.718150] pnp 00:06:   add io  0x680-0x69f flags 0x1
[    0.718150] pnp 00:06:   add io  0x800-0x80f flags 0x1
[    0.718150] pnp 00:06:   add io  0x1000-0x107f flags 0x1
[    0.718150] pnp 00:06:   add io  0x1180-0x11bf flags 0x1
[    0.718150] pnp 00:06:   add io  0x1640-0x164f flags 0x1
[    0.718150] pnp 00:06:   add io  0xfe00-0xfe00 flags 0x1
[    0.718150] pnp 00:06: PNP0c02: calling quirk_system_pci_resources+0x0/0x200
[    0.718150] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c.3 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x2e-0x2f) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x4e-0x4f) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x61-0x61) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x63-0x63) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x65-0x65) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x67-0x67) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x68-0x6f) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x80-0x80) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x92-0x92) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0xb2-0xb3) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x680-0x69f) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: io resource (0x800-0x80f) overlaps 0000:00:1c.5 BAR 7 (0x0-0xfff), disabling
[    0.718150] pnp 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.718150] pnp 00:07: parse allocated resources
[    0.718150] pnp 00:07:   add io  0x70-0x77 flags 0x1
[    0.718150] pnp 00:07:   add irq 8 flags 0x1
[    0.718150] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.718150] pnp 00:08: parse allocated resources
[    0.719022] pnp 00:08:   add io  0x600-0x607 flags 0x1
[    0.719025] pnp 00:08:   add io  0x620-0x63f flags 0x1
[    0.719029] pnp 00:08:   add irq 4 flags 0x1
[    0.719031] pnp 00:08: parse resource options
[    0.719100] pnp 00:08:   dependent set 0 (acceptable) io  min 0x600 max 0x600 align 1 size 8 flags 0x1
[    0.719103] pnp 00:08:   dependent set 0 (acceptable) io  min 0x620 max 0x620 align 1 size 32 flags 0x1
[    0.719108] pnp 00:08:   dependent set 0 (acceptable) irq 4 flags 0x1
[    0.719142] pnp 00:08: Plug and Play ACPI device, IDs WEC1020 (active)
[    0.719142] pnp 00:09: parse allocated resources
[    0.719142] pnp 00:09:   add io  0x60-0x60 flags 0x1
[    0.719142] pnp 00:09:   add io  0x64-0x64 flags 0x1
[    0.719142] pnp 00:09:   add irq 1 flags 0x1
[    0.719142] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.719142] pnp 00:0a: parse allocated resources
[    0.719142] pnp 00:0a:   add irq 12 flags 0x1
[    0.719142] pnp 00:0a: Plug and Play ACPI device, IDs SYN1b03 SYN1b00 SYN0002 PNP0f13 (active)
[    0.719142] pnp: PnP ACPI: found 11 devices
[    0.719142] ACPI: ACPI bus type pnp unregistered
[    0.719142] SCSI subsystem initialized
[    0.719142] libata version 3.00 loaded.
[    0.719142] usbcore: registered new interface driver usbfs
[    0.719142] usbcore: registered new interface driver hub
[    0.719142] usbcore: registered new device driver usb
[    0.719952] PCI: Using ACPI for IRQ routing
[    0.719952] pci 0000:00:1c.0: BAR 7: can't allocate resource
[    0.719952] pci 0000:00:1c.0: BAR 8: can't allocate resource
[    0.719952] pci 0000:00:1c.0: BAR 9: can't allocate resource
[    0.719953] pci 0000:00:1c.3: BAR 7: can't allocate resource
[    0.719956] pci 0000:00:1c.3: BAR 8: can't allocate resource
[    0.719959] pci 0000:00:1c.3: BAR 9: can't allocate resource
[    0.719962] pci 0000:00:1c.5: BAR 7: can't allocate resource
[    0.719965] pci 0000:00:1c.5: BAR 8: can't allocate resource
[    0.719969] pci 0000:00:1c.5: BAR 9: can't allocate resource
[    0.727954] PCI-GART: No AMD northbridge found.
[    0.727961] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.727965] hpet0: 3 64-bit timers, 14318180 Hz
[    0.728963] ACPI: RTC can wake from S4
[    0.729932] Switched to high resolution mode on CPU 0
[    0.730243] Switched to high resolution mode on CPU 1
[    0.731009] pnp: the driver 'system' has been registered
[    0.731019] system 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[    0.731022] system 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
[    0.731024] system 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
[    0.731027] system 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
[    0.731029] system 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.731032] system 00:01: iomem range 0xfed20000-0xfed3ffff could not be reserved
[    0.731035] system 00:01: iomem range 0xfed40000-0xfed44fff could not be reserved
[    0.731037] system 00:01: iomem range 0xfed45000-0xfed8ffff could not be reserved
[    0.731039] system 00:01: driver attached
[    0.731045] system 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
[    0.731047] system 00:04: driver attached
[    0.731053] system 00:06: ioport range 0x1000-0x107f has been reserved
[    0.731056] system 00:06: ioport range 0x1180-0x11bf has been reserved
[    0.731058] system 00:06: ioport range 0x1640-0x164f has been reserved
[    0.731061] system 00:06: ioport range 0xfe00-0xfe00 has been reserved
[    0.731063] system 00:06: driver attached
[    0.736096] pci 0000:01:00.0: BAR 6: can't allocate mem resource [0xe0000000-0xdfffffff]
[    0.736101] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.736104] pci 0000:00:01.0:   IO window: 0x2000-0x2fff
[    0.736108] pci 0000:00:01.0:   MEM window: 0xf0000000-0xf2ffffff
[    0.736111] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
[    0.736116] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.736118] pci 0000:00:1c.0:   IO window: disabled
[    0.736124] pci 0000:00:1c.0:   MEM window: disabled
[    0.736129] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.736189] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:06
[    0.736191] pci 0000:00:1c.3:   IO window: disabled
[    0.736197] pci 0000:00:1c.3:   MEM window: 0xc2000000-0xc20fffff
[    0.736202] pci 0000:00:1c.3:   PREFETCH window: disabled
[    0.736264] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:08
[    0.736266] pci 0000:00:1c.5:   IO window: disabled
[    0.736272] pci 0000:00:1c.5:   MEM window: 0xc2100000-0xc21fffff
[    0.736277] pci 0000:00:1c.5:   PREFETCH window: disabled
[    0.736285] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:0a
[    0.736287] pci 0000:00:1e.0:   IO window: disabled
[    0.736293] pci 0000:00:1e.0:   MEM window: 0xf3200000-0xf32fffff
[    0.736298] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.736314] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.736317] pci 0000:00:01.0: setting latency timer to 64
[    0.736326] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.736333] pci 0000:00:1c.0: setting latency timer to 64
[    0.736342] pci 0000:00:1c.3: enabling device (0000 -> 0002)
[    0.736346] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.736353] pci 0000:00:1c.3: setting latency timer to 64
[    0.736361] pci 0000:00:1c.5: enabling device (0000 -> 0002)
[    0.736365] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.736371] pci 0000:00:1c.5: setting latency timer to 64
[    0.736380] pci 0000:00:1e.0: setting latency timer to 64
[    0.736384] bus: 00 index 0 io port: [0, ffff]
[    0.736386] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.736387] bus: 01 index 0 io port: [2000, 2fff]
[    0.736389] bus: 01 index 1 mmio: [f0000000, f2ffffff]
[    0.736391] bus: 01 index 2 mmio: [d0000000, dfffffff]
[    0.736393] bus: 01 index 3 mmio: [0, 0]
[    0.736395] bus: 02 index 0 mmio: [0, fff]
[    0.736396] bus: 02 index 1 mmio: [0, fffff]
[    0.736398] bus: 02 index 2 mmio: [0, fffff]
[    0.736399] bus: 02 index 3 mmio: [0, 0]
[    0.736401] bus: 06 index 0 mmio: [0, fff]
[    0.736403] bus: 06 index 1 mmio: [c2000000, c20fffff]
[    0.736404] bus: 06 index 2 mmio: [0, fffff]
[    0.736406] bus: 06 index 3 mmio: [0, 0]
[    0.736408] bus: 08 index 0 mmio: [0, fff]
[    0.736409] bus: 08 index 1 mmio: [c2100000, c21fffff]
[    0.736411] bus: 08 index 2 mmio: [0, fffff]
[    0.736413] bus: 08 index 3 mmio: [0, 0]
[    0.736414] bus: 0a index 0 mmio: [0, 0]
[    0.736416] bus: 0a index 1 mmio: [f3200000, f32fffff]
[    0.736418] bus: 0a index 2 mmio: [0, 0]
[    0.736419] bus: 0a index 3 io port: [0, ffff]
[    0.736421] bus: 0a index 4 mmio: [0, ffffffffffffffff]
[    0.736432] NET: Registered protocol family 2
[    0.746154] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.747560] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.753643] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.754420] TCP: Hash tables configured (established 524288 bind 65536)
[    0.754423] TCP reno registered
[    0.757115] NET: Registered protocol family 1
[    0.757234] Unpacking initramfs... done
[    0.981746] Freeing initrd memory: 5293k freed
[    0.984564] Simple Boot Flag at 0x35 set to 0x1
[    0.985464] audit: initializing netlink socket (disabled)
[    0.985487] type=2000 audit(1224775994.985:1): initialized
[    0.985805] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.988418] msgmni has been set to 6043
[    0.988529] io scheduler noop registered
[    0.988531] io scheduler anticipatory registered
[    0.988533] io scheduler deadline registered
[    0.988638] io scheduler cfq registered (default)
[    0.988807] pci 0000:01:00.0: Boot video device
[    0.988924] pcieport-driver 0000:00:01.0: setting latency timer to 64
[    0.988959] pcieport-driver 0000:00:01.0: found MSI capability
[    0.988992] pci_express 0000:00:01.0:pcie00: allocate port service
[    0.989028] pci_express 0000:00:01.0:pcie02: allocate port service
[    0.989062] pci_express 0000:00:01.0:pcie03: allocate port service
[    0.989147] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.989196] pcieport-driver 0000:00:1c.0: found MSI capability
[    0.989245] pci_express 0000:00:1c.0:pcie00: allocate port service
[    0.989284] pci_express 0000:00:1c.0:pcie02: allocate port service
[    0.989319] pci_express 0000:00:1c.0:pcie03: allocate port service
[    0.989428] pcieport-driver 0000:00:1c.3: setting latency timer to 64
[    0.989478] pcieport-driver 0000:00:1c.3: found MSI capability
[    0.989529] pci_express 0000:00:1c.3:pcie00: allocate port service
[    0.989566] pci_express 0000:00:1c.3:pcie02: allocate port service
[    0.989600] pci_express 0000:00:1c.3:pcie03: allocate port service
[    0.989707] pcieport-driver 0000:00:1c.5: setting latency timer to 64
[    0.989756] pcieport-driver 0000:00:1c.5: found MSI capability
[    0.989805] pci_express 0000:00:1c.5:pcie00: allocate port service
[    0.989839] pci_express 0000:00:1c.5:pcie02: allocate port service
[    0.989872] pci_express 0000:00:1c.5:pcie03: allocate port service
[    0.990532] vesafb: framebuffer at 0xf1000000, mapped to 0xffffc20011100000, using 8000k, total 14336k
[    0.990535] vesafb: mode is 1280x800x32, linelength=5120, pages=1
[    0.990536] vesafb: scrolling: redraw
[    0.990539] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.064798] Console: switching to colour frame buffer device 160x50
[    1.132445] fb0: VESA VGA frame buffer device
[    1.135058] hpet_resources: 0xfed00000 is busy
[    1.135118] Linux agpgart interface v0.103
[    1.135120] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    1.135412] pnp: the driver 'serial' has been registered
[    1.135664] ahci 0000:00:1f.2: version 3.0
[    1.135679] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.135789] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
[    1.135792] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part 
[    1.135797] ahci 0000:00:1f.2: setting latency timer to 64
[    1.136089] scsi0 : ahci
[    1.136192] scsi1 : ahci
[    1.136265] scsi2 : ahci
[    1.136378] ata1: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf3504100 irq 315
[    1.136382] ata2: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf3504180 irq 315
[    1.136385] ata3: SATA max UDMA/133 abar m2048@0xf3504000 port 0xf3504200 irq 315
[    1.441021] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.441588] ata1.00: _GTF unexpected object type 0x1
[    1.490954] ata1.00: ATA-8: WDC WD2500BEVS-22UST0, 01.01A01, max UDMA/133
[    1.490956] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.491791] ata1.00: _GTF unexpected object type 0x1
[    1.491920] ata1.00: configured for UDMA/133
[    1.807018] ata2: SATA link down (SStatus 0 SControl 300)
[    2.123023] ata3: SATA link down (SStatus 0 SControl 300)
[    2.134107] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-2 01.0 PQ: 0 ANSI: 5
[    2.134245] usbmon: debugfs is not available
[    2.134249] pnp: the driver 'i8042 kbd' has been registered
[    2.134270] i8042 kbd 00:09: driver attached
[    2.134299] pnp: the driver 'i8042 aux' has been registered
[    2.134318] i8042 aux 00:0a: driver attached
[    2.134347] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.136842] i8042.c: Detected active multiplexing controller, rev 1.1.
[    2.138023] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.138029] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    2.138031] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    2.138033] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    2.138035] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    2.138159] mice: PS/2 mouse device common for all mice
[    2.138234] pnp: the driver 'rtc_cmos' has been registered
[    2.138383] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    2.138415] rtc0: alarms up to one month, y3k, hpet irqs
[    2.138417] rtc_cmos 00:07: driver attached
[    2.138448] cpuidle: using governor ladder
[    2.138451] cpuidle: using governor menu
[    2.138725] TCP cubic registered
[    2.138729] NET: Registered protocol family 17
[    2.138855] registered taskstats version 1
[    2.139018] rtc_cmos 00:07: setting system clock to 2008-10-23 15:33:17 UTC (1224775997)
[    2.139072] Freeing unused kernel memory: 428k freed
[    2.219144] input: AT Translated Set 2 keyboard as /class/input/input0
[    2.226578] ACPI: SSDT BFED481A, 01F6 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
[    2.227187] ACPI: SSDT BFED419E, 05F7 (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
[    2.229729] Monitor-Mwait will be used to enter C-1 state
[    2.229732] Monitor-Mwait will be used to enter C-2 state
[    2.229734] Monitor-Mwait will be used to enter C-3 state
[    2.229894] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    2.229940] processor ACPI0007:00: registered as cooling_device0
[    2.229944] ACPI: Processor [CPU0] (supports 8 throttling states)
[    2.230323] ACPI: SSDT BFED4A10, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
[    2.230700] ACPI: SSDT BFED4795, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
[    2.231930] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    2.231969] processor ACPI0007:01: registered as cooling_device1
[    2.231973] ACPI: Processor [CPU1] (supports 8 throttling states)
[    2.232001] Marking TSC unstable due to TSC halts in idle
[    2.339604] thermal LNXTHERM:01: registered as thermal_zone0
[    2.355341] ACPI: Thermal Zone [THRM] (50 C)
[    2.424171] Driver 'sd' needs updating - please use bus_type methods
[    2.424296] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
[    2.424319] sd 0:0:0:0: [sda] Write Protect is off
[    2.424322] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.424362] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.424430] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
[    2.424452] sd 0:0:0:0: [sda] Write Protect is off
[    2.424454] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.424493] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.424496]  sda: sda1 sda2 sda3 sda4 < sda5 sda6<4>Clocksource tsc unstable (delta = -97032654 ns)
[    2.522375]  sda7 >
[    2.522585] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.561356] USB Universal Host Controller Interface driver v3.0
[    2.561408] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.561418] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.561423] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.561470] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.561516] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
[    2.561613] usb usb1: configuration #1 chosen from 1 choice
[    2.561644] hub 1-0:1.0: USB hub found
[    2.561649] hub 1-0:1.0: 2 ports detected
[    2.635675] ricoh-mmc: Ricoh MMC Controller disabling driver
[    2.635678] ricoh-mmc: Copyright(c) Philip Langdale
[    2.635785] sdhci: Secure Digital Host Controller Interface driver
[    2.635787] sdhci: Copyright(c) Pierre Ossman
[    2.662901] Uniform Multi-Platform E-IDE driver
[    2.763277] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.763281] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.763283] usb usb1: Product: UHCI Host Controller
[    2.763285] usb usb1: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    2.763287] usb usb1: SerialNumber: 0000:00:1a.0
[    2.763501] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.763520] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    2.763523] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    2.763555] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 2
[    2.767475] ehci_hcd 0000:00:1a.7: debug port 1
[    2.767483] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    2.767500] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf3504800
[    2.865078] usb 1-2: new full speed USB device using uhci_hcd and address 2
[    2.871059] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    2.871216] usb usb2: configuration #1 chosen from 1 choice
[    2.871270] hub 2-0:1.0: USB hub found
[    2.871281] hub 2-0:1.0: 4 ports detected
[    2.926711] hub 1-0:1.0: unable to enumerate USB device on port 2
[    3.073242] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.073247] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.073252] usb usb2: Product: EHCI Host Controller
[    3.073255] usb usb2: Manufacturer: Linux 2.6.27.1bp ehci_hcd
[    3.073258] usb usb2: SerialNumber: 0000:00:1a.7
[    3.073335] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    3.073345] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    3.073349] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    3.073372] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 3
[    3.073410] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001820
[    3.073490] usb usb3: configuration #1 chosen from 1 choice
[    3.073518] hub 3-0:1.0: USB hub found
[    3.073524] hub 3-0:1.0: 2 ports detected
[    3.174418] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.174423] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.174427] usb usb3: Product: UHCI Host Controller
[    3.174431] usb usb3: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    3.174434] usb usb3: SerialNumber: 0000:00:1a.1
[    3.174799] piix 0000:00:1f.1: IDE controller (0x8086:0x2850 rev 0x03)
[    3.174808] PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    3.174827] piix 0000:00:1f.1: not 100% native mode: will probe irqs later
[    3.174834]     ide0: BM-DMA at 0x18a0-0x18a7
[    3.174843]     ide1: BM-DMA at 0x18a8-0x18af
[    3.174847] Probing IDE interface ide0...
[    3.176290] usb 2-2: new high speed USB device using ehci_hcd and address 2
[    3.299145] usb 2-2: configuration #1 chosen from 1 choice
[    3.299672] usb 2-2: New USB device found, idVendor=064e, idProduct=a101
[    3.299677] usb 2-2: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[    3.299681] usb 2-2: Product: Acer CrystalEye webcam
[    3.299684] usb 2-2: Manufacturer: SuYin
[    3.299687] usb 2-2: SerialNumber: CN0314-OV03-VA-R02.00.00
[    3.846471] hda: TSSTcorp CDDVDW TS-L632H, ATAPI CD/DVD-ROM drive
[    4.458274] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    4.458510] hda: UDMA/33 mode selected
[    4.458867] Probing IDE interface ide1...
[    4.977293] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.978184] ide1 at 0x170-0x177,0x376 on irq 15
[    4.978333] ohci1394 0000:0a:09.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.979301] tg3.c:v3.94 (August 14, 2008)
[    4.979355] tg3 0000:08:00.0: enabling device (0000 -> 0002)
[    4.979364] tg3 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    4.979381] tg3 0000:08:00.0: setting latency timer to 64
[    5.011441] eth0: Tigon3 [partno(BCM95787m) rev b002 PHY(5787)] (PCI Express) 10/100/1000Base-T Ethernet 00:1e:68:3e:f9:7a
[    5.011444] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
[    5.011447] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    5.011504] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    5.011510] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    5.011514] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.011542] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    5.011579] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001840
[    5.011664] usb usb4: configuration #1 chosen from 1 choice
[    5.011691] hub 4-0:1.0: USB hub found
[    5.011698] hub 4-0:1.0: 2 ports detected
[    5.031485] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[f3200000-f32007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    5.035660] sdhci-pci 0000:0a:09.1: SDHCI controller found [1180:0822] (rev 22)
[    5.035673] sdhci-pci 0000:0a:09.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    5.036689] sdhci-pci 0000:0a:09.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    5.038746] mmc0: SDHCI controller on PCI [0000:0a:09.1] using DMA
[    5.038792] ricoh-mmc: Ricoh MMC controller found at 0000:0a:09.2 [1180:0843] (rev 12)
[    5.038810] ricoh-mmc: Controller is now disabled.
[    5.213659] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    5.213664] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.213668] usb usb4: Product: UHCI Host Controller
[    5.213672] usb usb4: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.213675] usb usb4: SerialNumber: 0000:00:1d.0
[    5.213757] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    5.213774] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    5.213777] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    5.213802] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    5.217722] ehci_hcd 0000:00:1d.7: debug port 1
[    5.217729] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    5.217736] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf3504c00
[    5.315233] usb 4-2: new low speed USB device using uhci_hcd and address 2
[    5.321231] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    5.321355] usb usb5: configuration #1 chosen from 1 choice
[    5.321404] hub 5-0:1.0: USB hub found
[    5.321415] hub 5-0:1.0: 6 ports detected
[    5.377265] hub 4-0:1.0: unable to enumerate USB device on port 2
[    5.523390] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    5.523395] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.523399] usb usb5: Product: EHCI Host Controller
[    5.523402] usb usb5: Manufacturer: Linux 2.6.27.1bp ehci_hcd
[    5.523406] usb usb5: SerialNumber: 0000:00:1d.7
[    5.523440] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    5.523466] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    5.523471] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.523491] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    5.523529] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
[    5.523603] usb usb6: configuration #1 chosen from 1 choice
[    5.523628] hub 6-0:1.0: USB hub found
[    5.523634] hub 6-0:1.0: 2 ports detected
[    5.725378] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    5.725383] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.725387] usb usb6: Product: UHCI Host Controller
[    5.725391] usb usb6: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.725394] usb usb6: SerialNumber: 0000:00:1d.1
[    5.725505] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    5.725513] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    5.725517] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.725541] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    5.725568] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
[    5.725643] usb usb7: configuration #1 chosen from 1 choice
[    5.725677] hub 7-0:1.0: USB hub found
[    5.725683] hub 7-0:1.0: 2 ports detected
[    5.826438] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    5.826443] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.826447] usb usb7: Product: UHCI Host Controller
[    5.826456] usb usb7: Manufacturer: Linux 2.6.27.1bp uhci_hcd
[    5.826458] usb usb7: SerialNumber: 0000:00:1d.2
[    5.889319] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff880037875d98, rq->data_len: 0x18, on_stack: 1
[    5.896219] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[    5.896227] Uniform CD-ROM driver Revision: 3.20
[    5.896681] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff880037875c58, rq->data_len: 0x8, on_stack: 1
[    5.898596] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[    5.912042] usb 4-2: new low speed USB device using uhci_hcd and address 3
[    5.961944] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88003782da18, rq->data_len: 0x8, on_stack: 1
[    5.963935] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[    5.966361] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800379b6000, rq->data_len: 0x24, on_stack: 0
[    5.968295] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800379b6000, rq->data_len: 0x8, on_stack: 0
[    5.987184] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800379b6000, rq->data_len: 0x150, on_stack: 0
[    5.999653] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800379b6000, rq->data_len: 0xc, on_stack: 0
[    6.027422] PM: Starting manual resume from disk
[    6.075148] usb 4-2: configuration #1 chosen from 1 choice
[    6.078184] usb 4-2: New USB device found, idVendor=046d, idProduct=c052
[    6.078187] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.078189] usb 4-2: Product: USB Optical Mouse
[    6.078191] usb 4-2: Manufacturer: Logitech
[    6.105669] kjournald starting.  Commit interval 5 seconds
[    6.105710] EXT3-fs: mounted filesystem with ordered data mode.
[    6.180065] usb 6-1: new low speed USB device using uhci_hcd and address 2
[    6.292234] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b005630d300]
[    6.345692] usb 6-1: configuration #1 chosen from 1 choice
[    6.373737] usb 6-1: New USB device found, idVendor=04fc, idProduct=05d8
[    6.373742] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.373747] usb 6-1: Product: Trust Deskset 15176
[    6.373750] usb 6-1: Manufacturer: MLK
[    6.373887] usbcore: registered new interface driver hiddev
[    6.388178] input: Logitech USB Optical Mouse as /class/input/input1
[    6.390366] input,hidraw0: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-2
[    6.405040] input: MLK Trust Deskset 15176 as /class/input/input2
[    6.408086] input,hidraw1: USB HID v1.00 Keyboard [MLK Trust Deskset 15176] on usb-0000:00:1d.1-1
[    6.432610] Fixing up Sunplus Wireless Desktop report descriptor
[    6.433694] input: MLK Trust Deskset 15176 as /class/input/input3
[    6.439158] input,hiddev96,hidraw2: USB HID v1.00 Mouse [MLK Trust Deskset 15176] on usb-0000:00:1d.1-1
[    6.439187] usbcore: registered new interface driver usbhid
[    6.439191] usbhid: v2.6:USB HID core driver
[    8.297689] udevd version 125 started
[    8.438921] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd131000, rq->data_len: 0x24, on_stack: 0
[    8.441372] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd131000, rq->data_len: 0x8, on_stack: 0
[    8.459917] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd131000, rq->data_len: 0x150, on_stack: 0
[    8.472294] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd131000, rq->data_len: 0xc, on_stack: 0
[    8.872263] input: Power Button (FF) as /class/input/input4
[    8.888323] ACPI: Power Button (FF) [PWRF]
[    8.906163] acpi device:04: registered as cooling_device2
[    8.906670] input: Video Bus as /class/input/input5
[    8.917076] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    8.917331] input: Lid Switch as /class/input/input6
[    8.925190] ACPI: Lid Switch [LID]
[    8.925258] ACPI: Battery Slot [BAT1] (battery absent)
[    8.936982] ACPI: AC Adapter [ACAD] (on-line)
[    8.937074] input: Power Button (CM) as /class/input/input7
[    8.949080] ACPI: Power Button (CM) [PWRB]
[    8.949191] ACPI: WMI: Mapper loaded
[    8.949712] input: Sleep Button (CM) as /class/input/input8
[    8.965080] ACPI: Sleep Button (CM) [SLPB]
[    9.105722] Linux video capture interface: v2.00
[    9.140048] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
[    9.140054] ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI region SMBI [0x1c00-0x1c0f]
[    9.140056] ACPI: Device needs an ACPI driver
[    9.206634] input: PC Speaker as /class/input/input9
[    9.261724] uvcvideo: Found UVC 1.00 device Acer CrystalEye webcam (064e:a101)
[    9.263387] input: Acer CrystalEye webcam as /class/input/input10
[    9.269157] usbcore: registered new interface driver uvcvideo
[    9.269162] USB Video Class driver (v0.1.0)
[    9.726723] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.26ks
[    9.726727] iwl3945: Copyright(c) 2003-2008 Intel Corporation
[    9.726847] iwl3945 0000:06:00.0: enabling device (0000 -> 0002)
[    9.726859] iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    9.726878] iwl3945 0000:06:00.0: setting latency timer to 64
[    9.726904] iwl3945: Detected Intel Wireless WiFi Link 3945ABG
[    9.787050] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    9.787088] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    9.801336] iwl3945: Tunable channels: 13 802.11bg, 23 802.11a channels
[    9.801783] phy0: Selected rate control algorithm 'iwl-3945-rs'
[    9.833421] Synaptics Touchpad, model: 1, fw: 6.5, id: 0x1e0b1, caps: 0xc04751/0xe0500f
[    9.854600] iwl3945 0000:06:00.0: PCI INT A disabled
[    9.874380] input: SynPS/2 Synaptics TouchPad as /class/input/input11
[   10.466904] Synaptics Touchpad, model: 1, fw: 6.5, id: 0x81a0b1, caps: 0xa04711/0xa04000
[   10.500592] input: SynPS/2 Synaptics TouchPad as /class/input/input12
[   11.169364] Adding 2931820k swap on /dev/sda5.  Priority:-1 extents:1 across:2931820k
[   11.812305] EXT3 FS on sda2, internal journal
[   13.067289] fuse init (API version 7.9)
[   13.180509] kjournald starting.  Commit interval 5 seconds
[   13.180725] EXT3 FS on sda3, internal journal
[   13.180732] EXT3-fs: mounted filesystem with ordered data mode.
[   13.229581] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[   13.229631] kjournald starting.  Commit interval 5 seconds
[   13.229883] EXT3 FS on sda6, internal journal
[   13.229888] EXT3-fs: mounted filesystem with ordered data mode.
[   19.703651] NET: Registered protocol family 10
[   19.704305] lo: Disabled Privacy Extensions
[   27.514110] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbdc8000, rq->data_len: 0x8, on_stack: 0
[   27.558889] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbdc8000, rq->data_len: 0x44, on_stack: 0
[   27.590162] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbdc8000, rq->data_len: 0xc, on_stack: 0
[   27.622330] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbdc8000, rq->data_len: 0x4c, on_stack: 0
[   28.002272] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbddb9b8, rq->data_len: 0x8, on_stack: 1
[   28.028435] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[   28.055392] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbddbc98, rq->data_len: 0x20, on_stack: 1
[   28.099567] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbddba98, rq->data_len: 0x8, on_stack: 1
[   28.124773] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[   28.150407] cdrom: This disc doesn't have any tracks I recognize!
[   28.150487] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbd83000, rq->data_len: 0x8, on_stack: 0
[   28.186001] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbd83000, rq->data_len: 0x4, on_stack: 0
[   28.211035] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbd83000, rq->data_len: 0x1c, on_stack: 0
[   28.239484] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbddbae8, rq->data_len: 0x8, on_stack: 1
[   28.263353] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[   28.287637] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bbddbb08, rq->data_len: 0x8, on_stack: 1
[   28.310629] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[   28.718790] Bluetooth: Core ver 2.13
[   28.719550] NET: Registered protocol family 31
[   28.719606] Bluetooth: HCI device and connection manager initialized
[   28.719652] Bluetooth: HCI socket layer initialized
[   28.783612] Bluetooth: L2CAP ver 2.11
[   28.784284] Bluetooth: L2CAP socket layer initialized
[   28.826261] Bluetooth: RFCOMM socket layer initialized
[   28.826445] Bluetooth: RFCOMM TTY layer initialized
[   28.826551] Bluetooth: RFCOMM ver 1.10
[   29.159306] iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   29.159623] iwl3945 0000:06:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   29.159986] firmware: requesting iwlwifi-3945-1.ucode
[   29.241132] Registered led device: iwl-phy0:radio
[   29.241437] Registered led device: iwl-phy0:assoc
[   29.241580] Registered led device: iwl-phy0:RX
[   29.241714] Registered led device: iwl-phy0:TX
[   29.249641] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   29.500666] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   30.057147] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba035000, rq->data_len: 0x8, on_stack: 0
[   30.082508] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba00f000, rq->data_len: 0xc, on_stack: 0
[   30.113543] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba00f000, rq->data_len: 0x4c, on_stack: 0
[   32.057923] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba06e000, rq->data_len: 0x8, on_stack: 0
[   34.057650] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba181000, rq->data_len: 0x8, on_stack: 0
[   35.539065] nvidia: module license 'NVIDIA' taints kernel.
[   35.796561] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   35.796574] nvidia 0000:01:00.0: setting latency timer to 64
[   35.797088] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  177.80  Wed Oct  1 14:43:46 PDT 2008
[   37.926642] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b6f72000, rq->data_len: 0x8, on_stack: 0
[   38.237261] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b6fb8000, rq->data_len: 0x8, on_stack: 0
[   40.057627] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b81ed000, rq->data_len: 0x8, on_stack: 0
[   42.056730] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba1cb000, rq->data_len: 0x8, on_stack: 0
[   44.061187] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba17e000, rq->data_len: 0x8, on_stack: 0
[   46.061716] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80f6000, rq->data_len: 0x8, on_stack: 0
[   48.061758] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba198000, rq->data_len: 0x8, on_stack: 0
[   50.060995] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b8000000, rq->data_len: 0x8, on_stack: 0
[   52.060892] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba042000, rq->data_len: 0x8, on_stack: 0
[   54.062129] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b7c42000, rq->data_len: 0x8, on_stack: 0
[   56.061814] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b7d15000, rq->data_len: 0x8, on_stack: 0
[   58.060953] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b8178000, rq->data_len: 0x8, on_stack: 0
[   60.007881] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b2815ae8, rq->data_len: 0x8, on_stack: 1
[   60.009900] Disabling dma for 0xb cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800bd1be810, rq->data_len: 0x4, on_stack: 0
[   60.060628] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b287b000, rq->data_len: 0x8, on_stack: 0
[   62.060656] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b7d1e000, rq->data_len: 0x8, on_stack: 0
[   64.061666] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b808e000, rq->data_len: 0x8, on_stack: 0
[   66.060979] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b087c000, rq->data_len: 0x8, on_stack: 0
[   68.061022] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba1ce000, rq->data_len: 0x8, on_stack: 0
[   70.010790] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800af88e000, rq->data_len: 0x24, on_stack: 0
[   70.060722] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800af835000, rq->data_len: 0x8, on_stack: 0
[   72.065919] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800af819000, rq->data_len: 0x8, on_stack: 0
[   74.061081] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc98000, rq->data_len: 0x8, on_stack: 0
[   76.060924] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800af9db000, rq->data_len: 0x8, on_stack: 0
[   78.060783] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acddc000, rq->data_len: 0x8, on_stack: 0
[   80.061248] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800aa83b000, rq->data_len: 0x8, on_stack: 0
[   82.060863] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acdd5000, rq->data_len: 0x8, on_stack: 0
[   84.061156] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800aa858000, rq->data_len: 0x8, on_stack: 0
[   86.061259] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc20000, rq->data_len: 0x8, on_stack: 0
[   88.061206] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a94e2000, rq->data_len: 0x8, on_stack: 0
[   90.061303] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a94b3000, rq->data_len: 0x8, on_stack: 0
[   92.061198] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a551f000, rq->data_len: 0x8, on_stack: 0
[   94.063031] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba023000, rq->data_len: 0x8, on_stack: 0
[   94.426238] wlan0: authenticate with AP 00:14:7c:53:c4:34
[   94.428164] wlan0: authenticated
[   94.428302] wlan0: associate with AP 00:14:7c:53:c4:34
[   94.430456] wlan0: RX AssocResp from 00:14:7c:53:c4:34 (capab=0x431 status=0 aid=1)
[   94.430610] wlan0: associated
[   94.436564] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   96.062053] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a5452000, rq->data_len: 0x8, on_stack: 0
[   98.061911] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a958d000, rq->data_len: 0x8, on_stack: 0
[  100.061101] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0910000, rq->data_len: 0x8, on_stack: 0
[  102.062217] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a55d6000, rq->data_len: 0x8, on_stack: 0
[  104.062022] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc0d000, rq->data_len: 0x8, on_stack: 0
[  106.060825] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0934000, rq->data_len: 0x8, on_stack: 0
[  108.060880] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800aa881000, rq->data_len: 0x8, on_stack: 0
[  109.043170] wlan0: no IPv6 routers present
[  110.061110] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a093c000, rq->data_len: 0x8, on_stack: 0
[  112.062040] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800af9e8000, rq->data_len: 0x8, on_stack: 0
[  114.061163] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a09ee000, rq->data_len: 0x8, on_stack: 0
[  116.060847] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08b3000, rq->data_len: 0x8, on_stack: 0
[  118.062400] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0b01000, rq->data_len: 0x8, on_stack: 0
[  119.610324] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x24, on_stack: 0
[  119.620479] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x24, on_stack: 0
[  119.622593] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.627663] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.632426] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.637479] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.640420] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.645583] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.650110] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.654750] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.659403] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x28, on_stack: 0
[  119.669296] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.674533] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.679221] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0xc, on_stack: 0
[  119.683661] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.688938] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x10, on_stack: 0
[  119.692442] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0xc, on_stack: 0
[  119.697739] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x44, on_stack: 0
[  119.704148] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x8, on_stack: 0
[  119.706693] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.713727] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.717611] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.721590] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.725872] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.729532] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.732927] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.736661] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x3c, on_stack: 0
[  119.745128] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c812000, rq->data_len: 0x8, on_stack: 0
[  119.754883] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c812000, rq->data_len: 0x4c, on_stack: 0
[  119.762304] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x8, on_stack: 0
[  119.774672] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x8, on_stack: 0
[  119.781600] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a3000, rq->data_len: 0x4c, on_stack: 0
[  119.805326] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c879000, rq->data_len: 0x8, on_stack: 0
[  119.817798] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c879000, rq->data_len: 0x2, on_stack: 0
[  119.821054] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c879000, rq->data_len: 0x22, on_stack: 0
[  119.823215] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c879000, rq->data_len: 0x8, on_stack: 0
[  119.844039] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a958b000, rq->data_len: 0x8, on_stack: 0
[  119.858426] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ad000, rq->data_len: 0x8, on_stack: 0
[  119.867230] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c800000, rq->data_len: 0x4c, on_stack: 0
[  119.880347] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8b9000, rq->data_len: 0x8, on_stack: 0
[  119.889202] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0941000, rq->data_len: 0x4c, on_stack: 0
[  120.060702] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08b4000, rq->data_len: 0x8, on_stack: 0
[  122.060831] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a5000, rq->data_len: 0x8, on_stack: 0
[  124.060713] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e3000, rq->data_len: 0x8, on_stack: 0
[  126.061065] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95ca000, rq->data_len: 0x8, on_stack: 0
[  128.061731] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c84b000, rq->data_len: 0x8, on_stack: 0
[  130.062045] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e4000, rq->data_len: 0x8, on_stack: 0
[  132.061084] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a5000, rq->data_len: 0x8, on_stack: 0
[  134.061501] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08f8000, rq->data_len: 0x8, on_stack: 0
[  136.061301] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c825000, rq->data_len: 0x8, on_stack: 0
[  138.063364] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c825000, rq->data_len: 0x8, on_stack: 0
[  140.061978] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  142.061206] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0901000, rq->data_len: 0x8, on_stack: 0
[  144.061065] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89f000, rq->data_len: 0x8, on_stack: 0
[  146.060885] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0x8, on_stack: 0
[  148.061043] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c84b000, rq->data_len: 0x8, on_stack: 0
[  150.060804] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c92b000, rq->data_len: 0x8, on_stack: 0
[  152.061802] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c92d000, rq->data_len: 0x8, on_stack: 0
[  154.061053] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c804000, rq->data_len: 0x8, on_stack: 0
[  156.060533] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ed000, rq->data_len: 0x8, on_stack: 0
[  158.060963] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8da000, rq->data_len: 0x8, on_stack: 0
[  160.061076] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a6000, rq->data_len: 0x8, on_stack: 0
[  162.061713] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a5581000, rq->data_len: 0x8, on_stack: 0
[  164.062054] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c91f000, rq->data_len: 0x8, on_stack: 0
[  166.060835] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0949000, rq->data_len: 0x8, on_stack: 0
[  168.061102] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c3000, rq->data_len: 0x8, on_stack: 0
[  170.061860] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e8000, rq->data_len: 0x8, on_stack: 0
[  172.060848] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x8, on_stack: 0
[  174.064964] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x8, on_stack: 0
[  176.060906] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c6000, rq->data_len: 0x8, on_stack: 0
[  178.060846] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0x8, on_stack: 0
[  180.061843] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c884000, rq->data_len: 0x8, on_stack: 0
[  182.060886] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c90d000, rq->data_len: 0x8, on_stack: 0
[  184.060647] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c90d000, rq->data_len: 0x8, on_stack: 0
[  186.060920] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0x8, on_stack: 0
[  188.061166] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b2980000, rq->data_len: 0x8, on_stack: 0
[  190.061049] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e6000, rq->data_len: 0x8, on_stack: 0
[  192.061070] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c918000, rq->data_len: 0x8, on_stack: 0
[  194.061177] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b2980000, rq->data_len: 0x8, on_stack: 0
[  196.061075] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08f8000, rq->data_len: 0x8, on_stack: 0
[  198.061351] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x8, on_stack: 0
[  200.061485] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e8000, rq->data_len: 0x8, on_stack: 0
[  202.061368] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a0000, rq->data_len: 0x8, on_stack: 0
[  204.061078] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c880000, rq->data_len: 0x8, on_stack: 0
[  206.062442] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ee000, rq->data_len: 0x8, on_stack: 0
[  208.059961] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0x8, on_stack: 0
[  210.061320] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a558f000, rq->data_len: 0x8, on_stack: 0
[  212.061132] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c843000, rq->data_len: 0x8, on_stack: 0
[  214.061282] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c843000, rq->data_len: 0x8, on_stack: 0
[  216.063106] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c804000, rq->data_len: 0x8, on_stack: 0
[  218.062691] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8da000, rq->data_len: 0x8, on_stack: 0
[  220.062665] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ef000, rq->data_len: 0x8, on_stack: 0
[  222.062120] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a0000, rq->data_len: 0x8, on_stack: 0
[  224.061877] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c918000, rq->data_len: 0x8, on_stack: 0
[  224.551034] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c935000, rq->data_len: 0x8, on_stack: 0
[  224.565951] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c935000, rq->data_len: 0x8, on_stack: 0
[  224.575432] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c935000, rq->data_len: 0x4c, on_stack: 0
[  224.592724] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c935000, rq->data_len: 0x8, on_stack: 0
[  224.602175] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c935000, rq->data_len: 0x4c, on_stack: 0
[  226.063293] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0x8, on_stack: 0
[  226.530338] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x24, on_stack: 0
[  226.534405] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.541831] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.549572] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.556945] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.564387] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.583615] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x14c, on_stack: 0
[  226.601287] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.618802] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x14c, on_stack: 0
[  226.638457] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.645862] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.653461] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.660843] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.667769] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.686909] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x8, on_stack: 0
[  226.704615] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x14c, on_stack: 0
[  226.725964] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.733228] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.741163] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.750029] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.757248] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.765049] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.774023] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.781309] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.788967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4c, on_stack: 0
[  226.796319] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.800663] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x18, on_stack: 0
[  226.805293] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x18, on_stack: 0
[  226.809739] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x18, on_stack: 0
[  226.814043] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.818267] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.822536] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.829143] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.834782] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.837454] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.841845] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.848068] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.855863] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.863256] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.870814] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.878648] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.886161] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.893670] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.901492] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.907086] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x2, on_stack: 0
[  226.911338] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.915599] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.920740] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x3c, on_stack: 0
[  226.924115] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x10, on_stack: 0
[  226.929205] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0xc, on_stack: 0
[  226.931571] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c96a000, rq->data_len: 0x4, on_stack: 0
[  228.940465] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x10, on_stack: 0
[  228.946477] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x10, on_stack: 0
[  228.947309] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x8, on_stack: 0
[  228.947860] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x4, on_stack: 0
[  228.948949] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x1c, on_stack: 0
[  228.950146] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x4, on_stack: 0
[  228.951899] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x22, on_stack: 0
[  228.953774] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x4, on_stack: 0
[  228.955452] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x22, on_stack: 0
[  228.957654] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x2, on_stack: 0
[  228.958973] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.960372] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.962473] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.964913] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x2, on_stack: 0
[  228.966223] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.967525] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.968307] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x8, on_stack: 0
[  228.986942] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x3c, on_stack: 0
[  228.988802] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c7000, rq->data_len: 0x1c, on_stack: 0
[  228.992115] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x2, on_stack: 0
[  228.993221] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  228.994308] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  228.995799] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  228.997965] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x2, on_stack: 0
[  228.999085] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  229.000158] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  229.000882] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x8, on_stack: 0
[  229.019272] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x3c, on_stack: 0
[  229.021449] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x2, on_stack: 0
[  229.022705] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x18, on_stack: 0
[  229.024195] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x18, on_stack: 0
[  229.025627] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x18, on_stack: 0
[  229.026678] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x2, on_stack: 0
[  229.032370] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x4c, on_stack: 0
[  229.038038] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x4c, on_stack: 0
[  229.044795] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x2, on_stack: 0
[  229.050963] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x4c, on_stack: 0
[  229.056615] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c94e000, rq->data_len: 0x4c, on_stack: 0
[  234.063169] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x4, on_stack: 0
[  234.064772] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x2, on_stack: 0
[  234.066293] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.067831] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.069160] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x2, on_stack: 0
[  234.070457] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.071849] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.073248] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.074906] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.076415] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x2, on_stack: 0
[  234.077783] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.079181] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.080574] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x18, on_stack: 0
[  234.082335] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.084811] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x2, on_stack: 0
[  234.086071] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.087457] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.089614] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x3c, on_stack: 0
[  234.095321] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba418000, rq->data_len: 0x1c, on_stack: 0
[  252.480046] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xc, on_stack: 0
[  252.480648] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  252.515517] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c91d000, rq->data_len: 0xf810, on_stack: 0
[  252.552406] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  252.566300] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c91d000, rq->data_len: 0xf810, on_stack: 0
[  252.603257] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  252.650016] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c91d000, rq->data_len: 0x89d0, on_stack: 0
[  252.668439] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xc, on_stack: 0
[  252.671207] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  252.704711] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  252.738188] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  252.774241] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  252.806915] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  252.839323] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  252.871902] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  252.904528] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  252.937647] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  252.970768] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  253.003779] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  253.040923] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  253.073622] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  253.106192] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  253.139055] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  253.171652] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xf810, on_stack: 0
[  253.204544] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c913000, rq->data_len: 0xf810, on_stack: 0
[  253.237737] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c89d000, rq->data_len: 0xc, on_stack: 0
[  253.243221] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.280030] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.312306] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.344855] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.379439] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.411710] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.444638] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.481162] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.517631] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.549958] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.581959] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.613943] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.646378] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.678526] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.711022] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.743431] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.779875] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.816332] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xc, on_stack: 0
[  253.816879] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.849027] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.882153] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.914385] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  253.947298] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  253.979661] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.011964] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.044333] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.076822] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.109375] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.141912] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.174616] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.207033] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.239857] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.272638] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.305310] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.338414] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xc, on_stack: 0
[  254.338969] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.374951] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.413679] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.455457] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.487889] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.521364] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.557803] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.590041] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.622483] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.654576] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.686827] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.719018] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.751594] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.783824] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.820425] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.852543] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.884538] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.916770] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xc, on_stack: 0
[  254.921027] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  254.953632] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  254.986232] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.018614] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.050696] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.083144] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.115194] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.147773] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.181140] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.214161] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.246694] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.278981] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.311362] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.343810] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.380301] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.413938] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.447002] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xc, on_stack: 0
[  255.447568] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.485559] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.521760] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.554526] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.586935] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.619114] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.651240] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.683519] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.720124] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.752294] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.784352] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.816643] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.848682] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.880952] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.913221] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  255.945768] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  255.978156] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c969000, rq->data_len: 0xf810, on_stack: 0
[  256.010529] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xc, on_stack: 0
[  256.013140] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.045586] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.077747] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.110312] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.142553] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.174749] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.206767] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.239731] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.272235] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.304485] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.336929] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.369459] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.401871] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.434211] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.468015] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.500568] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.533099] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xc, on_stack: 0
[  256.533644] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.571068] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.605646] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.638398] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.670766] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.702837] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.735016] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.767277] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.799622] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.831744] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.864124] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.896417] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.928707] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  256.961642] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  256.993841] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  257.026048] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  257.058484] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8e7000, rq->data_len: 0xf810, on_stack: 0
[  257.090617] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xc, on_stack: 0
[  257.092887] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.125376] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.157477] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.189814] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.222216] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.254468] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.288402] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.320825] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.353336] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.385655] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.418291] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.450933] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.487296] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.519902] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.556422] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.595798] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.629490] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xc, on_stack: 0
[  257.630049] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.666821] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.699364] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.732208] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.769622] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.803269] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.835567] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.868201] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.900589] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.932882] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  257.965622] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  257.997823] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.030048] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.062895] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.095479] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.127647] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.160567] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.193238] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xc, on_stack: 0
[  258.193793] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.226035] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.259673] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.291833] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.324148] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.356668] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.388948] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.421111] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.462377] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.495277] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.527958] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.560013] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.592165] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.624365] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.657623] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.689881] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c822000, rq->data_len: 0xf810, on_stack: 0
[  258.722041] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xc, on_stack: 0
[  258.722628] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.760304] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  258.796544] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.832928] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  258.867599] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.899839] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  258.932025] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  258.964391] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  258.997050] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.029314] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.061669] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.093964] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.126275] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.158919] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.191162] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.223451] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.259810] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.292322] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xc, on_stack: 0
[  259.292898] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.325280] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.357612] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.390495] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.422896] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.455211] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.487717] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.520184] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.552456] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.584513] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.622479] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0

--Boundary-00=_oHIAJ2Kr3KWRhL1
Content-Type: text/plain;
  charset="iso 8859-15";
  name="log_late.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log_late.msg"

bling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  258.997050] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.029314] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.061669] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.093964] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.126275] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.158919] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.191162] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.223451] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.259810] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.292322] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xc, on_stack: 0
[  259.292898] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.325280] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.357612] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.390495] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.422896] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.455211] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.487717] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.520184] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.552456] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  259.584513] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95a4000, rq->data_len: 0xf810, on_stack: 0
[  259.622479] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c846000, rq->data_len: 0xf810, on_stack: 0
[  422.060957] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9c0000, rq->data_len: 0x8, on_stack: 0
[  424.061750] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b6000, rq->data_len: 0x8, on_stack: 0
[  426.062171] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c976000, rq->data_len: 0x8, on_stack: 0
[  428.060874] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800aa881000, rq->data_len: 0x8, on_stack: 0
[  430.061891] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c955000, rq->data_len: 0x8, on_stack: 0
[  432.060987] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c906000, rq->data_len: 0x8, on_stack: 0
[  434.060889] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b7c27000, rq->data_len: 0x8, on_stack: 0
[  436.061112] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a09e8000, rq->data_len: 0x8, on_stack: 0
[  438.061320] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9c0000, rq->data_len: 0x8, on_stack: 0
[  440.061174] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a95c6000, rq->data_len: 0x8, on_stack: 0
[  442.061425] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b9000, rq->data_len: 0x8, on_stack: 0
[  443.600575] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0912000, rq->data_len: 0x24, on_stack: 0
[  443.610322] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x24, on_stack: 0
[  443.612633] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.616339] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.621056] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.625864] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.628309] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.633134] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.637927] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.642611] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.648137] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x28, on_stack: 0
[  443.658288] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.662229] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.667086] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0xc, on_stack: 0
[  443.672342] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.677563] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x10, on_stack: 0
[  443.681125] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0xc, on_stack: 0
[  443.686439] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x44, on_stack: 0
[  443.692439] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x8, on_stack: 0
[  443.694881] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.702259] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.706188] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.710140] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.714110] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.718088] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.722517] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.726510] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x3c, on_stack: 0
[  443.737220] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x8, on_stack: 0
[  443.744452] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x4c, on_stack: 0
[  443.750380] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x8, on_stack: 0
[  443.762562] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x8, on_stack: 0
[  443.769604] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4ec000, rq->data_len: 0x4c, on_stack: 0
[  443.791917] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4e9000, rq->data_len: 0x8, on_stack: 0
[  443.804066] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4e9000, rq->data_len: 0x2, on_stack: 0
[  443.807269] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4e9000, rq->data_len: 0x22, on_stack: 0
[  443.811227] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba4e9000, rq->data_len: 0x8, on_stack: 0
[  443.832740] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b8000, rq->data_len: 0x8, on_stack: 0
[  443.846732] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a09db000, rq->data_len: 0x8, on_stack: 0
[  443.864095] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a092d000, rq->data_len: 0x4c, on_stack: 0
[  443.877665] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8b5000, rq->data_len: 0x8, on_stack: 0
[  443.891609] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c927000, rq->data_len: 0x4c, on_stack: 0
[  444.060804] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08ea000, rq->data_len: 0x8, on_stack: 0
[  446.061072] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b7000, rq->data_len: 0x8, on_stack: 0
[  448.060890] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c803000, rq->data_len: 0x8, on_stack: 0
[  450.060882] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a09ec000, rq->data_len: 0x8, on_stack: 0
[  451.713060] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  451.728054] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  451.737357] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x4c, on_stack: 0
[  451.747040] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  451.756413] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x4c, on_stack: 0
[  452.060707] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a09ee000, rq->data_len: 0x8, on_stack: 0
[  452.180200] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x24, on_stack: 0
[  452.182601] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.189972] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.197848] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.206720] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.215586] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.233069] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x14c, on_stack: 0
[  452.252346] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.269846] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x14c, on_stack: 0
[  452.289532] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.296899] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.304657] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.313527] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.320368] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.339456] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x8, on_stack: 0
[  452.356930] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x14c, on_stack: 0
[  452.382404] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.390153] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.399040] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.407896] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.415485] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.422825] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.432073] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.441040] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.449866] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4c, on_stack: 0
[  452.457561] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.461941] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x18, on_stack: 0
[  452.464851] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x18, on_stack: 0
[  452.469220] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x18, on_stack: 0
[  452.473484] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.476570] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.480810] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.487127] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.492627] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.496912] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.499915] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.506255] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.513722] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.521462] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.529087] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.536616] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.544403] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.551966] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.559461] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.565270] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x2, on_stack: 0
[  452.569659] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.573939] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.580234] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x3c, on_stack: 0
[  452.583605] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x10, on_stack: 0
[  452.589096] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0xc, on_stack: 0
[  452.591481] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0903000, rq->data_len: 0x4, on_stack: 0
[  454.636612] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x10, on_stack: 0
[  454.642634] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x10, on_stack: 0
[  454.643348] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  454.643813] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x4, on_stack: 0
[  454.644913] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x1c, on_stack: 0
[  454.646124] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x4, on_stack: 0
[  454.647939] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x22, on_stack: 0
[  454.649666] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x4, on_stack: 0
[  454.651387] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x22, on_stack: 0
[  454.654066] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x2, on_stack: 0
[  454.655342] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.656735] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.658571] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.661001] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x2, on_stack: 0
[  454.662119] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.663529] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.664319] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x8, on_stack: 0
[  454.683065] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x3c, on_stack: 0
[  454.684967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8ab000, rq->data_len: 0x1c, on_stack: 0
[  454.688465] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x2, on_stack: 0
[  454.689543] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.690629] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.692362] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.694765] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x2, on_stack: 0
[  454.696071] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.697140] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.697925] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x8, on_stack: 0
[  454.716275] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x3c, on_stack: 0
[  454.718437] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x2, on_stack: 0
[  454.719625] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x18, on_stack: 0
[  454.720785] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x18, on_stack: 0
[  454.721973] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x18, on_stack: 0
[  454.723428] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x2, on_stack: 0
[  454.729099] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x4c, on_stack: 0
[  454.734776] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x4c, on_stack: 0
[  454.742055] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x2, on_stack: 0
[  454.747855] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x4c, on_stack: 0
[  454.753537] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c988000, rq->data_len: 0x4c, on_stack: 0
[  457.761112] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x4, on_stack: 0
[  457.762696] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x2, on_stack: 0
[  457.763927] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.765052] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.766306] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x2, on_stack: 0
[  457.767485] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.768664] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.769873] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.771365] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.772707] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x2, on_stack: 0
[  457.773894] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.775054] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.776351] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x18, on_stack: 0
[  457.777772] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.780481] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x2, on_stack: 0
[  457.781600] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.782707] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.784243] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x3c, on_stack: 0
[  457.788871] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0899000, rq->data_len: 0x1c, on_stack: 0
[  476.185136] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c85c000, rq->data_len: 0xc, on_stack: 0
[  476.186207] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c85c000, rq->data_len: 0xf810, on_stack: 0
[  476.219835] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b0000, rq->data_len: 0xf810, on_stack: 0
[  476.253317] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c85c000, rq->data_len: 0xf810, on_stack: 0
[  476.286856] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b0000, rq->data_len: 0xf810, on_stack: 0
[  476.320459] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c85c000, rq->data_len: 0xf810, on_stack: 0
[  476.354159] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c9b0000, rq->data_len: 0x89d0, on_stack: 0
[  476.375219] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xc, on_stack: 0
[  476.375827] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.410307] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.443037] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.475515] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.498705] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.516157] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.575026] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.608487] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.642280] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.675883] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.708709] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.732007] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.774989] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.808556] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.822209] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.875722] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xf810, on_stack: 0
[  476.908667] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  476.942006] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c886000, rq->data_len: 0xc, on_stack: 0
[  476.947475] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  476.980386] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  476.999724] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.021021] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.079343] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.111960] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.145342] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.178039] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.211451] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.244158] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.277655] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.310108] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.343967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.380630] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.395598] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.449372] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.486768] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.519027] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xc, on_stack: 0
[  477.521471] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.547855] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.586820] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.620023] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.621933] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.685517] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.718017] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.751130] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.783620] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.816413] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.818021] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.882058] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.914737] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.923718] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  477.980259] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  477.982246] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.033591] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xc, on_stack: 0
[  478.048849] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.084925] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.121434] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.154498] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.191340] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.223429] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.255774] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.288145] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.320485] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.352737] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.385319] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.417588] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.449967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.482230] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.514410] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.546608] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.579075] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.611519] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xc, on_stack: 0
[  478.612074] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.645566] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.678071] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.710562] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.743086] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.775814] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.808550] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.841450] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.874054] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.906842] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  478.939773] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  478.972792] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  479.005778] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.038721] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  479.071830] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.105277] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  479.138402] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xc, on_stack: 0
[  479.138962] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.176966] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.213549] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.246767] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.278879] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.311156] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.343693] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.376085] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.408320] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.440620] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.472946] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.505345] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.537845] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.570547] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.603107] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.635661] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  479.668136] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c850000, rq->data_len: 0xf810, on_stack: 0
[  479.700973] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xc, on_stack: 0
[  479.703201] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  479.735805] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  479.768429] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  479.800848] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  479.833210] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  479.866003] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  479.898524] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  479.931384] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  479.964073] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  479.996996] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.029776] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.062895] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.095896] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.128980] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.162082] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.195038] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.228302] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  480.228869] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.261552] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.295439] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.332736] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.369337] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.401819] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.434096] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.466458] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.499094] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.531556] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.563973] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.597200] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.629554] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.662091] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.694722] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.727153] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.759307] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.791570] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xc, on_stack: 0
[  480.792128] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.825070] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.858351] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.890663] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.922915] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  480.955296] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  480.987606] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  481.019718] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  481.052251] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  481.085155] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  481.117816] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  481.150503] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  481.182893] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  481.215514] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  481.248167] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  481.280445] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  481.312958] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xc, on_stack: 0
[  481.316701] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.354153] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.391225] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.424042] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.456470] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.489266] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.521984] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.554494] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.587871] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.620326] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.653202] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.688684] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.721117] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.753415] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.785814] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.818035] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.850953] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.883283] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xc, on_stack: 0
[  481.883858] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.916050] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  481.948649] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  481.981706] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.013914] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.046381] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.078782] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.111833] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.144590] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.177174] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.209743] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.242000] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.274349] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.306648] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.338849] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.371346] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.403599] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xc, on_stack: 0
[  482.404159] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.442093] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.478539] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.511022] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.543341] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.576366] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.609073] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.641862] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.674466] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.707014] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.739587] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.772033] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.804693] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.837188] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.869774] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.902197] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  482.934481] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a54cb000, rq->data_len: 0xf810, on_stack: 0
[  482.966909] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xc, on_stack: 0
[  482.969565] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.002030] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.034176] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.066549] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.099142] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.131375] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.163621] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.196370] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.228654] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.261088] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.293327] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.325551] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.357969] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.390027] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.422306] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.454546] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.486795] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xc, on_stack: 0
[  483.487358] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.520373] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.557138] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.595062] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.627270] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.659708] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.692130] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.724647] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.756859] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.789198] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.821278] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.853862] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.886250] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.918516] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  483.950886] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  483.983042] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xf810, on_stack: 0
[  484.022431] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c818000, rq->data_len: 0xf810, on_stack: 0
[  484.054553] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c8a9000, rq->data_len: 0xc, on_stack: 0
[  484.056998] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.089400] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.121590] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.153820] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.186162] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.218496] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.250852] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.283194] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.315321] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.347629] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.379979] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.412061] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.444045] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.476312] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.508670] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.540965] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.574316] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  484.578121] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.615436] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.649093] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.681822] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.715481] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.747839] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.779945] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.812130] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.844459] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.876858] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.909335] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  484.941524] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  484.973595] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.005745] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.038115] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.070200] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.102932] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.135277] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xc, on_stack: 0
[  485.135842] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.169620] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.202414] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.234990] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.271264] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.303656] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.335807] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.368182] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.401083] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.433504] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.465719] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.497900] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.530330] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.562487] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.595123] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.627132] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.659443] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xc, on_stack: 0
[  485.659999] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.691985] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.724739] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.757094] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.794871] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.831089] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.863801] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.895929] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.928171] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  485.960460] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  485.992575] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  486.024824] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  486.056986] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  486.089343] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  486.121402] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  486.153984] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  486.186158] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c81a000, rq->data_len: 0xf810, on_stack: 0
[  486.218398] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  486.220791] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.254094] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.286351] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.318761] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.351323] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.383414] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.415860] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.448380] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.481062] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.514803] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.548235] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.582384] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.615509] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.647697] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.680010] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.712085] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.744189] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xc, on_stack: 0
[  486.744750] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.777459] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.809997] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.842055] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.874670] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.906823] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  486.939284] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  486.971582] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.003784] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.040143] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.072536] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.104979] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.136858] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.169520] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.201598] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.233901] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.266311] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.298594] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xc, on_stack: 0
[  487.299147] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.337691] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.375660] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.407883] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.439967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.472026] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.504059] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.536302] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.568505] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.600826] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.632959] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.665336] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.699029] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.734563] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.767138] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.799340] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ba107000, rq->data_len: 0xf810, on_stack: 0
[  487.831602] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xc, on_stack: 0
[  487.832176] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.864536] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  487.898020] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.930942] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  487.963250] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  487.995380] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.027461] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.059765] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.092143] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.124297] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.156634] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.188939] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.221586] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.254592] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.287768] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.320101] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.352324] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80a3000, rq->data_len: 0xf810, on_stack: 0
[  488.384646] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  488.385675] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.423643] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.460021] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.492477] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.525258] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.557781] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.589911] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.621997] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.654422] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.686825] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.719113] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.751284] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.783740] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.820463] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.854875] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.892170] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.928651] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  488.929221] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  488.961707] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  488.998443] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.035263] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.067727] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.099851] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.132077] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.164285] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.196465] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.228583] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.260712] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.292923] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.325714] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.358523] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.390891] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.423350] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.459616] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.491717] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xc, on_stack: 0
[  489.492266] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.526908] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.564486] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.600993] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.633831] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.666180] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.698699] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.731013] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.763346] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.799762] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.832285] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.864673] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.896622] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.928619] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  489.960865] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  489.993012] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.025727] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xc, on_stack: 0
[  490.026314] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.058455] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.090543] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.123627] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.160316] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.193480] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.225757] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.258284] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.290523] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.322827] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.355045] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.387423] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.423427] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.459591] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.495986] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.533638] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.566012] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.606204] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  490.618384] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.654546] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.688473] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.722304] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.756215] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.790187] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.824241] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.857460] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.891206] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.924969] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  490.958131] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  490.991011] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.024685] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.058447] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.091586] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.124356] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.157676] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xc, on_stack: 0
[  491.160557] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.194291] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.227922] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.264358] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.298190] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.332992] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.366663] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.401206] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.434970] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.467941] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.501785] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.535267] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.567975] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.601839] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.635550] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.668363] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xf810, on_stack: 0
[  491.702134] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b80c2000, rq->data_len: 0xf810, on_stack: 0
[  491.735689] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a0988000, rq->data_len: 0xc, on_stack: 0
[  491.739751] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  491.776305] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  491.809980] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  491.846248] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  491.879780] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  491.912851] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  491.945411] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  491.979354] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.012649] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.045802] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.078522] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.111135] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.147223] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.179429] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.211723] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.244070] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.280192] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xc, on_stack: 0
[  492.280751] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.314021] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.347954] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.382473] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.416684] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.449518] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.484179] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.520620] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.554487] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.590636] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.624774] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.658093] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.691173] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.724714] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.757839] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.791573] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.824565] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.857656] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xc, on_stack: 0
[  492.858225] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.892415] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.926330] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  492.962703] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  492.996633] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.030249] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.063216] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.097039] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.130608] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.164331] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.197716] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.230785] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.266594] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.300329] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.333822] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.369120] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.402684] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xc, on_stack: 0
[  493.403242] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.436495] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.470371] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.504294] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.540565] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.577128] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.613967] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.647782] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.680884] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.714046] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.747422] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.781694] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.834387] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.870851] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.904951] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  493.938367] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  493.971514] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.003989] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xc, on_stack: 0
[  494.004928] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.042464] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.075662] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.111254] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.143242] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.179125] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.218581] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.254748] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.287601] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.319911] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.352233] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.384926] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.417370] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.449738] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.485398] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.521850] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c882000, rq->data_len: 0xf810, on_stack: 0
[  494.558044] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xc, on_stack: 0
[  494.560024] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.596370] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.629303] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.662218] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.694444] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.726845] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.759095] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.791159] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.823344] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.860004] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.892712] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.925029] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  494.957471] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  494.989687] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.022414] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.054715] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.087189] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.119267] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xc, on_stack: 0
[  495.119812] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.155038] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.192739] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.226562] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.264909] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.303048] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.344036] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.384695] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.421886] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.461754] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.500391] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.538732] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.571784] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.607783] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.644133] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.678294] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800acc02000, rq->data_len: 0xf810, on_stack: 0
[  495.710870] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xc, on_stack: 0
[  495.711437] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.744372] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  495.777956] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  495.810673] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  495.842797] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  496.909591] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  496.941976] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  496.974431] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.006898] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  497.040080] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.072761] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  497.105213] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.137663] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  497.169900] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.202343] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  497.234546] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.266509] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800a08e0000, rq->data_len: 0xf810, on_stack: 0
[  497.298567] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xc, on_stack: 0
[  497.300498] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800b29a3000, rq->data_len: 0xf810, on_stack: 0
[  497.334222] Disabling dma for 0x2 cmd type, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff88009c915000, rq->data_len: 0xf810, on_stack: 0

--Boundary-00=_oHIAJ2Kr3KWRhL1--
