From: "George T. Joseph \(development\)" <gtj.devel@peakin.com>
Subject: Marvell 6145 SATA via AHCI
Date: Wed, 28 Feb 2007 20:30:30 -0700
Message-ID: <22E26940476D1E48AA6F292B5316C9C337CB@bes1.peakin.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmail128144.authsmtp.com ([62.13.128.144]:54344 "EHLO
	outmail128144.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbXCAEEt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Feb 2007 23:04:49 -0500
Received: from outmail128175.authsmtp.net (outmail128175.authsmtp.net [62.13.128.175])
	by punt3.authsmtp.com (8.13.8/8.13.8/Kp) with ESMTP id l213V4Zr055487
	for <linux-ide@vger.kernel.org>; Thu, 1 Mar 2007 03:31:04 GMT
Received: from bes1.peakin.com (ideasource.cust.viawest.net [216.87.87.33])
	(authenticated bits=0)
	by mail.authsmtp.com (8.13.8/8.13.8/Kp) with ESMTP id l213UwrQ072679
	for <linux-ide@vger.kernel.org>; Thu, 1 Mar 2007 03:30:59 GMT
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying Jeff Garzik's preliminary Marvell 6145 SATA support patch and
getting nowhere so I'm just checking to see if anyone has got it working
or if there have been any further developments.
 
Basically,  I'll get "failed to IDENTIFY" messages for each of the
drives when the module loads.  If I disable MSI (per Jeff's comments) or
use irqpoll I can get by those but ultimately under any kind of stress,
the drives throw errors...
 
[  298.335640] ata6.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0
action 0x2 frozen
[  298.335650] ata6.00: cmd 61/08:00:ef:91:7a/00:00:00:00:00/40 tag 0
cdb 0x0 data 4096 out
[  298.335652]          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)
[  298.335661] ata6.00: cmd 60/00:08:87:45:60/01:00:00:00:00/40 tag 1
cdb 0x0 data 131072 in
[  298.335663]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
...
[  298.647119] ata6: soft resetting port
[  299.147026] ata6: softreset failed (1st FIS failed)
[  299.147032] ata6: softreset failed, retrying in 5 secs
[  304.144189] ata6: hard resetting port
[  304.965800] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  334.919509] ata6.00: qc timeout (cmd 0xec)
[  335.418808] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  335.418813] ata6.00: revalidation failed (errno=-5)
[  335.418817] ata6: failed to recover some devices, retrying in 5 secs
[  340.415950] ata6: hard resetting port
[  341.237601] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
...
[  407.463893] ata6.00: qc timeout (cmd 0xec)
[  407.963253] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  407.963257] ata6.00: revalidation failed (errno=-5)
[  407.963261] ata6.00: disabled
[  408.466655] ata6: EH complete

Drives and cables are fine.  I can plug them into the ICH7 ports and
beat them up for hours.  I can also boot to Windows and run the drives
flat out on the Marvell without problem.  Jumpering the drives back to
1.5g doesn't help.
 
Any ideas or am I just jumping the gun trying to get this to work now?
 
Thanks...george
 
MB: Intel 975XBX2
Marvell 88SE6145 running 1.1.0.34 firmware
Kernel 2.6.20 with Jeff's ahci patch from 1/27/07
WD2500JS drives
 
