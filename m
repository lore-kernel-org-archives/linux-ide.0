From: Heiko Schocher <hs@denx.de>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 05 Jul 2010 10:26:41 +0200
Message-ID: <4C319741.3060602@denx.de>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com>
 <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:55601 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab0GEI0u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 04:26:50 -0400
In-reply-to: <4C2DFF43.6050502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Tejun,

Tejun Heo wrote:
> Can you please give a shot at the following branch and report
> the kernel log?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git libata-irq-expect

I tried it with above kernel, but same problem as I reported:

   Uncompressing Kernel Image ... OK
Using KUP4K machine description
Linux version 2.6.35-rc3-112005-gc44f4d3-dirty (hs@pollux.denx.de) (gcc version 4.2.2) #1 Mon Jul 5 10:11:11 CEST 2010
Zone PFN ranges:
  DMA      0x00000000 -> 0x00006000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00006000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 24384
Kernel command line: root=/dev/nfs rw nfsroot=/opt/eldk-4.2/ppc_8xx,timeo=20,retrans=5 ip=192.168.120.4:192.168.1.1:192.168.1.254:255.255.0.0:kup4k:eth0:off console=ttyCPM0,115200
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 93912k/98304k available (3180k kernel code, 4392k reserved, 112k data, 106k bss, 132k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfddf9000..0xfde00000  : early ioremap
  * 0xc7000000..0xfddf9000  : vmalloc & ioremap
SLUB: Genslabs=12, HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:512 nr_irqs:512
Decrementer Frequency = 0x4c4b40
clocksource: timebase mult[32000000] shift[22] registered
console [ttyCPM0] enabled
pid_max: default: 4096 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
pwm_init
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
mpc8xx-gpt fff00980.pwm_m8xx_gpt: 4 channels
msgmni has been set to 183
io scheduler noop registered
io scheduler deadline registered (default)
s1d13xxxfb: chip production id 10 = S1D13706
s1d13xxxfb: chip revision 0
fff00a80.serial: ttyCPM0 at MMIO 0xc7034a80 (irq = 19) is a CPM UART
fff00a90.serial: ttyCPM1 at MMIO 0xc703ca90 (irq = 20) is a CPM UART
brd: module loaded
loop: module loaded
Found: AMD AM29LV800BB
40000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
number of JEDEC chips: 1
RedBoot partition parsing not available
mpc8xxx_spi fff00aa0.spi: at 0xc705aaa0 (irq = 21), CPM1 mode
eth0: fs_enet: 00:0b:64:00:0b:72
FEC MII Bus: probed
m8xx_pcmcia: Version 0.07, March 2010
m8xx_pcmcia: m8xx_probe: using SLOT_A and SLOT_B with IRQ 24  (13).
pcmcia_hardware_enable: Slot: 0 3.3V card found:
pcmcia_hardware_enable: Slot: 1 3.3V card found:
ads7846 spi32766.0: touchscreen, irq 22
input: ADS7846 Touchscreen as /class/input/input0
i2c /dev entries driver
pcf857x 0-0021: gpios 168..175 on a pcf8574
rtc-pcf8563 0-0051: chip found, driver version 0.4.3
rtc-pcf8563 0-0051: rtc core: registered rtc-pcf8563 as rtc0
WD: Software Watchdog Timer 1.1.0, timeout 300 sec.
TCP cubic registered
NET: Registered protocol family 17
rtc-pcf8563 0-0051: setting system clock to 2010-07-05 08:14:34 UTC (1278317674)
pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia_setup_irq: s->pcmcia_irq: 25
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 25)
scsi0 : pata_pcmcia
ata1: PATA max PIO4 cmd 0x0 ctl 0xe irq 25+
ata1.00: CFA: TOSHIBA THNCF512MDG, 3.00, max MWDMA2
ata1.00: 1000944 sectors, multi 1: LBA
ata1.00: configured for PIO4
ata1.00: configured for PIO4
ata1: EH complete
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNCF512 3.00 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1000944 512-byte logical blocks: (512 MB/488 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
pcmcia_setup_irq: s->pcmcia_irq: 26
pcmcia 1.0: pcmcia: registering new device pcmcia1.0 (IRQ: 26)
sd 0:0:0:0: [sda] Attached SCSI removable disk
scsi1 : pata_pcmcia
ata2: PATA max PIO4 cmd 0x10 ctl 0x1e irq 26+
IRQ 26: too many spurious IRQs, disabling and polling for 10k 10msec intervals.
IRQ 26: system performance may be affected
handlers:
[<c0198d00>] (ata_sff_interrupt+0x0/0x204)
IP-Config: Complete:
     device=eth0, addr=192.168.120.4, mask=255.255.0.0, gw=192.168.1.254,
     host=kup4k, domain=, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=
ata2.00: CFA: TOSHIBA THNCF032MBA, 2.00, max PIO2
ata2.00: 63488 sectors, multi 0: LBA
ata2.00: configured for PIO2
ata2.00: configured for PIO2
ata2: EH complete
scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA THNCF032 2.00 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 63488 512-byte logical blocks: (32.5 MB/31.0 MiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI removable disk
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing unused kernel memory: 132k init
modprobe: FATAL: Could not load /lib/modules/2.6.35-rc3-112005-gc44f4d3-dirty/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.35-rc3-112005-gc44f4d3-dirty/modules.dep: No such file or directory

INIT: version 2.86 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Setting clock : Mon Jul  5 08:14:41 CEST 2010 [  OK  ]
Building the cache [  OK  ]
Setting hostname kup4k:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
FATAL: Could not load /lib/modules/2.6.35-rc3-112005-gc44f4d3-dirty/modules.dep: No such file or directory
Bringing up loopback interface:  [  OK  ]
FATAL: Could not load /lib/modules/2.6.35-rc3-112005-gc44f4d3-dirty/modules.dep: No such file or directory
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting rpcbind: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.2 build 2008-04-01
Linux 2.6.35-rc3-112005-gc44f4d3-dirty on a ppc

kup4k login: root
Last login: Thu Jan  1 01:01:08 on console
reboot-bash-3.2#

I tried it with my posted patch, and it solved it also for this kernel:

   Uncompressing Kernel Image ... OK
Using KUP4K machine description
Linux version 2.6.35-rc3-112005-gc44f4d3-dirty (hs@pollux.denx.de) (gcc version 4.2.2) #2 Mon Jul 5 10:20:35 CEST 2010
Zone PFN ranges:
  DMA      0x00000000 -> 0x00006000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
[...]
m8xx_pcmcia: Version 0.07, March 2010
m8xx_pcmcia: m8xx_probe: using SLOT_A and SLOT_B with IRQ 24  (13).
pcmcia_hardware_enable: Slot: 0 3.3V card found:
pcmcia_hardware_enable: Slot: 1 3.3V card found:
ads7846 spi32766.0: touchscreen, irq 22
input: ADS7846 Touchscreen as /class/input/input0
i2c /dev entries driver
pcf857x 0-0021: gpios 168..175 on a pcf8574
rtc-pcf8563 0-0051: chip found, driver version 0.4.3
rtc-pcf8563 0-0051: rtc core: registered rtc-pcf8563 as rtc0
WD: Software Watchdog Timer 1.1.0, timeout 300 sec.
TCP cubic registered
NET: Registered protocol family 17
rtc-pcf8563 0-0051: setting system clock to 2010-07-05 08:16:30 UTC (1278317790)
pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 25)
scsi0 : pata_pcmcia
ata1: PATA max PIO4 cmd 0x0 ctl 0xe irq 25+
ata1.00: CFA: TOSHIBA THNCF512MDG, 3.00, max MWDMA2
ata1.00: 1000944 sectors, multi 1: LBA
ata1.00: configured for PIO4
ata1.00: configured for PIO4
ata1: EH complete
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNCF512 3.00 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1000944 512-byte logical blocks: (512 MB/488 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI removable disk
pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
pcmcia 1.0: pcmcia: registering new device pcmcia1.0 (IRQ: 26)
scsi1 : pata_pcmcia
ata2: PATA max PIO4 cmd 0x10 ctl 0x1e irq 26+
ata2.00: CFA: TOSHIBA THNCF032MBA, 2.00, max PIO2
ata2.00: 63488 sectors, multi 0: LBA
ata2.00: configured for PIO2
ata2.00: configured for PIO2
ata2: EH complete
scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA THNCF032 2.00 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 63488 512-byte logical blocks: (32.5 MB/31.0 MiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI removable disk
IP-Config: Complete:
[...]

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
