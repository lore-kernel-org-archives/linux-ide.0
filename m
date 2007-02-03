From: Fredrik Rinnestam <fredrik@obra.se>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Sun, 4 Feb 2007 00:17:57 +0100
Message-ID: <20070203231757.GA2035@useful.obra.se>
References: <74342.74582.qm@web52304.mail.yahoo.com> <457E040D.2020707@gmail.com> <20070203201449.GA1222@useful.obra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep01.bredband.com ([195.54.107.70]:42541 "EHLO
	mxfep01.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbXBCXTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 18:19:08 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep01.bredband.com with ESMTP
          id <20070203231850.TDNC3634.mxfep01.bredband.com@ironport2.bredband.com>
          for <linux-ide@vger.kernel.org>; Sun, 4 Feb 2007 00:18:50 +0100
Content-Disposition: inline
In-Reply-To: <20070203201449.GA1222@useful.obra.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> 
> I get very similar error-messages with my SiI 3512 controller. I just
> noticed this while connecting a second drive and moving data from sdb to
> sda. Copying stuff from the internal ide-controller (nvidia) to sda does
> not produce any errors. I've also tried diffrent cables without any
> luck. Kernel is 2.6.19.2
> 
uhm, scratch that:

this is from normal operation on the second drive (fileserver):

ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2.00: disabled
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x1
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2.00: detaching (SCSI 1:0:0:0)
Synchronizing SCSI cache for disk sdb: 
FAILED
  status = 0, message = 00, host = 4, driver = 00
  <3>ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: COMRESET failed (device not ready)
ata2: reset failed, giving up
ata2: EH complete
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2
offset 0
scsi 1:0:0:0: rejecting I/O to dead device
Buffer I/O error on device sdb1, logical block 0
lost page write due to I/O error on sdb1
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device
scsi 1:0:0:0: rejecting I/O to dead device

-- 
Fredrik Rinnestam
