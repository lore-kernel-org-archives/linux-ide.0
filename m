From: Milan Burgdorf <milan@wwwburgdorf.de>
Subject: Re: Request to 2.6.24/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24
 because it doesn't work
Date: Wed, 28 Oct 2009 15:54:42 +0100
Message-ID: <4AE85B32.7050203@wwwburgdorf.de>
References: <200910231231.n9NCVbIV011530@post.webmailer.de> <19169.44382.793296.116944@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17869 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbZJ1Oyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Oct 2009 10:54:43 -0400
Received: from [10.12.79.11] (p54AE5150.dip.t-dialin.net [84.174.81.80])
	by post.strato.de (mrclete mo12) (RZmta 22.1)
	with ESMTP id N0436cl9SERJLw for <linux-ide@vger.kernel.org>;
	Wed, 28 Oct 2009 15:54:43 +0100 (MET)
In-Reply-To: <19169.44382.793296.116944@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>  > Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650099] ata1: limiting
>  > SATA link speed to 1.5 Gbps
>  > Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650114] ata1: hard
>  > resetting link
>  > Oct 15 20:21:56 alexandria-epia kernel: [ 5801.658417] ata1.00: disabled
> 
> Incomplete messages. Please post the full kernel log.

Thank you for the quick answer!!!

Here is the log of the 15.10.:

Oct 15 18:56:56 alexandria-epia syslogd 1.5.0#1ubuntu1: restart.
Oct 15 18:56:56 alexandria-epia kernel: Inspecting
/boot/System.map-2.6.24-24-generic
Oct 15 18:56:57 alexandria-epia kernel: Loaded 27922 symbols from
/boot/System.map-2.6.24-24-generic.
Oct 15 18:56:57 alexandria-epia kernel: Symbols match kernel version 2.6.24.
Oct 15 18:56:57 alexandria-epia kernel: Loaded 14462 symbols from 72
modules.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Initializing
cgroup subsys cpuset
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Initializing
cgroup subsys cpu
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Linux version
2.6.24-24-generic (buildd@palmer) (gcc version 4.2.4 (Ubuntu
4.2.4-1ubuntu4)) #1 SMP Fri Sep 18 16:49:39 UTC 2009 (Ubuntu
2.6.24-24.61-generic)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] BIOS-provided
physical RAM map:
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
0000000000000000 - 00000000000a0000 (usable)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
00000000000f0000 - 0000000000100000 (reserved)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
0000000000100000 - 000000001eff0000 (usable)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
000000001eff0000 - 000000001eff3000 (ACPI NVS)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
000000001eff3000 - 000000001f000000 (ACPI data)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]  BIOS-e820:
00000000ffff0000 - 0000000100000000 (reserved)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] 0MB HIGHMEM
available.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] 495MB LOWMEM
available.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Zone PFN ranges:
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]   DMA
 0 ->     4096
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]   Normal
4096 ->   126960
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]   HighMem
126960 ->   126960
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Movable zone
start PFN for each node
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] early_node_map[1]
active PFN ranges
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000]     0:        0
->   126960
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] DMI 2.2 present.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: RSDP
signature @ 0xC00F6620 checksum 0
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: RSDP
000F6620, 0014 (r0 VT9174)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: RSDT
1EFF3000, 0028 (r1 VT9174 AWRDACPI 42302E31 AWRD        0)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: FACP
1EFF3040, 0074 (r1 VT9174 AWRDACPI 42302E31 AWRD        0)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: DSDT
1EFF30C0, 2FDD (r1 VT9174 AWRDACPI     1000 MSFT  100000C)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: FACS
1EFF0000, 0040
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] ACPI: PM-Timer IO
Port: 0x408
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Allocating PCI
resources starting at 20000000 (gap: 1f000000:e0ff0000)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] swsusp:
Registered nosave memory region: 00000000000a0000 - 00000000000f0000
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] swsusp:
Registered nosave memory region: 00000000000f0000 - 0000000000100000
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Built 1 zonelists
in Zone order, mobility grouping on.  Total pages: 125969
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Kernel command
line: root=UUID=aaa9e2d6-6d42-4ea3-a1e4-2427daef47d9 ro
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] No local APIC
present or hardware disabled
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Enabling fast FPU
save and restore... done.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Enabling unmasked
SIMD FPU exception support... done.
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Initializing CPU#0
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] PID hash table
entries: 2048 (order: 11, 8192 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [    0.000000] Detected 999.848
MHz processor.
Oct 15 18:56:57 alexandria-epia kernel: [   18.672310] Console: colour
VGA+ 80x25
Oct 15 18:56:57 alexandria-epia kernel: [   18.672320] console [tty0]
enabled
Oct 15 18:56:57 alexandria-epia kernel: [   18.674996] Dentry cache hash
table entries: 65536 (order: 6, 262144 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   18.676903] Inode-cache hash
table entries: 32768 (order: 5, 131072 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754529] Memory:
491384k/507840k available (2181k kernel code, 15880k reserved, 1006k
data, 368k init, 0k highmem)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754624] virtual kernel
memory layout:
Oct 15 18:56:57 alexandria-epia kernel: [   18.754628]     fixmap  :
0xfff4b000 - 0xfffff000   ( 720 kB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754633]     pkmap   :
0xff800000 - 0xffc00000   (4096 kB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754638]     vmalloc :
0xdf800000 - 0xff7fe000   ( 511 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754643]     lowmem  :
0xc0000000 - 0xdeff0000   ( 495 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754648]       .init :
0xc0423000 - 0xc047f000   ( 368 kB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754653]       .data :
0xc0321548 - 0xc041cdc4   (1006 kB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.754657]       .text :
0xc0100000 - 0xc0321548   (2181 kB)
Oct 15 18:56:57 alexandria-epia kernel: [   18.755003] Checking if this
processor honours the WP bit even in supervisor mode... Ok.
Oct 15 18:56:57 alexandria-epia kernel: [   18.755181] SLUB:
Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Oct 15 18:56:57 alexandria-epia kernel: [   18.755290] Calibrating delay
loop (skipped), using tsc calculated value.. 1999.69 BogoMIPS (lpj=3999392)
Oct 15 18:56:57 alexandria-epia kernel: [   18.755437] Security
Framework initialized
Oct 15 18:56:57 alexandria-epia kernel: [   18.755494] SELinux:
Disabled at boot.
Oct 15 18:56:57 alexandria-epia kernel: [   18.755583] AppArmor:
AppArmor initialized
Oct 15 18:56:57 alexandria-epia kernel: [   18.755636] Failure
registering capabilities with primary security module.
Oct 15 18:56:57 alexandria-epia kernel: [   18.755704] Mount-cache hash
table entries: 512
Oct 15 18:56:57 alexandria-epia kernel: [   18.756007] Initializing
cgroup subsys ns
Oct 15 18:56:57 alexandria-epia kernel: [   18.756059] Initializing
cgroup subsys cpuacct
Oct 15 18:56:57 alexandria-epia kernel: [   18.756148] CPU: L1 I Cache:
64K (32 bytes/line), D cache 64K (32 bytes/line)
Oct 15 18:56:57 alexandria-epia kernel: [   18.756202] CPU: L2 Cache:
64K (32 bytes/line)
Oct 15 18:56:57 alexandria-epia kernel: [   18.756279] Compat vDSO
mapped to ffffe000.
Oct 15 18:56:57 alexandria-epia kernel: [   18.756353] Checking 'hlt'
instruction... OK.
Oct 15 18:56:57 alexandria-epia kernel: [   18.771908] SMP alternatives:
switching to UP code
Oct 15 18:56:57 alexandria-epia kernel: [   18.774581] Freeing SMP
alternatives: 11k freed
Oct 15 18:56:57 alexandria-epia kernel: [   18.774997] Early unpacking
initramfs... done
Oct 15 18:56:57 alexandria-epia kernel: [   20.060351] ACPI: Core
revision 20070126
Oct 15 18:56:57 alexandria-epia kernel: [   20.060632] ACPI: Looking for
DSDT in initramfs... error, file /DSDT.aml not found.
Oct 15 18:56:57 alexandria-epia kernel: [   20.064765] ACPI: setting
ELCR to 0200 (from 1e20)
Oct 15 18:56:57 alexandria-epia kernel: [   20.067498] CPU0: Centaur VIA
Nehemiah stepping 05
Oct 15 18:56:57 alexandria-epia kernel: [   20.067630] SMP motherboard
not detected.
Oct 15 18:56:57 alexandria-epia kernel: [   20.067676] Local APIC not
detected. Using dummy APIC emulation.
Oct 15 18:56:57 alexandria-epia kernel: [   20.067841] Brought up 1 CPUs
Oct 15 18:56:57 alexandria-epia kernel: [   20.068463] net_namespace: 64
bytes
Oct 15 18:56:57 alexandria-epia kernel: [   20.068528] Booting
paravirtualized kernel on bare hardware
Oct 15 18:56:57 alexandria-epia kernel: [   20.069860] Time: 16:56:02
Date: 10/15/09
Oct 15 18:56:57 alexandria-epia kernel: [   20.069994] NET: Registered
protocol family 16
Oct 15 18:56:57 alexandria-epia kernel: [   20.070577] EISA bus registered
Oct 15 18:56:57 alexandria-epia kernel: [   20.070645] ACPI: bus type
pci registered
Oct 15 18:56:57 alexandria-epia kernel: [   20.100591] PCI: PCI BIOS
revision 2.10 entry at 0xfb260, last bus=1
Oct 15 18:56:57 alexandria-epia kernel: [   20.100646] PCI: Using
configuration type 1
Oct 15 18:56:57 alexandria-epia kernel: [   20.100716] Setting up
standard PCI resources
Oct 15 18:56:57 alexandria-epia kernel: [   20.122784] ACPI: Interpreter
enabled
Oct 15 18:56:57 alexandria-epia kernel: [   20.122846] ACPI: (supports
S0 S1 S4 S5)
Oct 15 18:56:57 alexandria-epia kernel: [   20.123023] ACPI: Using PIC
for interrupt routing
Oct 15 18:56:57 alexandria-epia kernel: [   20.131347] ACPI: PCI Root
Bridge [PCI0] (0000:00)
Oct 15 18:56:57 alexandria-epia kernel: [   20.132033] PCI quirk: region
0400-047f claimed by vt8235 PM
Oct 15 18:56:57 alexandria-epia kernel: [   20.132086] PCI quirk: region
0500-050f claimed by vt8235 SMB
Oct 15 18:56:57 alexandria-epia kernel: [   20.169711] ACPI: PCI
Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Oct 15 18:56:57 alexandria-epia kernel: [   20.170525] ACPI: PCI
Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Oct 15 18:56:57 alexandria-epia kernel: [   20.171374] ACPI: PCI
Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Oct 15 18:56:57 alexandria-epia kernel: [   20.172179] ACPI: PCI
Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Oct 15 18:56:57 alexandria-epia kernel: [   20.172921] Linux Plug and
Play Support v0.97 (c) Adam Belay
Oct 15 18:56:57 alexandria-epia kernel: [   20.173051] pnp: PnP ACPI init
Oct 15 18:56:57 alexandria-epia kernel: [   20.173114] ACPI: bus type
pnp registered
Oct 15 18:56:57 alexandria-epia kernel: [   20.178116] pnp: PnP ACPI:
found 9 devices
Oct 15 18:56:57 alexandria-epia kernel: [   20.178177] ACPI: ACPI bus
type pnp unregistered
Oct 15 18:56:57 alexandria-epia kernel: [   20.178230] PnPBIOS: Disabled
by ACPI PNP
Oct 15 18:56:57 alexandria-epia kernel: [   20.178872] PCI: Using ACPI
for IRQ routing
Oct 15 18:56:57 alexandria-epia kernel: [   20.178927] PCI: If a device
doesn't work, try "pci=routeirq".  If it helps, post a report
Oct 15 18:56:57 alexandria-epia kernel: [   20.251107] NET: Registered
protocol family 8
Oct 15 18:56:57 alexandria-epia kernel: [   20.251159] NET: Registered
protocol family 20
Oct 15 18:56:57 alexandria-epia kernel: [   20.251398] AppArmor:
AppArmor Filesystem Enabled
Oct 15 18:56:57 alexandria-epia kernel: [   20.255091] Time: tsc
clocksource has been installed.
Oct 15 18:56:57 alexandria-epia kernel: [   20.263211] system 00:00:
iomem range 0xd0000-0xd3fff has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263268] system 00:00:
iomem range 0xdd000-0xdffff has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263323] system 00:00:
iomem range 0xf0000-0xfbfff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263378] system 00:00:
iomem range 0xfc000-0xfffff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263434] system 00:00:
iomem range 0x1eff0000-0x1effffff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263499] system 00:00:
iomem range 0xffff0000-0xffffffff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263563] system 00:00:
iomem range 0x0-0x9ffff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263617] system 00:00:
iomem range 0x100000-0x1efeffff could not be reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263680] system 00:00:
iomem range 0xfee00000-0xfee00fff has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263736] system 00:00:
iomem range 0xfff80000-0xfffeffff has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263804] system 00:02:
ioport range 0x400-0x47f has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263858] system 00:02:
ioport range 0x500-0x50f has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.263926] system 00:03:
ioport range 0x4d0-0x4d1 has been reserved
Oct 15 18:56:57 alexandria-epia kernel: [   20.295066] PCI: Bridge:
0000:00:01.0
Oct 15 18:56:57 alexandria-epia kernel: [   20.295128]   IO window:
disabled.
Oct 15 18:56:57 alexandria-epia kernel: [   20.295178]   MEM window:
e4000000-e5ffffff
Oct 15 18:56:57 alexandria-epia kernel: [   20.295227]   PREFETCH
window: e0000000-e3ffffff
Oct 15 18:56:57 alexandria-epia kernel: [   20.295341] NET: Registered
protocol family 2
Oct 15 18:56:57 alexandria-epia kernel: [   20.335345] IP route cache
hash table entries: 4096 (order: 2, 16384 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   20.336109] TCP established
hash table entries: 16384 (order: 5, 131072 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   20.336667] TCP bind hash
table entries: 16384 (order: 5, 131072 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   20.337321] TCP: Hash tables
configured (established 16384 bind 16384)
Oct 15 18:56:57 alexandria-epia kernel: [   20.337379] TCP reno registered
Oct 15 18:56:57 alexandria-epia kernel: [   20.347537] checking if image
is initramfs...<7>Switched to high resolution mode on CPU 0
Oct 15 18:56:57 alexandria-epia kernel: [   21.506992]  it is
Oct 15 18:56:57 alexandria-epia kernel: [   22.833479] Freeing initrd
memory: 7350k freed
Oct 15 18:56:57 alexandria-epia kernel: [   22.834825] audit:
initializing netlink socket (disabled)
Oct 15 18:56:57 alexandria-epia kernel: [   22.834912]
audit(1255625764.080:1): initialized
Oct 15 18:56:57 alexandria-epia kernel: [   22.840877] VFS: Disk quotas
dquot_6.5.1
Oct 15 18:56:57 alexandria-epia kernel: [   22.841187] Dquot-cache hash
table entries: 1024 (order 0, 4096 bytes)
Oct 15 18:56:57 alexandria-epia kernel: [   22.841648] io scheduler noop
registered
Oct 15 18:56:57 alexandria-epia kernel: [   22.841697] io scheduler
anticipatory registered
Oct 15 18:56:57 alexandria-epia kernel: [   22.841744] io scheduler
deadline registered
Oct 15 18:56:57 alexandria-epia kernel: [   22.841820] io scheduler cfq
registered (default)
Oct 15 18:56:57 alexandria-epia kernel: [   22.841891] PCI: VIA PCI
bridge detected. Disabling DAC.
Oct 15 18:56:57 alexandria-epia kernel: [   22.842729] isapnp: Scanning
for PnP cards...
Oct 15 18:56:57 alexandria-epia kernel: [   23.196460] isapnp: No Plug &
Play device found
Oct 15 18:56:57 alexandria-epia kernel: [   23.285886] Real Time Clock
Driver v1.12ac
Oct 15 18:56:57 alexandria-epia kernel: [   23.286164] Serial:
8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Oct 15 18:56:57 alexandria-epia kernel: [   23.289275] RAMDISK driver
initialized: 16 RAM disks of 65536K size 1024 blocksize
Oct 15 18:56:57 alexandria-epia kernel: [   23.289565] input: Macintosh
mouse button emulation as /devices/virtual/input/input0
Oct 15 18:56:57 alexandria-epia kernel: [   23.289990] PNP: No PS/2
controller found. Probing ports directly.
Oct 15 18:56:57 alexandria-epia kernel: [   23.542448] serio: i8042 KBD
port at 0x60,0x64 irq 1
Oct 15 18:56:57 alexandria-epia kernel: [   23.554522] mice: PS/2 mouse
device common for all mice
Oct 15 18:56:57 alexandria-epia kernel: [   23.554865] EISA: Probing bus
0 at eisa.0
Oct 15 18:56:57 alexandria-epia kernel: [   23.554965] EISA: Detected 0
cards.
Oct 15 18:56:57 alexandria-epia kernel: [   23.555012] cpuidle: using
governor ladder
Oct 15 18:56:57 alexandria-epia kernel: [   23.555058] cpuidle: using
governor menu
Oct 15 18:56:57 alexandria-epia kernel: [   23.555574] NET: Registered
protocol family 1
Oct 15 18:56:57 alexandria-epia kernel: [   23.555699] Using IPI
No-Shortcut mode
Oct 15 18:56:57 alexandria-epia kernel: [   23.555815] registered
taskstats version 1
Oct 15 18:56:57 alexandria-epia kernel: [   23.556121]   Magic number:
13:738:944
Oct 15 18:56:57 alexandria-epia kernel: [   23.556333]   hash matches
device ptyyf
Oct 15 18:56:57 alexandria-epia kernel: [   23.556472]   hash matches
device tty1
Oct 15 18:56:57 alexandria-epia kernel: [   23.556562] BIOS EDD facility
v0.16 2004-Jun-25, 0 devices found
Oct 15 18:56:57 alexandria-epia kernel: [   23.556611] EDD information
not available.
Oct 15 18:56:57 alexandria-epia kernel: [   23.558195] Freeing unused
kernel memory: 368k freed
Oct 15 18:56:57 alexandria-epia kernel: [   23.558436] Write protecting
the kernel read-only data: 802k
Oct 15 18:56:57 alexandria-epia kernel: [   24.259182] fuse init (API
version 7.9)
Oct 15 18:56:57 alexandria-epia kernel: [   24.334449] ACPI: CPU0 (power
states: C1[C1] C2[C2])
Oct 15 18:56:57 alexandria-epia kernel: [   24.334594] ACPI: Processor
[CPU0] (supports 2 throttling states)
Oct 15 18:56:57 alexandria-epia kernel: [   25.498784] usbcore:
registered new interface driver usbfs
Oct 15 18:56:57 alexandria-epia kernel: [   25.498896] usbcore:
registered new interface driver hub
Oct 15 18:56:57 alexandria-epia kernel: [   25.533893] ACPI: PCI
Interrupt Link [LNKB] enabled at IRQ 10
Oct 15 18:56:57 alexandria-epia kernel: [   25.534011] ACPI: PCI
Interrupt 0000:00:0d.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 15 18:56:57 alexandria-epia kernel: [   25.587087] ohci1394:
fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e8022000-e80227ff]  Max
Packet=[2048]  IR/IT contexts=[4/8]
Oct 15 18:56:57 alexandria-epia kernel: [   25.630320] usbcore:
registered new device driver usb
Oct 15 18:56:57 alexandria-epia kernel: [   25.666028] USB Universal
Host Controller Interface driver v3.0
Oct 15 18:56:57 alexandria-epia kernel: [   26.032612] SCSI subsystem
initialized
Oct 15 18:56:57 alexandria-epia kernel: [   26.057799] ACPI: PCI
Interrupt Link [LNKA] enabled at IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   26.057919] ACPI: PCI
Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   26.058052] uhci_hcd
0000:00:10.0: UHCI Host Controller
Oct 15 18:56:57 alexandria-epia kernel: [   26.058822] uhci_hcd
0000:00:10.0: new USB bus registered, assigned bus number 1
Oct 15 18:56:57 alexandria-epia kernel: [   26.058923] uhci_hcd
0000:00:10.0: irq 11, io base 0x0000d400
Oct 15 18:56:57 alexandria-epia kernel: [   26.059395] usb usb1:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   26.059502] hub 1-0:1.0: USB
hub found
Oct 15 18:56:57 alexandria-epia kernel: [   26.059555] hub 1-0:1.0: 2
ports detected
Oct 15 18:56:57 alexandria-epia kernel: [   26.133922]
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
Oct 15 18:56:57 alexandria-epia kernel: [   26.133997] via-rhine: Broken
BIOS detected, avoid_D3 enabled.
Oct 15 18:56:57 alexandria-epia kernel: [   26.162106] ACPI: PCI
Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 15 18:56:57 alexandria-epia kernel: [   26.162254] uhci_hcd
0000:00:10.1: UHCI Host Controller
Oct 15 18:56:57 alexandria-epia kernel: [   26.162363] uhci_hcd
0000:00:10.1: new USB bus registered, assigned bus number 2
Oct 15 18:56:57 alexandria-epia kernel: [   26.162456] uhci_hcd
0000:00:10.1: irq 10, io base 0x0000d800
Oct 15 18:56:57 alexandria-epia kernel: [   26.162844] usb usb2:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   26.162949] hub 2-0:1.0: USB
hub found
Oct 15 18:56:57 alexandria-epia kernel: [   26.163003] hub 2-0:1.0: 2
ports detected
Oct 15 18:56:57 alexandria-epia kernel: [   26.266971] ACPI: PCI
Interrupt Link [LNKC] enabled at IRQ 5
Oct 15 18:56:57 alexandria-epia kernel: [   26.267047] ACPI: PCI
Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Oct 15 18:56:57 alexandria-epia kernel: [   26.267180] uhci_hcd
0000:00:10.2: UHCI Host Controller
Oct 15 18:56:57 alexandria-epia kernel: [   26.267311] uhci_hcd
0000:00:10.2: new USB bus registered, assigned bus number 3
Oct 15 18:56:57 alexandria-epia kernel: [   26.267407] uhci_hcd
0000:00:10.2: irq 5, io base 0x0000dc00
Oct 15 18:56:57 alexandria-epia kernel: [   26.267810] usb usb3:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   26.267918] hub 3-0:1.0: USB
hub found
Oct 15 18:56:57 alexandria-epia kernel: [   26.267972] hub 3-0:1.0: 2
ports detected
Oct 15 18:56:57 alexandria-epia kernel: [   26.371419] ACPI: PCI
Interrupt Link [LNKD] enabled at IRQ 12
Oct 15 18:56:57 alexandria-epia kernel: [   26.371496] ACPI: PCI
Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
Oct 15 18:56:57 alexandria-epia kernel: [   26.371635] ehci_hcd
0000:00:10.3: EHCI Host Controller
Oct 15 18:56:57 alexandria-epia kernel: [   26.371771] ehci_hcd
0000:00:10.3: new USB bus registered, assigned bus number 4
Oct 15 18:56:57 alexandria-epia kernel: [   26.371932] ehci_hcd
0000:00:10.3: irq 12, io mem 0xe8023000
Oct 15 18:56:57 alexandria-epia kernel: [   26.401837] usb 1-1: new low
speed USB device using uhci_hcd and address 2
Oct 15 18:56:57 alexandria-epia kernel: [   26.413992] ehci_hcd
0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Oct 15 18:56:57 alexandria-epia kernel: [   26.414397] usb usb4:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   26.414508] hub 4-0:1.0: USB
hub found
Oct 15 18:56:57 alexandria-epia kernel: [   26.414565] hub 4-0:1.0: 6
ports detected
Oct 15 18:56:57 alexandria-epia kernel: [   26.518519] ACPI: PCI
Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   26.523306] eth0: VIA Rhine
II at 0xe8020000, 00:40:63:db:17:22, IRQ 11.
Oct 15 18:56:57 alexandria-epia kernel: [   26.524070] eth0: MII PHY
found at address 1, status 0x786d advertising 05e1 Link 45e1.
Oct 15 18:56:57 alexandria-epia kernel: [   26.525703] ACPI: PCI
Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   26.525900] PCI: VIA VLink
IRQ fixup for 0000:00:11.1, from 255 to 11
Oct 15 18:56:57 alexandria-epia kernel: [   26.526109] ACPI: PCI
interrupt for device 0000:00:11.1 disabled
Oct 15 18:56:57 alexandria-epia kernel: [   26.529850] ACPI: PCI
Interrupt 0000:00:14.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 15 18:56:57 alexandria-epia kernel: [   26.553830] scsi0 : sata_promise
Oct 15 18:56:57 alexandria-epia kernel: [   26.580918] scsi1 : sata_promise
Oct 15 18:56:57 alexandria-epia kernel: [   26.598580] scsi2 : sata_promise
Oct 15 18:56:57 alexandria-epia kernel: [   26.598772] ata1: SATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021200 irq 10
Oct 15 18:56:57 alexandria-epia kernel: [   26.598837] ata2: SATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021280 irq 10
Oct 15 18:56:57 alexandria-epia kernel: [   26.598899] ata3: PATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021300 irq 10
Oct 15 18:56:57 alexandria-epia kernel: [   27.065722] ata1: SATA link
up 3.0 Gbps (SStatus 123 SControl 300)
Oct 15 18:56:57 alexandria-epia kernel: [   27.118145] ata1.00: ATA-8:
WDC WD2500BEVT-22ZCT0, 11.01A11, max UDMA/133
Oct 15 18:56:57 alexandria-epia kernel: [   27.118216] ata1.00:
488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Oct 15 18:56:57 alexandria-epia kernel: [   27.134959] ata1.00:
configured for UDMA/133
Oct 15 18:56:57 alexandria-epia kernel: [   27.601623] ata2: SATA link
up 3.0 Gbps (SStatus 123 SControl 300)
Oct 15 18:56:57 alexandria-epia kernel: [   27.609927] ata2.00: ATA-8:
ST9250827AS, 3.AAA, max UDMA/133
Oct 15 18:56:57 alexandria-epia kernel: [   27.609993] ata2.00:
488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Oct 15 18:56:57 alexandria-epia kernel: [   27.625907] ata2.00:
configured for UDMA/133
Oct 15 18:56:57 alexandria-epia kernel: [   27.721591] usb 1-1: new low
speed USB device using uhci_hcd and address 3
Oct 15 18:56:57 alexandria-epia kernel: [   27.781933] scsi 0:0:0:0:
Direct-Access     ATA      WDC WD2500BEVT-2 11.0 PQ: 0 ANSI: 5
Oct 15 18:56:57 alexandria-epia kernel: [   27.782504] scsi 1:0:0:0:
Direct-Access     ATA      ST9250827AS      3.AA PQ: 0 ANSI: 5
Oct 15 18:56:57 alexandria-epia kernel: [   27.783265] ACPI: PCI
Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   27.783394] PCI: VIA VLink
IRQ fixup for 0000:00:11.1, from 255 to 11
Oct 15 18:56:57 alexandria-epia kernel: [   27.786271] scsi3 : pata_via
Oct 15 18:56:57 alexandria-epia kernel: [   27.788881] scsi4 : pata_via
Oct 15 18:56:57 alexandria-epia kernel: [   27.794354] ata4: PATA max
UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xe000 irq 14
Oct 15 18:56:57 alexandria-epia kernel: [   27.794414] ata5: PATA max
UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xe008 irq 15
Oct 15 18:56:57 alexandria-epia kernel: [   27.879844] usb 1-1:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   27.958143] ata4.00: ATA-6:
IC25N030ATMR04-0, MOAOAD4A, max UDMA/100
Oct 15 18:56:57 alexandria-epia kernel: [   27.958213] ata4.00: 58605120
sectors, multi 16: LBA
Oct 15 18:56:57 alexandria-epia kernel: [   27.974023] ata4.00:
configured for UDMA/100
Oct 15 18:56:57 alexandria-epia kernel: [   28.121519] usb 1-2: new low
speed USB device using uhci_hcd and address 4
Oct 15 18:56:57 alexandria-epia kernel: [   28.293858] ata5.00: ATAPI:
HL-DT-ST DVDRAM GSA-4167B, DL13, max UDMA/33
Oct 15 18:56:57 alexandria-epia kernel: [   28.296638] usb 1-2:
configuration #1 chosen from 1 choice
Oct 15 18:56:57 alexandria-epia kernel: [   28.465681] ata5.00:
configured for UDMA/33
Oct 15 18:56:57 alexandria-epia kernel: [   28.466019] scsi 3:0:0:0:
Direct-Access     ATA      IC25N030ATMR04-0 MOAO PQ: 0 ANSI: 5
Oct 15 18:56:57 alexandria-epia kernel: [   28.471527] scsi 4:0:0:0:
CD-ROM            HL-DT-ST DVDRAM GSA-4167B DL13 PQ: 0 ANSI: 5
Oct 15 18:56:57 alexandria-epia kernel: [   28.479280] Driver 'sd' needs
updating - please use bus_type methods
Oct 15 18:56:57 alexandria-epia kernel: [   28.479540] sd 0:0:0:0: [sda]
488397168 512-byte hardware sectors (250059 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.479616] sd 0:0:0:0: [sda]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.479708] sd 0:0:0:0: [sda]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.479886] sd 0:0:0:0: [sda]
488397168 512-byte hardware sectors (250059 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.479957] sd 0:0:0:0: [sda]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.480044] sd 0:0:0:0: [sda]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.480111]  sda: sda1 < sda5 >
Oct 15 18:56:57 alexandria-epia kernel: [   28.494813] sd 0:0:0:0: [sda]
Attached SCSI disk
Oct 15 18:56:57 alexandria-epia kernel: [   28.495037] sd 1:0:0:0: [sdb]
488397168 512-byte hardware sectors (250059 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.495114] sd 1:0:0:0: [sdb]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.495206] sd 1:0:0:0: [sdb]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.495377] sd 1:0:0:0: [sdb]
488397168 512-byte hardware sectors (250059 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.495448] sd 1:0:0:0: [sdb]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.495535] sd 1:0:0:0: [sdb]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.496808]  sdb: sdb1 < sdb5 >
Oct 15 18:56:57 alexandria-epia kernel: [   28.514465] sd 1:0:0:0: [sdb]
Attached SCSI disk
Oct 15 18:56:57 alexandria-epia kernel: [   28.514667] sd 3:0:0:0: [sdc]
58605120 512-byte hardware sectors (30006 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.514743] sd 3:0:0:0: [sdc]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.514836] sd 3:0:0:0: [sdc]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.515000] sd 3:0:0:0: [sdc]
58605120 512-byte hardware sectors (30006 MB)
Oct 15 18:56:57 alexandria-epia kernel: [   28.515070] sd 3:0:0:0: [sdc]
Write Protect is off
Oct 15 18:56:57 alexandria-epia kernel: [   28.515157] sd 3:0:0:0: [sdc]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 18:56:57 alexandria-epia kernel: [   28.515224]  sdc: sdc1 sdc2
Oct 15 18:56:57 alexandria-epia kernel: [   28.571981] sd 3:0:0:0: [sdc]
Attached SCSI disk
Oct 15 18:56:57 alexandria-epia kernel: [   28.621584] sd 0:0:0:0:
Attached scsi generic sg0 type 0
Oct 15 18:56:57 alexandria-epia kernel: [   28.621694] sd 1:0:0:0:
Attached scsi generic sg1 type 0
Oct 15 18:56:57 alexandria-epia kernel: [   28.621789] sd 3:0:0:0:
Attached scsi generic sg2 type 0
Oct 15 18:56:57 alexandria-epia kernel: [   28.621880] scsi 4:0:0:0:
Attached scsi generic sg3 type 5
Oct 15 18:56:57 alexandria-epia kernel: [   28.710624] usbcore:
registered new interface driver hiddev
Oct 15 18:56:57 alexandria-epia kernel: [   28.738030] input: HID
046a:002b as /devices/pci0000:00/0000:00:10.0/usb1/1-1/1-1:1.0/input/input1
Oct 15 18:56:57 alexandria-epia kernel: [   28.753480] input,hidraw0:
USB HID v1.11 Keyboard [HID 046a:002b] on usb-0000:00:10.0-1
Oct 15 18:56:57 alexandria-epia kernel: [   28.757397] Driver 'sr' needs
updating - please use bus_type methods
Oct 15 18:56:57 alexandria-epia kernel: [   28.774596] input: HID
046a:002b as /devices/pci0000:00/0000:00:10.0/usb1/1-1/1-1:1.1/input/input2
Oct 15 18:56:57 alexandria-epia kernel: [   28.778913] sr0: scsi3-mmc
drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Oct 15 18:56:57 alexandria-epia kernel: [   28.778989] Uniform CD-ROM
driver Revision: 3.20
Oct 15 18:56:57 alexandria-epia kernel: [   28.789409] input,hidraw1:
USB HID v1.11 Device [HID 046a:002b] on usb-0000:00:10.0-1
Oct 15 18:56:57 alexandria-epia kernel: [   28.806896] input: Logitech
USB Receiver as
/devices/pci0000:00/0000:00:10.0/usb1/1-2/1-2:1.0/input/input3
Oct 15 18:56:57 alexandria-epia kernel: [   28.817485] input,hidraw2:
USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-2
Oct 15 18:56:57 alexandria-epia kernel: [   28.817703] usbcore:
registered new interface driver usbhid
Oct 15 18:56:57 alexandria-epia kernel: [   28.817757]
/build/buildd/linux-2.6.24/drivers/hid/usbhid/hid-core.c: v2.6:USB HID
core driver
Oct 15 18:56:57 alexandria-epia kernel: [   34.800905] kjournald
starting.  Commit interval 5 seconds
Oct 15 18:56:57 alexandria-epia kernel: [   34.800992] EXT3-fs: mounted
filesystem with ordered data mode.
Oct 15 18:56:57 alexandria-epia kernel: [   52.576399] Linux agpgart
interface v0.102
Oct 15 18:56:57 alexandria-epia kernel: [   52.692458] pci_hotplug: PCI
Hot Plug PCI Core version: 0.5
Oct 15 18:56:57 alexandria-epia kernel: [   52.758980] shpchp: Standard
Hot Plug PCI Controller Driver version: 0.4
Oct 15 18:56:57 alexandria-epia kernel: [   52.832535] agpgart: Detected
VIA CLE266 chipset
Oct 15 18:56:57 alexandria-epia kernel: [   52.834296] agpgart: AGP
aperture is 16M @ 0xe6000000
Oct 15 18:56:57 alexandria-epia kernel: [   53.320410] input: PC Speaker
as /devices/platform/pcspkr/input/input4
Oct 15 18:56:57 alexandria-epia kernel: [   53.752220] NET: Registered
protocol family 23
Oct 15 18:56:57 alexandria-epia kernel: [   54.900348] input: Power
Button (FF) as /devices/virtual/input/input5
Oct 15 18:56:57 alexandria-epia kernel: [   54.911849] ACPI: Power
Button (FF) [PWRF]
Oct 15 18:56:57 alexandria-epia kernel: [   54.912203] input: Power
Button (CM) as /devices/virtual/input/input6
Oct 15 18:56:57 alexandria-epia kernel: [   54.927821] ACPI: Power
Button (CM) [PWRB]
Oct 15 18:56:57 alexandria-epia kernel: [   55.478425] eth0: link up,
100Mbps, full-duplex, lpa 0x45E1
Oct 15 18:56:57 alexandria-epia kernel: [   55.711987] ACPI: PCI
Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Oct 15 18:56:57 alexandria-epia kernel: [   56.995845] Console:
switching to colour frame buffer device 80x30
Oct 15 18:56:57 alexandria-epia kernel: [   56.998564] fb0: VIA VT8623
on 0000:01:00.0, 16 MB RAM
Oct 15 18:56:57 alexandria-epia kernel: [   59.699555] NET: Registered
protocol family 10
Oct 15 18:56:57 alexandria-epia kernel: [   59.700272] lo: Disabled
Privacy Extensions
Oct 15 18:56:57 alexandria-epia kernel: [   65.255719] lp: driver loaded
but no devices found
Oct 15 18:56:57 alexandria-epia kernel: [   65.457876] vt1211: Found
VT1211 chip at 0x6000, revision 2
Oct 15 18:56:57 alexandria-epia kernel: [   66.168643] Adding 1959920k
swap on /dev/sdc2.  Priority:-1 extents:1 across:1959920k
Oct 15 18:56:57 alexandria-epia kernel: [   66.719515] EXT3 FS on sdc1,
internal journal
Oct 15 18:56:57 alexandria-epia kernel: [   69.027766] kjournald
starting.  Commit interval 5 seconds
Oct 15 18:56:57 alexandria-epia kernel: [   69.033492] EXT3 FS on sda5,
internal journal
Oct 15 18:56:57 alexandria-epia kernel: [   69.033507] EXT3-fs: mounted
filesystem with ordered data mode.
Oct 15 18:56:57 alexandria-epia kernel: [   69.059687] kjournald
starting.  Commit interval 5 seconds
Oct 15 18:56:57 alexandria-epia kernel: [   69.065353] EXT3 FS on sdb5,
internal journal
Oct 15 18:56:57 alexandria-epia kernel: [   69.065367] EXT3-fs: mounted
filesystem with ordered data mode.
Oct 15 18:56:57 alexandria-epia kernel: [   70.441875] ip_tables: (C)
2000-2006 Netfilter Core Team
Oct 15 18:56:57 alexandria-epia kernel: [   73.474457] No dock devices
found.
Oct 15 18:56:57 alexandria-epia kernel: [   74.285889] longhaul: VIA C3
'Nehemiah C' [C5P] CPU detected.  Powersaver supported.
Oct 15 18:56:57 alexandria-epia kernel: [   74.285923] longhaul: ACPI
I/O at 0x400
Oct 15 18:56:57 alexandria-epia kernel: [   74.285963] longhaul: Using
northbridge support.
Oct 15 18:56:57 alexandria-epia kernel: [   74.285970] longhaul: Using
ACPI support.
Oct 15 18:56:58 alexandria-epia kernel: [   76.476357] apm: BIOS version
1.2 Flags 0x07 (Driver version 1.16ac)
Oct 15 18:56:58 alexandria-epia kernel: [   76.476373] apm: overridden
by ACPI.
Oct 15 18:56:59 alexandria-epia kernel: [  116.274084] Marking TSC
unstable due to: cpufreq changes.
Oct 15 18:56:59 alexandria-epia kernel: [  116.275897] Time: acpi_pm
clocksource has been installed.
Oct 15 18:56:59 alexandria-epia kernel: [  116.487422] Clocksource tsc
unstable (delta = -72795865 ns)
Oct 15 18:56:59 alexandria-epia dhcdbd: Started up.
Oct 15 18:57:03 alexandria-epia kernel: [  150.520234] RPC: Registered
udp transport module.
Oct 15 18:57:03 alexandria-epia kernel: [  150.520257] RPC: Registered
tcp transport module.
Oct 15 18:57:04 alexandria-epia kernel: [  150.989153] Installing knfsd
(copyright (C) 1996 okir@monad.swb.de).
Oct 15 18:57:04 alexandria-epia kernel: [   81.206993] NFSD: Using
/var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Oct 15 18:57:04 alexandria-epia kernel: [   81.239059] NFSD: starting
90-second grace period
Oct 15 18:57:06 alexandria-epia kernel: [   82.333813] [drm] Initialized
drm 1.1.0 20060810
Oct 15 18:57:06 alexandria-epia kernel: [   82.353583] [drm] Initialized
via 2.11.1 20070202 on minor 0
Oct 15 18:57:06 alexandria-epia kernel: [   82.403044] agpgart: Found an
AGP 2.0 compliant device at 0000:00:00.0.
Oct 15 18:57:06 alexandria-epia kernel: [   82.403085] agpgart: Putting
AGP V2 device at 0000:00:00.0 into 4x mode
Oct 15 18:57:06 alexandria-epia kernel: [   82.403153] agpgart: Putting
AGP V2 device at 0000:01:00.0 into 4x mode
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Lock
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Include
folders: ['/naspool_data/milan/Eigene-Dateien']
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Ignore
folders: []
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Last
snapshots: {}
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Compare with
old snapshot: 20091013-220848
Oct 15 18:57:13 alexandria-epia backintime (ramses): WARNING: Command
"rsync -aEAX  -i --dry-run  --chmod=Fa-w,D+w --whole-file --delete
--exclude="/naspool_data/milan/Back-in-Time"
--exclude="/home/ramses/.local/share/backintime"
--include="/naspool_data/milan/Eigene-Dateien/"
--include="/naspool_data/milan/" --include="/naspool_data/"
--exclude=".*" --exclude="*.backup*" --exclude="*~"
--include="/naspool_data/milan/Eigene-Dateien/**" --exclude="*" /
"/naspool_data/milan/Back-in-Time/backintime/20091013-220848/backup/""
returns 256
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Nothing
changed, no back needed
Oct 15 18:57:13 alexandria-epia backintime (ramses): WARNING: No new
snapshot (not needed or error)
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Remove
backups older than: 20041015-000000
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: [smart
remove] There is only one snapshots, so keep it
Oct 15 18:57:13 alexandria-epia backintime (ramses): INFO: Keep min free
disk space: 102400 Mb
Oct 15 18:57:15 alexandria-epia backintime (ramses): INFO: Unlock
Oct 15 18:58:02 alexandria-epia gnome-power-manager: (ramses)
Energieverwaltung is already running in this session.
Oct 15 19:16:56 alexandria-epia -- MARK --
Oct 15 19:36:56 alexandria-epia -- MARK --
Oct 15 19:56:56 alexandria-epia -- MARK --
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.469711]          res
d0/00:80:00:75:41/00:00:00:00:00/e2 Emask 0x12 (ATA bus error)
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.778141] ata1: soft
resetting link
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.934009] ata1: SATA link
up 3.0 Gbps (SStatus 123 SControl 300)
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.963130] ata1.00:
configured for UDMA/133
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.963174] ata1: EH complete
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.982166] sd 0:0:0:0: [sda]
488397168 512-byte hardware sectors (250059 MB)
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.982237] sd 0:0:0:0: [sda]
Write Protect is off
Oct 15 20:05:24 alexandria-epia kernel: [ 4712.982332] sd 0:0:0:0: [sda]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 15 20:16:56 alexandria-epia -- MARK --
Oct 15 20:20:46 alexandria-epia kernel: [ 5731.478618]          res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct 15 20:20:51 alexandria-epia kernel: [ 5736.825857] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526446] ata1: device not
ready (errno=-16), forcing hardreset
Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526472] ata1: hard
resetting link
Oct 15 20:21:02 alexandria-epia kernel: [ 5747.713897] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:06 alexandria-epia kernel: [ 5751.575082] ata1: hard
resetting link
Oct 15 20:21:12 alexandria-epia kernel: [ 5757.762534] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:16 alexandria-epia kernel: [ 5761.623715] ata1: hard
resetting link
Oct 15 20:21:22 alexandria-epia kernel: [ 5767.811162] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650099] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650114] ata1: hard
resetting link
Oct 15 20:21:56 alexandria-epia kernel: [ 5801.658417] ata1.00: disabled
Oct 15 20:21:56 alexandria-epia kernel: [ 5801.658536] ata1: hard
resetting link
Oct 15 20:22:02 alexandria-epia kernel: [ 5808.217578] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:22:06 alexandria-epia kernel: [ 5811.687078] ata1: hard
resetting link
Oct 15 20:22:12 alexandria-epia kernel: [ 5818.274258] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:22:16 alexandria-epia kernel: [ 5821.691766] ata1: hard
resetting link
Oct 15 20:22:23 alexandria-epia kernel: [ 5828.279061] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:22:51 alexandria-epia kernel: [ 5856.718163] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:22:51 alexandria-epia kernel: [ 5856.718178] ata1: hard
resetting link
Oct 15 20:22:56 alexandria-epia kernel: [ 5861.738615] ata1: hard
resetting link
Oct 15 20:23:03 alexandria-epia kernel: [ 5868.341658] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:23:06 alexandria-epia kernel: [ 5871.755193] ata1: hard
resetting link
Oct 15 20:23:13 alexandria-epia kernel: [ 5878.350348] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:23:16 alexandria-epia kernel: [ 5881.763886] ata1: hard
resetting link
Oct 15 20:23:23 alexandria-epia kernel: [ 5888.351051] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:23:51 alexandria-epia kernel: [ 5917.282365] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:23:51 alexandria-epia kernel: [ 5917.282380] ata1: hard
resetting link
Oct 15 20:23:56 alexandria-epia kernel: [ 5922.302823] ata1: hard
resetting link
Oct 15 20:24:03 alexandria-epia kernel: [ 5928.893884] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:24:06 alexandria-epia kernel: [ 5932.308846] ata1: hard
resetting link
Oct 15 20:24:13 alexandria-epia kernel: [ 5938.894607] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:24:16 alexandria-epia kernel: [ 5942.308193] ata1: hard
resetting link
Oct 15 20:24:23 alexandria-epia kernel: [ 5948.895326] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:24:51 alexandria-epia kernel: [ 5977.326697] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:24:51 alexandria-epia kernel: [ 5977.326712] ata1: hard
resetting link
Oct 15 20:24:56 alexandria-epia kernel: [ 5982.351151] ata1: hard
resetting link
Oct 15 20:25:03 alexandria-epia kernel: [ 5988.950311] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:25:06 alexandria-epia kernel: [ 5992.363869] ata1: hard
resetting link
Oct 15 20:25:13 alexandria-epia kernel: [ 5998.955224] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:25:16 alexandria-epia kernel: [ 6002.368707] ata1: hard
resetting link
Oct 15 20:25:23 alexandria-epia kernel: [ 6008.955955] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:25:51 alexandria-epia kernel: [ 6037.395626] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:25:51 alexandria-epia kernel: [ 6037.395642] ata1: hard
resetting link
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416096] sd 0:0:0:0: [sda]
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416119] sd 0:0:0:0: [sda]
Sense Key : Aborted Command [current] [descriptor]
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416144] Descriptor sense
data with sense descriptors (in hex):
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416157]         72 0b 00
00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416194]         00 00 00 00
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416211] sd 0:0:0:0: [sda]
Add. Sense: No additional sense information
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416235] end_request: I/O
error, dev sda, sector 46898304
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.416279] ata1: EH complete
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.420602] ata1.00:
detaching (SCSI 0:0:0:0)
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.421613] sd 0:0:0:0: [sda]
Synchronizing SCSI cache
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.425374] sd 0:0:0:0: [sda]
Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.425405] sd 0:0:0:0: [sda]
Stopping disk
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.425758] sd 0:0:0:0: [sda]
START_STOP FAILED
Oct 15 20:25:56 alexandria-epia kernel: [ 6042.425771] sd 0:0:0:0: [sda]
Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Oct 15 20:26:01 alexandria-epia kernel: [ 3229.201352] printk: 58056
messages suppressed.
Oct 15 20:26:06 alexandria-epia kernel: [ 3234.205044] printk: 55896
messages suppressed.
Oct 15 20:26:11 alexandria-epia kernel: [ 3239.203445] printk: 54639
messages suppressed.
Oct 15 20:26:16 alexandria-epia kernel: [ 3244.202383] printk: 57627
messages suppressed.
Oct 15 20:26:21 alexandria-epia kernel: [ 3249.197164] printk: 57827
messages suppressed.
Oct 15 20:26:26 alexandria-epia kernel: [ 3254.235350] printk: 56766
messages suppressed.
Oct 15 20:26:31 alexandria-epia kernel: [ 3259.206494] printk: 56007
messages suppressed.
Oct 15 20:26:36 alexandria-epia kernel: [ 3264.194019] printk: 57076
messages suppressed.
Oct 15 20:26:41 alexandria-epia kernel: [ 3269.217233] printk: 57609
messages suppressed.
Oct 15 20:26:46 alexandria-epia kernel: [ 3274.198062] printk: 57134
messages suppressed.
Oct 15 20:26:51 alexandria-epia kernel: [ 3279.190876] printk: 55536
messages suppressed.
Oct 15 20:26:56 alexandria-epia kernel: [ 3284.194655] printk: 56754
messages suppressed.
Oct 15 20:27:01 alexandria-epia kernel: [ 3289.188908] printk: 56462
messages suppressed.
Oct 15 20:27:06 alexandria-epia kernel: [ 3294.199876] printk: 58035
messages suppressed.
Oct 15 20:27:11 alexandria-epia kernel: [ 3299.191366] printk: 56992
messages suppressed.
Oct 15 20:27:16 alexandria-epia kernel: [ 3304.218411] printk: 56165
messages suppressed.
Oct 15 20:27:21 alexandria-epia kernel: [ 3309.192869] printk: 56700
messages suppressed.
Oct 15 20:27:26 alexandria-epia kernel: [ 3314.203828] printk: 56625
messages suppressed.
Oct 15 20:27:31 alexandria-epia kernel: [ 3319.182798] printk: 57850
messages suppressed.
Oct 15 20:27:36 alexandria-epia kernel: [ 3324.189708] printk: 56388
messages suppressed.
Oct 15 20:27:41 alexandria-epia kernel: [ 3329.180412] printk: 56685
messages suppressed.
Oct 15 20:27:46 alexandria-epia kernel: [ 3334.187466] printk: 57426
messages suppressed.
Oct 15 20:27:51 alexandria-epia kernel: [ 3339.178317] printk: 56907
messages suppressed.
Oct 15 20:27:56 alexandria-epia kernel: [ 3344.193380] printk: 57776
messages suppressed.
Oct 15 20:28:01 alexandria-epia kernel: [ 3349.188479] printk: 57536
messages suppressed.
Oct 15 20:28:06 alexandria-epia kernel: [ 3354.175306] printk: 55568
messages suppressed.
Oct 15 20:28:11 alexandria-epia kernel: [ 3359.175259] printk: 57028
messages suppressed.
Oct 15 20:28:16 alexandria-epia kernel: [ 3364.197592] printk: 57333
messages suppressed.
Oct 15 20:28:21 alexandria-epia kernel: [ 3369.184288] printk: 57658
messages suppressed.
Oct 15 20:28:26 alexandria-epia kernel: [ 3374.178743] printk: 56678
messages suppressed.
Oct 15 20:28:31 alexandria-epia kernel: [ 3379.174093] printk: 56841
messages suppressed.
Oct 15 20:28:36 alexandria-epia kernel: [ 3384.181644] printk: 56953
messages suppressed.
Oct 15 20:28:41 alexandria-epia kernel: [ 3389.167893] printk: 57125
messages suppressed.
Oct 15 20:28:46 alexandria-epia kernel: [ 3394.166908] printk: 50158
messages suppressed.
Oct 15 20:28:51 alexandria-epia kernel: [ 3399.166061] printk: 57506
messages suppressed.
Oct 15 20:28:56 alexandria-epia kernel: [ 3404.176976] printk: 57274
messages suppressed.
Oct 15 20:29:01 alexandria-epia kernel: [ 3409.179737] printk: 56445
messages suppressed.
Oct 15 20:29:06 alexandria-epia kernel: [ 3414.178775] printk: 57484
messages suppressed.
Oct 15 20:29:11 alexandria-epia kernel: [ 3419.161798] printk: 57346
messages suppressed.
Oct 15 20:29:16 alexandria-epia kernel: [ 3424.206680] printk: 57874
messages suppressed.
Oct 15 20:29:21 alexandria-epia kernel: [ 3429.168330] printk: 56015
messages suppressed.
Oct 15 20:29:26 alexandria-epia kernel: [ 3434.170657] printk: 56400
messages suppressed.
Oct 15 20:29:31 alexandria-epia kernel: [ 3439.164417] printk: 58399
messages suppressed.
Oct 15 20:29:36 alexandria-epia kernel: [ 3444.168687] printk: 56321
messages suppressed.
Oct 15 20:29:41 alexandria-epia kernel: [ 3449.155457] printk: 56930
messages suppressed.
Oct 15 20:29:46 alexandria-epia kernel: [ 3454.178635] printk: 55817
messages suppressed.
Oct 15 20:29:51 alexandria-epia kernel: [ 3459.153412] printk: 57252
messages suppressed.
Oct 15 20:29:56 alexandria-epia kernel: [ 3464.164405] printk: 58380
messages suppressed.
Oct 15 20:30:01 alexandria-epia kernel: [ 3469.151242] printk: 56203
messages suppressed.
Oct 15 20:30:06 alexandria-epia kernel: [ 3474.150214] printk: 56936
messages suppressed.
Oct 15 20:30:11 alexandria-epia kernel: [ 3479.157268] printk: 56362
messages suppressed.
Oct 15 20:30:16 alexandria-epia kernel: [ 3484.148117] printk: 56088
messages suppressed.
Oct 15 20:30:21 alexandria-epia kernel: [ 3489.147110] printk: 57905
messages suppressed.
Oct 15 20:30:26 alexandria-epia kernel: [ 3494.170161] printk: 56089
messages suppressed.
Oct 15 20:30:31 alexandria-epia kernel: [ 3499.148540] printk: 57544
messages suppressed.
Oct 15 20:30:36 alexandria-epia kernel: [ 3504.156076] printk: 56149
messages suppressed.
Oct 15 20:30:41 alexandria-epia kernel: [ 3509.144470] printk: 58096
messages suppressed.
Oct 15 20:30:46 alexandria-epia kernel: [ 3514.141886] printk: 57648
messages suppressed.
Oct 15 20:30:51 alexandria-epia kernel: [ 3519.167677] printk: 56172
messages suppressed.
Oct 15 20:30:56 alexandria-epia kernel: [ 3524.149442] printk: 56296
messages suppressed.
Oct 15 20:31:01 alexandria-epia kernel: [ 3529.173825] printk: 56543
messages suppressed.
Oct 15 20:31:06 alexandria-epia kernel: [ 3534.142046] printk: 57400
messages suppressed.
Oct 15 20:31:11 alexandria-epia kernel: [ 3539.144648] printk: 57764
messages suppressed.
Oct 15 20:31:16 alexandria-epia kernel: [ 3544.135834] printk: 55831
messages suppressed.
Oct 15 20:31:21 alexandria-epia kernel: [ 3549.138827] printk: 56413
messages suppressed.
Oct 15 20:31:26 alexandria-epia kernel: [ 3554.137979] printk: 55730
messages suppressed.
Oct 15 20:31:31 alexandria-epia kernel: [ 3559.132546] printk: 57203
messages suppressed.
Oct 15 20:31:36 alexandria-epia kernel: [ 3564.132314] printk: 55991
messages suppressed.
Oct 15 20:31:41 alexandria-epia kernel: [ 3569.159913] printk: 57235
messages suppressed.
Oct 15 20:31:46 alexandria-epia kernel: [ 3574.141727] printk: 56423
messages suppressed.
Oct 15 20:31:51 alexandria-epia kernel: [ 3579.136482] printk: 57275
messages suppressed.
Oct 15 20:31:56 alexandria-epia kernel: [ 3584.138632] printk: 57901
messages suppressed.
Oct 15 20:32:01 alexandria-epia kernel: [ 3589.126362] printk: 55934
messages suppressed.
Oct 15 20:32:06 alexandria-epia kernel: [ 3594.154458] printk: 55794
messages suppressed.
Oct 15 20:32:11 alexandria-epia kernel: [ 3599.141288] printk: 58209
messages suppressed.
Oct 15 20:32:16 alexandria-epia kernel: [ 3604.123272] printk: 57454
messages suppressed.
Oct 15 20:32:21 alexandria-epia kernel: [ 3609.128975] printk: 57315
messages suppressed.
Oct 15 20:32:26 alexandria-epia kernel: [ 3614.121455] printk: 55829
messages suppressed.
Oct 15 20:32:31 alexandria-epia kernel: [ 3619.128343] printk: 57432
messages suppressed.
Oct 15 20:32:36 alexandria-epia kernel: [ 3624.119131] printk: 56418
messages suppressed.
Oct 15 20:32:41 alexandria-epia kernel: [ 3629.120875] printk: 56254
messages suppressed.
Oct 15 20:32:46 alexandria-epia kernel: [ 3634.131739] printk: 56200
messages suppressed.
Oct 15 20:32:51 alexandria-epia kernel: [ 3639.116094] printk: 57371
messages suppressed.
Oct 15 20:32:56 alexandria-epia kernel: [ 3644.119225] printk: 55993
messages suppressed.
Oct 15 20:33:01 alexandria-epia kernel: [ 3649.113953] printk: 57137
messages suppressed.
Oct 15 20:33:06 alexandria-epia kernel: [ 3654.117411] printk: 55590
messages suppressed.
Oct 15 20:33:11 alexandria-epia kernel: [ 3659.127350] printk: 56027
messages suppressed.
Oct 15 20:33:16 alexandria-epia kernel: [ 3664.125399] printk: 56090
messages suppressed.
Oct 15 20:33:21 alexandria-epia kernel: [ 3669.120432] printk: 56515
messages suppressed.
Oct 15 20:33:26 alexandria-epia kernel: [ 3674.139650] printk: 58085
messages suppressed.
Oct 15 20:33:31 alexandria-epia kernel: [ 3679.115942] printk: 56786
messages suppressed.
Oct 15 20:33:36 alexandria-epia kernel: [ 3684.113709] printk: 55181
messages suppressed.
Oct 15 20:33:41 alexandria-epia kernel: [ 3689.106004] printk: 57292
messages suppressed.
Oct 15 20:33:46 alexandria-epia kernel: [ 3694.118522] printk: 50620
messages suppressed.
Oct 15 20:33:51 alexandria-epia kernel: [ 3699.104308] printk: 57015
messages suppressed.
Oct 15 20:33:56 alexandria-epia kernel: [ 3704.103347] printk: 56276
messages suppressed.
Oct 15 20:34:01 alexandria-epia kernel: [ 3709.108856] printk: 55820
messages suppressed.
Oct 15 20:34:06 alexandria-epia kernel: [ 3714.113963] printk: 57194
messages suppressed.
Oct 15 20:34:11 alexandria-epia kernel: [ 3719.100690] printk: 56656
messages suppressed.
Oct 15 20:34:16 alexandria-epia kernel: [ 3724.104087] printk: 56871
messages suppressed.
Oct 15 20:34:21 alexandria-epia kernel: [ 3729.099001] printk: 57775
messages suppressed.
Oct 15 20:34:26 alexandria-epia kernel: [ 3734.134743] printk: 56592
messages suppressed.
Oct 15 20:34:31 alexandria-epia kernel: [ 3739.109402] printk: 57752
messages suppressed.
Oct 15 20:34:36 alexandria-epia kernel: [ 3744.096271] printk: 55149
messages suppressed.
Oct 15 20:34:41 alexandria-epia kernel: [ 3749.102733] printk: 55328
messages suppressed.
Oct 15 20:34:46 alexandria-epia kernel: [ 3754.106507] printk: 57443
messages suppressed.
Oct 15 20:34:51 alexandria-epia kernel: [ 3759.103564] printk: 57148
messages suppressed.
Oct 15 20:34:56 alexandria-epia kernel: [ 3764.096738] printk: 56921
messages suppressed.
Oct 15 20:35:01 alexandria-epia kernel: [ 3769.129935] printk: 55964
messages suppressed.
Oct 15 20:35:06 alexandria-epia kernel: [ 3774.095176] printk: 56760
messages suppressed.
Oct 15 20:35:11 alexandria-epia kernel: [ 3779.101244] printk: 57063
messages suppressed.
Oct 15 20:35:16 alexandria-epia kernel: [ 3784.101580] printk: 58139
messages suppressed.
Oct 15 20:35:21 alexandria-epia kernel: [ 3789.088123] printk: 57406
messages suppressed.
Oct 15 20:35:26 alexandria-epia kernel: [ 3794.087270] printk: 56617
messages suppressed.
Oct 15 20:35:31 alexandria-epia kernel: [ 3799.106471] printk: 56304
messages suppressed.
Oct 15 20:35:36 alexandria-epia kernel: [ 3804.087945] printk: 55649
messages suppressed.
Oct 15 20:35:41 alexandria-epia kernel: [ 3809.112015] printk: 57640
messages suppressed.
Oct 15 20:35:46 alexandria-epia kernel: [ 3814.083888] printk: 56030
messages suppressed.
Oct 15 20:35:51 alexandria-epia kernel: [ 3819.082716] printk: 55645
messages suppressed.
Oct 15 20:35:56 alexandria-epia kernel: [ 3824.092227] printk: 57767
messages suppressed.
Oct 15 20:36:01 alexandria-epia kernel: [ 3829.084996] printk: 57403
messages suppressed.
Oct 15 20:36:06 alexandria-epia kernel: [ 3834.085510] printk: 55639
messages suppressed.
Oct 15 20:36:11 alexandria-epia kernel: [ 3839.086933] printk: 55618
messages suppressed.
Oct 15 20:36:16 alexandria-epia kernel: [ 3844.089274] printk: 56590
messages suppressed.
Oct 15 20:36:21 alexandria-epia kernel: [ 3849.079477] printk: 57262
messages suppressed.
Oct 15 20:36:26 alexandria-epia kernel: [ 3854.080911] printk: 57807
messages suppressed.
Oct 15 20:36:31 alexandria-epia kernel: [ 3859.087688] printk: 55651
messages suppressed.
Oct 15 20:36:36 alexandria-epia kernel: [ 3864.074571] printk: 57099
messages suppressed.
Oct 15 20:36:41 alexandria-epia kernel: [ 3869.084921] printk: 57310
messages suppressed.
Oct 15 20:36:46 alexandria-epia kernel: [ 3874.076999] printk: 56639
messages suppressed.
Oct 15 20:36:51 alexandria-epia kernel: [ 3879.071856] printk: 56682
messages suppressed.
Oct 15 20:36:56 alexandria-epia kernel: [ 3884.078078] printk: 55770
messages suppressed.
Oct 15 20:37:01 alexandria-epia kernel: [ 3889.082255] printk: 56984
messages suppressed.
Oct 15 20:37:06 alexandria-epia kernel: [ 3894.073569] printk: 56552
messages suppressed.
Oct 15 20:37:11 alexandria-epia kernel: [ 3899.072302] printk: 57028
messages suppressed.
Oct 15 20:37:16 alexandria-epia kernel: [ 3904.070505] printk: 54904
messages suppressed.
Oct 15 20:37:21 alexandria-epia kernel: [ 3909.078795] printk: 56373
messages suppressed.
Oct 15 20:37:26 alexandria-epia kernel: [ 3914.065504] printk: 57068
messages suppressed.
Oct 15 20:37:31 alexandria-epia kernel: [ 3919.068760] printk: 55467
messages suppressed.
Oct 15 20:37:36 alexandria-epia kernel: [ 3924.063678] printk: 57371
messages suppressed.
Oct 15 20:37:41 alexandria-epia kernel: [ 3929.110562] printk: 55989
messages suppressed.
Oct 15 20:37:46 alexandria-epia kernel: [ 3934.114147] printk: 56489
messages suppressed.
Oct 15 20:37:51 alexandria-epia kernel: [ 3939.060927] printk: 56740
messages suppressed.
Oct 15 20:37:56 alexandria-epia kernel: [ 3944.064249] printk: 56164
messages suppressed.
Oct 15 20:38:01 alexandria-epia kernel: [ 3949.065852] printk: 56785
messages suppressed.
Oct 15 20:38:06 alexandria-epia kernel: [ 3954.058326] printk: 56566
messages suppressed.
Oct 15 20:38:11 alexandria-epia kernel: [ 3959.057315] printk: 57861
messages suppressed.
Oct 15 20:38:16 alexandria-epia kernel: [ 3964.056409] printk: 56342
messages suppressed.
Oct 15 20:38:21 alexandria-epia kernel: [ 3969.056899] printk: 56367
messages suppressed.
Oct 15 20:38:26 alexandria-epia kernel: [ 3974.070777] printk: 55905
messages suppressed.
Oct 15 20:38:31 alexandria-epia kernel: [ 3979.065704] printk: 57014
messages suppressed.
Oct 15 20:38:36 alexandria-epia kernel: [ 3984.052743] printk: 56026
messages suppressed.
Oct 15 20:38:41 alexandria-epia kernel: [ 3989.058524] printk: 56023
messages suppressed.
Oct 15 20:38:46 alexandria-epia kernel: [ 3994.051009] printk: 50794
messages suppressed.
Oct 15 20:38:51 alexandria-epia kernel: [ 3999.060250] printk: 56603
messages suppressed.
Oct 15 20:38:56 alexandria-epia kernel: [ 4004.053786] printk: 55790
messages suppressed.
Oct 15 20:39:01 alexandria-epia kernel: [ 4009.053042] printk: 56364
messages suppressed.
Oct 15 20:39:06 alexandria-epia kernel: [ 4014.051341] printk: 55206
messages suppressed.
Oct 15 20:39:11 alexandria-epia kernel: [ 4019.049663] printk: 57709
messages suppressed.
Oct 15 20:39:16 alexandria-epia kernel: [ 4024.046964] printk: 57009
messages suppressed.
Oct 15 20:39:21 alexandria-epia kernel: [ 4029.048647] printk: 55038
messages suppressed.
Oct 15 20:39:26 alexandria-epia kernel: [ 4034.043743] printk: 57039
messages suppressed.
Oct 15 20:39:31 alexandria-epia kernel: [ 4039.050941] printk: 56591
messages suppressed.
Oct 15 20:39:36 alexandria-epia kernel: [ 4044.045792] printk: 57193
messages suppressed.
Oct 15 20:39:41 alexandria-epia kernel: [ 4049.044996] printk: 55319
messages suppressed.
Oct 15 20:39:46 alexandria-epia kernel: [ 4054.048075] printk: 56450
messages suppressed.
Oct 15 20:39:51 alexandria-epia kernel: [ 4059.038936] printk: 56516
messages suppressed.
Oct 15 20:39:56 alexandria-epia kernel: [ 4064.038017] printk: 57658
messages suppressed.
Oct 15 20:40:01 alexandria-epia kernel: [ 4069.037402] printk: 55407
messages suppressed.
Oct 15 20:40:06 alexandria-epia kernel: [ 4074.048319] printk: 57221
messages suppressed.
Oct 15 20:40:11 alexandria-epia kernel: [ 4079.035253] printk: 55405
messages suppressed.
Oct 15 20:40:16 alexandria-epia kernel: [ 4084.045362] printk: 56682
messages suppressed.
Oct 15 20:40:21 alexandria-epia kernel: [ 4089.047445] printk: 57388
messages suppressed.
Oct 15 20:40:26 alexandria-epia kernel: [ 4094.041791] printk: 57056
messages suppressed.
Oct 15 20:40:31 alexandria-epia kernel: [ 4099.043778] printk: 57487
messages suppressed.
Oct 15 20:40:36 alexandria-epia kernel: [ 4104.051574] printk: 55761
messages suppressed.
Oct 15 20:40:41 alexandria-epia kernel: [ 4109.029957] printk: 55892
messages suppressed.
Oct 15 20:40:46 alexandria-epia kernel: [ 4114.028836] printk: 57282
messages suppressed.
Oct 15 20:40:51 alexandria-epia kernel: [ 4119.031780] printk: 55296
messages suppressed.
Oct 15 20:40:56 alexandria-epia kernel: [ 4124.039228] printk: 57602
messages suppressed.
Oct 15 20:41:01 alexandria-epia kernel: [ 4129.026073] printk: 56592
messages suppressed.
Oct 15 20:41:06 alexandria-epia kernel: [ 4134.037246] printk: 56466
messages suppressed.
Oct 15 20:41:11 alexandria-epia kernel: [ 4139.056192] printk: 55415
messages suppressed.
Oct 15 20:41:16 alexandria-epia kernel: [ 4144.027597] printk: 55960
messages suppressed.
Oct 15 20:41:21 alexandria-epia kernel: [ 4149.029408] printk: 58188
messages suppressed.
Oct 15 20:41:26 alexandria-epia kernel: [ 4154.025582] printk: 55562
messages suppressed.
Oct 15 20:41:31 alexandria-epia kernel: [ 4159.047482] printk: 55822
messages suppressed.
Oct 15 20:41:36 alexandria-epia kernel: [ 4164.031637] printk: 55222
messages suppressed.
Oct 15 20:41:41 alexandria-epia kernel: [ 4169.039863] printk: 56598
messages suppressed.
Oct 15 20:41:46 alexandria-epia kernel: [ 4174.025766] printk: 57571
messages suppressed.
Oct 15 20:41:51 alexandria-epia kernel: [ 4179.035945] printk: 56831
messages suppressed.
Oct 15 20:41:56 alexandria-epia kernel: [ 4184.015799] printk: 55510
messages suppressed.
Oct 15 20:42:01 alexandria-epia kernel: [ 4189.038968] printk: 56848
messages suppressed.
Oct 15 20:42:06 alexandria-epia kernel: [ 4194.033889] printk: 56083
messages suppressed.
Oct 15 20:42:11 alexandria-epia kernel: [ 4199.030214] printk: 55857
messages suppressed.
Oct 15 20:42:16 alexandria-epia kernel: [ 4204.012345] printk: 54387
messages suppressed.
Oct 15 20:42:21 alexandria-epia kernel: [ 4209.042634] printk: 56998
messages suppressed.
Oct 15 20:42:26 alexandria-epia kernel: [ 4214.010718] printk: 55918
messages suppressed.
Oct 15 20:42:31 alexandria-epia kernel: [ 4219.011222] printk: 56173
messages suppressed.
Oct 15 20:42:36 alexandria-epia kernel: [ 4224.009054] printk: 57062
messages suppressed.
Oct 15 20:42:41 alexandria-epia kernel: [ 4229.008196] printk: 55767
messages suppressed.
Oct 15 20:42:46 alexandria-epia kernel: [ 4234.012970] printk: 57561
messages suppressed.
Oct 15 20:42:51 alexandria-epia kernel: [ 4239.006625] printk: 56029
messages suppressed.
Oct 15 20:42:56 alexandria-epia kernel: [ 4244.005777] printk: 55082
messages suppressed.
Oct 15 20:43:01 alexandria-epia kernel: [ 4249.017471] printk: 57666
messages suppressed.
Oct 15 20:43:06 alexandria-epia kernel: [ 4254.004012] printk: 55598
messages suppressed.
Oct 15 20:43:11 alexandria-epia kernel: [ 4259.003190] printk: 56541
messages suppressed.
Oct 15 20:43:16 alexandria-epia kernel: [ 4264.002609] printk: 55624
messages suppressed.
Oct 15 20:43:21 alexandria-epia kernel: [ 4269.001510] printk: 57052
messages suppressed.
Oct 15 20:43:26 alexandria-epia kernel: [ 4274.002967] printk: 57143
messages suppressed.
Oct 15 20:43:31 alexandria-epia kernel: [ 4279.015967] printk: 55772
messages suppressed.
Oct 15 20:43:36 alexandria-epia kernel: [ 4284.007266] printk: 56014
messages suppressed.
Oct 15 20:43:41 alexandria-epia kernel: [ 4289.006299] printk: 56721
messages suppressed.
Oct 15 20:43:46 alexandria-epia kernel: [ 4293.997336] printk: 50669
messages suppressed.
Oct 15 20:43:51 alexandria-epia kernel: [ 4299.004758] printk: 56115
messages suppressed.
Oct 15 20:43:56 alexandria-epia kernel: [ 4304.007931] printk: 54892
messages suppressed.
Oct 15 20:44:01 alexandria-epia kernel: [ 4309.023007] printk: 55947
messages suppressed.
Oct 15 20:44:06 alexandria-epia kernel: [ 4313.998239] printk: 56479
messages suppressed.
Oct 15 20:44:11 alexandria-epia kernel: [ 4319.005178] printk: 57125
messages suppressed.
Oct 15 20:44:16 alexandria-epia kernel: [ 4323.992259] printk: 55761
messages suppressed.
Oct 15 20:44:21 alexandria-epia kernel: [ 4328.995545] printk: 55390
messages suppressed.
Oct 15 20:44:26 alexandria-epia kernel: [ 4333.990741] printk: 56824
messages suppressed.
Oct 15 20:44:31 alexandria-epia kernel: [ 4338.993775] printk: 55206
messages suppressed.
Oct 15 20:44:36 alexandria-epia kernel: [ 4343.988913] printk: 54788
messages suppressed.
Oct 15 20:44:41 alexandria-epia kernel: [ 4348.993912] printk: 56652
messages suppressed.
Oct 15 20:44:46 alexandria-epia kernel: [ 4354.009857] printk: 56075
messages suppressed.
Oct 15 20:44:51 alexandria-epia kernel: [ 4358.986623] printk: 57317
messages suppressed.
Oct 15 20:44:56 alexandria-epia kernel: [ 4363.989925] printk: 55191
messages suppressed.
Oct 15 20:45:01 alexandria-epia kernel: [ 4368.984634] printk: 56512
messages suppressed.
Oct 15 20:45:06 alexandria-epia kernel: [ 4373.983769] printk: 56452
messages suppressed.
Oct 15 20:45:11 alexandria-epia kernel: [ 4379.039029] printk: 56700
messages suppressed.
Oct 15 20:45:16 alexandria-epia kernel: [ 4383.982192] printk: 54682
messages suppressed.
Oct 15 20:45:21 alexandria-epia kernel: [ 4388.981220] printk: 56460
messages suppressed.
Oct 15 20:45:26 alexandria-epia kernel: [ 4393.993681] printk: 57604
messages suppressed.
Oct 15 20:45:31 alexandria-epia kernel: [ 4398.982440] printk: 56579
messages suppressed.
Oct 15 20:45:36 alexandria-epia kernel: [ 4403.981684] printk: 55791
messages suppressed.
Oct 15 20:45:41 alexandria-epia kernel: [ 4409.006216] printk: 55370
messages suppressed.
Oct 15 20:45:46 alexandria-epia kernel: [ 4413.989323] printk: 57072
messages suppressed.
Oct 15 20:45:51 alexandria-epia kernel: [ 4418.976420] printk: 56575
messages suppressed.
Oct 15 20:45:56 alexandria-epia kernel: [ 4423.996021] printk: 55755
messages suppressed.
Oct 15 20:46:01 alexandria-epia kernel: [ 4428.986587] printk: 56669
messages suppressed.
Oct 15 20:46:06 alexandria-epia kernel: [ 4433.977593] printk: 56902
messages suppressed.
Oct 15 20:46:11 alexandria-epia kernel: [ 4438.984810] printk: 56802
messages suppressed.
Oct 15 20:46:16 alexandria-epia kernel: [ 4443.971766] printk: 55044
messages suppressed.
Oct 15 20:46:21 alexandria-epia kernel: [ 4448.970927] printk: 56495
messages suppressed.
Oct 15 20:46:26 alexandria-epia kernel: [ 4453.970059] printk: 56142
messages suppressed.
Oct 15 20:46:31 alexandria-epia kernel: [ 4458.969222] printk: 56419
messages suppressed.
Oct 15 20:46:36 alexandria-epia kernel: [ 4463.992083] printk: 54820
messages suppressed.
Oct 15 20:46:41 alexandria-epia kernel: [ 4468.968807] printk: 56888
messages suppressed.
Oct 15 20:46:46 alexandria-epia kernel: [ 4473.978775] printk: 57488
messages suppressed.
Oct 15 20:46:51 alexandria-epia kernel: [ 4478.990478] printk: 55535
messages suppressed.
Oct 15 20:46:56 alexandria-epia kernel: [ 4483.973127] printk: 56481
messages suppressed.
Oct 15 20:47:01 alexandria-epia kernel: [ 4488.972412] printk: 55654
messages suppressed.
Oct 15 20:47:06 alexandria-epia kernel: [ 4493.963145] printk: 57109
messages suppressed.
Oct 15 20:47:11 alexandria-epia kernel: [ 4498.986473] printk: 56653
messages suppressed.
Oct 15 20:47:16 alexandria-epia kernel: [ 4503.968145] printk: 54844
messages suppressed.
Oct 15 20:47:21 alexandria-epia kernel: [ 4508.972690] printk: 57044
messages suppressed.
Oct 15 20:47:26 alexandria-epia kernel: [ 4513.982400] printk: 56676
messages suppressed.
Oct 15 20:47:31 alexandria-epia kernel: [ 4518.958815] printk: 55031
messages suppressed.
Oct 15 20:47:36 alexandria-epia kernel: [ 4523.969735] printk: 52997
messages suppressed.
Oct 15 20:47:41 alexandria-epia kernel: [ 4528.957295] printk: 55755
messages suppressed.
Oct 15 20:47:46 alexandria-epia kernel: [ 4533.956730] printk: 56769
messages suppressed.
Oct 15 20:47:51 alexandria-epia kernel: [ 4538.955784] printk: 54536
messages suppressed.
Oct 15 20:47:56 alexandria-epia kernel: [ 4543.961813] printk: 55323
messages suppressed.
Oct 15 20:48:25 alexandria-epia kernel: [ 4564.381020] nfsd: last server
has exited
Oct 15 20:48:25 alexandria-epia kernel: [ 4564.381033] nfsd: unexporting
all filesystems
Oct 15 20:48:26 alexandria-epia exiting on signal 15
Oct 19 18:50:18 alexandria-epia syslogd 1.5.0#1ubuntu1: restart.

It's a VIA Epia M-10000 board with a Promise TX2 Plus SATA300
Controller. 1st IDE-Onboard-Channel is a 30 GB IDE harddisk with the
xubunt 8.04 and 2 GB Swap, 2nd IDE-Onboard-Channel is a LG DVD-RAM.
Promise 1st SATA-Channel is a 250GB harddisk (2,5"), Promise 2nd
SATA-Channel is a 250GB harddisk (2,5"). All disks with ext3-filesystem.
No raid, but automatic syncs between the two SATA-disks.

> FWIW, the 2.6.32-rc kernel has updates for the controller reset operations
> which may help get stubborn disks back on line. That patch is available
> for 2.6.28 to 2.6.31 kernels in the patch repository you mention below.

> Libata has a generic libata.force= parameter which can be used to tweak
> various settings, including 1.5Gbps vs 3Gbps. I haven't used it myself,
> but see Documentation/kernel-parameters.txt for details.

Thank you for this possibility. I discovered, that libata.force isn't
mentioned in Documentation/kernel-parameters.txt for 2.6.24. So I will
upgrade my system to xubuntu 9.04 (2.6.28) or xubuntu 9.10 (2.6.31) to
check libata.force and the newer patches.

Best regards, Milan

