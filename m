From: Pauli Borodulin <boro@fixel.org>
Subject: libata's sil-driver
Date: Tue, 25 May 2004 17:48:23 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40B35CB7.1090902@fixel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from htklx2.htk.fi ([195.156.245.118]:49623 "EHLO htklx2.htk.fi")
	by vger.kernel.org with ESMTP id S264959AbUEYOsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 May 2004 10:48:16 -0400
Received: from fixel.org (f69b.pappila.ton.tut.fi [193.166.85.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htklx2.htk.fi (Postfix) with ESMTP id 31D5E7D7B
	for <linux-ide@vger.kernel.org>; Tue, 25 May 2004 17:48:10 +0300 (EEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I recently upgraded my kernel from 2.4.25 to 2.6.6 and started using
libata. I used siimage.c with 2.4 and it worked fine enough with this
patch applied:
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/b=
roken-out/ide-siimage-seagate.patch

Now with 2.6.6 and libata, all things don't seem to work that well. I
use couple of Maxtor's 120GB SATA-disks (6Y120M0) in software raid
configuration (mirroring) with Silicon Image's SIL3112. Hdparm seems to
indicate correct performance for the disks, but writing to the disks is
slow and makes my system sluggerish. Good example is running bonnie++
(bonnie++ -u nobody -d /archive/tmp -s 1024 -n 0) to test the speed of
my raid. Bonnie++ writing its test file (putc part) is really slow,
something like 1MB/s. If I press ctrl-c, it takes a short while to end,
and while that ps reports bonnie++'s status as "D" (uninterruptible
sleep). Also kjournald seems to be as "D". Intelligently writing part
works faster (higher MB/s), but system remains quite slow thru' the
whole test. I also tried copying files to my raid with cp and it's the
same 1MB/s.

I noticed the bad performance first after booting my system to 2.6.6: m=
y
raid mirror was in unsync and md started recovering it in the backgroun=
d
-- highest speed I saw while watching /proc/mdstat was about 1MB/s and =
I
had hard time trying to do anything. With 120GB disks, I had no other
choice than cancel it. Reading from the disks seems to work better, cat
really-big-file > /dev/null doesn't disturb other activity and works as
quickly as it should.

I did try changing the disks behind a HPT374 with serial ata bridges an=
d
I reached about 17MB/s speed without any interference. I assume there's
something wrong with libata's 3112/3114-support. Any ideas how to fix
this would be good.

Here's libata's output from dmesg:

libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xE0826080 ctl 0xE082608A bmdma 0xE0826000
irq 18
ata2: SATA max UDMA/100 cmd 0xE08260C0 ctl 0xE08260CA bmdma 0xE0826008
irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
    Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 1.02
    Type:   Direct-Access                      ANSI SCSI revision: 05
    Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 1.02
    Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write through
   /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write through
   /dev/scsi/host1/bus0/target0/lun0: p1 p2


Regards,
--=20
=2E------------------------------------------ -
| Pauli Borodulin       | snail.                 .
| email. boro@fixel.org | Haukkam=E4enkatu 1 F 69  | boro@ircnet
| gsm. +358 44 5555381  | 33560 Tampere, Finland | http://boro.fixel.or=
g
'------------------------------------------------------------------ -- =
-


