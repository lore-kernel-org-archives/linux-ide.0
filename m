From: Vlad Codrea <VladCodrea@mail.utexas.edu>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Fri, 16 Mar 2007 13:09:23 -0500
Message-ID: <45FADD53.5030500@mail.utexas.edu>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu> <45FAC6FC.4020105@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030906040005040108070401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironmaiden.mail.utexas.edu ([128.83.32.53]:35267 "EHLO
	ironmaiden.mail.utexas.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965814AbXCPSJa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 14:09:30 -0400
In-Reply-To: <45FAC6FC.4020105@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906040005040108070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:
> ata2: protocol 7 task_state 4   <=== The device interrupts to receive CDB
> ata2: protocol 7 task_state 4 (dev_stat 0x58)  <== Good, DRQ seen. CDB sent.
> ata2: protocol 7 task_state 2   <=== interrupt. We expect DMA complete.
> ata2: protocol 7 task_state 2 (dev_stat 0x58) <== What? DRQ set? No good.
> ata2: protocol 7 task_state 3 (dev_stat 0x58) <== HSM violation.
> (BMDMA stat 0x5) <=== Interrupted, DMA active.
>
> Still no clue why the device wrongly sets DRQ here for a DMA transfer...
> Possibilities:
> 1. HSM sent all CDB to the device, but the device is waiting for more CDB data?
> 2. HSM asked the drive to do ATAPI DMA, but the drive is doing PIO?
>
> Hi Vlad,
>
> Could you please turn off ATAPI DMA and see if the drive works under PIO,
> thanks.
>
> --
> albert
>
> (This is not a patch. Please edit drivers/ata/libata-core.c as below.)
>
> int ata_check_atapi_dma(struct ata_queued_cmd *qc)
> {
> 	struct ata_port *ap = qc->ap;
> 	int rc = 0; /* Assume ATAPI DMA is OK by default */
>
> 	if (ap->ops->check_atapi_dma)
> 		rc = ap->ops->check_atapi_dma(qc);
>
>  rc = 1; (<==== Please add "rc = 1;" here to turn off ATAPI DMA. )
>
> 	return rc;
> }
>   

Hi,

After adding "rc = 1;", the drive now appears as /dev/sr0. I've attached 
an annotated dmesg: the first part contains the messages immediately 
after booting. The second part contains messages after I inserted a CD 
and ran  "mount /dev/sr0 /root/cdrom". The third part contains messages 
after I ran "cp -r /root/cdrom /root/cdrom_copy". I separated the parts 
by adding lines containing "#####".

The recursive copy fails after about 10 seconds, even though a few files 
are copied.

Thanks,
Vlad

--------------030906040005040108070401
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 2180-218f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0530-0537
PIIX4 devres C PIO at 0388-038b
PIIX4 devres G PIO at 0f00-0f07
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:04.1
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:04.0
PCI: Found IRQ 11 for device 0000:00:04.1
NET: Registered protocol family 8
NET: Registered protocol family 20
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:04' and the driver 'system'
pnp: 00:04: ioport range 0x401-0x407 has been reserved
pnp: match found with the PnP device '00:05' and the driver 'system'
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x2180-0x218f has been reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 1, cardbus bridge: 0000:00:04.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 10000000-13ffffff
  MEM window: 14000000-17ffffff
PCI: Bus 5, cardbus bridge: 0000:00:04.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 18000000-1bffffff
  MEM window: 1c000000-1fffffff
PCI: Found IRQ 11 for device 0000:00:04.0
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Found IRQ 11 for device 0000:00:04.1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 49152 bytes)
TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3441k freed
PM: Adding info for platform:pcspkr
audit: initializing netlink socket (disabled)
audit(1174005383.472:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
PM: Adding info for platform:vesafb.0
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:ptyp0
PM: Adding info for No Bus:ptyp1
PM: Adding info for No Bus:ptyp2
PM: Adding info for No Bus:ptyp3
PM: Adding info for No Bus:ptyp4
PM: Adding info for No Bus:ptyp5
PM: Adding info for No Bus:ptyp6
PM: Adding info for No Bus:ptyp7
PM: Adding info for No Bus:ptyp8
PM: Adding info for No Bus:ptyp9
PM: Adding info for No Bus:ptypa
PM: Adding info for No Bus:ptypb
PM: Adding info for No Bus:ptypc
PM: Adding info for No Bus:ptypd
PM: Adding info for No Bus:ptype
PM: Adding info for No Bus:ptypf
PM: Adding info for No Bus:ttyp0
PM: Adding info for No Bus:ttyp1
PM: Adding info for No Bus:ttyp2
PM: Adding info for No Bus:ttyp3
PM: Adding info for No Bus:ttyp4
PM: Adding info for No Bus:ttyp5
PM: Adding info for No Bus:ttyp6
PM: Adding info for No Bus:ttyp7
PM: Adding info for No Bus:ttyp8
PM: Adding info for No Bus:ttyp9
PM: Adding info for No Bus:ttypa
PM: Adding info for No Bus:ttypb
PM: Adding info for No Bus:ttypc
PM: Adding info for No Bus:ttypd
PM: Adding info for No Bus:ttype
PM: Adding info for No Bus:ttypf
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:ttyS2
PM: Adding info for No Bus:ttyS3
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'serial'
PM: Removing info for No Bus:ttyS0
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:06' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:16' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
PM: Adding info for serio:serio1
PM: Adding info for No Bus:psaux
mice: PS/2 mouse device common for all mice
PM: Adding info for platform:eisa.0
EISA: Probing bus 0 at eisa.0
PM: Removing info for platform:eisa.0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
  Magic number: 15:758:607
Freeing unused kernel memory: 256k freed
Time: tsc clocksource has been installed.
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFCD0 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFCD8 irq 15
scsi0 : ata_piix
PM: Adding info for No Bus:host0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/33
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata2.00: ATAPI, max MWDMA2, CDB intr
ata2.00: configured for MWDMA2
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
PM: Adding info for No Bus:target1:0:0
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
scsi 1:0:0:0: CD-ROM            TORiSAN  DVD-ROM DRD-N216 1.08 PQ: 0 ANSI: 5
PM: Adding info for scsi:1:0:0:0
PCI: setting IRQ 10 as level-triggered
PCI: Assigned IRQ 10 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 10, io base 0x0000fce0
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
SCSI device sda: 12685680 512-byte hdwr sectors (6495 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 12685680 512-byte hdwr sectors (6495 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
sr0: scsi3-mmc drive: 0x/0x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
Yenta: CardBus bridge found at 0000:00:04.0 [1028:007e]
Yenta: ISA IRQ mask 0x0298, PCI irq 11
Socket status: 30000010
Yenta: CardBus bridge found at 0000:00:04.1 [1028:007e]
Yenta: ISA IRQ mask 0x0298, PCI irq 11
Socket status: 30000020
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
PM: Adding info for No Bus:i2c-0
pccard: PCMCIA card inserted into slot 0
pccard: CardBus card inserted into slot 1
PM: Adding info for pci:0000:05:00.0
input: PC Speaker as /class/input/input1
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:10' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x148a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
cs: IO port probe 0x100-0x3af: excluding 0x220-0x22f 0x388-0x38f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
PCI: Enabling device 0000:05:00.0 (0000 -> 0001)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:05:00.0: 3Com PCI 3c575 Boomerang CardBus at 00011800.
PCI: Setting latency timer of device 0000:05:00.0 to 64
PM: Adding info for No Bus:timer
cs: IO port probe 0x100-0x3af: excluding 0x220-0x22f 0x388-0x38f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
PM: Adding info for pcmcia:0.0
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
pnp: the driver 'cs4232-pnpbios' has been registered
pnp: match found with the PnP device '00:11' and the driver 'cs4232-pnpbios'
CS4232 WSS PnP manual resources are invalid, using auto config
CS4232 WSS PnP configure failed for WSS (out of resources?)
PnP BIOS detection failed for CS4232
pnp: Device 00:11 disabled.
cs4232-pnpbios: probe of 00:11 failed with error -16
pnp: the driver 'cs4232_isapnp' has been registered
CS4232 soundcard not found or device busy
pnp: the driver 'cs4232_isapnp' has been unregistered
pnp: the driver 'cs4232-pnpbios' has been unregistered
pnp: the driver 'cs4232-pnpbios' has been registered
pnp: match found with the PnP device '00:11' and the driver 'cs4232-pnpbios'
PnPBIOS: Unknown tag '0x82', length '6'.
pnp: Device 00:11 activated.
CS4232 WSS PnP manual resources are invalid, using auto config
CS4232 WSS PnP configure failed for WSS (out of resources?)
PnP BIOS detection failed for CS4232
pnp: Device 00:11 disabled.
cs4232-pnpbios: probe of 00:11 failed with error -16
pnp: the driver 'cs4232_isapnp' has been registered
CS4232 soundcard not found or device busy
pnp: the driver 'cs4232_isapnp' has been unregistered
pnp: the driver 'cs4232-pnpbios' has been unregistered
pcmcia: CIS filename is too long
PM: Removing info for No Bus:ttyS1
0.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
EXT3 FS on sda2, internal journal
loop: loaded (max 8 devices)
eth0:  setting half-duplex.
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
eth0: no IPv6 routers present

##### Inserted CD and ran "mount /dev/sr0 /root/cdrom" #####

ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 6 task_state 4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: protocol 6 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ISO 9660 Extensions: Microsoft Joliet Level 3
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ISOFS: changing to secondary root
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)

##### Ran "cp -r /root/cdrom /root/cdrom_copy" #####

ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 59392 bytes trailing data
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x58)
ata2: protocol 5 task_state 3 (dev_stat 0x58)
ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 79872 in
         res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata2: soft resetting port
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2: soft resetting port
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ATA: abnormal status 0xD8 on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs

--------------030906040005040108070401--
