From: Steven Campbell <scampbel@Ncrypted.ORG>
Subject: Difficulties building IDE as module in linux-2.5.37
Date: Sun, 22 Sep 2002 11:14:23 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3D8DDE4F.9000601@Ncrypted.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Smiley.Ncrypted.ORG (IDENT:hlgz0kbnos6a5awy7gh7@H40.C194.tor.velocet.net [216.138.194.40])
	by zeus.kernel.org (8.11.6/8.11.6) with ESMTP id g8NF06A15894
	for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2002 08:00:07 -0700
Received: from Ncrypted.ORG (host03.gsc.noc [192.168.0.3])
	by Host01.Ncrypted.ORG (8.12.2/8.12.2) with ESMTP id g8MFENSX022334
	for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2002 11:14:27 -0400 (EDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

2. When building IDE as a module, this happens:

   gcc -Wp,-MD,./.ide.o.d -D__KERNEL__ -I/usr/src/linux-2.5.37/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -I/usr/src/linux-2.5.37/arch/i386/mach-generic -nostdinc 
-iwithprefix include -DMODULE -include 
/usr/src/linux-2.5.37/include/linux/modversions.h 
-DKBUILD_BASENAME=ide -DEXPORT_SYMTAB  -c -o ide.o ide.c
ide.c:3572: redefinition of `init_module'
ide.c:3550: `init_module' previously defined here
{standard input}: Assembler messages:
{standard input}:8612: Error: symbol `init_module' is already defined
make[2]: *** [ide.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.37/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.37/drivers'
make: *** [drivers] Error 2

Summary: IDE module build difficulties

4. kernel version 2.5.37

5. oops output not relevant

6. small shell script replicating problem not relevant

7. Environment:

Linux Phalanx.gsc.noc 2.4.19 #1 SMP Sun Sep 15 16:45:27 EDT 2002 i686 
unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.28
pcmcia-cs              3.1.25
PPP                    2.4.0
Linux C Library        2.2.1
Dynamic linker (ldd)   2.2.1
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.04
Sh-utils               2.0
Modules Loaded

7.2 cpu info:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.561
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1592.52

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.561
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1592.52

7.3 module information

No modules loaded

7.4 I/O ports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
ec00-ec7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
   ec00-ec7f : 00:11.0
ece0-ecff : Intel Corp. 82371AB/EB/MB PIIX4 USB
   ece0-ecff : usb-uhci
f000-ffff : PCI Bus #02
   f800-f8ff : Adaptec AIC-7880U
   fc00-fcff : Adaptec AHA-2940U2/U2W / 7890/7891


7.4 I/O memory

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000cc800-000ccfff : Extension ROM
000cd000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffdfff : System RAM
   00100000-0025973f : Kernel code
   00259740-002e975f : Kernel data
3fffe000-3fffffff : reserved
ec000000-efffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
f1000000-f1ffffff : PCI Bus #02
f2000000-f5ffffff : PCI Bus #01
   f4000000-f5ffffff : Matrox Graphics, Inc. MGA G400 AGP
fa000000-fbffffff : PCI Bus #02
   faffe000-faffefff : Adaptec AIC-7880U
     faffe000-faffefff : aic7xxx
   fafff000-faffffff : Adaptec AHA-2940U2/U2W / 7890/7891
     fafff000-faffffff : aic7xxx
fc000000-fdffffff : PCI Bus #01
   fc000000-fc7fffff : Matrox Graphics, Inc. MGA G400 AGP
   fcffc000-fcffffff : Matrox Graphics, Inc. MGA G400 AGP
fe000000-fe0fffff : Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion 
Audio A
ccelerator]
fe100000-fe100fff : Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion 
Audio A
ccelerator]
fe101000-fe10107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffe00000-ffffffff : reserved

7.5 PCI information

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(rev 02
)
         Subsystem: Dell Computer Corporation: Unknown device 0080
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge 
(rev 02)
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fc000000-fdffffff
         Prefetchable memory behind bridge: f2000000-f5ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80
[Master])
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Region 4: I/O ports at 1000 [disabled] [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00
  [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 19
         Region 4: I/O ports at ece0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:0e.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear So
undFusion Audio Accelerator] (rev 01)
         Subsystem: Voyetra Technologies: Unknown device 3357
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 6000ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]
         Region 1: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
         Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 
10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at ec00 [size=128]
         Region 1: Memory at fe101000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at f9000000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot
+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-i
f 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000f000-0000ffff
         Memory behind bridge: fa000000-fbffffff
         Prefetchable memory behind bridge: 
00000000f1000000-00000000f1f00000
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3h
ot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                 Bridge: PM- B3+

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 04) (
prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64 (4000ns min, 8000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
         Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at 80000000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
         Subsystem: Dell Computer Corporation: Unknown device 0080
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64 (9750ns min, 6250ns max), cache line size 08
         Interrupt: pin A routed to IRQ 18
         BIST result: 00
         Region 0: I/O ports at fc00 [disabled] [size=256]
         Region 1: Memory at fafff000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at fb000000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
         Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at f800 [disabled] [size=256]
         Region 1: Memory at faffe000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at fb000000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 SCSI information

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: COMPAQPC Model: MAN3184MP        Rev: 1805
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 3506
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
   Vendor: PLEXTOR  Model: CD-ROM PX-40TW   Rev: 1.04
   Type:   CD-ROM                           ANSI SCSI revision: 02



8. IDE stuff will build if linked into the kernel, but will not build as 
modules. Currently I don't have any devices connected to the IDE buses 
in this box, but hope to have soon.

Regards,

Steven Campbell

-- 


Fortune cookie for the day is:

A woman's best protection is a little money of her own.
		-- Clare Booth Luce, quoted in "The Wit of Women"


Steven Campbell

scampbell@ncrypted.org

http://www.ncrypted.org


