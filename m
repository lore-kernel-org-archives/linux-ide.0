From: Mark Lord <liml@rtr.ca>
Subject: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 16:15:49 -0400
Message-ID: <4633AB75.7070107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2798 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbXD1UPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:15:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

While working on the new hdparm (version 7.0, released today),
I ran into trouble when a buggy SG_IO/ATA_16 packet caused
the libata EH to get confused.

I triggered this by accident, issuing an IDENTIFY command
which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
but libata never recovered from the "stuck DRQ bit" that resulted.

In the IDE driver, we had code to try and cope with stuck DRQ,
by just looping and reading from the data port a few times.
That could have been done better, but it worked a lot of the time,
back in those simpler days.

I don't know what you try in libata-eh, but perhaps it can be tweaked?
Below is the 'dmesg' from that system before I hit the big red button.

I can also supply a program that will generate this lockup on demand,
for testing purposes.

Cheers

Mark


sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
         res 58/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd8)
ata1: port failed to respond (30 secs, Status 0xd8)
ata1: soft resetting port
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd8)
ata1: port failed to respond (30 secs, Status 0xd8)
ata1: soft resetting port
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ATA: abnormal status 0xD8 on port 0x000101f7
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: EH complete
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 120322555
Buffer I/O error on device sda1, logical block 15018230
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 127883035
Buffer I/O error on device sda1, logical block 15963290
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 31060987
Buffer I/O error on device sda1, logical block 3860534
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 31060995
Buffer I/O error on device sda1, logical block 3860535
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 3860536
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 3860537
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 31780267
Buffer I/O error on device sda1, logical block 3950444
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 3950445
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43692707
Buffer I/O error on device sda1, logical block 5439499
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43692739
Buffer I/O error on device sda1, logical block 5439503
lost page write due to I/O error on sda1
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693195
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693243
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693259
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693299
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693315
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693331
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693355
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693419
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693451
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693467
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693523
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693563
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693603
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693619
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693635
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693651
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 43693683
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 54442019
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 54442051
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 92386395
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 94024779
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 94024803
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 96384107
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 96384211
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 96384227
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 96384275
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 117617635
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 117617707
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 118141547
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 118288219
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 126005883
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 126300947
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155417787
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155519227
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155519251
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155519347
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155519539
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155521219
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155589019
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155589523
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155595347
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 155596443
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 275427915
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 275427939
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 176787
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27701915
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27702155
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27702243
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27702427
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27704179
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27891339
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 27964171
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 28253219
Aborting journal on device sda1.
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 28253315
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30847571
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30882475
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30941587
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30956683
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30956795
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958155
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958435
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958499
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958563
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958659
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958915
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30959171
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30959427
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30959683
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30959939
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30960195
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30960451
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30960707
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30960963
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30961219
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30961475
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30961731
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30961987
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30962243
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30964363
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30964619
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30964875
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30965131
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30965387
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30965643
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30965899
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30966155
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30966411
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30966667
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30966923
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30967179
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30967435
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30967691
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30967947
ext3_abort called.
EXT3-fs error (device sda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30968283
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30968539
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30968771
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30969027
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30969283
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30969539
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30997643
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30997707
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 126005891
EXT3-fs error (device sda1): ext3_get_inode_loc: unable to read inode block - inode=7864507, block=15728647
EXT3-fs error (device sda1) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device sda1) in ext3_dirty_inode: IO failure
journal commit I/O error
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958443
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958475
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30958499
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30961371
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 30967803
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 31780267
__journal_remove_journal_head: freeing b_committed_data
