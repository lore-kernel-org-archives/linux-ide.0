From: Simon Jackson <sjackson@bluearc.com>
Subject: Drives  freeze on Linux appliances.
Date: Thu, 29 Oct 2009 10:13:21 +0000
Message-ID: <ABFC24E4C13D81489F7F624E14891C865A9998BB@uk-ex-mbx1.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from p01c11o143.mxlogic.net ([208.65.144.66]:33911 "EHLO
	p01c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZJ2KWo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 06:22:44 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


Hi.

I have a problem on a Linux appliance that seems to be related to ata devices freezing.  This problem has been seen on multiple systems (an appliance that runs Debian Linux and uses a pair of SATA drives configured as RAID 1 pair.

The symptoms of the problem are that one or other of the devices (sda or sdb) log multiple ata errors and subsequently the device cannot be accessed.

In some cases a reboot of Linux resolves the problem, but in others after the reboot Linux does not see the device and a power cycle of the unit is required to make the device available.  Once cleared the device will continue to work for hours, days or weeks.  I do not believe this to be a specific hardware fault as the problem has been seen on multiple systems.

Below is an extract from the kern.log of a system that has seen the problem:

2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104358] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104416] ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0
2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104417]          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104451] ata1.00: status: { DRDY }
2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104483] ata1: hard resetting link
2009-10-27T11:34:48+00:00 merc-stm2-1 kernel: [1317095.795176] ata1: link is slow to respond, please be patient (ready=0)
2009-10-27T11:34:51+00:00 merc-stm2-1 kernel: [1317099.906167] ata1: softreset failed (device not ready)
2009-10-27T11:34:51+00:00 merc-stm2-1 kernel: [1317099.906167] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829417] ata1.00: qc timeout (cmd 0xec)
2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829426] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829429] ata1.00: revalidation failed (errno=-5)
2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829463] ata1: failed to recover some devices, retrying in 5 secs
2009-10-27T11:35:26+00:00 merc-stm2-1 kernel: [1317141.697825] ata1: hard resetting link
2009-10-27T11:35:33+00:00 merc-stm2-1 kernel: [1317149.155788] ata1: link is slow to respond, please be patient (ready=0)
2009-10-27T11:35:36+00:00 merc-stm2-1 kernel: [1317153.211822] ata1: softreset failed (device not ready)
2009-10-27T11:35:36+00:00 merc-stm2-1 kernel: [1317153.211863] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
2009-10-27T11:36:06+00:00 merc-stm2-1 kernel: [1317188.533402] ata1.00: qc timeout (cmd 0xec)
2009-10-27T11:36:06+00:00 merc-stm2-1 kernel: [1317188.533402] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
2009-10-27T11:36:06+00:00 merc-stm2-1 kernel: [1317188.533402] ata1.00: revalidation failed (errno=-5)
2009-10-27T11:36:06+00:00 merc-stm2-1 kernel: [1317188.533402] ata1: failed to recover some devices, retrying in 5 secs
2009-10-27T11:36:11+00:00 merc-stm2-1 kernel: [1317194.208794] ata1: hard resetting link
2009-10-27T11:36:18+00:00 merc-stm2-1 kernel: [1317201.841850] ata1: link is slow to respond, please be patient (ready=0)
2009-10-27T11:36:21+00:00 merc-stm2-1 kernel: [1317205.809897] ata1: softreset failed (device not ready)
2009-10-27T11:36:21+00:00 merc-stm2-1 kernel: [1317205.809897] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
2009-10-27T11:36:51+00:00 merc-stm2-1 kernel: [1317242.146833] ata1.00: qc timeout (cmd 0xec)
2009-10-27T11:36:51+00:00 merc-stm2-1 kernel: [1317242.146841] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
2009-10-27T11:36:51+00:00 merc-stm2-1 kernel: [1317242.146844] ata1.00: revalidation failed (errno=-5)
2009-10-27T11:36:51+00:00 merc-stm2-1 kernel: [1317242.146877] ata1.00: disabled
2009-10-27T11:36:52+00:00 merc-stm2-1 kernel: [1317242.761410] ata1: hard resetting link
2009-10-27T11:36:58+00:00 merc-stm2-1 kernel: [1317250.905662] ata1: link is slow to respond, please be patient (ready=0)
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222789] ata1: softreset failed (device not ready)
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222830] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222842] end_request: I/O error, dev sda, sector 154721790
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222877] md: super_written gets error=-5, uptodate=0
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222881] raid1: Disk failure on sda6, disabling device.
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222882] raid1: Operation continuing on 1 devices.
2009-10-27T11:37:02+00:00 merc-stm2-1 kernel: [1317255.222931] ata1: EH complete
009-10-27T14:35:54+0


This was followed by a whole load of scsi device errors and md raid errors.  In this case, a reboot of Linux did not resolve the problem, only after a power cycle of the unit did the device come back to life.


$ uname -a
Linux  2.6.26-1-amd64 #1 SMP Sat Jan 10 17:57:00 UTC 2009 x86_64 GNU/Linux

The problem has been seen both on Seagate and Hitachi HDDs, so I am inclined to discount a drive issue here.

MoBo information.
Manufacturer: TYAN Computer Corporation
Product:      TYAN Toledo i3210W/i3200R S5211
Serial:       empty
BIOS vendor:  Phoenix Technologies LTD
BIOS version: V1.05

Can anyone shed light on what is happening here?

