From: =?ISO-8859-1?Q?Radovan_V=E1pen=EDk?= <radovan.vapenik@tcz.cz>
Subject: Re: AT91 IDE module
Date: Wed, 24 Nov 2010 10:36:37 +0100
Message-ID: <4CECDCA5.2060106@tcz.cz>
References: <4CEB8FB8.80702@tcz.cz> <20101123210054.GA4164@r2bh72.net.upc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms.tcz.cz ([62.77.127.194]:38494 "EHLO ms.tcz.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab0KXJqq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Nov 2010 04:46:46 -0500
In-Reply-To: <20101123210054.GA4164@r2bh72.net.upc.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org

Stanislaw Gruszka napsal(a):
> Hi
>
> (cc linux-ide)
>
> On Tue, Nov 23, 2010 at 10:56:08AM +0100, Radovan V=E1pen=EDk wrote:
>  =20
>> Hello Stanislaw,
>> i am working on custom board with AT91SAM9263, i am trying to start
>> communication with CompactFlash throught your kernel driver (true
>> ide mode). I have problem to connect CF to file to /dev directory.
>> After module load kernel prints message "ide0 at
>> 0xc4866000-0xc4866007,0xc486e006 on irq 132" without some
>> identification in /dev/(hda). Can you help me, what can be wrong?
>> Wires connections betweent processor and CF should be ok.
>>
>> I have these options in kernel:
>> CONFIG_IDE
>> CONFIG_IDE_GD
>> CONFIG_IDE_GD_ATA
>> CONFIG_IDE_TASK_IOCTL
>> CONFIG_IDE_PROC_FS
>> CONFIG_BLK_DEV_PLATFORM
>> CONFIG_BLK_DEV_IDE_AT91
>>    =20
>
> CONFIG_IDE_TIMINGS is also needed, but this should be selected if=20
> CONFIG_BLK_DEV_IDE_AT91 was chosen.
>
> If there is no info in /proc/partitions, then disc was not detected.
> It's hard to tell why without more verbose messages. Add
> "EXTRA_CFLAGS +=3D -DDEBUG" to drivers/ide/Makefile and provide full
> dmesg output.
>
> Stanislaw
>
>  =20
Hello,
i have only mtdblock0 in /proc/partitions (it is NAND), about CF is=20
nothing. There is my dmesg output, the important is on end of list.

Linux version 2.6.30 (root@black) (gcc version 4.3.3 (GCC) ) #55 Wed No=
v=20
24 09:06:41 CET 2010
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9263-EK
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c02f1b00, node_mem_map c0309000
  Normal zone: 128 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 16256 pages, LIFO batch:3
Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16=
256
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs=20
nfsroot=3D192.168.0.126:/home/kremilek/ARM/angstrom/base_image/=20
ip=3D192.168.0.200:192.168.0.126::255.255.255.0::eth0:off
NR_IRQS:192
AT91: 160 gpio irqs in 5 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
console [ttyS0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 61792KB available (2652K code, 222K data, 112K init, 0K highmem=
)
Calibrating delay loop... 99.12 BogoMIPS (lpj=3D495616)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 296 bytes
NET: Registered protocol family 16
tcb_clksrc: tc0 at 12.916 MHz
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 120
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
atmel_lcdfb atmel_lcdfb.0: 300KiB frame buffer at 23980000 (mapped at=20
ffc00000)
Console: switching to colour frame buffer device 80x30
atmel_lcdfb atmel_lcdfb.0: fb0: Atmel LCDC at 0x00700000 (mapped at=20
c485c000), irq 26
atmel_usart.0: ttyS0 at MMIO 0xfeffee00 (irq =3D 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfff8c000 (irq =3D 7) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
MACB_mii_bus: probed
eth0: Atmel MACB at 0xfffbc000 irq 21 (00:00:45:58:14:11)
eth0: attached PHY driver [Davicom DM9161A]=20
(mii_bus:phy_addr=3Dffffffff:00, irq=3D-1)
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB=20
3,3V 8-bit)
AT91 NAND: 8-bit, Software ECC
Scanning device for bad blocks
Bad eraseblock 1024 at 0x000008000000
Bad eraseblock 1025 at 0x000008020000
Creating 2 MTD partitions on "atmel_nand":
0x000000000000-0x000004000000 : "Partition 1"
0x000004000000-0x000010000000 : "Partition 2"
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 29, io mem 0x00a00000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
udc: at91_udc version 3 May 2006
mice: PS/2 mouse device common for all mice
input: gpio-keys as /class/input/input0
Registered led device: ds1
Registered led device: ds2
Registered led device: ds3
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
usb 1-2: new full speed USB device using at91_ohci and address 2
usb 1-2: configuration #1 chosen from 1 choice
IP-Config: Complete:
     device=3Deth0, addr=3D192.168.0.200, mask=3D255.255.255.0,=20
gw=3D255.255.255.255,
     host=3D192.168.0.200, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.0.126, rootserver=3D192.168.0.126, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.0.126
eth0: link up (100/Full)
Looking up port of RPC 100005/1 on 192.168.0.126
VFS: Mounted root (nfs filesystem) on device 0:11.
=46reeing init memory: 112K
udevd version 124 started
at91_ide_probe chipselect 4 irq 132 res 50000000
apply_timings t0=3D600 t1=3D70 t2=3D290 t6z=3D30
apply_timings mck_hz=3D99328000
apply_timings cycle=3D60 setup=3D7 pulse=3D29 data_float=3D3
Probing IDE interface ide0...
probing for hda: present=3D0, media=3D32, probetype=3DATA
probing for hda: present=3D0, media=3D32, probetype=3DATAPI
probing for hdb: present=3D0, media=3D32, probetype=3DATA
probing for hdb: present=3D0, media=3D32, probetype=3DATAPI
ide0 at 0xc4866000-0xc4866007,0xc486e006 on irq 132

Radovan
