From: KueiHuan Chen <khchen@synology.com>
Subject: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
	(Resent)
Date: Wed, 22 Jul 2009 10:10:32 +0800
Message-ID: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:45149 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbZGVCKd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 22:10:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so5287349and.1
        for <linux-ide@vger.kernel.org>; Tue, 21 Jul 2009 19:10:32 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, saeed@marvell.com
Cc: linux-ide@vger.kernel.org

Dear Mark,

  Sorry for the incorrect mail format, so i resent it again.

  Here has a problem when we put the 7042 on the kirkwood
platform(6281). When system starting to build software raid 5,
sometimes it would meet the unable to stop eDMA problem in all
channels.  And then whole system is being hang ...  All the phy mode
value are also not correctly if we read it out at that time.

  Could you please kindly have a look at the error messages and give
some advice for me to find out the root cause ? Thanks.

Thanks again.
-------------
ata4: Unable to stop eDMA
ata4.00: exception Emask 0x52 SAct 0x1f SErr 0xffffffff action 0xe frozen
ata4: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt
PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq
TrStaTrns UnrecFIS DevExch }
ata4.00: cmd 61/e0:00:c7:26:4f/01:00:01:00:00/40 tag 0 ncq 245760 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata4.00: status: { DRDY }
ata4.00: cmd 61/c8:08:cf:22:4f/03:00:01:00:00/40 tag 1 ncq 495616 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata4.00: status: { DRDY }
ata4.00: cmd 61/30:10:97:26:4f/00:00:01:00:00/40 tag 2 ncq 24576 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata4.00: status: { DRDY }
ata4.00: cmd 61/20:18:a7:28:4f/02:00:01:00:00/40 tag 3 ncq 278528 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata4.00: status: { DRDY }
ata4.00: cmd 61/00:20:c7:2a:4f/04:00:01:00:00/40 tag 4 ncq 524288 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata1: Unable to stop eDMA
ata1.00: exception Emask 0x52 SAct 0x1fffff SErr 0xffffffff action 0xe frozen
ata1: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt
PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq
TrStaTrns UnrecFIS DevExch }
ata1.00: cmd 60/00:00:c7:2f:4f/01:00:01:00:00/40 tag 0 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:08:c7:30:4f/01:00:01:00:00/40 tag 1 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:10:c7:31:4f/01:00:01:00:00/40 tag 2 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:18:c7:32:4f/01:00:01:00:00/40 tag 3 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:20:c7:2e:4f/01:00:01:00:00/40 tag 4 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:28:c7:33:4f/01:00:01:00:00/40 tag 5 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:30:c7:34:4f/01:00:01:00:00/40 tag 6 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:38:c7:35:4f/01:00:01:00:00/40 tag 7 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:40:c7:36:4f/01:00:01:00:00/40 tag 8 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:48:c7:37:4f/01:00:01:00:00/40 tag 9 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:50:c7:38:4f/01:00:01:00:00/40 tag 10 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:58:c7:39:4f/01:00:01:00:00/40 tag 11 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:60:c7:3a:4f/01:00:01:00:00/40 tag 12 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:68:c7:3b:4f/01:00:01:00:00/40 tag 13 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:70:c7:3c:4f/01:00:01:00:00/40 tag 14 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:78:c7:3d:4f/01:00:01:00:00/40 tag 15 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:80:c7:3e:4f/01:00:01:00:00/40 tag 16 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:88:c7:3f:4f/01:00:01:00:00/40 tag 17 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:90:c7:40:4f/01:00:01:00:00/40 tag 18 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/00:98:c7:41:4f/01:00:01:00:00/40 tag 19 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 60/08:a0:c7:42:4f/00:00:01:00:00/40 tag 20 ncq 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata2: Unable to stop eDMA
ata2.00: exception Emask 0x52 SAct 0x1fffff SErr 0xffffffff action 0xe frozen
ata2: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt
PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq
TrStaTrns UnrecFIS DevExch }
ata2.00: cmd 60/00:00:c7:2f:4f/01:00:01:00:00/40 tag 0 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:08:c7:30:4f/01:00:01:00:00/40 tag 1 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:10:c7:31:4f/01:00:01:00:00/40 tag 2 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:18:c7:32:4f/01:00:01:00:00/40 tag 3 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:20:c7:2e:4f/01:00:01:00:00/40 tag 4 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:28:c7:33:4f/01:00:01:00:00/40 tag 5 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:30:c7:34:4f/01:00:01:00:00/40 tag 6 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:38:c7:35:4f/01:00:01:00:00/40 tag 7 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:40:c7:36:4f/01:00:01:00:00/40 tag 8 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:48:c7:37:4f/01:00:01:00:00/40 tag 9 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:50:c7:38:4f/01:00:01:00:00/40 tag 10 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:58:c7:39:4f/01:00:01:00:00/40 tag 11 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:60:c7:3a:4f/01:00:01:00:00/40 tag 12 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:68:c7:3b:4f/01:00:01:00:00/40 tag 13 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:70:c7:3c:4f/01:00:01:00:00/40 tag 14 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:78:c7:3d:4f/01:00:01:00:00/40 tag 15 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:80:c7:3e:4f/01:00:01:00:00/40 tag 16 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:88:c7:3f:4f/01:00:01:00:00/40 tag 17 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:90:c7:40:4f/01:00:01:00:00/40 tag 18 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/00:98:c7:41:4f/01:00:01:00:00/40 tag 19 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2.00: cmd 60/08:a0:c7:42:4f/00:00:01:00:00/40 tag 20 ncq 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata3: Unable to stop eDMA
ata3.00: exception Emask 0x52 SAct 0x1fffff SErr 0xffffffff action 0xe frozen
ata3: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt
PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq
TrStaTrns UnrecFIS DevExch }
ata3.00: cmd 60/00:00:c7:2f:4f/01:00:01:00:00/40 tag 0 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:08:c7:30:4f/01:00:01:00:00/40 tag 1 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:10:c7:31:4f/01:00:01:00:00/40 tag 2 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:18:c7:32:4f/01:00:01:00:00/40 tag 3 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:20:c7:2e:4f/01:00:01:00:00/40 tag 4 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:28:c7:33:4f/01:00:01:00:00/40 tag 5 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:30:c7:34:4f/01:00:01:00:00/40 tag 6 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:38:c7:35:4f/01:00:01:00:00/40 tag 7 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:40:c7:36:4f/01:00:01:00:00/40 tag 8 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:48:c7:37:4f/01:00:01:00:00/40 tag 9 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:50:c7:38:4f/01:00:01:00:00/40 tag 10 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:58:c7:39:4f/01:00:01:00:00/40 tag 11 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:60:c7:3a:4f/01:00:01:00:00/40 tag 12 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:68:c7:3b:4f/01:00:01:00:00/40 tag 13 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:70:c7:3c:4f/01:00:01:00:00/40 tag 14 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:78:c7:3d:4f/01:00:01:00:00/40 tag 15 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:80:c7:3e:4f/01:00:01:00:00/40 tag 16 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:88:c7:3f:4f/01:00:01:00:00/40 tag 17 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:90:c7:40:4f/01:00:01:00:00/40 tag 18 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/00:98:c7:41:4f/01:00:01:00:00/40 tag 19 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3.00: cmd 60/08:a0:c7:42:4f/00:00:01:00:00/40 tag 20 ncq 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
ata3.00: status: { DRDY }
ata3: hard resetting link

Best Regards,
KueiHuan-Chen
