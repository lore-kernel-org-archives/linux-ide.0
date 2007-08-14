From: babl <babl1986@gmail.com>
Subject: look at this log!!!
Date: Tue, 14 Aug 2007 22:59:33 +0400
Message-ID: <200708142259.34215.babl1986@gmail.com>
Reply-To: babl1986@gmail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:61877 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765013AbXHNS7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 14:59:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so753897nfb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 11:59:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

6 HDD's with device arror and ATA BUS ERROR!! 

nforce4 sli: sata_nv + sil3114, 

Power: 700W FSP Epsilon
+3.3V:     +3.28 V
+5V:       +4.89 V
+12V:     +12.16 V


libata or ... ?

Aug 14 20:51:08 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x580000 action 0x2 frozen
Aug 14 20:51:08 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 20:51:08 bobr kernel: ata2.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 
0x0 (timeout)
Aug 14 20:51:08 bobr kernel: ata2: port is slow to respond, please be patient
Aug 14 20:51:08 bobr kernel: ata2: port failed to respond (30 secs)
Aug 14 20:51:08 bobr kernel: ata2: soft resetting port
Aug 14 20:51:08 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 20:51:08 bobr kernel: ata2.00: configured for UDMA/133
Aug 14 20:51:08 bobr kernel: ata2: EH complete
Aug 14 20:51:08 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 20:51:08 bobr kernel: sdb: Write Protect is off
Aug 14 20:51:09 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 20:51:09 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: sda: Write Protect is off
Aug 14 22:13:36 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:13:36 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:13:36 bobr kernel: sda: Write Protect is off
Aug 14 22:13:36 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:13:36 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:13:36 bobr kernel: sda: Write Protect is off
Aug 14 22:13:36 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:13:36 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:13:36 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:13:36 bobr kernel: sda: Write Protect is off
Aug 14 22:13:36 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:13:36 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:13:36 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:13:36 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:13:36 bobr kernel: ata1: EH complete
Aug 14 22:13:36 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:13:36 bobr kernel: sda: Write Protect is off
Aug 14 22:13:36 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:13:36 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:18:42 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:42 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:42 bobr kernel: ata2: EH complete
Aug 14 22:18:42 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:42 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:42 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:42 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:42 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:42 bobr kernel: ata2: EH complete
Aug 14 22:18:42 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:18:42 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:42 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:42 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:42 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:42 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:42 bobr kernel: ata2: EH complete
Aug 14 22:18:42 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:18:42 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:42 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:42 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:42 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:42 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:42 bobr kernel: ata2: EH complete
Aug 14 22:18:42 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:18:42 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:42 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:42 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:43 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:43 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:43 bobr kernel: ata2: EH complete
Aug 14 22:18:43 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:18:43 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:43 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:43 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:43 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:18:43 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:18:43 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:18:43 bobr kernel: ata2: EH complete
Aug 14 22:18:43 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:18:43 bobr kernel: sdb: Write Protect is off
Aug 14 22:18:43 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:18:43 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:22:12 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:22:12 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:22:12 bobr kernel: ata2: EH complete
Aug 14 22:22:12 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:22:12 bobr kernel: sdb: Write Protect is off
Aug 14 22:22:12 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:22:12 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:22:12 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:22:12 bobr kernel: ata2: EH complete
Aug 14 22:22:12 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:22:12 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:22:12 bobr kernel: sdb: Write Protect is off
Aug 14 22:22:12 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:22:12 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:22:12 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:22:12 bobr kernel: ata2: EH complete
Aug 14 22:22:12 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:22:12 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:22:12 bobr kernel: sdb: Write Protect is off
Aug 14 22:22:12 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:22:12 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:22:12 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:22:12 bobr kernel: ata2: EH complete
Aug 14 22:22:12 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:22:12 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:22:12 bobr kernel: sdb: Write Protect is off
Aug 14 22:22:12 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:22:12 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:25:42 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:42 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:42 bobr kernel: ata1: EH complete
Aug 14 22:25:42 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:42 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:42 bobr kernel: ata1: EH complete
Aug 14 22:25:42 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:42 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:42 bobr kernel: ata1: EH complete
Aug 14 22:25:42 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:42 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:42 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:42 bobr kernel: ata1: EH complete
Aug 14 22:25:42 bobr kernel: sda: Write Protect is off
Aug 14 22:25:42 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:25:43 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:25:43 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:43 bobr kernel: sda: Write Protect is off
Aug 14 22:25:43 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:25:43 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:25:46 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:46 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:46 bobr kernel: ata1: EH complete
Aug 14 22:25:46 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:46 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:46 bobr kernel: ata1: EH complete
Aug 14 22:25:46 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:46 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:46 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:46 bobr kernel: ata1: EH complete
Aug 14 22:25:46 bobr kernel: sda: Write Protect is off
Aug 14 22:25:46 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:25:46 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:25:46 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:46 bobr kernel: ata1: EH complete
Aug 14 22:25:46 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:25:46 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:46 bobr kernel: sda: Write Protect is off
Aug 14 22:25:46 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:25:46 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:25:50 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:50 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:50 bobr kernel: ata2: EH complete
Aug 14 22:25:50 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:50 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:50 bobr kernel: ata2: EH complete
Aug 14 22:25:50 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:25:50 bobr kernel: sdb: Write Protect is off
Aug 14 22:25:50 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:25:50 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:25:50 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:50 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:50 bobr kernel: ata2: EH complete
Aug 14 22:25:50 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:25:50 bobr kernel: sdb: Write Protect is off
Aug 14 22:25:50 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:25:50 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:25:50 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:50 bobr kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:50 bobr kernel: ata2: EH complete
Aug 14 22:25:50 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:25:51 bobr kernel: sdb: Write Protect is off
Aug 14 22:25:51 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:25:51 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:25:51 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:25:51 bobr kernel: sdb: Write Protect is off
Aug 14 22:25:51 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:25:51 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:25:56 bobr kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:56 bobr kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:56 bobr kernel: ata3: EH complete
Aug 14 22:25:56 bobr kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:56 bobr kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:56 bobr kernel: ata3: EH complete
Aug 14 22:25:56 bobr kernel: SCSI device sdc: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:56 bobr kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:56 bobr kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:56 bobr kernel: ata3: EH complete
Aug 14 22:25:57 bobr kernel: sdc: Write Protect is off
Aug 14 22:25:57 bobr kernel: sdc: Mode Sense: 00 3a 00 00
Aug 14 22:25:57 bobr kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x0
Aug 14 22:25:57 bobr kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:25:57 bobr kernel: ata3: EH complete
Aug 14 22:25:57 bobr kernel: SCSI device sdc: drive cache: write back
Aug 14 22:25:57 bobr kernel: SCSI device sdc: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:25:57 bobr kernel: sdc: Write Protect is off
Aug 14 22:25:57 bobr kernel: sdc: Mode Sense: 00 3a 00 00
Aug 14 22:25:57 bobr kernel: SCSI device sdc: drive cache: write back
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: sda: Write Protect is off
Aug 14 22:26:05 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:26:05 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:05 bobr kernel: sda: Write Protect is off
Aug 14 22:26:05 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:26:05 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: sda: Write Protect is off
Aug 14 22:26:05 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:26:05 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:26:05 bobr kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:05 bobr kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:05 bobr kernel: ata1: EH complete
Aug 14 22:26:05 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:05 bobr kernel: sda: Write Protect is off
Aug 14 22:26:05 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:26:05 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:26:05 bobr kernel: SCSI device sda: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:05 bobr kernel: sda: Write Protect is off
Aug 14 22:26:05 bobr kernel: sda: Mode Sense: 00 3a 00 00
Aug 14 22:26:05 bobr kernel: SCSI device sda: drive cache: write back
Aug 14 22:26:13 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:13 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:13 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:14 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:14 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: SCSI device sde: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:14 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:14 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:14 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: sde: Write Protect is off
Aug 14 22:26:14 bobr kernel: sde: Mode Sense: 00 3a 00 00
Aug 14 22:26:14 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:14 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:14 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: SCSI device sde: drive cache: write back
Aug 14 22:26:14 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:14 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:14 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:14 bobr kernel: ata5.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:14 bobr kernel: ata5: EH complete
Aug 14 22:26:14 bobr kernel: SCSI device sde: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:14 bobr kernel: sde: Write Protect is off
Aug 14 22:26:14 bobr kernel: sde: Mode Sense: 00 3a 00 00
Aug 14 22:26:14 bobr kernel: SCSI device sde: drive cache: write back
Aug 14 22:26:14 bobr kernel: SCSI device sde: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:14 bobr kernel: sde: Write Protect is off
Aug 14 22:26:14 bobr kernel: sde: Mode Sense: 00 3a 00 00
Aug 14 22:26:14 bobr kernel: SCSI device sde: drive cache: write back
Aug 14 22:26:27 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:27 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:27 bobr kernel: ata7: EH complete
Aug 14 22:26:27 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:27 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:27 bobr kernel: ata7: EH complete
Aug 14 22:26:27 bobr kernel: SCSI device sdg: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:27 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:27 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:27 bobr kernel: ata7: EH complete
Aug 14 22:26:27 bobr kernel: sdg: Write Protect is off
Aug 14 22:26:27 bobr kernel: sdg: Mode Sense: 00 3a 00 00
Aug 14 22:26:27 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:27 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:27 bobr kernel: ata7: EH complete
Aug 14 22:26:27 bobr kernel: SCSI device sdg: drive cache: write back
Aug 14 22:26:28 bobr kernel: SCSI device sdg: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:28 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:28 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:28 bobr kernel: ata7: EH complete
Aug 14 22:26:28 bobr kernel: sdg: Write Protect is off
Aug 14 22:26:28 bobr kernel: sdg: Mode Sense: 00 3a 00 00
Aug 14 22:26:28 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:28 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:28 bobr kernel: ata7: EH complete
Aug 14 22:26:28 bobr kernel: SCSI device sdg: drive cache: write back
Aug 14 22:26:28 bobr kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x0
Aug 14 22:26:28 bobr kernel: ata7.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 
0x4 (device error)
Aug 14 22:26:28 bobr kernel: ata7: EH complete
Aug 14 22:26:28 bobr kernel: SCSI device sdg: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:28 bobr kernel: sdg: Write Protect is off
Aug 14 22:26:28 bobr kernel: sdg: Mode Sense: 00 3a 00 00
Aug 14 22:26:28 bobr kernel: SCSI device sdg: drive cache: write back
Aug 14 22:26:28 bobr kernel: SCSI device sdg: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 14 22:26:28 bobr kernel: sdg: Write Protect is off
Aug 14 22:26:28 bobr kernel: sdg: Mode Sense: 00 3a 00 00
Aug 14 22:26:28 bobr kernel: SCSI device sdg: drive cache: write back
Aug 14 22:50:32 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2
Aug 14 22:50:32 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:32 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:32 bobr kernel: ata2: soft resetting port
Aug 14 22:50:33 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:33 bobr kernel: ata2.00: configured for UDMA/133
Aug 14 22:50:33 bobr kernel: ata2: EH complete
Aug 14 22:50:33 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:33 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:33 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:34 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:34 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x380000 action 0x2
Aug 14 22:50:34 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:34 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:34 bobr kernel: ata2: soft resetting port
Aug 14 22:50:34 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:34 bobr kernel: ata2.00: configured for UDMA/133
Aug 14 22:50:34 bobr kernel: ata2: EH complete
Aug 14 22:50:34 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:34 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:34 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:34 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:34 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2
Aug 14 22:50:34 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:34 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:35 bobr kernel: ata2: soft resetting port
Aug 14 22:50:35 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:35 bobr kernel: ata2.00: configured for UDMA/133
Aug 14 22:50:35 bobr kernel: ata2: EH complete
Aug 14 22:50:35 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:35 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:35 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:35 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:36 bobr kernel: ata2.00: limiting speed to UDMA/100
Aug 14 22:50:37 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x380000 action 0x2
Aug 14 22:50:37 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:37 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:37 bobr kernel: ata2: soft resetting port
Aug 14 22:50:37 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:37 bobr kernel: ata2.00: configured for UDMA/100
Aug 14 22:50:37 bobr kernel: ata2: EH complete
Aug 14 22:50:37 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:37 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:37 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:37 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:38 bobr kernel: ata2.00: limiting speed to UDMA/66
Aug 14 22:50:38 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2
Aug 14 22:50:38 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:38 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:38 bobr kernel: ata2: soft resetting port
Aug 14 22:50:38 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:38 bobr kernel: ata2.00: configured for UDMA/66
Aug 14 22:50:39 bobr kernel: ata2: EH complete
Aug 14 22:50:39 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:39 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:39 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:39 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:39 bobr kernel: ata2.00: limiting speed to UDMA/44
Aug 14 22:50:40 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2
Aug 14 22:50:40 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:40 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:40 bobr kernel: ata2: soft resetting port
Aug 14 22:50:40 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:40 bobr kernel: ata2.00: configured for UDMA/44
Aug 14 22:50:40 bobr kernel: ata2: EH complete
Aug 14 22:50:40 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:40 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:40 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:40 bobr kernel: SCSI device sdb: drive cache: write back
Aug 14 22:50:41 bobr kernel: ata2.00: limiting speed to UDMA/33
Aug 14 22:50:42 bobr kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2
Aug 14 22:50:42 bobr kernel: ata2.00: (BMDMA stat 0x20)
Aug 14 22:50:42 bobr kernel: ata2.00: tag 0 cmd 0x25 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 14 22:50:42 bobr kernel: ata2: soft resetting port
Aug 14 22:50:42 bobr kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Aug 14 22:50:42 bobr kernel: ata2.00: configured for UDMA/33
Aug 14 22:50:42 bobr kernel: ata2: EH complete
Aug 14 22:50:42 bobr kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Aug 14 22:50:42 bobr kernel: sdb: Write Protect is off
Aug 14 22:50:42 bobr kernel: sdb: Mode Sense: 00 3a 00 00
Aug 14 22:50:42 bobr kernel: SCSI device sdb: drive cache: write back
