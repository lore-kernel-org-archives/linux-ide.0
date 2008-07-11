From: "Sagar Borikar" <sagar.borikar@gmail.com>
Subject: Infrequent soft reset of ata for silicon image 3512 cards
Date: Fri, 11 Jul 2008 14:59:12 +0530
Message-ID: <3fb94e50807110229l18def5fbjadf7af9d6f9943d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:56331 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYGKJ3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 05:29:14 -0400
Received: by py-out-1112.google.com with SMTP id p76so2121389pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2008 02:29:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I hope this is the right list for following questions if not please
direct me to the correct one.

Currently  I am working with NAS box which has following configuration:

MIPS arch
2.6.18 kernel - comparatively older but box is in production
128 MB RAM
sil 3512 SATA controller
xfs file system

When performing the iozone stress test of the box over CIFS, NFS
simultaneously, I find that the ata port gets soft reset once in 5-8
hours and because of which the the continuous write activity gets
stalled on the drives. All the smbd processes which are writing data
to the disk goes into uninterruptilbe sleep state continuosuly and the
test doesn't complete.

Following is the log that I get :

ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back


After this, I start getting errors from file system :

can't seek in filesystem at bb 10686861057857128
can't read btree block 1630685585/1000141
can't seek in filesystem at bb 8951363201349912
can't read btree block 1365869628/911139
can't seek in filesystem at bb 5768064121399776
can't read btree block 880136736/1043772

Which looks like filesystem is trying to read the block  which is not
present in the partition.
and because of which device driver cribs that it is trying to access
the data beyond end of the device.

So I guess there is filesystem corruption too which can be solved
independently but ata1 getting soft reset under load is something
strange. Has anyone observed this before with silicon image 3512
cards?

If I look for health of the drives, everything looks good:


[root@NAS001ee5ab9c85 ~]# smartctl -d ata -A /dev/sata1
smartctl version 5.33 [mips-unknown-linux-gnu] Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/
=== START OF READ SMART DATA SECTION ===
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0003   190   187   021    Pre-fail
Always       -       5500
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       603
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail
Always       -       0
  9 Power_On_Hours          0x0032   096   096   000    Old_age
Always       -       3188
 10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail
Always       -       0
 11 Calibration_Retry_Count 0x0013   100   100   051    Pre-fail
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       601
194 Temperature_Celsius     0x0022   120   096   000    Old_age
Always       -       30
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail
Offline      -       0

Checked whether it has any badblocks but it returns success for affected drive

buffer read and cache read command using hdparm also succeeds.
[root@NAS001ee5ab9c85 ~]# hdparm -tT /dev/sata1
/dev/sata1:
 Timing cached reads:   308 MB in  2.03 seconds = 152.05 MB/sec
 Timing buffered disk reads:  132 MB in  3.04 seconds =  43.45 MB/sec

any pointers?

Thanks in advance
Sagar
