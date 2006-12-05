From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Linux 2.6.19: Libata PATA report (minor detection problem)
Date: Tue, 5 Dec 2006 11:29:30 -0200
Message-ID: <20061205112930.5a4c3aff@tux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_V9q_Q6=EhKg9KjNrjwlsdBT"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:49670 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937550AbWLEN3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Dec 2006 08:29:41 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4129492wxd
        for <linux-ide@vger.kernel.org>; Tue, 05 Dec 2006 05:29:37 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--MP_V9q_Q6=EhKg9KjNrjwlsdBT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

	Hi, I'm testing the 2.6.19 kernel and using the
new experimental PATA driver for AMD/Nvidia. My basic setup:

Linux 2.6.19
Athlon64 3800+
Motherboard Asus A8N-VM
Maxtor DiamondMax 9 80GB -> primary master
HP CD-Writer 8100 -> secondary master
gcc 4.1.1

	I attached the requested info (lspci.txt). Here is what the
kernel says:

pata_amd 0000:00:0d.0: version 0.2.4
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : pata_amd
ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : pata_amd
ata2.00: ATAPI, max MWDMA1
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to MWDMA0
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080L0   YAR4 PQ: 0
ANSI: 5 SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda

	The ata2 is an old cd writer (HP CD-Writer 8100). With old
driver it was correctly identified (the bios also correctly identifies
the CD-Writer). The CD-Writer uses a 40 pin cable (the Maxtor HD uses a
80 pin cable).

	***

	Here's the hdparm -I output:

/dev/sda:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y080L0                          
        Serial Number:      Y2P4VXLE            
        Firmware Revision:  YAR41BW0
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 0 
        Supported: 7 6 5 4 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  160086528
        device size with M = 1024*1024:       78167 MBytes
        device size with M = 1000*1000:       81964 MBytes (81 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific
minimum R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6 Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_VERIFY command
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Advanced Power Management feature set
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

	***

hdparm /dev/sda output:

/dev/sda:
 IO_support   =768 (???)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 9964/255/63, sectors = 160086528, start = 0

	Should I use sdparm?

	Besides the problem with the CD-Writer and the "(???)" above,
everything is working perfectly here. No OOPs, no problems. Thank you.

	Ps: it was very easy to migrate from the old to the new driver.
The only thing I did was:

1) select the correct kernel options in menuconfig
2) make sure I have scsi disk support (important... maybe selecting
PATA driver should auto-select the scsi disk support?)
3) change fstab
4) change lilo.conf

	Ps2: if there's no solution for the above detection problem,
can I disable the cdrom passing a parameter to the kernel? Thanks.

-- 

--MP_V9q_Q6=EhKg9KjNrjwlsdBT
Content-Type: text/plain; name=lspci.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping
00: de 10 f1 02 06 01 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 bf 81 08 e0 e0 01 22 00 11 11 22 30 11 00
50: 23 06 7f 80 03 02 7f 80 00 00 03 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 06 36 05 00
70: 44 44 44 00 d0 09 00 00 11 00 00 00 11 11 88 00
80: 23 99 88 00 1f 00 64 0c 03 00 00 00 7f 00 00 00
90: 70 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 01 01 01 01 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 61 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 00 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 10
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: 66MHz, fast devsel
00: de 10 fa 02 00 01 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 10 00 21 21 14 00 11 11 00 00 03 00 00 00
60: 21 88 13 02 de 8f e1 1f 08 72 4e 10 02 3f 00 20
70: 10 32 54 0a 10 00 00 00 a0 00 00 00 02 00 01 01
80: 00 35 0c 00 00 00 00 00 00 00 50 3f 90 3f 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 01 00 00 00 80 f9 fd 00
e0: 00 00 b9 fe 00 00 00 00 00 fc ff ff 00 00 00 00
f0: 00 00 00 00 c7 02 32 00 00 00 00 00 00 00 00 00

00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: 66MHz, fast devsel
00: de 10 fe 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 bf 81 1f 20 1c a0 1f 20 c0 21 00 00 00 00
50: 51 30 54 c9 01 00 00 00 50 30 53 c9 02 1f 1c 80
60: 02 1f 1c 00 00 00 00 00 02 10 1c a0 02 0c 1c 90
70: 02 10 1c 90 02 14 1c 90 02 0c 1c 80 02 10 1c 80
80: 02 14 1c 80 02 18 1c 80 02 1c 1c 80 01 10 1c 80
90: 02 14 1c 80 11 00 11 00 32 01 00 00 00 00 00 00
a0: c2 00 40 01 10 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 41 23 05 08
c0: fd ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: 66MHz, fast devsel
00: de 10 f8 02 00 01 a0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 bf 81 00 00 00 00 02 10 1c 90 02 10 1c a0
50: 02 0c 1c 90 02 10 1c 90 02 14 1c 90 02 0c 1c 80
60: 02 10 1c 80 02 14 1c 80 02 18 1c 80 02 1c 1c 80
70: 01 10 1c 80 1f 20 c0 81 00 00 00 00 00 00 00 00
80: 00 00 00 00 fb 00 98 96 02 1f 1c 80 70 20 00 00
90: 89 da 01 09 00 00 00 00 11 00 10 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 08 00 00 00 4c 18 00 00 10 00 02 00 00 28 00 28
c0: 80 00 00 00 00 00 00 00 01 01 00 05 00 00 00 00
d0: 00 00 f0 03 00 04 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 60 ea 10 10 18 00 00 20 00 00 00 00 00 00 00 00

00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: bus master, 66MHz, fast devsel, latency 0
00: de 10 f9 02 06 01 a0 00 a2 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: ef dd 7b 2f f7 de 7b 2f f7 de 7b 2f f7 02 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00
70: 0a 00 00 00 03 00 00 00 25 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 05 00 00 00 04 00 00 00
90: 03 04 00 00 01 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] #00 [00fe]
	Capabilities: [fc] #00 [0000]
00: de 10 ff 02 06 01 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 17 00 00 00 00 fe fe 00 00 fe fe 00 00 fe fe 00
50: 00 fe fe 00 00 fe fe 00 00 fe fe 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: 66MHz, fast devsel
00: de 10 7f 02 02 01 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 08 00 00 00 00 00 00 00 00 80 bb fe 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: 66MHz, fast devsel
00: de 10 7e 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 bf 81 11 00 00 00 74 06 00 00 11 00 00 00
50: 74 06 00 00 40 00 60 00 60 60 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 04
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 04
b0: ff ff 03 00 10 11 00 00 ac 10 20 00 30 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [40] #0d [0000]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
00: de 10 fc 02 04 00 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 11 34 11 02
90: 00 00 11 10 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] #0d [0000]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
00: de 10 fd 02 04 00 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 11 34 11 01
90: 00 00 11 10 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] #0d [0000]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
00: de 10 fb 02 04 00 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 01 35 11 00
90: 00 00 01 11 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 VGA compatible controller: nVidia Corporation C51G [GeForce 6100] (rev a2) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Unknown device 81bf
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at fc000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at febe0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: de 10 42 02 07 00 b0 00 a2 00 00 03 00 00 00 00
10: 00 00 00 fd 0c 00 00 d0 00 00 00 00 04 00 00 fc
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 bf 81
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 00 00
40: 43 10 bf 81 00 00 00 00 01 50 02 00 00 00 00 00
50: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 00 00 04 00 00 00 00 00 00 00 01 00 00 00
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 00 00 78 00 00 00 00 04 00 00 00 00 ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping
00: de 10 70 02 06 00 b0 00 a2 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 c0 81 08 e0 e9 01 22 30 00 00 d0 00 00 00
50: 23 02 7f 80 03 00 00 00 00 00 03 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 06 15 05 00
70: 44 44 44 00 d0 09 00 00 11 00 00 00 11 11 55 00
80: 23 55 55 00 fa 00 64 0c 03 00 00 00 7f 00 00 00
90: 70 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 01 01 01 01 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 00 01 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
	Flags: bus master, 66MHz, fast devsel, latency 0
00: de 10 61 02 0f 00 a0 00 a2 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 c0 81 00 00 00 00 fa 3e ff 00 fa 3e ff 00
50: fa 3e ff 00 00 5a 62 02 00 00 00 01 00 00 fe 3b
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 ff
70: 10 00 ff ff c1 00 00 00 00 00 05 19 c6 00 00 04
80: 09 d0 00 00 02 10 00 00 f0 00 00 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 21 47 65 b7 ef cd 00 00
a0: 00 00 10 17 00 00 00 00 95 02 96 02 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
	Flags: 66MHz, fast devsel, IRQ 5
	I/O ports at 0600 [size=64]
	I/O ports at 0700 [size=64]
	Capabilities: [44] Power Management version 2
00: de 10 64 02 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 06 00 00 01 07 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
40: 43 10 c0 81 01 00 02 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 05 00 00 01 08 00 00 01 09 00 00 00 00 00 00
70: 01 00 00 00 00 00 b8 fe 00 00 fe fe 01 20 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: d4 30 80 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 10 04 00 00 a0 90 00 80 34 44 00 41 44 44 11
f0: 5a ff 5f bf 00 00 00 c0 10 00 00 00 00 00 00 00

00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
	Memory at febde000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
00: de 10 6d 02 07 00 b0 00 a2 10 03 0c 00 00 80 00
10: 00 e0 bd fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 43 10 c0 81 01 00 02 fe 00 00 00 00 00 00 00 00
50: 04 00 00 00 1d 47 40 00 10 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a2) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
	Memory at febdfc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2
00: de 10 6e 02 06 00 b0 00 a2 20 03 0c 00 00 80 00
10: 00 fc bd fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 02 03 01
40: 43 10 c0 81 0a 80 98 20 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 01 00 00 60 18 85 03 3c 0a 01 00 00 00 00
70: 00 00 08 05 00 10 20 80 89 3d b6 22 77 25 04 00
80: 01 00 02 fe 00 00 00 00 00 00 00 00 15 16 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 08 80 00 00 00 00 00 00 00 00
b0: 33 00 11 22 00 00 00 00 ff 00 00 00 00 00 00 00
c0: 10 10 2d 0d 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device f043:81c0
	Flags: bus master, 66MHz, fast devsel, latency 0
	I/O ports at ffa0 [size=16]
	Capabilities: [44] Power Management version 2
00: de 10 65 02 05 00 b0 00 a1 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 43 f0 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 43 f0 c0 81 01 00 02 00 00 00 00 00 00 00 00 00
50: 03 f0 09 00 00 00 00 00 a8 22 a8 20 37 00 22 20
60: 00 03 00 c7 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 d0 62 3b 00 00 02 38 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Prefetchable memory behind bridge: bfe00000-bfefffff
	Capabilities: [b8] #0d [0000]
	Capabilities: [8c] HyperTransport: MSI Mapping
00: de 10 6f 02 07 00 b0 00 a2 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 40 d0 d0 80 02
20: f0 ff 00 00 e0 bf e0 bf 00 00 00 00 00 00 00 00
30: 00 00 00 00 b8 00 00 00 00 00 00 00 00 00 02 02
40: 00 00 03 00 01 00 02 00 05 00 00 00 00 00 44 00
50: 00 00 fe 3b 00 00 00 00 ff 1f ff 1f 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 a8
90: 00 00 e0 fe 00 00 00 00 00 00 00 00 00 00 00 00
a0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 ff ff 00 00 0d 8c 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)
	Subsystem: nVidia Corporation Unknown device cb84
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] HyperTransport: MSI Mapping
00: de 10 6c 02 06 00 b0 00 a2 00 03 04 00 00 80 00
10: 00 80 bd fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 02 02 05
40: de 10 84 cb 01 50 02 c0 00 00 00 00 01 01 0f 00
50: 05 6c 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 0f 00 00 00 08 00 02 a8
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 46 00 29 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 0e 0f 3c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 06 75 80 02 00 00 00
90: 69 01 61 01 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 3f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 03 00 e0 00 80 ff ef 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 03 0a 00 00 00 0b 00 00 03 00 40 00 00 0b fe 00
c0: 13 10 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 10 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 ee e0 03 00 ee e0 03 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 04 00 00 00 00 00 00 00 42 35 82 13 31 0b 00 00
90: 80 cc 05 2e 07 87 7b 3e 00 00 00 00 0d 02 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 73 1b ef e2 5b 00 00 00 5f f6 40 10 8e 14 c6 14
c0: 00 80 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 5b 82 00 61 21 41 02 a0 08 08 0a 08 02 49 03 85
e0: a2 90 01 80 90 0a 50 12 0a 30 80 24 b8 f5 22 04
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 00 40 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 c0 9c 85 3b
60: b4 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 22 30 00 50 00 1b 00 08 1f 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 00 00 00 00 e2 53 00 00 30 80 10 a8 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 a7 0d 00 00 00 40 00 00 00 00 00
e0: 00 00 00 00 20 0b 5a 06 19 05 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Flags: medium devsel, IRQ 18
	I/O ports at dc00 [size=32]
00: ec 10 29 80 03 00 00 02 00 00 00 02 00 00 00 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 29 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Flags: bus master, medium devsel, latency 64, IRQ 19
	Memory at bfefe000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
00: 9e 10 6e 03 06 01 90 02 11 00 00 04 00 40 80 00
10: 08 e0 ef bf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 10 28
40: 00 00 00 00 03 4c 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at bfeff000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
00: 9e 10 78 08 06 01 90 02 11 00 80 04 00 40 80 00
10: 08 f0 ef bf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 04 ff
40: 00 00 00 00 03 4c 00 00 00 00 00 00 01 00 22 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--MP_V9q_Q6=EhKg9KjNrjwlsdBT--
