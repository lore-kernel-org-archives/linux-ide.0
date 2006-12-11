From: Fernando Faria Mariano <cpd@kachan.com.br>
Subject: Problems with controllers SATA chipset SIS
Date: Mon, 11 Dec 2006 16:00:02 -0200
Message-ID: <1165860002.5304.2.camel@ka029.kachan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fNUg8DqS7LzY3iIk3e4L"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kachan.com.br ([200.247.11.130]:48649 "EHLO kachan.com.br"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937385AbWLKR76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 12:59:58 -0500
Received: from ka029.kachan (aimar [192.169.3.29])
	by kachan.com.br (8.12.11.20060308/8.12.11) with ESMTP id kBBHukYF018330
	for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 15:56:52 -0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-fNUg8DqS7LzY3iIk3e4L
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
I´m using the OS Debian 3.1rc1 and Kernel 2.4.27-2-386, but I need help,
when I execute the backup script´s, the hardware can´t read and writer
in the HDD (30GB) SATA.
 
The backup is accomplished of a disk Sata for another Sata of same model
and  
mark.

 
My hardware are: Attached file_1.txt
 
 
Connecting the disk to the kernel mentioned in the enclosure above, the
system  
it recognized my two disks automatically SATA. The formatting of the
disk was easy without any error message and the writing of small volume
of data (approximately 200MB) it doesn't happen mistake also.
 
The problem is when the backup is accomplished using the command:

tar cvpfz /backup/local/$date/compart-$date.tar.gz /compart/

when the folder compart possesses about 20GB. When the backup is
accomplished  
the following error message is recorded in the log files:  
  
Error messages: Attached file_2.txt  

After that I had downloaded  the most recent kernel in kernel.org in the
version 2.6.18.1.  
I compiled the driver for controlling Sis 964 in the way buit-in and
other  
drivers SIS also as buit-in.

Although the Server has been stableer, in other words, it locks in
some  
days that are being accomplished the backup and no all as it was  
happening with the kernel mentioned in the begin of this e-mail, it is
still generating  
error messages, however different from the previous.  
  
The messages of mistakes are the following ones.  
  
Contained in / var/log/debug. - Attached file_3.txt  
  
Contained in / var/log/kernel.log. - Attached file_4.txt  


Does some special parameter exist to be passed to carry the driver?
 
Thank you.  
Fernando Faria Mariano.

--=-fNUg8DqS7LzY3iIk3e4L
Content-Disposition: attachment; filename=file_1.txt
Content-Type: text/plain; name=file_1.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

My hardware:
Placa MÃ£e: Asus P4S800MX SE
00:00.0 Host bridge Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX Host 11 00 Asustek Computer, Inc. 8113
00:01.0 PCI bridge Silicon Integrated Systems [SiS] 0003 00 00 0000 0000
00:02.0 ISA bridge Silicon Integrated Systems [SiS] SiS964 [MuTIOL Media IO] 36 00 0000 0000
00:02.5 IDE interface Silicon Integrated Systems [SiS] 5513 [IDE] 01 80 Asustek Computer, Inc. 810e
00:04.0 Ethernet controller Silicon Integrated Systems [SiS] SiS900 PCI Fast 
00:05.0 IDE interface Silicon Integrated Systems [SiS] 0181 01 85 Asustek Computer, Inc. 810e
01:00.0 VGA compatible controller Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX/741/M741/760/M760


Disk Sata:

Device: ATA      SAMSUNG HD160JJ/ Version: ZM10
Serial number: 1504J1FL428895

--=-fNUg8DqS7LzY3iIk3e4L
Content-Disposition: attachment; filename=file_2.txt
Content-Type: text/plain; name=file_2.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

ata1: DMA timeout, stat 0x1
ATA: abnormal status 0xDo on port 0xc807
scsi0: error on channel 0, id 0, lun 0, CDB: Read (10) 00 06 67 5f 3f 00 00 48 00
Current sd08:01: sense key medium error
Additional sense indicates Unrecovered read error - auto reallocate failed
I/0 error: dev 08:01, sector 107437824


ata2: DMA timeout, stat 0x1
scsi1: ERROR on channel 0, id0, lun0, CDB: Read (10) 00 00 85 4f cf 00 00 c8 00
Current sd08:11: sense key Medium Error
Additional sense indicates Unrecovered read error - auto reallocate failed
I/0 error: dev 08:11, sector 8736656


ata2: DMA timeout, stat 0x1
scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 06 97 e5 07 00 00 38 00
Current sd08:11: sense key Medium Error
Additional sense indicates Unrecovered read error - auto reallocate failed
I/O error: dev 08:11, sector 110617800



ata2: DMA timeout, stat 0x1
scsi1: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 28 20 4f 00 00 00
Current sd08:11: sense key Medium Error
Additional sense indicates Unrecovered read error - auto reallocate failed
I/O error: dev 08:11, sector 2625552
EXT-fs error (device sd(8,17)): ext3_readdir: directory #163841 contains a hole at offset 0 

--=-fNUg8DqS7LzY3iIk3e4L
Content-Disposition: attachment; filename=file_3.txt
Content-Type: text/plain; name=file_3.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Dec  1 23:39:18 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  1 23:46:17 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 00:49:03 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 00:57:39 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 01:12:47 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 01:48:53 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:26:11 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:28:33 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:48:10 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 03:03:32 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 23:34:15 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  4 08:06:02 localhost kernel: On node 0 totalpages: 229376
Dec  4 08:06:02 localhost kernel:   DMA zone: 4096 pages, LIFO batch:0
Dec  4 08:06:02 localhost kernel:   Normal zone: 225280 pages, LIFO batch:31
Dec  4 08:06:02 localhost kernel: ACPI: RSDP (v000 ACPIAM          ) @ 0x000fb230
Dec  4 08:06:02 localhost kernel: ACPI: RSDT (v001 A M I  OEMRSDT  0x08000504 MS FT 0x00000097) @ 0x3dfc0000
Dec  4 08:06:02 localhost kernel: ACPI: FADT (v002 A M I  OEMFACP  0x08000504 MS FT 0x00000097) @ 0x3dfc0200
Dec  4 08:06:02 localhost kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x08000504 MS FT 0x00000097) @ 0x3dfc0390
Dec  4 08:06:02 localhost kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x08000504 MS FT 0x00000097) @ 0x3dfd0040
Dec  4 08:06:02 localhost kernel: ACPI: DSDT (v001  A0211 A0211032 0x00000032 IN TL 0x02002026) @ 0x00000000
Dec  4 08:06:02 localhost kernel: ACPI: Local APIC address 0xfee00000
Dec  4 08:06:02 localhost kernel: ACPI: IRQ0 used by override.
Dec  4 08:06:02 localhost kernel: ACPI: IRQ2 used by override.
Dec  4 08:06:02 localhost kernel: ACPI: IRQ9 used by override.
Dec  4 08:06:02 localhost kernel: mapped APIC to ffffd000 (fee00000)
Dec  4 08:06:02 localhost kernel: mapped IOAPIC to ffffc000 (fec00000)
Dec  4 08:06:02 localhost kernel: CPU: After generic identify, caps: bfebfbff 00 000000 00000000 00000000 00004400 00000000 00000000
Dec  4 08:06:02 localhost kernel: CPU: After vendor identify, caps: bfebfbff 000 00000 00000000 00000000 00004400 00000000 00000000
Dec  4 08:06:02 localhost kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Dec  4 08:06:02 localhost kernel: PCI: Probing PCI hardware (bus 00)
Dec  4 08:06:02 localhost kernel: Boot video device is 0000:00:0a.0
Dec  4 08:06:02 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0. _PRT]
Dec  4 08:06:02 localhost kernel: Probing IDE interface ide0...
Dec  4 08:06:02 localhost kernel: Probing IDE interface ide1...
Dec  4 08:06:02 localhost kernel: Probing IDE interface ide1...
Dec  4 08:06:02 localhost kernel: libata version 2.00 loaded.
Dec  4 08:06:02 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  4 08:06:02 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  4 08:06:02 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  4 08:06:02 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  4 08:06:02 localhost kernel: PCI: cache line size of 128 is not supported b y device 0000:00:03.3
Dec  4 08:06:13 localhost kernel: eth0: no IPv6 routers present
Dec  4 08:06:51 localhost afpd[4080]: Loading ConfigFile
Dec  4 08:06:51 localhost afpd[4080]: Finished parsing Config File
Dec  4 08:06:57 localhost afpd[4080]: uam: loading (/usr/lib/netatalk/uams_dhx.s o)
Dec  4 08:06:57 localhost afpd[4080]: uam: loading (/usr/lib/netatalk/uams_clrtx t.so)
Dec  4 08:06:57 localhost afpd[4080]: uam: loading (/usr/lib/netatalk/uams_randn um.so)
Dec  5 13:59:53 localhost identd[28113]: started
Dec  7 09:58:20 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:02:29 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:05:41 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:11:14 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:11:26 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:12:56 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:17:06 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:18:16 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:18:57 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:22:57 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 10:47:59 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 12:52:46 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 13:37:53 localhost kernel: sdb: Mode Sense: 00 3a 00 00
Dec  7 14:51:01 localhost identd[27069]: started

--=-fNUg8DqS7LzY3iIk3e4L
Content-Disposition: attachment; filename=file_4.txt
Content-Type: text/plain; name=file_4.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Dec  2 02:26:11 localhost kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Dec  2 02:26:11 localhost kernel: sda: Write Protect is off
Dec  2 02:26:11 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:26:11 localhost kernel: SCSI device sda: drive cache: write back
Dec  2 02:28:32 localhost kernel: ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x700401 action 0x2
Dec  2 02:28:32 localhost kernel: ata1.00: tag 0 cmd 0xc4 Emask 0x12 stat 0x51 err 0x4 (ATA bus error)
Dec  2 02:28:32 localhost kernel: ata1: soft resetting port
Dec  2 02:28:32 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec  2 02:28:32 localhost kernel: ata1.00: configured for PIO4
Dec  2 02:28:32 localhost kernel: ata1: EH complete
Dec  2 02:28:33 localhost kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Dec  2 02:28:33 localhost kernel: sda: Write Protect is off
Dec  2 02:28:33 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:28:33 localhost kernel: SCSI device sda: drive cache: write back
Dec  2 02:48:10 localhost kernel: ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x700401 action 0x2
Dec  2 02:48:10 localhost kernel: ata1.00: tag 0 cmd 0xc4 Emask 0x12 stat 0x51 err 0x4 (ATA bus error)
Dec  2 02:48:10 localhost kernel: ata1: soft resetting port
Dec  2 02:48:10 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec  2 02:48:10 localhost kernel: ata1.00: configured for PIO4
Dec  2 02:48:10 localhost kernel: ata1: EH complete
Dec  2 02:48:10 localhost kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Dec  2 02:48:10 localhost kernel: sda: Write Protect is off
Dec  2 02:48:10 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 02:48:10 localhost kernel: SCSI device sda: drive cache: write back
Dec  2 03:03:31 localhost kernel: ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x700401 action 0x2
Dec  2 03:03:31 localhost kernel: ata1.00: tag 0 cmd 0xc4 Emask 0x12 stat 0x51 err 0x4 (ATA bus error)
Dec  2 03:03:32 localhost kernel: ata1: soft resetting port
Dec  2 03:03:32 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec  2 03:03:32 localhost kernel: ata1.00: configured for PIO4
Dec  2 03:03:32 localhost kernel: ata1: EH complete
Dec  2 03:03:32 localhost kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Dec  2 03:03:32 localhost kernel: sda: Write Protect is off
Dec  2 03:03:32 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec  2 03:03:32 localhost kernel: SCSI device sda: drive cache: write back
Dec  2 23:34:14 localhost kernel: ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x700401 action 0x2

--=-fNUg8DqS7LzY3iIk3e4L--

