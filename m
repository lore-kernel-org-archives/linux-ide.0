From: piet@bioinf.nl (Piet Plomp)
Subject: PROBLEM: SATA PCI on SB600: unable to reserve I/O region
Date: Fri, 26 Sep 2008 17:13:46 +0200
Message-ID: <20080926151346.GA22930@mail.bin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [145.33.222.2] ([145.33.222.2]:42519 "EHLO mail.bioinf.nl"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbYIZPss (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Sep 2008 11:48:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi IDE/SATA kernel developers,

This is a problem report: SB600 motherboard SATA PCI: Unable to reserve I/O ...
Note I'm off-list; mail me directly to contact me.

[1.] One line summary of the problem:    
  SATA: PCI is unable to reserve an I/O region, so no (root) disk

[2.] Full description of the problem/report:

The SB600 system won't be able to boot kernel 2.6.26.5 because the kernel
cannot reserve I/O space for the PCI SATA "card". The 2.6.24.2 kernel has no
trouble booting on the same system.

I run a school network; one class has 18 of these systems from HP.

Kernel message on the 2.6.26.5 kernel:
  ahci 0000:00:12.0: version 3.0
  ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
  PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:12.0
  ahci: probe of 0000:00:12.0 failed with error -16

After this the system (booted from pxe/ramdisk) panics because it cannot find
the root fs on the sata disk, of course.

## These is the lspci -vvv output for the SATA entry (note the 1f0 8 bytes!):
00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA (prog-if 01 [AHCI 1.0])
        Subsystem: Hewlett-Packard Company Unknown device 2812
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at 2100 [size=16]
        Region 5: Memory at d8a09000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] #12 [0010]

Compared to the same dmesg output for 2.6.24.2 in which everything is ok:
  ahci 0000:00:12.0: version 3.0
  ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
  ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
  ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
  ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
  ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
  scsi0 : ahci
  scsi1 : ahci
  scsi2 : ahci
  scsi3 : ahci
  ata1: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09100 irq 22
  ata2: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09180 irq 22
  ata3: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09200 irq 22
  ata4: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09280 irq 22
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.00: ATA-7: ST3250824AS, 3.AHL, max UDMA/100
  ata1.00: 488397168 sectors, multi 16: LBA48 
  ata1.00: configured for UDMA/100
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: ATAPI: ATAPI   DVD D  DH16DYS, XH31, max UDMA/100
  ata2.00: configured for UDMA/100
  ...
  scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AH PQ: 0 ANSI: 5
  sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
  sd 0:0:0:0: [sda] Attached SCSI disk
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  scsi 1:0:0:0: CD-ROM            ATAPI    DVD D  DH16DYS   XH31 PQ: 0 ANSI: 5
  sr0: scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
  Uniform CD-ROM driver Revision: 3.20
  sr 1:0:0:0: Attached scsi CD-ROM sr0

[3.] Keywords (i.e., modules, networking, kernel):
     sata iomem pci ahci "unable to reserve I/O region"

[4.] Kernel version (from /proc/version):
     fail: 2.6.26.5; 
     ok: 2.6.24.2 (Linux version 2.6.24.2 (piet@calculix) (gcc version 4.1.2
     20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Tue Feb 12 17:35:39 CET
     2008) 

[5.] Output of Oops.. message (if applicable) 
     No oops, just a panic: disk (0,0) not found

[6.] A small shell script 
     N/A: problem happens early at boot
     
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux bin111 2.6.24.2 #2 SMP Tue Feb 12 17:35:39 CET 2008 x86_64 GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
xfsprogs               2.8.11
quota-tools            3.14.
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   105
Modules Loaded         eeprom w83781d hwmon_vid i2c_viapro snd_hda_intel snd_pcm_oss snd_mixer_oss snd_pcm i2c_piix4 snd_timer snd_page_alloc k8temp

Note compilation machine has the same software (Debian etch).

[7.2.] Processor information (from /proc/cpuinfo):
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 15
  model           : 75
  model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
  stepping        : 2
  cpu MHz         : 2200.000
  cache size      : 512 KB
  physical id     : 0
  siblings        : 2
  core id         : 0
  cpu cores       : 2
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
  bogomips        : 4393.55
  TLB size        : 1024 4K pages
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 40 bits physical, 48 bits virtual
  power management: ts fid vid ttp tm stc

  processor       : 1
  vendor_id       : AuthenticAMD
  cpu family      : 15
  model           : 75
  model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
  stepping        : 2
  cpu MHz         : 2200.000
  cache size      : 512 KB
  physical id     : 0
  siblings        : 2
  core id         : 1
  cpu cores       : 2
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
  bogomips        : 4390.87
  TLB size        : 1024 4K pages
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 40 bits physical, 48 bits virtual
  power management: ts fid vid ttp tm stc

[7.3.] Module information (from /proc/modules):
  cat /proc/modules (from 2.6.24.2)
  eeprom 7120 0 - Live 0xffffffff880a1000
  w83781d 37424 0 - Live 0xffffffff88096000
  hwmon_vid 3712 1 w83781d, Live 0xffffffff88094000
  i2c_viapro 10008 0 - Live 0xffffffff88090000
  snd_hda_intel 364388 0 - Live 0xffffffff88036000
  snd_pcm_oss 39648 0 - Live 0xffffffff8802b000
  snd_mixer_oss 16640 1 snd_pcm_oss, Live 0xffffffff88025000
  snd_pcm 73480 2 snd_hda_intel,snd_pcm_oss, Live 0xffffffff88012000
  i2c_piix4 9932 0 - Live 0xffffffff8800e000
  snd_timer 21768 1 snd_pcm, Live 0xffffffff88007000
  snd_page_alloc 8784 2 snd_hda_intel,snd_pcm, Live 0xffffffff88003000
  k8temp 5440 0 - Live 0xffffffff8800000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
  cat /proc/ioports (2.6.26.5)
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0077 : rtc
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0170-0177 : 0000:00:12.0
    0170-0177 : ide_generic
  01f0-01f7 : 0000:00:12.0
    01f0-01f7 : ide_generic
  0376-0376 : 0000:00:12.0
    0376-0376 : ide_generic
  03c0-03df : vga+
  03f6-03f6 : 0000:00:12.0
    03f6-03f6 : ide_generic
  0400-041f : pnp 00:0c
  0420-043f : pnp 00:0c
  0440-045f : pnp 00:0c
  0460-047f : pnp 00:0c
  0480-048f : pnp 00:0c
  04d0-04df : pnp 00:0b
  0800-081f : pnp 00:0c
  0820-083f : pnp 00:0c
  0840-085f : pnp 00:0c
  0860-087f : pnp 00:0c
    0860-0861 : ACPI PM1b_CNT_BLK
  0c00-0c1f : pnp 00:0c
  0c50-0c6f : pnp 00:0c
  0cd0-0cdf : pnp 00:0c
  0cf8-0cff : PCI conf1
  1000-1fff : PCI Bus 0000:01
    1100-11ff : 0000:01:05.0
  2100-210f : 0000:00:12.0
  2120-212f : 0000:00:14.1
  2140-2147 : 0000:00:14.1
  2148-214f : 0000:00:14.1
  2158-215b : 0000:00:14.1
  215c-215f : 0000:00:14.1
  f800-f81f : pnp 00:0c
    f800-f803 : ACPI PM1a_EVT_BLK
    f804-f805 : ACPI PM1a_CNT_BLK
    f808-f80b : ACPI PM_TMR
    f810-f815 : ACPI CPU throttle
  f820-f83f : pnp 00:0c
    f828-f82f : ACPI GPE0_BLK
  f840-f85f : pnp 00:0c
  f860-f87f : pnp 00:0c
  fa00-fa3f : pnp 00:0c
  fc00-fc0f : 0000:00:14.0
  fe00-fe7f : pnp 00:0c
  fe80-feff : pnp 00:0c

  cat /proc/iomem (2.6.24.2)
  00000000-0009fbff : System RAM
  0009fc00-0009ffff : reserved
  000d1c00-000e3fff : pnp 00:0d
  000e8000-000fffff : reserved
  00100000-77eb7eff : System RAM
    00200000-005dffae : Kernel code
    005dffaf-0075738f : Kernel data
    007d4000-00826b47 : Kernel bss
  77eb7f00-7fffffff : reserved
  c8000000-d81fffff : PCI Bus #01
    c8000000-cfffffff : 0000:01:05.0
    d0000000-d7ffffff : 0000:01:05.1
    d8000000-d801ffff : 0000:01:05.0
  d8200000-d84fffff : PCI Bus #3f
    d8400000-d840ffff : 0000:3f:00.0
      d8400000-d840ffff : tg3
  d8500000-d87fffff : PCI Bus #01
    d8500000-d850ffff : 0000:01:05.0
    d8510000-d851ffff : 0000:01:05.1
  d8a00000-d8a03fff : 0000:00:14.2
    d8a00000-d8a03fff : ICH HD audio
  d8a04000-d8a04fff : 0000:00:13.0
  d8a05000-d8a05fff : 0000:00:13.1
  d8a06000-d8a06fff : 0000:00:13.2
  d8a07000-d8a07fff : 0000:00:13.3
  d8a08000-d8a08fff : 0000:00:13.4
  d8a09000-d8a093ff : 0000:00:12.0
    d8a09000-d8a093ff : ahci
  d8a09400-d8a097ff : 0000:00:14.0
  d8a09800-d8a098ff : 0000:00:13.5
    d8a09800-d8a098ff : ehci_hcd
  e0000000-efffffff : reserved
  fec00000-fed3ffff : reserved
    fec00000-fec00fff : IOAPIC 0
  fee00000-fee00fff : Local APIC

[7.5.] PCI information ('lspci -vvv' as root)
  00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 10)
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
  
  00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: d8500000-d87fffff
        Prefetchable memory behind bridge: 00000000c8000000-00000000d81fffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [44] HyperTransport: MSI Mapping
        Capabilities: [b0] Subsystem: Hewlett-Packard Company Unknown device 280a
  
  00:07.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=3f, subordinate=3f, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d8200000-d84fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 6, PowerLimit 25.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd Off, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device 5950
        Capabilities: [b8] HyperTransport: MSI Mapping
  
  00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA (prog-if 01 [AHCI 1.0])
        Subsystem: Hewlett-Packard Company Unknown device 2812
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at 2100 [size=16]
        Region 5: Memory at d8a09000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] #12 [0010]
  
  00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0) (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8a04000 (32-bit, non-prefetchable) [size=4K]
  
  00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1) (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at d8a05000 (32-bit, non-prefetchable) [size=4K]
  
  00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2) (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at d8a06000 (32-bit, non-prefetchable) [size=4K]
  
  00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3) (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at d8a07000 (32-bit, non-prefetchable) [size=4K]
  
  00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4) (prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at d8a08000 (32-bit, non-prefetchable) [size=4K]
  
  00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller (EHCI) (prog-if 20 [EHCI])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at d8a09800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [e4] Debug port
  
  00:14.0 SMBus: ATI Technologies Inc SB600 SMBus (rev 13)
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: I/O ports at fc00 [size=16]
        Region 1: Memory at d8a09400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [b0] HyperTransport: MSI Mapping
  
  00:14.1 IDE interface: ATI Technologies Inc SB600 IDE (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 2140 [size=8]
        Region 1: I/O ports at 2158 [size=4]
        Region 2: I/O ports at 2148 [size=8]
        Region 3: I/O ports at 215c [size=4]
        Region 4: I/O ports at 2120 [size=16]
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
  
  00:14.2 Audio device: ATI Technologies Inc SB600 Azalia
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at d8a00000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
  
  00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
  
  00:14.4 PCI bridge: ATI Technologies Inc SB600 PCI to PCI Bridge (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
  
  00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02
  
  00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  
  00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  
  00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [f0] #0f [0010]
  
  01:05.0 VGA compatible controller: ATI Technologies Inc RS482 [Radeon Xpress 200] (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 1100 [size=256]
        Region 2: Memory at d8500000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at d8000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  
  01:05.1 Display controller: ATI Technologies Inc Unknown device 5874
        Subsystem: Hewlett-Packard Company Unknown device 280b
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 64 bytes
        Region 0: Memory at d0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Region 1: Memory at d8510000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  
  3f:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5755 Gigabit Ethernet PCI Express (rev 02)
        Subsystem: Hewlett-Packard Company Unknown device 280a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d8400000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at <ignored> [disabled]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Vendor Specific Information
        Capabilities: [e8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0441c84000204800  Data: 0000
        Capabilities: [d0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <4us, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
                Link: Latency L0s <4us, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1

[7.6.] SCSI information (from /proc/scsi/scsi)
       ?no such dir

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
       I'll show the complete dmesg outputs for 2.6.24.2 and 2.6.26.5:
  [2.6.24.2 dmesg]
  Linux version 2.6.24.2 (piet@calculix) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Tue Feb 12 17:35:39 CET 2008
  Command line: ro initrd=autoinitrd.gz root=/dev/sda1 BOOT_IMAGE=vmlinuz-2.6.24.2-amd64x2 ip=192.168.2.121:192.168.1.2:192.168.2.254:255.255.255.0 
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
   BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
   BIOS-e820: 0000000000100000 - 0000000077eb7f00 (usable)
   BIOS-e820: 0000000077eb7f00 - 0000000080000000 (reserved)
   BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
   BIOS-e820: 00000000fec00000 - 00000000fed40000 (reserved)
   BIOS-e820: 00000000fed45000 - 0000000100000000 (reserved)
  Entering add_active_range(0, 0, 159) 0 entries of 3200 used
  Entering add_active_range(0, 256, 491191) 1 entries of 3200 used
  end_pfn_map = 1048576
  DMI 2.4 present.
  ACPI: RSDP 000E7610, 0014 (r0 COMPAQ)
  ACPI: RSDT 77EC7F40, 0038 (r1 HPQOEM SLIC-BPC 20070125             0)
  ACPI: FACP 77EC7FE8, 0074 (r1 COMPAQ HP_RS485        1             0)
  ACPI: DSDT 77EC8343, 8C65 (r1 COMPAQ DSDT_PRJ        1 MSFT  100000E)
  ACPI: FACS 77EC7F00, 0040
  ACPI: APIC 77EC805C, 0068 (r1 COMPAQ HP_RS485        1             0)
  ACPI: ASF! 77EC80C4, 0063 (r32 COMPAQ HP_RS485        1             0)
  ACPI: MCFG 77EC8127, 003C (r1 COMPAQ HP_RS485        1             0)
  ACPI: TCPA 77EC8163, 0032 (r1 COMPAQ HP_RS485        1             0)
  ACPI: DMI detected: Hewlett-Packard
  No NUMA configuration found
  Faking a node at 0000000000000000-0000000077eb7000
  Entering add_active_range(0, 0, 159) 0 entries of 3200 used
  Entering add_active_range(0, 256, 491191) 1 entries of 3200 used
  Bootmem setup node 0 0000000000000000-0000000077eb7000
  No mptable found.
  Zone PFN ranges:
    DMA             0 ->     4096
    DMA32        4096 ->  1048576
    Normal    1048576 ->  1048576
  Movable zone start PFN for each node
  early_node_map[2] active PFN ranges
      0:        0 ->      159
      0:      256 ->   491191
  On node 0 totalpages: 491094
    DMA zone: 56 pages used for memmap
    DMA zone: 1582 pages reserved
    DMA zone: 2361 pages, LIFO batch:0
    DMA32 zone: 6659 pages used for memmap
    DMA32 zone: 480436 pages, LIFO batch:31
    Normal zone: 0 pages used for memmap
    Movable zone: 0 pages used for memmap
  ATI board detected. Disabling timer routing over 8254.
  ACPI: PM-Timer IO Port: 0xf808
  ACPI: Local APIC address 0xfee00000
  ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
  Processor #0 (Bootup-CPU)
  ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
  Processor #1
  ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
  ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
  IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
  ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
  ACPI: IRQ0 used by override.
  ACPI: IRQ2 used by override.
  ACPI: IRQ9 used by override.
  Setting APIC routing to flat
  Using ACPI (MADT) for SMP configuration information
  Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
  PERCPU: Allocating 29408 bytes of per cpu data
  Built 1 zonelists in Node order, mobility grouping on.  Total pages: 482797
  Policy zone: DMA32
  Kernel command line: ro initrd=autoinitrd.gz root=/dev/sda1 BOOT_IMAGE=vmlinuz-2.6.24.2-amd64x2 ip=192.168.2.121:192.168.1.2:192.168.2.254:255.255.255.0 
  Initializing CPU#0
  PID hash table entries: 4096 (order: 12, 32768 bytes)
  TSC calibrated against PM_TIMER
  Marking TSC unstable due to TSCs unsynchronized
  time.c: Detected 2194.494 MHz processor.
  Console: colour VGA+ 80x25
  console [tty0] enabled
  Checking aperture...
  CPU 0: aperture @ 3c94000000 size 32 MB
  Aperture too small (32 MB)
  No AGP bridge found
  Memory: 1926012k/1964764k available (3967k kernel code, 38364k reserved, 1500k data, 376k init)
  Calibrating delay using timer specific routine.. 4393.58 BogoMIPS (lpj=7319332)
  Security Framework initialized
  Capability LSM initialized
  Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
  Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
  Mount-cache hash table entries: 256
  CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
  CPU: L2 Cache: 512K (64 bytes/line)
  CPU 0/0 -> Node 0
  CPU: Physical Processor ID: 0
  CPU: Processor Core ID: 0
  Freeing SMP alternatives: 33k freed
  ACPI: Core revision 20070126
  Using local APIC timer interrupts.
  APIC timer calibration result 12468715
  Detected 12.468 MHz APIC timer.
  Booting processor 1/2 APIC 0x1
  Initializing CPU#1
  Calibrating delay using timer specific routine.. 4390.88 BogoMIPS (lpj=7315009)
  CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
  CPU: L2 Cache: 512K (64 bytes/line)
  CPU 1/1 -> Node 0
  CPU: Physical Processor ID: 0
  CPU: Processor Core ID: 1
  AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 02
  Brought up 2 CPUs
  net_namespace: 120 bytes
  NET: Registered protocol family 16
  ACPI: bus type pci registered
  PCI: Using configuration type 1
  ACPI: EC: Look up EC in DSDT
  ACPI: Interpreter enabled
  ACPI: (supports S0 S5)
  ACPI: Using IOAPIC for interrupt routing
  ACPI: PCI Root Bridge [PCI0] (0000:00)
  PCI: Transparent bridge - 0000:00:14.4
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IGFX._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCX2._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
  ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
  Linux Plug and Play Support v0.97 (c) Adam Belay
  pnp: PnP ACPI init
  ACPI: bus type pnp registered
  pnp: PnP ACPI: found 14 devices
  ACPI: ACPI bus type pnp unregistered
  SCSI subsystem initialized
  libata version 3.00 loaded.
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
  PCI: Using ACPI for IRQ routing
  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  system 00:0b: ioport range 0x4d0-0x4df has been reserved
  system 00:0c: ioport range 0x400-0x41f has been reserved
  system 00:0c: ioport range 0x420-0x43f has been reserved
  system 00:0c: ioport range 0x440-0x45f has been reserved
  system 00:0c: ioport range 0x460-0x47f has been reserved
  system 00:0c: ioport range 0x480-0x48f has been reserved
  system 00:0c: ioport range 0x800-0x81f has been reserved
  system 00:0c: ioport range 0x820-0x83f has been reserved
  system 00:0c: ioport range 0x840-0x85f has been reserved
  system 00:0c: ioport range 0x860-0x87f has been reserved
  system 00:0c: ioport range 0xc00-0xc1f has been reserved
  system 00:0c: ioport range 0xc50-0xc6f has been reserved
  system 00:0c: ioport range 0xcd0-0xcdf has been reserved
  system 00:0c: ioport range 0xf800-0xf81f has been reserved
  system 00:0c: ioport range 0xf820-0xf83f has been reserved
  system 00:0c: ioport range 0xf840-0xf85f has been reserved
  system 00:0c: ioport range 0xf860-0xf87f has been reserved
  system 00:0c: ioport range 0xfa00-0xfa3f has been reserved
  system 00:0c: ioport range 0xfe00-0xfe7f has been reserved
  system 00:0c: ioport range 0xfe80-0xfeff has been reserved
  system 00:0d: iomem range 0x0-0x9ffff could not be reserved
  system 00:0d: iomem range 0x100000-0x7fffffff could not be reserved
  system 00:0d: iomem range 0xe4000-0xfffff could not be reserved
  system 00:0d: iomem range 0xfec01000-0xfecfffff could not be reserved
  system 00:0d: iomem range 0xfed00000-0xfed3ffff could not be reserved
  system 00:0d: iomem range 0xfed40000-0xffffffff could not be reserved
  system 00:0d: iomem range 0xe0000000-0xefffffff could not be reserved
  system 00:0d: iomem range 0xd1c00-0xe3fff has been reserved
  PCI: Bridge: 0000:00:01.0
    IO window: 1000-1fff
    MEM window: d8500000-d87fffff
    PREFETCH window: c8000000-d81fffff
  PCI: Bridge: 0000:00:07.0
    IO window: disabled.
    MEM window: d8200000-d84fffff
    PREFETCH window: disabled.
  PCI: Bridge: 0000:00:14.4
    IO window: disabled.
    MEM window: disabled.
    PREFETCH window: disabled.
  PCI: Setting latency timer of device 0000:00:07.0 to 64
  NET: Registered protocol family 2
  Time: acpi_pm clocksource has been installed.
  IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
  TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
  TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
  TCP: Hash tables configured (established 262144 bind 65536)
  TCP reno registered
  checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
  Freeing initrd memory: 4848k freed
  VFS: Disk quotas dquot_6.5.1
  Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
  NTFS driver 2.1.29 [Flags: R/O].
  SGI XFS with large block/inode numbers, no debug enabled
  SGI XFS Quota Management subsystem
  io scheduler noop registered
  io scheduler anticipatory registered
  io scheduler deadline registered
  io scheduler cfq registered (default)
  PCI: MSI quirk detected. MSI deactivated.
  Boot video device is 0000:01:05.0
  PCI: Setting latency timer of device 0000:00:07.0 to 64
  assign_interrupt_mode Found MSI capability
  Allocate Port Service[0000:00:07.0:pcie00]
  input: Power Button (FF) as /devices/virtual/input/input0
  ACPI: Power Button (FF) [PWRF]
  input: Power Button (CM) as /devices/virtual/input/input1
  ACPI: Power Button (CM) [PBTN]
  ACPI: Processor [CPU0] (supports 8 throttling states)
  ACPI: Processor [CPU1] (supports 8 throttling states)
  Real Time Clock Driver v1.12ac
  Non-volatile memory driver v1.2
  Linux agpgart interface v0.102
  [drm] Initialized drm 1.1.0 20060810
  ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
  [drm] Initialized radeon 1.28.0 20060524 on minor 0
  floppy0: no floppy controllers found
  RAMDISK driver initialized: 8 RAM disks of 16384K size 1024 blocksize
  loop: module loaded
  tg3.c:v3.86 (November 9, 2007)
  ACPI: PCI Interrupt 0000:3f:00.0[A] -> GSI 19 (level, low) -> IRQ 19
  PCI: Setting latency timer of device 0000:3f:00.0 to 64
  eth0: Tigon3 [partno(BCM95755) rev a002 PHY(5755)] (PCI Express) 10/100/1000Base-T Ethernet 00:19:bb:e2:7d:ca
  eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
  eth0: dma_rwctrl[76180000] dma_mask[64-bit]
  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  Probing IDE interface ide0...
  Probing IDE interface ide1...
  Driver 'sd' needs updating - please use bus_type methods
  Driver 'sr' needs updating - please use bus_type methods
  ahci 0000:00:12.0: version 3.0
  ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
  ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
  ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
  ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
  ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
  scsi0 : ahci
  scsi1 : ahci
  scsi2 : ahci
  scsi3 : ahci
  ata1: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09100 irq 22
  ata2: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09180 irq 22
  ata3: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09200 irq 22
  ata4: SATA max UDMA/133 abar m1024@0xd8a09000 port 0xd8a09280 irq 22
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.00: ATA-7: ST3250824AS, 3.AHL, max UDMA/100
  ata1.00: 488397168 sectors, multi 16: LBA48 
  ata1.00: configured for UDMA/100
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: ATAPI: ATAPI   DVD D  DH16DYS, XH31, max UDMA/100
  ata2.00: configured for UDMA/100
  ata3: SATA link down (SStatus 0 SControl 300)
  ata4: SATA link down (SStatus 0 SControl 300)
  scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AH PQ: 0 ANSI: 5
  sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
  sd 0:0:0:0: [sda] Attached SCSI disk
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  scsi 1:0:0:0: CD-ROM            ATAPI    DVD D  DH16DYS   XH31 PQ: 0 ANSI: 5
  sr0: scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
  Uniform CD-ROM driver Revision: 3.20
  sr 1:0:0:0: Attached scsi CD-ROM sr0
  sr 1:0:0:0: Attached scsi generic sg1 type 5
  usbmon: debugfs is not available
  ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
  ehci_hcd 0000:00:13.5: EHCI Host Controller
  ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
  ehci_hcd 0000:00:13.5: debug port 1
  ehci_hcd 0000:00:13.5: irq 19, io mem 0xd8a09800
  ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 10 ports detected
  USB Universal Host Controller Interface driver v3.0
  Initializing USB Mass Storage driver...
  usbcore: registered new interface driver usb-storage
  USB Mass Storage support registered.
  PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
  serio: i8042 KBD port at 0x60,0x64 irq 1
  serio: i8042 AUX port at 0x60,0x64 irq 12
  mice: PS/2 mouse device common for all mice
  input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
  i2c /dev entries driver
  EDAC MC: Ver: 2.1.0 Feb 12 2008
  usbcore: registered new interface driver usbhid
  drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
  Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:42 2007 UTC).
  ALSA device list:
    No soundcards found.
  Netfilter messages via NETLINK v0.30.
  nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
  ip_tables: (C) 2000-2006 Netfilter Core Team
  arp_tables: (C) 2002 David S. Miller
  TCP cubic registered
  Initializing XFRM netlink socket
  NET: Registered protocol family 1
  NET: Registered protocol family 17
  NET: Registered protocol family 15
  RPC: Registered udp transport module.
  RPC: Registered tcp transport module.
  powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (2 cpu cores) (version 2.20.00)
  powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xc
  powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xe
  powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x10
  powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
  powernow-k8: ph2 null fid transition 0xe
  input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input3
  IP-Config: Complete:
        device=eth0, addr=192.168.2.121, mask=255.255.255.0, gw=192.168.2.254,
       host=192.168.2.121, domain=, nis-domain=(none),
       bootserver=192.168.1.2, rootserver=192.168.1.2, rootpath=
  RAMDISK: Compressed image found at block 0
  EXT2-fs warning: checktime reached, running e2fsck is recommended
  VFS: Mounted root (ext2 filesystem).
  tg3: eth0: Link is up at 1000 Mbps, full duplex.
  tg3: eth0: Flow control is off for TX and off for RX.
  kjournald starting.  Commit interval 5 seconds
  EXT3-fs: mounted filesystem with ordered data mode.
  VFS: Mounted root (ext3 filesystem) readonly.
  Trying to move old root to /initrd ... okay
  Freeing unused kernel memory: 376k freed
  piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
  piix4_smbus 0000:00:14.0: Using Interrupt SMI# for SMBus.
  piix4_smbus 0000:00:14.0: SMBREV = 0x0
  piix4_smbus 0000:00:14.0: SMBA = 0xFC00
  ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
  Adding 2008116k swap on /dev/sda3.  Priority:-1 extents:1 across:2008116k
  EXT3 FS on sda1, internal journal
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=40, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=40, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=42, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=42, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=44, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=44, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=46, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=46, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=48, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=48, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=4a, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=4a, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=4c, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=4c, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=4e, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=4e, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=50, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=50, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=52, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=52, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=54, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=54, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=56, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=56, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=58, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=58, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=5a, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=5a, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=5c, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=5c, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=5e, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=5e, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a0, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a0, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a2, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a2, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a4, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a4, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a4, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a4, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a6, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a6, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a6, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a6, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=a8, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=a8, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=aa, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=aa, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=ac, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=ac, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=5a, ADD=ae, DAT0=20, DAT1=00
  i2c-adapter i2c-0: Error: no response!
  i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=5a, ADD=ae, DAT0=20, DAT1=00
  XFS mounting filesystem sda2
  Ending clean XFS mount for filesystem: sda2
  XFS mounting filesystem sda5
  Ending clean XFS mount for filesystem: sda5
  XFS mounting filesystem sda6
  Ending clean XFS mount for filesystem: sda6
  XFS mounting filesystem sda7
  Ending clean XFS mount for filesystem: sda7
  XFS mounting filesystem sda8
  Ending clean XFS mount for filesystem: sda8
  XFS mounting filesystem sda9
  Ending clean XFS mount for filesystem: sda9
  XFS mounting filesystem sda10
  Ending clean XFS mount for filesystem: sda10
  XFS mounting filesystem sda11
  Ending clean XFS mount for filesystem: sda11
  XFS mounting filesystem sda12
  Ending clean XFS mount for filesystem: sda12

  [2.6.26.5 dmesg]
  10 11 14 15) *0, disabled.
  Linux Plug and Play Support v0.97 (c) Adam Belay
  pnp: PnP ACPI init
  ACPI: bus type pnp registered
  pnp: PnP ACPI: found 14 devices
  ACPI: ACPI bus type pnp unregistered
  SCSI subsystem initialized
  libata version 3.00 loaded.
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
  PCI: Using ACPI for IRQ routing
  system 00:0b: ioport range 0x4d0-0x4df has been reserved
  system 00:0c: ioport range 0x400-0x41f has been reserved
  system 00:0c: ioport range 0x420-0x43f has been reserved
  system 00:0c: ioport range 0x440-0x45f has been reserved
  system 00:0c: ioport range 0x460-0x47f has been reserved
  system 00:0c: ioport range 0x480-0x48f has been reserved
  system 00:0c: ioport range 0x800-0x81f has been reserved
  system 00:0c: ioport range 0x820-0x83f has been reserved
  system 00:0c: ioport range 0x840-0x85f has been reserved
  system 00:0c: ioport range 0x860-0x87f has been reserved
  system 00:0c: ioport range 0xc00-0xc1f has been reserved
  system 00:0c: ioport range 0xc50-0xc6f has been reserved
  system 00:0c: ioport range 0xcd0-0xcdf has been reserved
  system 00:0c: ioport range 0xf800-0xf81f has been reserved
  system 00:0c: ioport range 0xf820-0xf83f has been reserved
  system 00:0c: ioport range 0xf840-0xf85f has been reserved
  system 00:0c: ioport range 0xf860-0xf87f has been reserved
  system 00:0c: ioport range 0xfa00-0xfa3f has been reserved
  system 00:0c: ioport range 0xfe00-0xfe7f has been reserved
  system 00:0c: ioport range 0xfe80-0xfeff has been reserved
  system 00:0d: iomem range 0x0-0x9ffff could not be reserved
  system 00:0d: iomem range 0x100000-0x7fffffff could not be reserved
  system 00:0d: iomem range 0xe4000-0xfffff could not be reserved
  system 00:0d: iomem range 0xfec01000-0xfecfffff could not be reserved
  system 00:0d: iomem range 0xfed00000-0xfed3ffff could not be reserved
  system 00:0d: iomem range 0xfed40000-0xffffffff could not be reserved
  system 00:0d: iomem range 0xe0000000-0xefffffff could not be reserved
  system 00:0d: iomem range 0xd1c00-0xe3fff has been reserved
  PCI: Bridge: 0000:00:01.0
    IO window: 1000-1fff
    MEM window: 0xd8500000-0xd87fffff
    PREFETCH window: 0x00000000c8000000-0x00000000d81fffff
  PCI: Bridge: 0000:00:07.0
    IO window: disabled.
    MEM window: 0xd8200000-0xd84fffff
    PREFETCH window: disabled.
  PCI: Bridge: 0000:00:14.4
    IO window: disabled.
    MEM window: disabled.
    PREFETCH window: disabled.
  PCI: Setting latency timer of device 0000:00:07.0 to 64
  NET: Registered protocol family 2
  IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
  TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
  TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
  TCP: Hash tables configured (established 262144 bind 65536)
  TCP reno registered
  NET: Registered protocol family 1
  checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
  Freeing initrd memory: 5064k freed
  VFS: Disk quotas dquot_6.5.1
  Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
  NTFS driver 2.1.29 [Flags: R/O].
  SGI XFS with security attributes, large block/inode numbers, no debug enabled
  SGI XFS Quota Management subsystem
  msgmni has been set to 3767
  io scheduler noop registered
  io scheduler anticipatory registered
  io scheduler deadline registered
  io scheduler cfq registered (default)
  pci 0000:00:00.0: MSI quirk detected; MSI disabled
  pci 0000:01:05.0: Boot video device
  PCI: Setting latency timer of device 0000:00:07.0 to 64
  assign_interrupt_mode Found MSI capability
  Allocate Port Service[0000:00:07.0:pcie00]
  input: Power Button (FF) as /class/input/input0
  ACPI: Power Button (FF) [PWRF]
  input: Power Button (CM) as /class/input/input1
  ACPI: Power Button (CM) [PBTN]
  ACPI: ACPI0007:00 is registered as cooling_device0
  ACPI: Processor [CPU0] (supports 8 throttling states)
  ACPI: ACPI0007:01 is registered as cooling_device1
  ACPI: Processor [CPU1] (supports 8 throttling states)
  Real Time Clock Driver v1.12ac
  Linux agpgart interface v0.103
  [drm] Initialized drm 1.1.0 20060810
  ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
  [drm] Initialized radeon 1.29.0 20080528 on minor 0
  floppy0: no floppy controllers found
  brd: module loaded
  loop: module loaded
  tg3.c:v3.92.1 (June 9, 2008)
  ACPI: PCI Interrupt 0000:3f:00.0[A] -> GSI 19 (level, low) -> IRQ 19
  PCI: Setting latency timer of device 0000:3f:00.0 to 64
  eth0: Tigon3 [partno(BCM95755) rev a002 PHY(5755)] (PCI Express) 10/100/1000Base-T Ethernet 00:19:bb:e2:7d:ca
  eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
  eth0: dma_rwctrl[76180000] dma_mask[64-bit]
  Uniform Multi-Platform E-IDE driver
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
  Probing IDE interface ide0...
  Probing IDE interface ide1...
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  ide1 at 0x170-0x177,0x376 on irq 15
  Driver 'sd' needs updating - please use bus_type methods
  Driver 'sr' needs updating - please use bus_type methods
  ahci 0000:00:12.0: version 3.0
  ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
  PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:12.0
  ahci: probe of 0000:00:12.0 failed with error -16
  usbmon: debugfs is not available
  ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
  ehci_hcd 0000:00:13.5: EHCI Host Controller
  ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
  ehci_hcd 0000:00:13.5: debug port 1
  ehci_hcd 0000:00:13.5: irq 19, io mem 0xd8a09800
  ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 10 ports detected
  USB Universal Host Controller Interface driver v3.0
  Initializing USB Mass Storage driver...
  usbcore: registered new interface driver usb-storage
  USB Mass Storage support registered.
  PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
  serio: i8042 KBD port at 0x60,0x64 irq 1
  serio: i8042 AUX port at 0x60,0x64 irq 12
  mice: PS/2 mouse device common for all mice
  input: AT Translated Set 2 keyboard as /class/input/input2
  i2c /dev entries driver
  EDAC MC: Ver: 2.1.0 Sep 22 2008
  cpuidle: using governor ladder
  Advanced Linux Sound Architecture Driver Version 1.0.16.
  ALSA device list:
    No soundcards found.
  Netfilter messages via NETLINK v0.30.
  nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
  ip_tables: (C) 2000-2006 Netfilter Core Team
  arp_tables: (C) 2002 David S. Miller
  TCP cubic registered
  Initializing XFRM netlink socket
  NET: Registered protocol family 17
  NET: Registered protocol family 15
  RPC: Registered udp transport module.
  RPC: Registered tcp transport module.
  powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (2 cpu cores) (version 2.20.00)
  powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xc
  powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xe
  powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x10
  powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
  powernow-k8: ph2 null fid transition 0xe
  BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
  input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
  IP-Config: Complete:
       device=eth0, addr=192.168.2.121, mask=255.255.255.0, gw=192.168.2.254,
       host=192.168.2.121, domain=, nis-domain=(none),
       bootserver=192.168.1.2, rootserver=192.168.1.2, rootpath=
  RAMDISK: Compressed image found at block 0
  EXT2-fs warning: checktime reached, running e2fsck is recommended
  VFS: Mounted root (ext2 filesystem).
  tg3: eth0: Link is up at 1000 Mbps, full duplex.
  tg3: eth0: Flow control is off for TX and off for RX.

Kernel config for 2.6.26.5
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.26.5
# Mon Sep 22 17:40:49 2008
#
CONFIG_64BIT=y
# CONFIG_X86_32 is not set
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_FAST_CMPXCHG_LOCAL=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_HAVE_CPUMASK_OF_CPU_MAP=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ZONE_DMA32=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_AOUT=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_64_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
# CONFIG_KTIME_SCALAR is not set
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_CGROUPS is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_COMPAT_BRK is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
# CONFIG_HAVE_DMA_ATTRS is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_CLASSIC_RCU=y

#
# Processor type and features
#
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_VSMP is not set
# CONFIG_PARAVIRT_GUEST is not set
CONFIG_MEMTEST_BOOTPARAM=y
CONFIG_MEMTEST_BOOTPARAM_VALUE=0
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_CPU=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_INTERNODE_CACHE_BYTES=64
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=2
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NUMA=y
# CONFIG_K8_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
# CONFIG_DISCONTIGMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MTRR=y
# CONFIG_X86_PAT is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_ACPI=y
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_PROCFS_POWER=y
CONFIG_ACPI_SYSFS_POWER=y
CONFIG_ACPI_PROC_EVENT=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
# CONFIG_ACPI_BAY is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
# CONFIG_DMAR is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIEASPM is not set
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY is not set
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
CONFIG_K8_NB=y
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
# CONFIG_NF_CT_ACCT is not set
# CONFIG_NF_CONNTRACK_MARK is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CT_PROTO_DCCP is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=y
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_RECENT=y
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_AH is not set
CONFIG_IP_NF_MATCH_TTL=y
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
CONFIG_IP_NF_FILTER=y
# CONFIG_IP_NF_TARGET_REJECT is not set
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_NF_NAT is not set
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_TTL is not set
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
# CONFIG_IP_NF_ARP_MANGLE is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=2
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y  tried both on/off, no difference
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y  NOTE tried with and without SFF - no difference
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_SCH is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
# CONFIG_NET_ETHERNET is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_E1000E_ENABLED is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=y
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_IWLWIFI_LEDS is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_DEVKMEM is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set
CONFIG_FIX_EARLYCON_MEM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=y
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_PLATFORM is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
# CONFIG_PCF8575 is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ABITUGURU=m
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7473 is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHER=m
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_HWMON_DEBUG_CHIP is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83697HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=m
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
# CONFIG_FB_CFB_FILLRECT is not set
# CONFIG_FB_CFB_COPYAREA is not set
# CONFIG_FB_CFB_IMAGEBLIT is not set
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=y

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=128
# CONFIG_VIDEO_SELECT is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_ATIHDMI=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
# CONFIG_SND_HDA_POWER_SAVE is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_HIFIER is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AC97_POWER_SAVE is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# ALSA SoC audio for Freescale SOCs
#

#
# SoC Audio for the Texas Instruments OMAP
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=m
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y

#
# DMA Devices
#
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_UIO is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFSD is not set
# CONFIG_ROOT_NFS is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
# CONFIG_SUNRPC_BIND34 is not set
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_LATENCYTOP is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_NONPROMISC_DEVMEM is not set
CONFIG_EARLY_PRINTK=y
CONFIG_X86_MPPARSE=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_HASH=m
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=m
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_X86_64=m
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

Thanks for looking at this!
Piet Plomp
