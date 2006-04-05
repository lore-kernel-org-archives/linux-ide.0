From: Jonathan Blake Benson <airbatica@verizon.net>
Subject: Re: libata machine check on Alpha
Date: Wed, 05 Apr 2006 10:48:16 -0500
Message-ID: <r4p732p2j7rlui8umeqrq9hothsl79n3bo@4ax.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com>
 <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:28035 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751108AbWDEPsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 11:48:09 -0400
Received: from raptor ([71.252.222.131])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IX900D5GAK6E708@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 05 Apr 2006 10:48:06 -0500 (CDT)
In-reply-to: <4431D5F5.4010905@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

On Tue, 04 Apr 2006 10:12:05 +0800, you wrote:

>Tejun Heo wrote:
>> Jonathan Blake Benson wrote:
>> 
>>> I posted a couple of months ago regarding enabling libata.atapi on a
>>> Digital Alpha 164LX, equipped with a Silicon Image 3114 controller.  I
>>> decied to give kernel 2.6.16 (release, was previously using rc-1) a
>>> shot, and it no longer longer panics.  I still have a Lite-ON DVD ROM
>>> drive connected via a sil3611 bridge to port number 4, hoping that I
>>> can avoid using the onboard CMD646.
>>>
>>> No panic this time, though it appears to throw a machine check.  The
>>> system continues all the way to multi-user, and the Maxtor drives are
>>> usable.  Hope the attached dmesg helps.  Let me know if I can be of
>>> any assitance.
>>>
>> 
>> Can you build your kernel with ATA_DEBUG set and post dmesg?  Just
>> change #undef ATA_DEBUG to #define ATA_DEBUG at the top of
>> include/linux/libata.h
>> 
>For the SiI 3611 bridge + ATAPI devices, maybe the ATAPI_ENABLE_DMADIR
>workaround should also be turned on as well. (in linux/libata.h)
>
>My JMicron 20330 bridge + SiI 3112 can handle ATAPI DMA without
>the ATAPI_ENABLE_DMADIR workaround. However, the SiI 3611 bridge seems
>need it.

Albert, enabling the ATAPI_ENABLE_DMADIR workaround did the trick.
The DVD-ROM drive now works as it should.  Thanks again!

Jonathan Benson

libata version 1.20 loaded.
sata_sil 0000:00:09.0: version 0.9
sata_sil 0000:00:09.0: cache line size not set.  Driver may not
function
sata_sil 0000:00:09.0: Applying R_ERR on DMA activate FIS errata fix
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
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c68 86:3a01
87:4003 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01
87:4003 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01
87:4003 88:007f
ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata3(0): applying bridge limits
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000
87:0000 88:0007
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 0 configured for UDMA/33
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: LITE-ON   Model: DVD SOHD-167T     Rev: 9S16
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sr 3:0:0:0: Attached scsi generic sg3 type 5

