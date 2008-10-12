From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Sun, 12 Oct 2008 09:15:23 +0200
Message-ID: <20081012071523.GA20434@gollum.tnic>
References: <20081004091232.GB4160@gollum.tnic> <Pine.LNX.4.64.0810051147470.2543@cantor.unex.es> <20081010061610.GA5273@gollum.tnic> <Pine.LNX.4.64.0810101212170.2505@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:64428 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYJLHP3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Oct 2008 03:15:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1114634fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 12 Oct 2008 00:15:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0810101212170.2505@cantor.unex.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Fri, Oct 10, 2008 at 12:23:34PM +0200, Santiago Vila wrote:

[... ]

> [    6.100193] ide-cd: Call cdrom_end_request, cmd: 0x12, uptodate: 0x1, nsectors: 0
> [    6.101294] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.108015] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [    6.108165] Sending BLOCK_PC to drive! Fixed.
> [    6.108224] Original rq: : dev hdc: type=2, flags=504c8
> [    6.108286]   sector 18446744073709551615, nr/cnr 0/0
> [    6.108346]   bio cf87b5a0, biotail cf87b5a0, buffer 00000000, data 00000000, len 8
> [    6.108421]   cdb: 46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
> [    6.109036] rq->cmd_len: 10
> [    6.109088] Pid: 806, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [    6.109164]  [<d091cd0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [    6.109289]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [    6.109386]  [<d0900b68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [    6.109545]  [<d090168b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [    6.109670]  [<d08ffdc3>] ide_do_request+0x671/0x876 [ide_core]
> [    6.109794]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [    6.109890]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.109990]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.110084]  [<c012ba3c>] del_timer+0x4a/0x50
> [    6.110174]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [    6.110267]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [    6.110369]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [    6.110461]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [    6.110553]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [    6.110647]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [    6.110742]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [    6.110835]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [    6.110929]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [    6.111021]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [    6.111115]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [    6.111209]  [<c015a744>] find_get_page+0x1f/0x81
> [    6.111307]  [<c015ab06>] find_lock_page+0x10/0x43
> [    6.111400]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [    6.111493]  [<d0915c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [    6.111601]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [    6.111700]  [<d091c4aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [    6.111803]  [<c018036c>] do_lookup+0x53/0x153
> [    6.111899]  [<c0188932>] dput+0x16/0x103
> [    6.111992]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [    6.112150]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [    6.112244]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [    6.112336]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [    6.112426]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [    6.112528]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [    6.112621]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [    6.112715]  [<c011511f>] __ptep_modify_prot_start+0x16/0x2e
> [    6.112823]  [<c019aaf9>] block_ioctl+0x13/0x16
> [    6.112913]  [<c019aae6>] block_ioctl+0x0/0x16
> [    6.113003]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [    6.113095]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [    6.113185]  [<c017894e>] do_sys_open+0xaa/0xb2
> [    6.113276]  [<c0184385>] sys_ioctl+0x41/0x58
> [    6.113365]  [<c010398e>] syscall_call+0x7/0xb
> [    6.113460]  =======================
> [    6.113531] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.113594] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.113667] ide-cd: Call cdrom_transfer_packet_command
> [    6.115773] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x46, write: 0x0
> [    6.115862] ide-cd: cdrom_decode_status: stat: 0x59, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.115945] ide-cd: Call cdrom_queue_request_sense
> [    6.116003] ide-cd: failed_cmd: 0x46
> [    6.116143] hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> [    6.116387] hdc: status error: error=0x20 { LastFailedSense=0x02 }
> [    6.116547] ide: failed opcode was: unknown

Ok, it seems that your drive gets puzzled after receiving a GET_CONFIGURATION
command. Lets see whether this is the real cause of the problem. Here's a yet
another version of the inquisitive patch :) which drops such commands. Please
rebuild with it and send me the dmesg. Thanks.

---
 drivers/ide/ide-cd.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 1f2df24..1da0ef8 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1329,6 +1329,21 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		if (!rq->timeout)
 			rq->timeout = ATAPI_WAIT_PC;
 
+		if (blk_pc_request(rq)) {
+
+			printk(KERN_ERR "Sending BLOCK_PC to drive!\n");
+			blk_dump_rq_flags(rq, "Original rq: ");
+			printk(KERN_ERR "rq->cmd_len: %d\n", rq->cmd_len);
+
+			dump_stack();
+
+			if (rq->cmd[0] == GPCMD_GET_CONFIGURATION) {
+				printk(KERN_ERR "GET_CONFIGURATION cmd. Skipping\n");
+				cdrom_end_request(drive, 0);
+				return ide_stopped;
+			}
+		}
+
 		cdrom_do_block_pc(drive, rq);
 	} else if (blk_special_request(rq)) {
 		/* right now this can only be a reset... */
-- 

-- 
Regards/Gruss,
    Boris.
