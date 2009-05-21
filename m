From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 08:14:56 +0200
Message-ID: <4A14F160.6080605@hiramoto.org>
References: <4A13EC76.3020206@hiramoto.org>	<m3r5ykgd97.fsf@intrepid.localdomain>	<20090520205151.GC4095@n2100.arm.linux.org.uk>
	<m3zld7cuxk.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath9k-devel-bounces@lists.ath9k.org>
In-Reply-To: <m3zld7cuxk.fsf@intrepid.localdomain>
List-Unsubscribe: <https://lists.ath9k.org/mailman/listinfo/ath9k-devel>,
	<mailto:ath9k-devel-request@lists.ath9k.org?subject=unsubscribe>
List-Archive: <http://lists.ath9k.org/pipermail/ath9k-devel>
List-Post: <mailto:ath9k-devel@lists.ath9k.org>
List-Help: <mailto:ath9k-devel-request@lists.ath9k.org?subject=help>
List-Subscribe: <https://lists.ath9k.org/mailman/listinfo/ath9k-devel>,
	<mailto:ath9k-devel-request@lists.ath9k.org?subject=subscribe>
Sender: ath9k-devel-bounces@lists.ath9k.org
Errors-To: ath9k-devel-bounces@lists.ath9k.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

Krzysztof Halasa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>   
>> Normally you get a backtrace when a "nobody cared" message is issued -
>> this should tell you which driver is probably the cause.
>>     
>
> Right - or that the other device is the cause (stuck IRQ line). So,
> Karl, please just post the backtrace.
>   

Krzysztof, you mentioned clearing the IRQ in the platform code, is there an example of this somewhere?


There is a Compact flash on hda connected the the HPT371N,  looking at 
the IDE code it looks like the drive my not be ready,  or the drive may 
raise the IRQ..

As soon as request_irq is called, the IRQ happens.

CCing linux-IDE now, as it may be an issue with this driver.


Backtrace below, sorry about some of the lines being wrapped.



Linux version 2.6.30-rc5 (karl@Canopo) (gcc version 4.2.4) #1 Tue May 19 
16:27:47 CEST 2009
CPU: XScale-IXP42x Family [690541f1] revision 1 (ARMv5TE), cr=000039ff
CPU: VIVT data cache, VIVT instruction cache
Machine: IronGate NetSurviBox Network Platform
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS1,115200 mem=64M@0x0 
ip=192.168.10.61:192.168.10.60:192.168.10.254:255.255.255.0:nsbkarl:eth1 
root=/dev/nfs nfsroot=192.1
NR_IRQS:64
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61584KB available (2952K code, 236K data, 96K init, 0K highmem)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 266.24 BogoMIPS (lpj=1331200)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 736 bytes
NET: Registered protocol family 16
IXP4xx: Using 16MiB expansion bus window size
PCI: IXP4xx is host
PCI: IXP4xx Using direct access for memory space
pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:03.0: PME# disabled
pci 0000:00:03.1: PME# supported from D0 D1 D2 D3hot
pci 0000:00:03.1: PME# disabled
pci 0000:00:03.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:03.2: PME# disabled
pci 0000:00:04.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:00:04.0: PME# disabled
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: dmabounce: registered device
pci 0000:00:02.0: dmabounce: registered device
pci 0000:00:03.0: dmabounce: registered device
pci 0000:00:03.1: dmabounce: registered device
pci 0000:00:03.2: dmabounce: registered device
pci 0000:00:04.0: dmabounce: registered device
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 8
NET: Registered protocol family 20
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
IXP4xx Queue Manager initialized.
squashfs: version 3.0 (2006/03/15) Phillip Lougher
msgmni has been set to 120
alg: No test for cipher_null (cipher_null-generic)
alg: No test for ecb(cipher_null) (ecb-cipher_null)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xc8000000 (irq = 15) is a XScale
serial8250.0: ttyS1 at MMIO 0xc8001000 (irq = 13) is a XScale
console [ttyS1] enabled
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
hpt366: HPT371N chipset detected
hpt366 0000:00:01.0: IDE controller (0x1103:0x0007 rev 0x02)
PCI: enabling device 0000:00:01.0 (0140 -> 0141)
hpt366 0000:00:01.0: IDE port disabled
hpt366 0000:00:01.0: no clock data saved by BIOS
hpt366 0000:00:01.0: DPLL base: 77 MHz, f_CNT: 120, assuming 50 MHz PCI
hpt366 0000:00:01.0: using 66 MHz DPLL clock
hpt366 0000:00:01.0: 100% native mode on irq 28
hda: KINGSTON, ATA DISK drive
irq 28: nobody cared (try booting with the "irqpoll" option)
Backtrace:
[<c002440c>] (dump_backtrace+0x0/0x110) from [<c002486c>] 
(dump_stack+0x18/0x1c)
 r6:10000000 r5:00000000 r4:c0309cd8
[<c0024854>] (dump_stack+0x0/0x1c) from [<c0055360>] 
(__report_bad_irq+0x38/0x90)
[<c0055328>] (__report_bad_irq+0x0/0x90) from [<c005551c>] 
(note_interrupt+0x164/0x1d8)
 r4:c0309cd8
[<c00553b8>] (note_interrupt+0x0/0x1d8) from [<c0056110>] 
(handle_level_irq+0x94/0xf0)
[<c005607c>] (handle_level_irq+0x0/0xf0) from [<c0020054>] (_text+0x54/0x6c)
 r5:c381dcd0 r4:0000001c
[<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
Exception stack(0xc381dc2c to 0xc381dc74)
dc20:                            c032ad40 c381c000 00000000 20000013 c381c000
dc40: 00000000 10000000 00000102 0000000a c032ad6c 00000000 c381dca4 c381dca8
dc60: c381dc74 c0035c9c c00359c4 20000013 ffffffff
 r5:0000001f r4:ffffffff
[<c0035974>] (__do_softirq+0x0/0xf8) from [<c0035c9c>] (irq_exit+0x44/0x4c)
[<c0035c58>] (irq_exit+0x0/0x4c) from [<c0020058>] (_text+0x58/0x6c)
[<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
Exception stack(0xc381dcd0 to 0xc381dd18)
dcc0:                                     00000000 69054200 00000000 00000000
dce0: c0309cd8 c3807f80 00000080 60000013 0000001c c386680c c0309cf8 c381dd40
dd00: c381dccc c381dd18 c00295e8 c0054b44 60000013 ffffffff
 r5:0000001f r4:ffffffff
[<c0054950>] (__setup_irq+0x0/0x2a8) from [<c0054cac>] 
(request_threaded_irq+0xb4/0xe0)
[<c0054bf8>] (request_threaded_irq+0x0/0xe0) from [<c01783c0>] 
(ide_host_register+0x444/0x60c)
[<c0177f7c>] (ide_host_register+0x0/0x60c) from [<c017c158>] 
(ide_pci_init_one+0xdc/0x10c)
[<c017c07c>] (ide_pci_init_one+0x0/0x10c) from [<c024cec0>] 
(hpt366_init_one+0x344/0x3a8)
 r8:c0321cac r7:c38737a0 r6:00000000 r5:c3814400 r4:c0321920
[<c024cb7c>] (hpt366_init_one+0x0/0x3a8) from [<c0015998>] 
(ide_scan_pcibus+0x50/0x124)
 r7:c0015948 r6:c0319330 r5:c3814400 r4:c0318fb4
[<c0015948>] (ide_scan_pcibus+0x0/0x124) from [<c0020290>] 
(do_one_initcall+0x58/0x190)
 r8:c0321cac r7:c0015948 r6:00000000 r5:c001c840 r4:c001c784
[<c0020238>] (do_one_initcall+0x0/0x190) from [<c0008744>] 
(kernel_init+0x78/0xe4)
[<c00086cc>] (kernel_init+0x0/0xe4) from [<c0033b28>] (do_exit+0x0/0x584)
 r5:00000000 r4:00000000
handlers:
[<c0174bc0>] (ide_intr+0x0/0x220)
Disabling IRQ #28
ide0 at 0x1848-0x184f,0x1856 on irq 28 (serialized)
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 506016 sectors (259 MB) w/1KiB Cache, CHS=502/16/63
 hda: hda1
Driver 'sd' needs updating - please use bus_type methods
PPP generic driver version 2.4.2
8139too Fast Ethernet driver 0.9.28
PCI: enabling device 0000:00:04.0 (0140 -> 0143)
eth1: RealTek RTL8139 at 0x1400, 00:13:01:00:02:18, IRQ 25
IXP4xx MII Bus: probed
eth0: generated random MAC address 8e:26:8c:8a:92:d8.
eth0: MII PHY 0 on NPE-B
eth2: generated random MAC address ee:f3:97:b9:36:57.
0:01 not found
eth2: Could not attach to PHY
IXP4XX-Flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
IXP4XX-Flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Searching for RedBoot partition table in IXP4XX-Flash.0 at offset 0x7f0000
6 RedBoot partitions found on MTD device IXP4XX-Flash.0
Creating 6 MTD partitions on "IXP4XX-Flash.0":
0x000000000000-0x000000040000 : "RedBoot"
0x000000040000-0x000000060000 : "nsbcfg"
0x000000060000-0x000000210000 : "kernel"
0x000000210000-0x0000007e0000 : "image"
0x0000007e0000-0x0000007e1000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't end on an erase block -- force 
read-only
0x0000007f0000-0x000000800000 : "FIS directory"
i2c /dev entries driver
i2c-gpio i2c-gpio.0: using pins 7 (SDA) and 6 (SCL)
IXP4xx Watchdog Timer: heartbeat 60 sec
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
lib80211: common routines for IEEE802.11 drivers
XScale DSP coprocessor detected.
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
IP-Config: Complete:
     device=eth1, addr=192.168.10.61, mask=255.255.255.0, gw=192.168.10.254,
     host=nsbkarl, domain=, nis-domain=(none),
     bootserver=192.168.10.60, rootserver=192.168.10.60, rootpath=
Root-NFS: unknown option: actimeo=1
Looking up port of RPC 100003/2 on 192.168.10.60
Looking up port of RPC 100005/1 on 192.168.10.60
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing init memory: 96K
init: can't log to /dev/tty5
starting pid 807, tty '/dev/console': '/etc/init.d/board start'
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: US
        (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
        (2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
        (5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
cfg80211: Calling CRDA for country: ES
loading ath9k
PCI: enabling device 0000:00:02.0 (0140 -> 0142)
cfg80211: Calling CRDA for country: AM
Registered led device: ath9k-phy0::radio
Registered led device: ath9k-phy0::assoc
Registered led device: ath9k-phy0::tx
Registered led device: ath9k-phy0::rx
irq 28: nobody cared (try booting with the "irqpoll" option)
Backtrace:
[<c002440c>] (dump_backtrace+0x0/0x110) from [<c002486c>] 
(dump_stack+0x18/0x1c)
 r6:10000000 r5:00000000 r4:c0309cd8
[<c0024854>] (dump_stack+0x0/0x1c) from [<c0055360>] 
(__report_bad_irq+0x38/0x90)
[<c0055328>] (__report_bad_irq+0x0/0x90) from [<c005551c>] 
(note_interrupt+0x164/0x1d8)
 r4:c0309cd8
[<c00553b8>] (note_interrupt+0x0/0x1d8) from [<c0056110>] 
(handle_level_irq+0x94/0xf0)
[<c005607c>] (handle_level_irq+0x0/0xf0) from [<c0020054>] (_text+0x54/0x6c)
 r5:c399bcec r4:0000001c
[<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
Exception stack(0xc399bc48 to 0xc399bc90)
bc40:                   c032ad40 c399a000 00000000 20000013 c399a000 00000000
bc60: 10000000 00000102 0000000a c032ad6c 00000000 c399bcc0 c399bcc4 c399bc90
bc80: c0035c9c c00359c4 20000013 ffffffff
 r5:0000001f r4:ffffffff
[<c0035974>] (__do_softirq+0x0/0xf8) from [<c0035c9c>] (irq_exit+0x44/0x4c)
[<c0035c58>] (irq_exit+0x0/0x4c) from [<c0020058>] (_text+0x58/0x6c)
[<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
Exception stack(0xc399bcec to 0xc399bd34)
bce0:                            0000000b 69054200 ffbeefff 00000000 c0309cd8
bd00: c39d5100 00000080 60000013 0000001c bf0b9430 c3807f94 c399bd5c c399bccc
bd20: c399bd34 c00295e8 c0054b44 20000013 ffffffff
 r5:0000001f r4:ffffffff
[<c0054950>] (__setup_irq+0x0/0x2a8) from [<c0054cac>] 
(request_threaded_irq+0xb4/0xe0)
[<c0054bf8>] (request_threaded_irq+0x0/0xe0) from [<bf0a65cc>] 
(ath_pci_probe+0x1a8/0x294 [ath9k])
[<bf0a6424>] (ath_pci_probe+0x0/0x294 [ath9k]) from [<c0152678>] 
(local_pci_probe+0x20/0x24)
[<c0152658>] (local_pci_probe+0x0/0x24) from [<c0152828>] 
(pci_device_probe+0x6c/0x9c)
[<c01527bc>] (pci_device_probe+0x0/0x9c) from [<c016d7bc>] 
(driver_probe_device+0xb0/0x164)
 r7:bf0c09f0 r6:bf0c09f0 r5:c381488c r4:c3814858
[<c016d70c>] (driver_probe_device+0x0/0x164) from [<c016d8d8>] 
(__driver_attach+0x68/0x8c)
 r7:bf0c09f0 r6:bf0c09f0 r5:c381488c r4:c3814858
[<c016d870>] (__driver_attach+0x0/0x8c) from [<c016cbf4>] 
(bus_for_each_dev+0x58/0x8c)
 r6:c016d870 r5:c399be44 r4:00000000
[<c016cb9c>] (bus_for_each_dev+0x0/0x8c) from [<c016d620>] 
(driver_attach+0x20/0x28)
 r7:c3880a20 r6:00077288 r5:bf0c09f0 r4:00000000
[<c016d600>] (driver_attach+0x0/0x28) from [<c016d1d0>] 
(bus_add_driver+0xa4/0x210)
[<c016d12c>] (bus_add_driver+0x0/0x210) from [<c016dbb8>] 
(driver_register+0xac/0x134)
 r8:c0321cac r7:bf0c09f0 r6:00077288 r5:bf0c09f0 r4:bf0c09c0
[<c016db0c>] (driver_register+0x0/0x134) from [<c0152bf8>] 
(__pci_register_driver+0x40/0xb4)
[<c0152bb8>] (__pci_register_driver+0x0/0xb4) from [<bf0a63d0>] 
(ath_pci_init+0x1c/0x2c [ath9k])
 r7:bf0c4000 r6:00077288 r5:bf0c0af8 r4:00000000
[<bf0a63b4>] (ath_pci_init+0x0/0x2c [ath9k]) from [<bf0c402c>] 
(ath9k_init+0x2c/0x54 [ath9k])
[<bf0c4000>] (ath9k_init+0x0/0x54 [ath9k]) from [<c0020290>] 
(do_one_initcall+0x58/0x190)
 r4:0003ce17
[<c0020238>] (do_one_initcall+0x0/0x190) from [<c005345c>] 
(sys_init_module+0xa0/0x250)
[<c00533bc>] (sys_init_module+0x0/0x250) from [<c0020d80>] 
(ret_fast_syscall+0x0/0x2c)
 r7:00000080 r6:00000000 r5:00077288 r4:0003ce17
handlers:
[<c0174bc0>] (ide_intr+0x0/0x220)
[<bf09fde4>] (ath_isr+0x0/0x2cc [ath9k])
Disabling IRQ #28
phy0: Atheros AR5416 MAC/BB Rev:2 AR2133 RF Rev:81: mem=0xc4920000, irq=28


--
Karl
