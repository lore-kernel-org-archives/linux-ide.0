From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Mon, 03 Sep 2007 22:38:06 +0200
Message-ID: <46DC70AE.6050100@how.dk>
References: <200709030811.l838BC9a026315@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:46782 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbXICUiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 16:38:09 -0400
In-Reply-To: <200709030811.l838BC9a026315@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi,

Below some more info on my two systems:

Mikael Pettersson wrote:
> I assume the PE1800 has some Intel chipset? Which one?

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.228
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5590.09

(this machine has hyperthreading and SMP enabled - shows up as processor 
#1 but this was left out here)

lspci:
0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express 
Port A0 (rev 09)
0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express 
Port B0 (rev 09)
0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express 
Port C0 (rev 09)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #3 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra 
ATA 100 Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
Storage Controller (rev 02)
0000:01:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
0000:01:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
0000:02:06.0 Unknown mass storage controller: Promise Technology, Inc.: 
Unknown device 3d17 (rev 02)
0000:03:07.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit 
Ethernet Controller (rev 05)
0000:06:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:06:05.0 VGA compatible controller: ATI Technologies Inc Radeon 
RV100 QY [Radeon 7000/VE]

cat /proc/interrupts
            CPU0       CPU1
   0:         61 1968626752   IO-APIC-edge      timer
   1:          0        658   IO-APIC-edge      i8042
   6:          0          3   IO-APIC-edge      floppy
   7:          0          0   IO-APIC-edge      parport0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0        413   IO-APIC-edge      i8042
  14:          0         16   IO-APIC-edge      libata
  15:          0          0   IO-APIC-edge      libata
  16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
  17:          0   48140761   IO-APIC-fasteoi   libata, uhci_hcd:usb4
  18:          0  757251738   IO-APIC-fasteoi   libata
  19:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
  20:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
  21:          0  606210513   IO-APIC-fasteoi   eth0
  22:          0  154792474   IO-APIC-fasteoi   eth1
NMI:          0          0
LOC: 1968636127 1968636126
ERR:          0
MIS:          0

The promise card has IRQ 18 all by itself

> And the machine that does have problems, what chipset does it have?

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1837.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3677.78
clflush size    : 32

lspci:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio 
Processing Unit (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:04.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
01:08.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 
300 TX4) (rev 02)
01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02)
03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP 
(rev 01)

cat /proc/interrupts
            CPU0
   0:         79    XT-PIC-XT        timer
   1:          2    XT-PIC-XT        i8042
   2:          0    XT-PIC-XT        cascade
   5:     141710    XT-PIC-XT        sk98lin
   6:          5    XT-PIC-XT        floppy
   7:         35    XT-PIC-XT        parport0
   8:          1    XT-PIC-XT        rtc
   9:          6    XT-PIC-XT        acpi, ehci_hcd:usb1, ohci1394
  10:          0    XT-PIC-XT        MPU401 UART
  11:      27474    XT-PIC-XT        libata, libata, ohci_hcd:usb3, 
NVidia nForce2
  12:      15057    XT-PIC-XT        ohci_hcd:usb2
  14:      23211    XT-PIC-XT        ide0
  15:      32805    XT-PIC-XT        ide1
NMI:       3911
LOC:     917176
ERR:          0

The promise card is sharing IRQ11 with usb, the other libata device, and 
nForce2 (wonder what that is?)

> I'm actually beginning to think there's some PCI compatibility breakage
> somewhere, as I too see sata_promise working fine in some machines but
> not in others. Alas, my knowledge of PCI tweakables is close to nil.

I second that (although I'm really clueless about PCI).

Could it be that at 3.0Gbps with 4 ports running at full speed 
contention on the pci bus cause this behavior? This would explain why a 
PCI-X port helps (or limiting to 1.5Gbps). Or maybe it is an NFORCE2 
issue... Or too many IRQ-handlers on the same IRQ...

I wish I could do something more to help. Unfortunately it is almost 
impossible for me to do tests on the Intel system (as it is a production 
system) - though I might be able to try some things late at night in the 
weekends ;-)

Guess at this point it would be nice to be able to reproduce the 
behavior on an Intel system...

Best regards,

Peter
