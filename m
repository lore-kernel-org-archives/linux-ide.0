From: Vlad Codrea <vladcodrea@mail.utexas.edu>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Sun, 18 Mar 2007 23:58:24 -0600
Message-ID: <45FE2680.9050702@mail.utexas.edu>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu> <45FAC6FC.4020105@tw.ibm.com> <45FADD53.5030500@mail.utexas.edu> <45FB71EA.7070602@tw.ibm.com> <45FC952C.1040708@mail.utexas.edu> <45FD1B35.2090607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040507020804070807000201"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironman.mail.utexas.edu ([128.83.32.51]:10279 "EHLO
	ironman.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965650AbXCSF6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 01:58:36 -0400
In-Reply-To: <45FD1B35.2090607@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040507020804070807000201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:

>This is the first problem.
>It's weird to see HSM violation here, without any debug task_state trace.
>In your previous log, it was detected correctly with debug task_state trace.
>
>ata2.00: ATAPI, max MWDMA2, CDB intr
>ata2.00: configured for MWDMA2
>PM: Adding info for No Bus:target0:0:0
>scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
>PM: Adding info for scsi:0:0:0:0
>PM: Adding info for No Bus:target1:0:0
>ata2: protocol 5 task_state 4
>ata2: protocol 5 task_state 4 (dev_stat 0x58)
>ata2: protocol 5 task_state 1
>ata2: protocol 5 task_state 1 (dev_stat 0x58)
>ata2: protocol 5 task_state 2
>ata2: protocol 5 task_state 2 (dev_stat 0x50)
>scsi 1:0:0:0: CD-ROM            TORiSAN  DVD-ROM DRD-N216 1.08 PQ: 0 ANSI: 5
>
>  
>

The first problem shouldn't be there -- I accidentaly copied the top 
portion (before the mount command) from an old dmesg where the DMA was 
still enabled. Sorry about that.

>>ata2.00: 63488 bytes trailing data
>>ata2: protocol 5 task_state 1
>>ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>ata2.00: 63488 bytes trailing data
>>ata2: protocol 5 task_state 1
>>ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>ata2.00: 63488 bytes trailing data
>>ata2: protocol 5 task_state 1
>>ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>ata2.00: 63488 bytes trailing data
>>ata2: protocol 5 task_state 1
>>ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>ata2.00: 63488 bytes trailing data
>>ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
>>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 124928 in
>>         res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x6 (timeout)
>>ata2: soft resetting port
>>ata2: port is slow to respond, please be patient (Status 0xd8)
>>ata2: port failed to respond (30 secs, Status 0xd8)
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ata2.00: qc timeout (cmd 0xa1)
>>ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>ata2.00: revalidation failed (errno=-5)
>>ata2: failed to recover some devices, retrying in 5 secs
>>ata2: port is slow to respond, please be patient (Status 0xd8)
>>ata2: port failed to respond (30 secs, Status 0xd8)
>>ata2: soft resetting port
>>ata2: port is slow to respond, please be patient (Status 0xd8)
>>ata2: port failed to respond (30 secs, Status 0xd8)
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ATA: abnormal status 0xD8 on port 0x177
>>ata2.00: qc timeout (cmd 0xa1)
>>    
>>
>
>This is the second problem. The device firmware/state machine stopped
>working suddenly. The INTRQ was not cleared even after the device status
>register was read. And the device status was struck to 0x58.
>Let the device transfer the trailing data without limitation didn't help.
>
>Vlad, could you please apply the attached debug patch. The patch
>1. adds your TORiSAM drive to the DMA blacklist
>   (so, we don't need to the check_atapi_dma() change this time)
>2. adds more debug trace
>
>  
>

I have attached the dmesg generated after applying this patch.

>For the 2nd problem, could you please try change the medium and copy
>the data from another known to be good CD? It might be the medium that
>caused the device firmware malfunction.
>  
>

I have switched mediums to another pressed CD that I know works on my 
other computer and on this laptop when it is booted in Windows 98.

Thank you,
Vlad

--------------040507020804070807000201
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

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
  Magic number: 15:221:178
  hash matches device platform
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 256k freed
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
ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/33
scsi1 : ata_piix
PM: Adding info for No Bus:host1
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ata2: protocol 2 task_state 1 (dev_stat 0x58)
ata2: protocol 2 task_state 2 (dev_stat 0x50)
ata2.00: ATAPI, max MWDMA2, CDB intr
ata2.00: device is on DMA blacklist, disabling DMA
ata2: protocol 1 task_state 2
ata2: host_stat 0x4
ata2: protocol 1 task_state 2 (dev_stat 0x50)
ata2: protocol 2 task_state 1 (dev_stat 0x58)
ata2: protocol 2 task_state 2 (dev_stat 0x50)
ata2.00: configured for PIO4
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
PM: Adding info for No Bus:target1:0:0
CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
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
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x0
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
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
pccard: PCMCIA card inserted into slot 0
input: PC Speaker as /class/input/input1
pccard: CardBus card inserted into slot 1
PM: Adding info for pci:0000:05:00.0
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
PM: Adding info for No Bus:i2c-0
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x148a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:10' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 80
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 12 01 00 00 fe 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
PCI: Enabling device 0000:05:00.0 (0000 -> 0001)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:05:00.0: 3Com PCI 3c575 Boomerang CardBus at 00011800.
PCI: Setting latency timer of device 0000:05:00.0 to 64
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x0
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 12 01 00 00 fe 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
cs: IO port probe 0x100-0x3af: excluding 0x220-0x22f 0x388-0x38f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
PM: Adding info for pcmcia:0.0
cs: IO port probe 0x100-0x3af: excluding 0x220-0x22f 0x388-0x38f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
PM: Adding info for No Bus:timer
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
pcmcia: CIS filename is too long
PM: Removing info for No Bus:ttyS1
0.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PM: Adding info for No Bus:ttyS1
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

CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x51)
ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 02 00 00 00 00 01 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 01 00 0c
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 00 00 00 00 00 20
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 01 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 00 00 00 00 40
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x0
ata2: protocol 5 task_state 1
ata2: host_stat 0x0
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)

##### Ran "cp -r /root/cdrom /root/cdrom_copy" #####

CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 02 00 00 00 00 01 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 01 00 0c
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 00 00 00 00 00 20
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 00 00 00 00 40
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 02 00 00 00 00 01 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 01 00 0c
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 00 00 00 00 00 20
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 28 00 00 00 00 10
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 20 00 00 00 00 18
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 00 00 00 00 00 00 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 43 02 00 00 00 00 01 00 0c
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 01 00 0c
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 46 00 00 00 00 00 00 00 20
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x51)
ata2: protocol 5 task_state 2 (dev_stat 0x51)
ata2: protocol 5 task_state 3 (dev_stat 0x51)
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 00
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 00 00 00 00 00 00 00 00 20
ata2: protocol 6 task_state 4
ata2: host_stat 0x4
ata2: protocol 6 task_state 4 (dev_stat 0x58)
ata2: protocol 6 task_state 2
ata2: host_stat 0x4
ata2: protocol 6 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 00 10 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 00 11 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 00 12 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ISO 9660 Extensions: Microsoft Joliet Level 3
CDB (2:0,0,0) 28 00 00 00 04 e8 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
ISOFS: changing to secondary root
CDB (2:0,0,0) 28 00 00 00 02 f7 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 02 f8 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 02 ff 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 03 00 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e4 09 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x0
ata2: protocol 5 task_state 1
ata2: host_stat 0x0
ata2: protocol 5 task_state 1
ata2: host_stat 0x0
ata2: protocol 5 task_state 1
ata2: host_stat 0x0

-- snip --

ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 09 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 0a 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 0b 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 0c 00 00 35
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 41 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 42 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 43 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 44 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 45 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 46 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 47 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 48 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 49 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 4a 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 4b 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 4c 00 00 03
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 4f 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 50 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 51 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 52 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 53 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 54 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 55 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 56 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 57 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 58 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 59 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 5a 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 5b 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 5c 00 00 2b
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 87 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 88 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 89 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8a 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8b 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8c 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8d 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8e 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 8f 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 90 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 91 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 92 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 93 00 00 34
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 c7 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 c8 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 c9 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 ca 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 cb 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 cc 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 cd 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 ce 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 cf 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 d0 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 d1 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 d2 00 00 01
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)
CDB (2:0,0,0) 28 00 00 00 e5 d3 00 00 34
ata2: protocol 5 task_state 4
ata2: host_stat 0x4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x50)
ata2: protocol 5 task_state 2 (dev_stat 0x50)

-- snip --

ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2: protocol 5 task_state 1
ata2: host_stat 0x4
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2.00: 63488 bytes trailing data
ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 114688 in
         res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x6 (timeout)
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

--------------040507020804070807000201--
