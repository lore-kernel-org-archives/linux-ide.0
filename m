From: Mike Young <myoung@wildernessvoice.com>
Subject: 2.6.9 Problem w/ NVDIA and WD SATA Drives
Date: Wed, 3 Nov 2004 11:11:20 -0800
Message-ID: <200411031111.20669.myoung@wildernessvoice.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wildernessvoice.com ([216.218.172.84]:34315 "HELO
	wildernessvoice.com") by vger.kernel.org with SMTP id S261847AbUKCULr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Nov 2004 15:11:47 -0500
Received: from 66.14.154.112 ([66.14.154.112]) by wildernessvoice.com for <linux-ide@vger.kernel.org>; Wed, 3 Nov 2004 12:11:47 -0800
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm trying to bring up the SATA support on an MSI K8N Neo2 Platinum board.  
I've currently got four WD 250GB SATA drives connected to the four on-board 
SATA ports.  I'm currently running a stock 2.6.9 kernel.  The drives seem to 
be getting seen by the controller.  However, I'm definitely unable to fdisk 
them.  When I check dmesg output, I notice the following (significantly 
shortened for reader's sake):

Nov  3 11:39:16 expresso kernel: end_request: I/O error, dev sdd, sector 104
Nov  3 11:39:16 expresso kernel: Buffer I/O error on device sdd, logical block 
13
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: SCSI error : <3 0 0 0> return code = 
0x8000002
Nov  3 11:39:16 expresso kernel: Current sdd: sense key Aborted Command
Nov  3 11:39:16 expresso kernel: end_request: I/O error, dev sdd, sector 112
Nov  3 11:39:16 expresso kernel: Buffer I/O error on device sdd, logical block 
14
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: SCSI error : <3 0 0 0> return code = 
0x8000002
Nov  3 11:39:16 expresso kernel: Current sdd: sense key Aborted Command
Nov  3 11:39:16 expresso kernel: end_request: I/O error, dev sdd, sector 120
Nov  3 11:39:16 expresso kernel: Buffer I/O error on device sdd, logical block 
15
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Nov  3 11:39:16 expresso kernel: ata4: error=0x04 { DriveStatusError }
Nov  3 11:39:16 expresso kernel: SCSI error : <3 0 0 0> return code = 
0x8000002
Nov  3 11:39:16 expresso kernel: Current sdd: sense key Aborted Command
Nov  3 11:39:16 expresso kernel: end_request: I/O error, dev sdd, sector 0
Nov  3 11:39:16 expresso kernel: Buffer I/O error on device sdd, logical block 
0

Working with this nVidia nForce3 Ultra chipset as well as with libata is new 
for me.  These drives were definitely working for me with another controller 
and driver set.  However, I definitely want to get this working and any help 
is greatly appreciated.

I did notice a reference by Jeff to some settings for a Promise controller on 
another version of the motherboard.  But I'm not sure what settings these are 
or if they're applicable to the nvidia controller.  It looked like a similar 
problem, though.

Thanks,

-Mike
