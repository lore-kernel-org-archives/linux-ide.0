From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: sata_mv BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Date: Wed, 23 May 2007 11:03:50 +0200
Message-ID: <46540376.6000700@wpkg.org>
References: <4631CE7C.3000703@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:51772 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067AbXEWJEA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 05:04:00 -0400
In-Reply-To: <4631CE7C.3000703@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Tomasz Chmielewski schrieb:
> Today at night, I had a serious sata_mv driver failure on one of the 
> servers.
> 
> I tested the drive in question with both smart and badblocks, but none 
> shown any errors - so my quick conclusion is that something is not right 
> with the sata_mv driver.
> 
> 
> The server has two drives; sda1 and sdb1 are connected into a RAID-1 
> array. 38 seconds after the failure started to happen, sda1 was kicked 
> out of RAID-1.

The error I mentioned before - BUG: at drivers/ata/sata_mv.c:1236 
mv_qc_issue() - happened on /dev/sda drive.

As it appears, my /dev/sdb drive just dies (has multiple badblocks). It 
causes similar errors when I tried to dd if=/dev/ero of=/dev/sdb.

It triggered two bugs:

BUG: at drivers/ata/sata_mv.c:657 mv_start_dma()

BUG: at drivers/ata/sata_mv.c:1201 mv_qc_issue()


Should it really print "BUG: at drivers/ata/sata_mv.c:657 
mv_start_dma()" when it meets a badblock?


All that on 2.6.21 kernel:

ata2: translated ATA stat/err 0x51/40 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x40 { UncorrectableError }
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current [descriptor]: sense key=0x3
     ASC=0x11 ASCQ=0x4
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         0e 23 38 54
end_request: I/O error, dev sdb, sector 237189204
BUG: at drivers/ata/sata_mv.c:657 mv_start_dma()
  [<c0221aa3>] mv_qc_issue+0xe6/0x10d
  [<c0216784>] ata_qc_issue+0x41f/0x475
  [<c020a9b6>] scsi_done+0x0/0x16
  [<c021ab16>] ata_scsi_translate+0xf7/0x151
  [<c020e2bb>] scsi_prep_fn+0x1b8/0x225
  [<c020a9b6>] scsi_done+0x0/0x16
  [<c021c96a>] ata_scsi_queuecmd+0x107/0x10e
  [<c021a83e>] ata_scsi_rw_xlat+0x0/0x1bb
  [<c020ade3>] scsi_dispatch_cmd+0x17a/0x1b5
  [<c020ec50>] scsi_request_fn+0x1f2/0x273
  [<c0198a89>] blk_remove_plug+0x4e/0x5a
  [<c0198ab2>] __generic_unplug_device+0x1d/0x1f
  [<c0199748>] __make_request+0x38b/0x498
  [<c0197ea5>] generic_make_request+0x1a9/0x1b9
  [<c0199d23>] submit_bio+0xa6/0xad
  [<c0131ab8>] mempool_alloc+0x1c/0x94
  [<c016072d>] bio_alloc_bioset+0x9b/0xf3
  [<c015dcbc>] submit_bh+0xd5/0xf3
  [<c015ef00>] __block_write_full_page+0x1e4/0x2cc
  [<c016216e>] blkdev_get_block+0x0/0x42
  [<c015f279>] block_write_full_page+0xbc/0xc4
  [<c016216e>] blkdev_get_block+0x0/0x42
  [<c0133aa5>] generic_writepages+0x171/0x2a4
  [<c0161690>] blkdev_writepage+0x0/0xc
  [<c0133934>] generic_writepages+0x0/0x2a4
  [<c0133bf8>] do_writepages+0x20/0x30
  [<c0130189>] __filemap_fdatawrite_range+0x65/0x70
  [<c01303b7>] filemap_fdatawrite+0x23/0x27
  [<c01303cc>] filemap_write_and_wait+0x11/0x29
  [<c0161a57>] __blkdev_put+0x38/0xf4
  [<c0146dd2>] __fput+0x96/0x13c
  [<c0144bcb>] filp_close+0x51/0x58
  [<c0145af1>] sys_close+0x55/0x84
  [<c0103b30>] syscall_call+0x7/0xb
  =======================

ata2: Entering mv_eng_timeout
mmio_base d0900000 ap cfb202cc qc cfb20cfc scsi_cmnd cfa641c0 &cmnd cfa641f8
ata2: no sense translation for status: 0x40
ata2: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x40 { DriveReady }
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current [descriptor]: sense key=0xb
     ASC=0x0 ASCQ=0x0
Descriptor sense data with sense descriptors (in hex):
         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         0e 23 38 54
end_request: I/O error, dev sdb, sector 237142040
Buffer I/O error on device sdb, logical block 29642755
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642756
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642757
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642758
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642759
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642760
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642761
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642762
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642763
lost page write due to I/O error on sdb
Buffer I/O error on device sdb, logical block 29642764
lost page write due to I/O error on sdb
BUG: at drivers/ata/sata_mv.c:1201 mv_qc_issue()
  [<c0221a56>] mv_qc_issue+0x99/0x10d
  [<c0216784>] ata_qc_issue+0x41f/0x475
  [<c020a9b6>] scsi_done+0x0/0x16
  [<c021ab16>] ata_scsi_translate+0xf7/0x151
  [<c02138c4>] sd_rw_intr+0x15d/0x186
  [<c020a9b6>] scsi_done+0x0/0x16
  [<c021c96a>] ata_scsi_queuecmd+0x107/0x10e
  [<c021a83e>] ata_scsi_rw_xlat+0x0/0x1bb
  [<c020ade3>] scsi_dispatch_cmd+0x17a/0x1b5
  [<c020ec50>] scsi_request_fn+0x1f2/0x273
  [<c0198a89>] blk_remove_plug+0x4e/0x5a
  [<c0199966>] blk_run_queue+0x2a/0x4b
  [<c020e338>] scsi_run_host_queues+0x10/0x22
  [<c020d4a2>] scsi_error_handler+0x231/0x267
  [<c0110b0d>] __wake_up_common+0x31/0x4f
  [<c020d271>] scsi_error_handler+0x0/0x267
  [<c020d271>] scsi_error_handler+0x0/0x267
  [<c0121574>] kthread+0xa0/0xc8
  [<c01214d4>] kthread+0x0/0xc8
  [<c010464b>] kernel_thread_helper+0x7/0x10
  =======================
ata2: translated ATA stat/err 0x7f/00 to SCSI SK/ASC/ASCQ 0x4/00/00
ata2: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest 
CorrectedError Index Error }
ata2: no device found (phy stat 00000000)
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current [descriptor]: sense key=0x4
     ASC=0x0 ASCQ=0x0
Descriptor sense data with sense descriptors (in hex):
         72 04 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         0e 22 88 67
end_request: I/O error, dev sdb, sector 237144167
sd 1:0:0:0: SCSI error: return eturn code = 0x00040000
e
  end_request: I/O error, dev sdb, sector 237146976
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237147680
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237148384
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237149088
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237149792
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237150496
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237151200
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237151904
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237152608
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237153312
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237154016
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237154720
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237155424
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237156128
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237156832
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237157536
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237158240
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237158944
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237159648
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237160352
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237161056
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237161760
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237162464
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237163168
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237163872
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237164576
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237165280
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237165984
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237166688
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237167392
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237168096
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237168800
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237169504
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237170208
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237170912
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237171616
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237172320
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237173024
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237173728
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237174432
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237175136
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237175840
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237176544
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237177248
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237177952
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237178656
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237179360
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237180064
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237180768
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237181472
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237182176
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237182880
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237183584
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237184288
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237184992
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237185696
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237186400
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237187104
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237187808
sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 237188512


-- 
Tomasz Chmielewski
