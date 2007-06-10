From: Kai Makisara <Kai.Makisara@kolumbus.fi>
Subject: 2.6.22-rc regression: smartctl does not work with SATA disk
Date: Sun, 10 Jun 2007 11:05:10 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0706101049130.6348@kai.makisara.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46944 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760433AbXFJIMY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 04:12:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

The command 'smartctl -a /dev/sdb' fails with 2.6.22-rc4 kernel. The 
disk /dev/sdb is a SATA disk. The command does work still with a real SCSI 
disk.

The computer has Athlon64 X2 and it is running x86_64 SMP kernel. The 
chipset is Nvidia CK804 and the sata_nv driver is used.

The following output from 'smartctl -a -r ioctl,1 /dev/sdb' tells the disk 
details and shows where the regression is:

-----
smartctl version 5.38 [x86_64-suse-linux-gnu] Copyright (C) 2002-7 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

 [inquiry: 12 00 00 00 24 00 ]
  scsi_status=0x0, host_status=0x0, driver_status=0x0
  info=0x0  duration=0 milliseconds  resid=0
  status=0x0
 [ata pass-through(16): 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 ec 00 ]
  scsi_status=0x0, host_status=0x0, driver_status=0x0
  info=0x0  duration=4 milliseconds  resid=0
  status=0x0
Detected SAT interface, switch to device type 'sat'

REPORT-IOCTL: DeviceFD=3 Command=IDENTIFY DEVICE
 [ata pass-through(16): 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 ec 00 ]
  scsi_status=0x0, host_status=0x0, driver_status=0x0
  info=0x0  duration=0 milliseconds  resid=0
  status=0x0
REPORT-IOCTL: DeviceFD=3 Command=IDENTIFY DEVICE returned 0
=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.10 family
Device Model:     ST3320620AS
Serial Number:    9QF22KAP
Firmware Version: 3.AAJ
User Capacity:    320,072,933,376 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sun Jun 10 10:47:30 2007 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled


REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS
 [ata pass-through(16): 85 06 2c 00 da 00 00 00 00 00 4f 00 c2 00 b0 00 ]
  scsi_status=0x2, host_status=0x0, driver_status=0x8
  info=0x1  duration=44 milliseconds  resid=0
  status=2: [desc] sense_key=0 asc=0 ascq=0
REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS returned 0

REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS CHECK
 [ata pass-through(16): 85 06 2c 00 da 00 00 00 00 00 4f 00 c2 00 b0 00 ]
  scsi_status=0x2, host_status=0x0, driver_status=0x8
  info=0x1  duration=44 milliseconds  resid=0
  status=2: [desc] sense_key=0 asc=0 ascq=0
Error SMART Status command failed
Please get assistance from http://smartmontools.sourceforge.net/
Values from ATA status return descriptor are:
 00     09 0c 00 00 00 00 00 00  00 00 00 00 00 50                              
REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS CHECK returned -1
A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.
----

This is smartctl from cvs a few days ago but the smartctl shipping with 
SuSE 10.2 fails in the same way.


I ran 'git bisect' and it suggests that the problem was introduced by

1e999736cafdffc374f22eed37b291129ef82e4e is first bad commit
commit 1e999736cafdffc374f22eed37b291129ef82e4e
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Wed Apr 11 00:23:13 2007 +0100

    libata: HPA support

i.e., before 2.6.22-rc1. At this point I find best to leave the problem to 
experts.

-- 
Kai
