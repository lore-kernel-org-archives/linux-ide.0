From: "r93072" <r93072@csie.ntu.edu.tw>
Subject: Re: Porblem in sata_sil24
Date: Mon, 25 Jun 2007 23:11:09 +0800
Message-ID: <20070625145433.M87750@csie.ntu.edu.tw>
References: <20070625125733.M79854@csie.ntu.edu.tw> <467FBEAA.4090101@gmail.com> <467FC076.70102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=big5
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms.csie.ntu.edu.tw ([140.112.30.68]:56061 "EHLO
	ms.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674AbXFYPS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 11:18:26 -0400
In-Reply-To: <467FC076.70102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 25 Jun 2007 22:17:42 +0900, Tejun Heo wrote
> Tejun Heo wrote:
> > r93072 wrote:
> >> Hello,
> >>    I have some questions when using sata_sil24 for silicon image 3132.
> >>    One port of this chip connects to silicon image 5723.  My kernel 
> >>    version is 2.6.18.6.  When I turn on my eSATA device, some error 
> >>    messages would be produced.
> >>
> >>     ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
> >>     ata2: (irq_stat 0x00b00090, PHY RDY changed)
> >>     ata2: waiting for device to spin up (8 secs)
> >>     ata2: soft resetting port
> >>     ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>     ata2.00: qc timeout (cmd 0xec)
> >>     ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> >>     ata2: hard resetting port
> >>     ata2: softreset failed (port not ready)
> >>     ata2: follow-up softreset failed, retrying in 5 secs
> >>     ata2: hard resetting port
> >>     ata2: softreset failed (port not ready)
> >>     ata2: follow-up softreset failed, retrying in 5 secs
> >>     ata2: hard resetting port
> >>     ata2: softreset failed (port not ready)
> >>     ata2: reset failed, giving up
> >>     ata2: EH complete
> >>
> >>    It seems that driver would receive the interrupt signal from eSATA
> >>    device but can not reset the chip.  Could you give any idea about
> >>    it ?  Thanks a lot.
> > 
> > * What's the failing device?  An external hard disk cage?
      Yeah, it is an external hard disk cage.


> > * Does any other port of the controller has some device attached and
> > working?
    Only the cage the sil5723. 
   

> > * Please post full boot dmesg and the result of 'lspci -nnv'.
> > 
> > * Please give a shot at 2.6.22-rc5.
    
    Sorry, because it is embedded system, upgrade kernel is not easy.  
    The Soc chip is Marvell 88f5182, and the boot message is following. 
       
Linux version 2.6.18.6 (root@NAS) (gcc version 3.4.3 (MontaVista 3.4.3-25.0.70.0
501961 2005-12-18)) #6 Fri Jun 22 01:52:46 CST 2007
CPU: ARM926EJ-Sid(wb) [41069260] revision 0 (ARMv5TEJ), cr=b0053177
Machine: MV-88fxx81
parse_tag_initrd2: phys_initrd_start->0x2000000 ,phys_initrd_size->0xb375a7
early_initrd: phys_initrd_start->0x2000000, phys_initrd_size->0xb375a7
Memory policy: ECC disabled, Data cache writeback
check_initrd:initrd_node = 0x0
end_pfn -> 0x8000
node == 0x0, initrd_node = 0x0
initrd_start -> 0xc2000000, initrd_end -> 0xc2b375a7

 mv_map_io
CPU0: D VIVT write-back cache
CPU0: I cache: 32768 bytes, associativity 1, 32 byte lines, 1024 sets
CPU0: D cache: 32768 bytes, associativity 1, 32 byte lines, 1024 sets
Built 1 zonelists.  Total pages: 32768
Kernel command line: root=/dev/ram0 rw initrd=ramdisk mtdparts=physmap-flash.0:2
432k(kernel),1600k(etc),-(bootbase) console=ttyS0,115200n8 mem=128M init=/linuxr
c
--------
init irq----------------------------------------------------------------
PID hash table entries: 1024 (order: 10, 4096 bytes)
~~~~ timer init
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 114560KB available (3025K code, 618K data, 112K init)
Mount-cache hash table entries: 512
PU: Testing write buffer coherency: ok
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 11485K
NET: Registered protocol family 16

-------------------nmv_init--------------------------------------------------
Jackson boardId=0000000a
GPP out enable  1=026d00cc
GPP polarity  1=000d008c
GPP out enable  1=fff5ffd7
GPP polarity  1=00000403
0x10100  1=0092ff33
0x10100  1=0092ff33
0x10100  2=0092ff33
...................mvCpuIfInit

CPU Interface
-------------
SDRAM_CS0 ....base 00000000, size 128MB
SDRAM_CS1 ....base 08000000, size 128MB
SDRAM_CS2 ....disable
SDRAM_CS3 ....disable
PEX0_MEM ....base e0000000, size  64MB
PEX0_IO ....base f2000000, size   1MB
PCI0_MEM ....base e4000000, size  64MB
PCI0_IO ....base f2200000, size  64KB
INTER_REGS ....base f1000000, size   1MB
DEVICE_CS0 ....base fa000000, size  16MB
DEVICE_CS1 ....base f4000000, size  32MB
DEVICE_CS2 ....no such
DEV_BOOCS ....base f8000000, size  16MB

  Marvell Development Board (LSP Version 1.10.3_DB_NAS)--   Soc: 88F5182 A2

 Detected Tclk 166000000 and SysClk 166666667
Marvell USB EHCI Host controller #0: c2b2da00
Marvell USB EHCI Host controller #1: c2b2d800
pexBarOverlapDetect: winNum 2 overlap current 0
mvPexInit:Warning :Bar 2 size is illigal
it will be disabled
please check Pex and CPU windows configuration
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
use IDMA acceleration in copy to/from user buffers. used channels 2 and 3
Done.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
squashfs: version 3.2-r2 (2007/01/15) Phillip Lougher
squashfs: LZMA suppport for slax.org by jro
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
Marvell Gigabit Ethernet Driver 'egiga':
~~~GPIODOR2 F1010100=0092ff33
~~~~~~~~~~~~~~SMI2 F1072004=00019140
  o Ethernet descriptors in DRAM
  o DRAM SW cache-coherency
  o Checksum offload enabled
  o Loading network interface 'egiga0'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~egiga_init_module ok
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Intergrated Sata device found
scsi0 : Marvell SCSI to SATA adapter
scsi1 : Marvell SCSI to SATA adapter
EnablePowerSaving
PowerSavingTime = 3
No found HD
----cmdline parser init---
ehci_platform ehci_platform.4523: EHCI Host Controller
ehci_platform ehci_platform.4523: new USB bus registered, assigned bus number 1
ehci_platform ehci_platform.4523: irq 17, io mem 0x00000000
ehci_platform ehci_platform.4523: USB 0.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci_platform ehci_platform.16781: EHCI Host Controller
ehci_platform ehci_platform.16781: new USB bus registered, assigned bus number 2
ehci_platform ehci_platform.16781: irq 12, io mem 0x00000000
ehci_platform ehci_platform.16781: USB 0.0 started, EHCI 1.00, driver 10 Dec 200
4
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
USB Universal Host Controller Interface driver v3.0
sl811: driver sl811-hcd, 19 May 2005
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: not present
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 112K
Mounting file systems...
ifconfig: invalid hw-addr file
~~~~egiga_start
~~~GPIODOR1 egiga_start F1010100=0092ff33
egiga0: link down
NTFS driver 2.1.27 [Flags: R/O MODULE].
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
ata1: SATA max UDMA/100 cmd 0xC8858000 ctl 0x0 bmdma 0x0 irq 11
ata2: SATA max UDMA/100 cmd 0xC885A000 ctl 0x0 bmdma 0x0 irq 11
probe begin
scsi2 : sata_sil24
ata_port_schedule_eh
egiga0: link up<5>, full duplex<5>, speed 1 Gbps<5>
flow control disabled<5>MRU 1522 bytes<5>user-defined mtu is 1500 (rounded)
ata1: softreset failed (timeout)
ata1: softreset failed, retrying in 5 secs
ata1: softreset failed (timeout)
ata1: follow-up softreset failed, retrying in 5 secs
ata1: softreset failed (timeout)
ata1: reset failed, giving up
scsi3 : sata_sil24
ata_port_schedule_eh
ata2: SATA link down (SStatus 0 SControl 300)



BusyBox v1.1.1 (2007.06.15-10:41+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.
/ #
(Turn on eSATA)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0x2 frozen
ata2: (irq_stat 0x00a00080, device exchanged)
ata2: waiting for device to spin up (8 secs)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata2: hard resetting port
ata2: softreset failed (port not ready)
ata2: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: softreset failed (port not ready)
ata2: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: softreset failed (port not ready)
ata2: reset failed, giving up
ata2: EH complete

> 
> Umm... It's also linux-ide@vger.kernel.org not inux-ide.  Please repost
> with the above info.  Thanks.

> 
> -- 
> tejun


--
Open WebMail Project (http://openwebmail.org)

