From: Jonathan Blake Benson <airbatica@verizon.net>
Subject: libata ATAPI on Alpha
Date: Sat, 04 Feb 2006 11:38:43 -0600
Message-ID: <n3p9u1p5tsuev6h5ggei5tl5a95dpe6i03@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms040pub.verizon.net ([206.46.252.40]:2047 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932534AbWBDRg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Feb 2006 12:36:28 -0500
Received: from thunder ([71.252.239.182])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IU6004ZMBKS77G4@vms040.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sat, 04 Feb 2006 11:36:28 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've encountered the following problem when enabling libata.atapi on a
Digital Alpha 164LX.

I'm using a Sil3114 SATA controller, in a 32 bit PCI slot.  All drives
are connected with bridges based on the Sil3611 chipset.  Kernel
version is 2.6.16-rc1. Ports 1-3 are Maxtor 120GB hard drives.  The
device connected on port 4 is a Lite-On DVD-ROM drive.

Let me know if I need to provide more information.

Thanks,
Jonathan Benson




sata_sil 0000:00:09.0: cache line size not set.  Driver may not
function
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/100 cmd 0xFFFFFC88093C1080 ctl 0xFFFFFC88093C108A
bmdma 0xFF
FFFC88093C1000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFFC88093C10C0 ctl 0xFFFFFC88093C10CA
bmdma 0xFF
FFFC88093C1008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFFC88093C1280 ctl 0xFFFFFC88093C128A
bmdma 0xFF
FFFC88093C1200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFFC88093C12C0 ctl 0xFFFFFC88093C12CA
bmdma 0xFF
FFFC88093C1208 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata3(0): applying bridge limits
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 0 configured for UDMA/33
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
Unable to handle kernel paging request at virtual address
0000000000000010
scsi_eh_3(735): Oops 0
pc = [<fffffc0000316158>]  ra = [<fffffc000031de74>]  ps = 0007    Not
tainted
pc is at process_mcheck_info+0x58/0x370
ra is at cia_machine_check+0x94/0xb0
v0 = 0000000000000001  t0 = 0000000000000670  t1 = 0000000000000660
t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000000000
t5 = 0000000000000000  t6 = 0000000000000001  t7 = fffffc001fcfc000
s0 = 0000000000000000  s1 = fffffc001fcff990  s2 = fffffc001f83c950
s3 = 0000000000000000  s4 = 0000000000000000  s5 = 0000008740000000
s6 = aa00000000000103
a0 = fffffc00005d5200  a1 = fffffc00005cec79  a2 = fffffc001fcff990
a3 = fffffc00004ffda8  a4 = 0000000000000000  a5 = 0000000000000000
t8 = 000000000000001f  t9 = 000000000008526b  t10= 0000000000000000
t11= 0000000000000000  pv = fffffc0000316100  at = 0000000000000000
gp = fffffc00006d5200  sp = fffffc001fcff950
Trace:
[<fffffc000031de74>] cia_machine_check+0x94/0xb0
[<fffffc00003160c4>] do_entInt+0x134/0x170
[<fffffc0000311210>] ret_from_sys_call+0x0/0x10
[<fffffc0000502f08>] ata_eng_timeout+0x168/0x1c0
[<fffffc00004ffda8>] ata_altstatus+0x58/0x90
[<fffffc0000502f08>] ata_eng_timeout+0x168/0x1c0
[<fffffc0000507fb8>] ata_scsi_error+0x28/0x60
[<fffffc00004f6af0>] scsi_error_handler+0x0/0xb50
[<fffffc00004f7028>] scsi_error_handler+0x538/0xb50
[<fffffc000033ecd8>] kthread+0x148/0x1b0
[<fffffc00004f6af0>] scsi_error_handler+0x0/0xb50
[<fffffc00003115c8>] kernel_thread+0x28/0x90
[<fffffc00003115c8>] kernel_thread+0x28/0x90

Code: 383dfa39  23de0020  6bfa8001  2ffe0000  a67200c0  261dfff0
<a2890010> a77d
bdc0
