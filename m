From: Johan van den Berg <johanvdb@teqcle.co.za>
Subject: ata-piix booting woes
Date: Tue, 6 May 2008 04:21:37 +0200
Message-ID: <C4E7938E-5F8F-4732-8A20-D3B6BDB044D6@teqcle.co.za>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg-2-3.saix.net ([196.25.240.83]:50283 "EHLO
	ctb-mesg-2-3.saix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbYEFCVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 22:21:47 -0400
Received: from [192.168.1.154] (dsl-242-61-169.telkomadsl.co.za [41.242.61.169])
	by ctb-mesg-2-3.saix.net (Postfix) with ESMTP id 6EE9157B5
	for <linux-ide@vger.kernel.org>; Tue,  6 May 2008 04:21:43 +0200 (SAST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have been having issues booting into 2.6.26-rc1 using ata-piix

Herewith the netconsole output:

audit(1210037000.823:39): audit_pid=0 old=1804 by auid=4294967295
[    0.000000] Linux version 2.6.26-rc1 (root@backuppc.signs-africa.co.za 
) (gcc version 4.1.2 20070626 (Red Hat 4.1.2-14)) #4 SMP Tue May 6  
02:49:58 SAST 2008
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000  
(reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000  
(reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff2fc00 (usable)
[    0.000000]  BIOS-e820: 000000003ff2fc00 - 000000003ff30000 (ACPI  
NVS)
[    0.000000]  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI  
data)
[    0.000000]  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI  
NVS)
[    0.000000]  BIOS-e820: 000000003fff0000 - 0000000040000000  
(reserved)
[    0.000000]  BIOS-e820: 00000000fecf0000 - 00000000fecf1000  
(reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000  
(reserved)
[    0.000000] x86: PAT support disabled.
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at [c00ff780] 000ff780
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   261935
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   261935
[    0.000000] DMI 2.3 present.
[    0.000000] Using APIC driver default
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID:  Product ID: Springdale-G <6>MPTABLE:  
Product ID: Springdale-G <6>MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] I/O APIC #2 Version 32 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 1
[    0.000000] Allocating PCI resources starting at 50000000 (gap:  
40000000:becf0000)
[    0.000000] PERCPU: Allocating 37768 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.   
Total pages: 259889
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/LogVol00 netconsole=6665@192.168.1.164 
/eth0,6666@192.168.1.154/00:16:cb:8d:98:fb
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] CPU 0 irqstacks, hard=c0688000 soft=c0668000
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 3192.291 MHz processor.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Dentry cache hash table entries: 131072 (order: 7,  
524288 bytes)
[    0.000999] Inode-cache hash table entries: 65536 (order: 6, 262144  
bytes)
[    0.000999] Memory: 1032468k/1047740k available (1556k kernel code,  
14428k reserved, 665k data, 212k init, 130236k highmem)
[    0.000999] virtual kernel memory layout:
[    0.000999]     fixmap  : 0xffc59000 - 0xfffff000   (3736 kB)
[    0.000999]     pkmap   : 0xff400000 - 0xff800000   (4096 kB)
[    0.000999]     vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
[    0.000999]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000999]       .init : 0xc0630000 - 0xc0665000   ( 212 kB)
[    0.000999]       .data : 0xc0585051 - 0xc062b4c0   ( 665 kB)
[    0.000999]       .text : 0xc0400000 - 0xc0585051   (1556 kB)
[    0.000999] Checking if this processor honours the WP bit even in  
supervisor mode...Ok.
[    0.060993] Calibrating delay using timer specific routine..  
6386.67 BogoMIPS (lpj=3193338)
[    0.061155] Mount-cache hash table entries: 512
[    0.061359] CPU: Trace cache: 12K uops, L1 D cache: 16K
[    0.061452] CPU: L2 cache: 1024K
[    0.061512] CPU: Physical Processor ID: 0
[    0.061573] Intel machine check architecture supported.
[    0.061637] Intel machine check reporting enabled on CPU#0.
[    0.061699] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[    0.061763] CPU0: Thermal monitoring enabled
[    0.061835] Checking 'hlt' instruction... OK.
[    0.065268] SMP alternatives: switching to UP code
[    0.069095] Freeing SMP alternatives: 10k freed
[    0.069252] ExtINT not setup in hardware but reported by MP table
[    0.069384] ENABLING IO-APIC IRQs
[    0.069624] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[    0.079696] CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 01
[    0.180972] Brought up 1 CPUs
[    0.180972] Total of 1 processors activated (6386.67 BogoMIPS).
[    0.180972] khelper used greatest stack depth: 3400 bytes left
[    0.180972] net_namespace: 660 bytes
[    0.180972] NET: Registered protocol family 16
[    0.182031] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=2
[    0.182095] PCI: Using configuration type 1 for base access
[    0.182156] Setting up standard PCI resources
[    0.194112] khelper used greatest stack depth: 3340 bytes left
[    0.194584] khelper used greatest stack depth: 3176 bytes left
[    0.195254] PCI: Probing PCI hardware
[    0.195560] pci 0000:00:1f.0: quirk: region 0400-047f claimed by  
ICH4 ACPI/GPIO/TCO
[    0.195649] pci 0000:00:1f.0: quirk: region 0500-053f claimed by  
ICH4 GPIO
[    0.196161] PCI: Transparent bridge - 0000:00:1e.0
[    0.196840] PCI: Using IRQ router PIIX/ICH [8086/24d0] at  
0000:00:1f.0
[    0.196916] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[    0.196974] PCI->APIC IRQ transform: 0000:00:1f.2[A] -> IRQ 18
[    0.197038] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[    0.197100] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[    0.197165] PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 21
[    0.197228] PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 22
[    0.197290] PCI->APIC IRQ transform: 0000:02:08.0[A] -> IRQ 20
[    0.198009] PCI: Bridge: 0000:00:01.0
[    0.198071]   IO window: a000-afff
[    0.198132]   MEM window: 0xff900000-0xff9fffff
[    0.198194]   PREFETCH window: 0x00000000d0000000-0x00000000efffffff
[    0.198260] PCI: Bridge: 0000:00:1e.0
[    0.198321]   IO window: b000-cfff
[    0.198383]   MEM window: 0xffa00000-0xffafffff
[    0.198445]   PREFETCH window: 0x0000000050000000-0x00000000500fffff
[    0.198541] NET: Registered protocol family 2
[    0.198689] IP route cache hash table entries: 32768 (order: 5,  
131072 bytes)
[    0.199029] TCP established hash table entries: 131072 (order: 8,  
1048576 bytes)
[    0.199593] TCP bind hash table entries: 65536 (order: 7, 524288  
bytes)
[    0.199990] TCP: Hash tables configured (established 131072 bind  
65536)
[    0.200055] TCP reno registered
[    0.200234] NET: Registered protocol family 1
[    0.200410] Unpacking initramfs... done
[    0.284984] Freeing initrd memory: 2241k freed
[    0.285615] audit: initializing netlink socket (disabled)
[    0.285688] type=2000 audit(1210037050.284:1): initialized
[    0.287712] highmem bounce pool size: 64 pages
[    0.287776] Total HugeTLB memory allocated, 0
[    0.287926] msgmni has been set to 1767 for ipc namespace c060e1a0
[    0.288005] io scheduler noop registered
[    0.288066] io scheduler anticipatory registered
[    0.288126] io scheduler deadline registered
[    0.288193] io scheduler cfq registered (default)
[    0.288294] pci 0000:02:08.0: Firmware left e100 interrupts  
enabled; disabling
[    0.291381] Non-volatile memory driver v1.2
[    0.291443] Linux agpgart interface v0.103
[    0.291712] agpgart: Detected an Intel 865 Chipset.
[    0.294284] agpgart: AGP aperture is 64M @ 0xf0000000
[    0.294547] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,  
IRQ sharing enabled
[    0.538009] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.538344] e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
[    0.538407] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.560943] e100: eth0: e100_probe: addr 0xffa42000, irq 20, MAC  
addr 00:11:11:8c:50:aa
[    0.561078] netconsole: local port 6665
[    0.561139] netconsole: local IP 192.168.1.164
[    0.561198] netconsole: interface eth0
[    0.561257] netconsole: remote port 6666
[    0.561317] netconsole: remote IP 192.168.1.154
[    0.561378] netconsole: remote ethernet address 00:16:cb:8d:98:fb
[    0.561440] netconsole: device eth0 not up yet, forcing it
[    0.573021] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[    0.573150] netconsole: carrier detect appears untrustworthy,  
waiting 4 seconds
[    4.573338] console [netcon0] enabled
[    4.574309] netconsole: network logging started
[    4.578056] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.578124] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.578335] mice: PS/2 mouse device common for all mice
[    4.578624] cpuidle: using governor ladder
[    4.579097] TCP bic registered
[    4.579159] Initializing XFRM netlink socket
[    4.579229] NET: Registered protocol family 17
[    4.579299] Using IPI Shortcut mode
[    4.579429] registered taskstats version 1
[    4.579680] Freeing unused kernel memory: 212k freed
[    4.579758] Write protecting the kernel text: 1560k
[    4.579825] Write protecting the kernel read-only data: 496k
[    4.836962] insmod used greatest stack depth: 3088 bytes left
[    4.849519] SCSI subsystem initialized
[    4.849652] insmod used greatest stack depth: 3084 bytes left
[    4.851901] Driver 'sd' needs updating - please use bus_type methods
[    4.859939] insmod used greatest stack depth: 3072 bytes left
[    4.861578] ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
[    4.861773] scsi0 : ata_piix
[    4.861953] scsi1 : ata_piix
[    4.862055] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma  
0xffa0 irq 14
[    4.862121] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma  
0xffa8 irq 15
[    4.862708] input: AT Translated Set 2 keyboard as /devices/ 
platform/i8042/serio0/input/input0
[    5.164283] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    5.164605] scsi2 : ata_piix
[    5.164746] scsi3 : ata_piix
[    5.164841] ata3: SATA max UDMA/133 cmd 0xec00 ctl 0xe800 bmdma  
0xdc00 irq 18
[    5.164907] ata4: SATA max UDMA/133 cmd 0xe400 ctl 0xe000 bmdma  
0xdc08 irq 18
[    5.436557] ata3.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
[    5.436622] ata3.00: 390721968 sectors, multi 16: LBA48
[    5.458547] ata3.00: configured for UDMA/133
[   10.506408] ata4: link is slow to respond, please be patient  
(ready=0)
[   15.503648] ata4: device not ready (errno=-16), forcing hardreset
[   20.702857] ata4: link is slow to respond, please be patient  
(ready=0)
[   25.547121] ata4: SRST failed (errno=-16)
[   30.746330] ata4: link is slow to respond, please be patient  
(ready=0)
[   35.590594] ata4: SRST failed (errno=-16)
[   40.789804] ata4: link is slow to respond, please be patient  
(ready=0)
[   70.620268] ata4: SRST failed (errno=-16)
[   75.666501] ata4: SRST failed (errno=-16)
[   75.666564] ata4: reset failed, giving up
[   75.666719] scsi 2:0:0:0: Direct-Access     ATA       
ST3200822AS      3.01 PQ: 0 ANSI: 5
[   75.666909] sd 2:0:0:0: [sda] 390721968 512-byte hardware sectors  
(200050 MB)
[   75.666989] sd 2:0:0:0: [sda] Write Protect is off
[   75.667083] sd 2:0:0:0: [sda] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[   75.667228] sd 2:0:0:0: [sda] 390721968 512-byte hardware sectors  
(200050 MB)
[   75.667518] sd 2:0:0:0: [sda] Write Protect is off
[   75.667611] sd 2:0:0:0: [sda] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[   75.667705]  sda: sda1 sda2
[   75.686268] sd 2:0:0:0: [sda] Attached SCSI disk
[   75.686416] insmod used greatest stack depth: 1356 bytes left
[   75.689722] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18)  
initialised: dm-devel@redhat.com
[   78.211210] Kernel panic - not syncing: Attempted to kill init!

The failure happens in initrd, as it is unable to find and mount the  
new root. As you can see it is actually reading the partition table,  
so I am not sure why lvm would not pick up the volume group. Rebooting  
into an older 2.6.15 kernel consistently works whereas the 2.6.25  
consistently fails.

I think this might related to http://lists.openwall.net/linux-kernel/2007/05/29/100 
  where it was already isolated it to the controller not liking the  
SRST sequence.

I have tried disabling IDE (BIOS / recompile without IDE support),  
have tried various combinations of older kernels with newer drivers  
and vice versa, but the shared ata code is too complex for me to patch  
per driver.

Has there been any progress on this so far?

Johan van den Berg
Managing Director
Teqcle Information Technologies (Pty.) Ltd.

Email: johanvdb@teqcle.co.za
Cel: 0732013520




