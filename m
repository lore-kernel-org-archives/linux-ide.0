From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: SATA error while resume
Date: Sun, 19 Aug 2007 11:12:57 +0200
Message-ID: <46C80999.1060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:49937 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbXHSJND (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 05:13:03 -0400
Received: by fk-out-0910.google.com with SMTP id z23so919063fkz
        for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 02:13:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-kernel <linux-kernel@vger.kernel.org>, htejun@gmail.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

Kernel: 2.6.23-rc2 witch patches [1], but older and stable versions also
affected.

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0708.0/2655.html
+ipw3945 and truecrypt.

Sometimes (one in ten, or rarely) I have this error while system resume
from suspend to disk:

=================
swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
swsusp: Basic memory bitmaps created
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Loading image data pages (117687 pages)
...       0%  1%  2%  3%  4%  5%  6%  7%
 8%  9% 10% 11% 12% 13% 14% 15% 16% 17%
18% 19% 20%<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: irq_stat 0x40000001
ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
524288 in
         res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
ata1.00: configured for UDMA/100
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
        05 f3 0b 6c
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate
failed
end_request: I/O error, dev sda, sector 99814252
Read-error on swap-device (8:0:99814256)
Read-error on swap-device (8:0:99814264)
Read-error on swap-device (8:0:99814272)
...
Read-error on swap-device (8:0:99815184)
ata1: EH complete
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
Read 470748 kbytes in 30.97 seconds (15.20 MB/s)
PM: Restore failed, recovering.
Restarting tasks ... done.
swsusp: Basic memory bitmaps freed
=================

Then system continue booting without resume.


I use smartctl and check disk 2 times and run fsck/mkswap -c and I have
no erros:

=================
 rutek:/home/maciek/kernel.org/libata_error# smartctl -A /dev/sda
smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   046    Pre-fail  Always
      -       28879
  2 Throughput_Performance  0x0005   100   100   030    Pre-fail
Offline      -       20381999
  3 Spin_Up_Time            0x0003   100   100   025    Pre-fail  Always
      -       1
  4 Start_Stop_Count        0x0032   099   099   000    Old_age   Always
      -       1599
  5 Reallocated_Sector_Ct   0x0033   100   100   024    Pre-fail  Always
      -       8589934592000
  7 Seek_Error_Rate         0x000f   100   100   047    Pre-fail  Always
      -       3713
  8 Seek_Time_Performance   0x0005   100   100   019    Pre-fail
Offline      -       0
  9 Power_On_Seconds        0x0032   096   096   000    Old_age   Always
      -       0h+41m+39s
 10 Spin_Retry_Count        0x0013   100   100   020    Pre-fail  Always
      -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
      -       1354
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always
      -       65
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always
      -       2776
194 Temperature_Celsius     0x0022   100   100   000    Old_age   Always
      -       33 (Lifetime Min/Max 15/46)
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always
      -       344
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always
      -       444268544
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always
      -       1
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always
      -       0
200 Multi_Zone_Error_Rate   0x000f   100   100   060    Pre-fail  Always
      -       22830
203 Run_Out_Cancel          0x0002   100   100   000    Old_age   Always
      -       2632796799455
240 Head_Flying_Hours       0x003e   200   200   000    Old_age   Always
      -       0

=================

Dmesg and config:
http://www.unixy.pl/maciek/download/kernel/libata_error/

Regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
