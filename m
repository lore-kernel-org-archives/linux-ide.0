From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: nvidia status
Date: Sun, 12 Mar 2006 12:52:44 +0200
Message-ID: <5d96567b0603120252t2c007d4ay2af62012dec81ab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:36850 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932115AbWCLKwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Mar 2006 05:52:45 -0500
Received: by wproxy.gmail.com with SMTP id i5so1141385wra
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 02:52:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I know Nvidia chipset for sata is well,,,"somewhat problematic".
but why do i fail to write to the disks , while reading is OK.
i keep on getting write errors.
I am using AMD Opetron 248 , my motheboard is SuperMicro
H8DCE.

anyone ?
....
ATA: abnormal status 0xD0 on port 0xB407
ATA: abnormal status 0xD0 on port 0xB407
ata3: command 0x35 timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 328
Buffer I/O error on device sda, logical block 41
lost page write due to I/O error on sda
ATA: abnormal status 0xD0 on port 0xB407
ATA: abnormal status 0xD0 on port 0xB407
ATA: abnormal status 0xD0 on port 0xB407
....
--
Raz
