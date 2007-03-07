From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: iq81340mc: oops with SATA VIA
Date: Wed, 7 Mar 2007 13:39:56 +0100
Message-ID: <20070307123956.GI13384@deprecation.cyrius.com>
References: <20070212114114.GG6457@deprecation.cyrius.com> <0C7297FA1D2D244A9C7F6959C0BF1E52017D0497@azsmsx413.amr.corp.intel.com> <20070307011443.08a13916@lxorguk.ukuu.org.uk> <e9c3a7c20703061923y3d2fd9c7pdf323b94569f42c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:45681 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965375AbXCGNO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 08:14:56 -0500
Content-Disposition: inline
In-Reply-To: <e9c3a7c20703061923y3d2fd9c7pdf323b94569f42c3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, buytenh@wantstofly.org, linux-ide@vger.kernel.org

* Dan Williams <dan.j.williams@intel.com> [2007-03-06 20:23]:
> Martin can you give the attached patch a try to see if it resolves the
> oops?  It has only been compile tested.  The patch spins the processor
> on the ATU outbound-queue-busy bit whenever out*() is called.

Nope, that doesn't seem to work:

Linux version 2.6.21-rc3 (tbm@em64t) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #23 Wed Mar 7 12:33:00 UTC 2007
CPU: XScale-V3 based processor [69056818] revision 8 (ARMv5TE), cr=0400397f
Machine: Intel IQ81340MC
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 65024
Kernel command line: console=ttyS1,115200 root=/dev/ram0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 255744KB available (3624K code, 273K data, 128K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
ATUX: Initialized (16M @ resource/virtual: 80000000/51000000)
ATUE: Initialized (0M @ resource/virtual: c0000000/00000000)
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xffd82340 (irq = 52) is a XScale
serial8250.1: ttyS1 at MMIO 0xffd82300 (irq = 51) is a XScale
RAMDISK driver initialized: 2 RAM disks of 8192K size 1024 blocksize
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:00:02.0: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:72
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:00:02.1: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:73
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Loading iSCSI transport class v2.0-724.
sata_via 0000:00:01.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xfffb04a0 ctl 0xfffb04aa bmdma 0xfffb0480 irq 25
Unhandled fault: imprecise external abort (0x406) at 0x23212064
Internal error: : 406 [#1]
Modules linked in:
CPU: 0
PC is at ata_bmdma_freeze+0x3c/0x50
LR is at __iop13xx_io+0x14/0x4c
pc : [<401e9b30>]    lr : [<4003372c>]    Not tainted
sp : 40651dbc  ip : 40651d98  fp : 40651dcc
r10: 4fce1cf0  r9 : 4fce1cec  r8 : 00000001
r7 : 4fcd440c  r6 : 406702b4  r5 : 00000053  r4 : 406702b4
r3 : 00000001  r2 : fffe04a7  r1 : fee80074  r0 : fec604a7
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 400397F
Table: 00004018  DAC: 00000035
Process swapper (pid: 1, stack limit = 0x40650250)
Stack: (0x40651dbc to 0x40652000)
1da0:                                                                406702b4
1dc0: 40651de0 40651dd0 401ea07c 401e9b00 20000013 40651df4 40651de4 401ea0d4
1de0: 401ea040 00000001 40651e3c 40651df8 401e4448 401ea0b4 fffb04a0 fffb04aa
1e00: fffb0480 00000019 4062e848 00000019 40651e5a 4062e8ec 00000000 40651e5a
1e20: 4062e800 00000003 4fcd440c 4062e848 40651e84 40651e40 401ec984 401e422c
1e40: 40651e60 40651e50 40174c78 40175b50 4062e800 40651e70 40f11e64 403c8fc8
1e60: 4062e800 00000000 00000000 403eb0a4 40023884 4062e8ec 40651ea4 40651e88
1e80: 40187938 401ec6d4 4062e848 4062e848 4fce3fc0 403c8ffc 40651ecc 40651ea8
1ea0: 401acce8 401878dc 403c8ffc 4062e848 4fce3fc0 401acf90 40023884 400233b0
1ec0: 40651ee8 40651ed0 401ace94 401acc7c 4062e920 4062e848 403c8ffc 40651f00
1ee0: 40651eec 401ad074 401ace08 00000000 40651f04 40651f2c 40651f04 401ac13c
1f00: 401acf9c 403c0fc0 403c0fc0 4062e890 403c8ffc 403c9010 403c0ec0 00000000
1f20: 40651f3c 40651f30 401acb88 401ac0f4 40651f60 40651f40 401ac4c8 401acb74
1f40: 403c8ffc 00000000 403c8ffc 00000000 40023884 40651f74 40651f64 401ad29c
1f60: 401ac464 403c8fc8 40651f90 40651f78 40187b18 401ad248 40023328 00000000
1f80: 40650000 40651fa0 40651f94 4001df78 40187aa4 40651ff4 40651fa4 400087a0
1fa0: 4001df68 40651fb0 40028c44 4003b8b8 00000000 00000000 40008724 40041a44
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 40651ff8 40041a44 40008730 00000000 00000000
Backtrace:
[<401e9af4>] (ata_bmdma_freeze+0x0/0x50) from [<401ea07c>] (__ata_port_freeze+0x48/0x74)
 r4 = 406702B4
[<401ea034>] (__ata_port_freeze+0x0/0x74) from [<401ea0d4>] (ata_eh_freeze_port+0x2c/0x44)
 r4 = 20000013
[<401ea0a8>] (ata_eh_freeze_port+0x0/0x44) from [<401e4448>] (ata_device_add+0x228/0x4e4)
 r4 = 00000001
[<401e4220>] (ata_device_add+0x0/0x4e4) from [<401ec984>] (svia_init_one+0x2bc/0x57c)
[<401ec6c8>] (svia_init_one+0x0/0x57c) from [<40187938>] (pci_device_probe+0x68/0x8c)
[<401878d0>] (pci_device_probe+0x0/0x8c) from [<401acce8>] (really_probe+0x78/0x18c)
 r7 = 403C8FFC  r6 = 4FCE3FC0  r5 = 4062E848  r4 = 4062E848
[<401acc70>] (really_probe+0x0/0x18c) from [<401ace94>] (driver_probe_device+0x98/0xc4)
[<401acdfc>] (driver_probe_device+0x0/0xc4) from [<401ad074>] (__driver_attach+0xe4/0xe8)
 r6 = 403C8FFC  r5 = 4062E848  r4 = 4062E920
[<401acf90>] (__driver_attach+0x0/0xe8) from [<401ac13c>] (bus_for_each_dev+0x54/0x80)
 r5 = 40651F04  r4 = 00000000
[<401ac0e8>] (bus_for_each_dev+0x0/0x80) from [<401acb88>] (driver_attach+0x20/0x28)
 r7 = 00000000  r6 = 403C0EC0  r5 = 403C9010  r4 = 403C8FFC
[<401acb68>] (driver_attach+0x0/0x28) from [<401ac4c8>] (bus_add_driver+0x70/0x194)
[<401ac458>] (bus_add_driver+0x0/0x194) from [<401ad29c>] (driver_register+0x60/0x9c)
 r8 = 40023884  r7 = 00000000  r6 = 403C8FFC  r5 = 00000000
 r4 = 403C8FFC
[<401ad23c>] (driver_register+0x0/0x9c) from [<40187b18>] (__pci_register_driver+0x80/0xc8)
 r4 = 403C8FC8
[<40187a98>] (__pci_register_driver+0x0/0xc8) from [<4001df78>] (svia_init+0x1c/0x28)
 r6 = 40650000  r5 = 00000000  r4 = 40023328
[<4001df5c>] (svia_init+0x0/0x28) from [<400087a0>] (init+0x7c/0x1d4)
[<40008724>] (init+0x0/0x1d4) from [<40041a44>] (do_exit+0x0/0x880)
Code: e5943004 e1a00004 e1a0e00f e593f020 (e1a00004)
Kernel panic - not syncing: Attempted to kill init!

-- 
Martin Michlmayr
http://www.cyrius.com/
