From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 23:09:32 -0400
Message-ID: <43570A6C.3020105@rtr.ca>
References: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050808080003080603090903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:713 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751165AbVJTDJh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Oct 2005 23:09:37 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: t.schorpp@gmx.de, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050808080003080603090903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Timothy Thelin wrote:
>
>>But there is still a bug deep in the IDE taskfile code
>>that sometimes causes problems.  Someday I might have time
>>to dig deeper into the kernel and fix that issue.
> 
> And what bug is this? ...
 > I use taskfile and have a vested interest in getting all taskfile bugs fixed.

I've attached a crash ooops log from 2.6.12.

Email me (mlord@pobox.com) if you'd like to get in touch
with the chap who has been painstakingly working this
from the userspace side of the TASKFILE ioctls.

Cheers

--------------050808080003080603090903
Content-Type: text/x-log;
 name="taskfile_crash.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="taskfile_crash.log"

[root@athlon hdparm-6.1.work]# ./hdparm --security-unlock "ABC" --user-master m  /dev/hdc

/dev/hdc:
in flUnable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c02ba33e
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ext3 jbd dm_mod
CPU:    0
EIP:    0060:[<c02ba33e>]    Not tainted VLI
EFLAGS: 00010082   (2.6.12-1.1447_FC4_lj.leonard) 
EIP is at pre_task_out_intr+0xeb/0x10b
eax: 00000001   ebx: 00000000   ecx: c03cb8d0   edx: 000001f0
esi: c04991bc   edi: c049912c   ebp: c02ba253   esp: cc499ca0
ds: 007b   es: 007b   ss: 0068
Process hdparm (pid: 1954, threadinfo=cc499000 task=cc692550)
Stack: 00000000 00000064 cf5c09c0 bf838feb cc499da8 cc499e8c c04991bc c02bac72 
       c02b32f3 0051b5fc c04991bc 00000000 00000000 cc499da8 c02b3628 00000088 
       00001388 cec388d0 cc499da8 c04991bc c049912c c04991bc c02b38e3 00000000 
Call Trace:
 [<c02bac72>] flagged_taskfile+0x12a/0x368
 [<c02b32f3>] execute_drive_cmd+0x4e/0x1c5
 [<c02b3628>] start_request+0x1be/0x23a
 [<c02b38e3>] ide_do_request+0x21e/0x4ff
 [<c029ccca>] cfq_insert_request+0x55/0xef
 [<c017fece>] __getblk+0x2c/0x52
 [<c02b49e9>] ide_do_drive_cmd+0x121/0x2b8
 [<d08af2ec>] ext3_do_update_inode+0x183/0x390 [ext3]
 [<c02ba3d4>] ide_diag_taskfile+0x76/0xa8
 [<c0157d70>] buffered_rmqueue+0x225/0x31b
 [<c02931a9>] blk_end_sync_rq+0x0/0x1d
 [<c02ba6cb>] ide_taskfile_ioctl+0x2b4/0x41b
 [<c01676ae>] do_no_page+0x1be/0x58f
 [<c02ba253>] pre_task_out_intr+0x0/0x10b
 [<c02ba168>] task_out_intr+0x0/0xeb
 [<c02b198c>] generic_ide_ioctl+0x658/0x6c0
 [<c0119285>] do_page_fault+0x239/0x59f
 [<c025eab8>] opost+0x91/0x1ec
 [<c0261b5d>] write_chan+0x183/0x1f5
 [<c02c09e7>] idedisk_ioctl+0x29/0x2f
 [<c02c09be>] idedisk_ioctl+0x0/0x2f
 [<c02955af>] blkdev_ioctl+0x84/0x354
 [<c0187bba>] block_ioctl+0x0/0xd
 [<c0193a31>] do_ioctl+0x51/0x55
 [<c0193b27>] vfs_ioctl+0x50/0x1aa
 [<c0193cde>] sys_ioctl+0x5d/0x6b
 [<c0103a61>] syscall_call+0x7/0xb
Code: 89 f0 e8 90 fb ff ff b8 01 00 00 00 83 c4 14 5b 5e c3 fa c7 04 24 00 00 00 00 b9 30 75 00 00 ba 68 a1 2b c0 89 f0 e8 9a b5 ff ff <8b> 43 2c 85 c0 75 af eb b4 ba 01 00 00 00 89 f0 e8 32 fc ff ff 
 ags:  0
out flags: 80
io_ports[0] : 0
io_ports[1] : 0
io_ports[2] : 0
io_ports[3] : 0
io_ports[4] : 0
io_ports[5] : 0
io_ports[6] : 0
io_ports[7] : f2
 Issuing SECURITY_UNLOCK command, mode=0/1, password="ABC"
Sep  6 12:34:12 athlon kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
Sep  6 12:34:12 athlon kernel:  printing eip:
Sep  6 12:34:12 athlon kernel: c02ba33e
Sep  6 12:34:12 athlon kernel: *pde = 00000000
Sep  6 12:34:12 athlon kernel: Oops: 0000 [#1]
Sep  6 12:34:12 athlon kernel: Modules linked in: ext3 jbd dm_mod
Sep  6 12:34:12 athlon kernel: CPU:    0
Sep  6 12:34:12 athlon kernel: EIP:    0060:[<c02ba33e>]    Not tainted VLI
Sep  6 12:34:12 athlon kernel: EFLAGS: 00010082   (2.6.12-1.1447_FC4_lj.leonard) 
Sep  6 12:34:12 athlon kernel: EIP is at pre_task_out_intr+0xeb/0x10b
Sep  6 12:34:12 athlon kernel: eax: 00000001   ebx: 00000000   ecx: c03cb8d0   edx: 000001f0
Sep  6 12:34:12 athlon kernel: esi: c04991bc   edi: c049912c   ebp: c02ba253   esp: cc499ca0
Sep  6 12:34:12 athlon kernel: ds: 007b   es: 007b   ss: 0068
Sep  6 12:34:12 athlon kernel: Process hdparm (pid: 1954, threadinfo=cc499000 task=cc692550)
Sep  6 12:34:12 athlon kernel: Stack: 00000000 00000064 cf5c09c0 bf838feb cc499da8 cc499e8c c04991bc c02bac72 
Sep  6 12:34:12 athlon kernel:        c02b32f3 0051b5fc c04991bc 00000000 00000000 cc499da8 c02b3628 00000088 
Sep  6 12:34:12 athlon kernel:        00001388 cec388d0 cc499da8 c04991bc c049912c c04991bc c02b38e3 00000000 
Sep  6 12:34:12 athlon kernel: Call Trace:
Sep  6 12:34:12 athlon kernel:  [<c02bac72>] flagged_taskfile+0x12a/0x368
Sep  6 12:34:12 athlon kernel:  [<c02b32f3>] execute_drive_cmd+0x4e/0x1c5
Sep  6 12:34:12 athlon kernel:  [<c02b3628>] start_request+0x1be/0x23a
Sep  6 12:34:12 athlon kernel:  [<c02b38e3>] ide_do_request+0x21e/0x4ff
Sep  6 12:34:12 athlon kernel:  [<c029ccca>] cfq_insert_request+0x55/0xef
Sep  6 12:34:12 athlon kernel:  [<c017fece>] __getblk+0x2c/0x52
Sep  6 12:34:12 athlon kernel:  [<c02b49e9>] ide_do_drive_cmd+0x121/0x2b8
Sep  6 12:34:12 athlon kernel:  [<d08af2ec>] ext3_do_update_inode+0x183/0x390 [ext3]
Sep  6 12:34:12 athlon kernel:  [<c02ba3d4>] ide_diag_taskfile+0x76/0xa8
Sep  6 12:34:12 athlon kernel:  [<c0157d70>] buffered_rmqueue+0x225/0x31b
Sep  6 12:34:12 athlon kernel:  [<c02931a9>] blk_end_sync_rq+0x0/0x1d
Sep  6 12:34:12 athlon kernel:  [<c02ba6cb>] ide_taskfile_ioctl+0x2b4/0x41b
Sep  6 12:34:12 athlon kernel:  [<c01676ae>] do_no_page+0x1be/0x58f
Sep  6 12:34:12 athlon kernel:  [<c02ba253>] pre_task_out_intr+0x0/0x10b
Sep  6 12:34:12 athlon kernel:  [<c02ba168>] task_out_intr+0x0/0xeb
Sep  6 12:34:12 athlon kernel:  [<c02b198c>] generic_ide_ioctl+0x658/0x6c0
Sep  6 12:34:12 athlon kernel:  [<c0119285>] do_page_fault+0x239/0x59f
Sep  6 12:34:12 athlon kernel:  [<c025eab8>] opost+0x91/0x1ec
Sep  6 12:34:12 athlon kernel:  [<c0261b5d>] write_chan+0x183/0x1f5
Sep  6 12:34:12 athlon kernel:  [<c02c09e7>] idedisk_ioctl+0x29/0x2f
Sep  6 12:34:12 athlon kernel:  [<c02c09be>] idedisk_ioctl+0x0/0x2f
Sep  6 12:34:12 athlon kernel:  [<c02955af>] blkdev_ioctl+0x84/0x354
Sep  6 12:34:12 athlon kernel:  [<c0187bba>] block_ioctl+0x0/0xd
Sep  6 12:34:12 athlon kernel:  [<c0193a31>] do_ioctl+0x51/0x55
Sep  6 12:34:12 athlon kernel:  [<c0193b27>] vfs_ioctl+0x50/0x1aa
Sep  6 12:34:12 athlon kernel:  [<c0193cde>] sys_ioctl+0x5d/0x6b
Sep  6 12:34:12 athlon kernel:  [<c0103a61>] syscall_call+0x7/0xb
Sep  6 12:34:12 athlon kernel: Code: 89 f0 e8 90 fb ff ff b8 01 00 00 00 83 c4 14 5b 5e c3 fa c7 04 24 00 00 00 00 b9 30 75 00 00 ba 68 a1 2b c0 89 f0 e8 9a b5 ff ff <8b> 43 2c 85 c0 75 af eb b4 ba 01 00 00 00 89 f0 e8 32 fc ff ff 
<4>hdc: lost interrupt
Sep  6 12:34:41 athlon kernel:  <4>hdc: lost interrupt
Segmentation fault
[root@athlon hdparm-6.1.work]# ./hdparm --security-unlock "ABC" --user-master m /dev/hdc

/dev/hdc:
in flUnable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c02ba33e
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: ext3 jbd dm_mod
CPU:    0
EIP:    0060:[<c02ba33e>]    Not tainted VLI
EFLAGS: 00010082   (2.6.12-1.1447_FC4_lj.leonard) 
EIP is at pre_task_out_intr+0xeb/0x10b
eax: 00000001   ebx: 00000000   ecx: c03cb6f0   edx: 00000010
esi: c04991bc   edi: c049912c   ebp: c02ba253   esp: cc499ca0
ds: 007b   es: 007b   ss: 0068
Process hdparm (pid: 1956, threadinfo=cc499000 task=cc692550)
Stack: 00000000 00000064 00000010 cc692550 cc499da8 cc499e8c c04991bc c02bac72 
       c02b32f3 0051b5fc c04991bc 00000000 00000000 cc499da8 c02b3628 00000088 
       00001388 cec388d0 cc499da8 c04991bc c049912c c04991bc c02b38e3 00000000 
Call Trace:
 [<c02bac72>] flagged_taskfile+0x12a/0x368
 [<c02b32f3>] execute_drive_cmd+0x4e/0x1c5
 [<c02b3628>] start_request+0x1be/0x23a
 [<c02b38e3>] ide_do_request+0x21e/0x4ff
 [<c029ccca>] cfq_insert_request+0x55/0xef
 [<c017fece>] __getblk+0x2c/0x52
 [<c02b49e9>] ide_do_drive_cmd+0x121/0x2b8
 [<d08af2ec>] ext3_do_update_inode+0x183/0x390 [ext3]
 [<c02ba3d4>] ide_diag_taskfile+0x76/0xa8
 [<c0157d70>] buffered_rmqueue+0x225/0x31b
 [<c02931a9>] blk_end_sync_rq+0x0/0x1d
 [<c02ba6cb>] ide_taskfile_ioctl+0x2b4/0x41b
 [<c01676ae>] do_no_page+0x1be/0x58f
 [<c02ba253>] pre_task_out_intr+0x0/0x10b
 [<c02ba168>] task_out_intr+0x0/0xeb
 [<c02b198c>] generic_ide_ioctl+0x658/0x6c0
 [<c0119285>] do_page_fault+0x239/0x59f
 [<c025eab8>] opost+0x91/0x1ec
 [<c0261b5d>] write_chan+0x183/0x1f5
 [<c02c09e7>] idedisk_ioctl+0x29/0x2f
 [<c02c09be>] idedisk_ioctl+0x0/0x2f
 [<c02955af>] blkdev_ioctl+0x84/0x354
 [<c0187bba>] block_ioctl+0x0/0xd
 [<c0193a31>] do_ioctl+0x51/0x55
 [<c0193b27>] vfs_ioctl+0x50/0x1aa
 [<c0193cde>] sys_ioctl+0x5d/0x6b
 [<c0103a61>] syscall_call+0x7/0xb
Code: 89 f0 e8 90 fb ff ff b8 01 00 00 00 83 c4 14 5b 5e c3 fa c7 04 24 00 00 00 00 b9 30 75 00 00 ba 68 a1 2b c0 89 f0 e8 9a b5 ff ff <8b> 43 2c 85 c0 75 af eb b4 ba 01 00 00 00 89 f0 e8 32 fc ff ff 
 ags:  0
out flags: 80
io_ports[0] : 0
io_ports[1] : 0
io_ports[2] : 0
io_ports[3] : 0
io_ports[4] : 0
io_ports[5] : 0
io_ports[6] : 0
io_ports[7] : f2
 Issuing SECURITY_UNLOCK command, mode=0/1, password="ABC"
Sep  6 12:35:19 athlon kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
Sep  6 12:35:19 athlon kernel:  printing eip:
Sep  6 12:35:19 athlon kernel: c02ba33e
Sep  6 12:35:19 athlon kernel: *pde = 00000000
Sep  6 12:35:19 athlon kernel: Oops: 0000 [#2]
Sep  6 12:35:19 athlon kernel: Modules linked in: ext3 jbd dm_mod
Sep  6 12:35:19 athlon kernel: CPU:    0
Sep  6 12:35:19 athlon kernel: EIP:    0060:[<c02ba33e>]    Not tainted VLI
Sep  6 12:35:19 athlon kernel: EFLAGS: 00010082   (2.6.12-1.1447_FC4_lj.leonard) 
Sep  6 12:35:19 athlon kernel: EIP is at pre_task_out_intr+0xeb/0x10b
Sep  6 12:35:19 athlon kernel: eax: 00000001   ebx: 00000000   ecx: c03cb6f0   edx: 00000010
Sep  6 12:35:19 athlon kernel: esi: c04991bc   edi: c049912c   ebp: c02ba253   esp: cc499ca0
Sep  6 12:35:19 athlon kernel: ds: 007b   es: 007b   ss: 0068
Sep  6 12:35:19 athlon kernel: Process hdparm (pid: 1956, threadinfo=cc499000 task=cc692550)
Sep  6 12:35:19 athlon kernel: Stack: 00000000 00000064 00000010 cc692550 cc499da8 cc499e8c c04991bc c02bac72 
Sep  6 12:35:19 athlon kernel:        c02b32f3 0051b5fc c04991bc 00000000 00000000 cc499da8 c02b3628 00000088 
Sep  6 12:35:19 athlon kernel:        00001388 cec388d0 cc499da8 c04991bc c049912c c04991bc c02b38e3 00000000 
Sep  6 12:35:19 athlon kernel: Call Trace:
Sep  6 12:35:19 athlon kernel:  [<c02bac72>] flagged_taskfile+0x12a/0x368
Sep  6 12:35:19 athlon kernel:  [<c02b32f3>] execute_drive_cmd+0x4e/0x1c5
Sep  6 12:35:19 athlon kernel:  [<c02b3628>] start_request+0x1be/0x23a
Sep  6 12:35:19 athlon kernel:  [<c02b38e3>] ide_do_request+0x21e/0x4ff
Sep  6 12:35:19 athlon kernel:  [<c029ccca>] cfq_insert_request+0x55/0xef
Sep  6 12:35:19 athlon kernel:  [<c017fece>] __getblk+0x2c/0x52
Sep  6 12:35:19 athlon kernel:  [<c02b49e9>] ide_do_drive_cmd+0x121/0x2b8
Sep  6 12:35:19 athlon kernel:  [<d08af2ec>] ext3_do_update_inode+0x183/0x390 [ext3]
Sep  6 12:35:19 athlon kernel:  [<c02ba3d4>] ide_diag_taskfile+0x76/0xa8
Sep  6 12:35:19 athlon kernel:  [<c0157d70>] buffered_rmqueue+0x225/0x31b
Sep  6 12:35:19 athlon kernel:  [<c02931a9>] blk_end_sync_rq+0x0/0x1d
Sep  6 12:35:19 athlon kernel:  [<c02ba6cb>] ide_taskfile_ioctl+0x2b4/0x41b
Sep  6 12:35:19 athlon kernel:  [<c01676ae>] do_no_page+0x1be/0x58f
Sep  6 12:35:19 athlon kernel:  [<c02ba253>] pre_task_out_intr+0x0/0x10b
Sep  6 12:35:19 athlon kernel:  [<c02ba168>] task_out_intr+0x0/0xeb
Sep  6 12:35:19 athlon kernel:  [<c02b198c>] generic_ide_ioctl+0x658/0x6c0
Sep  6 12:35:19 athlon kernel:  [<c0119285>] do_page_fault+0x239/0x59f
Sep  6 12:35:19 athlon kernel:  [<c025eab8>] opost+0x91/0x1ec
Sep  6 12:35:19 athlon kernel:  [<c0261b5d>] write_chan+0x183/0x1f5
Sep  6 12:35:19 athlon kernel:  [<c02c09e7>] idedisk_ioctl+0x29/0x2f
Sep  6 12:35:19 athlon kernel:  [<c02c09be>] idedisk_ioctl+0x0/0x2f
Sep  6 12:35:19 athlon kernel:  [<c02955af>] blkdev_ioctl+0x84/0x354
Sep  6 12:35:19 athlon kernel:  [<c0187bba>] block_ioctl+0x0/0xd
Sep  6 12:35:19 athlon kernel:  [<c0193a31>] do_ioctl+0x51/0x55
Sep  6 12:35:19 athlon kernel:  [<c0193b27>] vfs_ioctl+0x50/0x1aa
Sep  6 12:35:19 athlon kernel:  [<c0193cde>] sys_ioctl+0x5d/0x6b
Sep  6 12:35:19 athlon kernel:  [<c0103a61>] syscall_call+0x7/0xb
Sep  6 12:35:19 athlon kernel: Code: 89 f0 e8 90 fb ff ff b8 01 00 00 00 83 c4 14 5b 5e c3 fa c7 04 24 00 00 00 00 b9 30 75 00 00 ba 68 a1 2b c0 89 f0 e8 9a b5 ff ff <8b> 43 2c 85 c0 75 af eb b4 ba 01 00 00 00 89 f0 e8 32 fc ff ff 
<4>hdc: lost interrupt
Sep  6 12:35:49 athlon kernel:  <4>hdc: lost interrupt
Segmentation fault
[root@athlon hdparm-6.1.work]# shutdown -h 0

Broadcast message from root (ttyS0) (Tue Sep  6 12:36:09 2005):

The system is going down for system halt NOW!

--------------050808080003080603090903--
