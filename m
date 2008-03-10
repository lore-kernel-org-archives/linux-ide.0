From: "George Spelvin" <linux@horizon.com>
Subject: 2.6.25-rc4 oops using hdparm --write-sector
Date: Mon, 10 Mar 2008 03:46:42 -0400
Message-ID: <20080310074642.19448.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:13952 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750800AbYCJHqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 03:46:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I was using --write-sector a lot to clean up some bad spots on
a drive (actually, I locally hacked hdparm to take a sector range,
so it was executing thousands).

It would periodically pause for a second while writing a sector,
and occasionally spit out:
hdi: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: 0x30

I think those were just timeouts (I have write cacheing disabled for
better error reporting) and I was ignoring them, but then I got the
appended puke in the syslog.


I can't say if this is a regression; it's not something I do regularly.
(I can say that repeating the operation seems to be succeeding
so far.)

Other things I've learned with hdparm:
- hdparm -R actually seems to work to re-scan an IDE bus that had nothing
  connected at boot.
- hdparm -U makes the kernel very unhappy.
- A subsequent hdparm -R will fill the screen with scrolling oops
  messages.
- I wish there was a cleaner (and less dangerous) way to do IDE coldplug.

Anyway, in case it helps anyone, here's the oops.  The drive is connected
to a PDC20268 PCI IDE controller.

Thank you for all your hard work.

hdi: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: 0x30
hdi: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: 0x30
hdi: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: 0x30
hdi: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: 0x30
BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<b01d9e1d>] sg_next+0x2/0x1a
*pde = 00000000 
Oops: 0000 [#1] 

Pid: 17734, comm: hdparm Not tainted (2.6.25-rc4 #47)
EIP: 0060:[<b01d9e1d>] EFLAGS: 00010246 CPU: 0
EIP is at sg_next+0x2/0x1a
EAX: 00000000 EBX: e9fcd800 ECX: 00000000 EDX: d1ba2000
ESI: b0452414 EDI: efaa3000 EBP: b0452460 ESP: d1ba2bb8
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process hdparm (pid: 17734, ti=d1ba2000 task=e9f68ff0 task.ti=d1ba2000)
Stack: b0248bb2 00000001 d1ba2ca8 b0452460 00000001 d1ba2ca8 b0248c6c 010000a1 
       d1ba2ca8 b0452460 000000a1 b0248ff7 00000000 00000000 d1ba2d9c b0452460 
       00000000 b0245394 4088c8a0 d1ba2c24 ffffffff ef8e0080 b0452414 00000000 
Call Trace:
 [<b0248bb2>] ide_pio_sector+0x99/0xdf
 [<b0248c6c>] ide_pio_datablock+0x74/0x80
 [<b0248ff7>] do_rw_taskfile+0x10c/0x1bb
 [<b0245394>] ide_do_request+0x45c/0x7d3
 [<b01cbded>] __blk_end_request+0x30/0x37
 [<b01ca33f>] elv_queue_empty+0x1d/0x1e
 [<b0124348>] getnstimeofday+0x2b/0xac
 [<b01cacd3>] elv_insert+0x64/0x134
 [<b0245863>] ide_do_drive_cmd+0x8a/0xc4
 [<b0248aab>] ide_raw_taskfile+0x83/0x8e
 [<b01cdf34>] blk_end_sync_rq+0x0/0x24
 [<b0249937>] ide_taskfile_ioctl+0x354/0x419
 [<b02444c4>] generic_ide_ioctl+0x1d2/0x495
 [<b024c2e0>] idedisk_ioctl+0xb9/0x126
 [<b024c227>] idedisk_ioctl+0x0/0x126
 [<b01cea95>] blkdev_driver_ioctl+0x39/0x3f
 [<b01cf0f9>] blkdev_ioctl+0x65e/0x68d
 [<b01236f2>] atomic_notifier_call_chain+0x9/0xc
 [<b0217b92>] do_con_write+0x1777/0x17c0
 [<b01310e8>] generic_writepages+0x1a/0x21
 [<b020d8e4>] write_chan+0x283/0x298
 [<b011174f>] __wake_up+0xf/0x15
 [<b020a28e>] tty_ldisc_deref+0x43/0x49
 [<b015ec4e>] block_ioctl+0x0/0x13
 [<b015ec5e>] block_ioctl+0x10/0x13
 [<b014c1da>] vfs_ioctl+0x16/0x48
 [<b014c3f3>] do_vfs_ioctl+0x1e7/0x1f3
 [<b014c42b>] sys_ioctl+0x2c/0x45
 [<b01027fe>] sysenter_past_esp+0x5f/0x85
 =======================
Code: eb ff 54 24 04 8b 4f 08 85 c9 75 d0 c7 07 00 00 00 00 83 c4 0c 5b 5e 5f 5d c3 b9 58 9e 1d b0 ba 00 01 00 00 e9 8d ff ff ff 31 c9 <f6> 00 02 75 10 8d 48 10 8b 40 10 89 c2 83 e2 fc a8 01 0f 45 ca 
EIP: [<b01d9e1d>] sg_next+0x2/0x1a SS:ESP 0068:d1ba2bb8
---[ end trace 011499e041e7beb2 ]---
note: hdparm[17734] exited with preempt_count 1
BUG: scheduling while atomic: hdparm/17734/0x10000001
Pid: 17734, comm: hdparm Tainted: G      D  2.6.25-rc4 #47
 [<b03318a0>] schedule+0x3d/0x225
 [<b01119a3>] __cond_resched+0x13/0x2f
 [<b0331b1a>] _cond_resched+0x21/0x2a
 [<b0115531>] put_files_struct+0x5a/0x96
 [<b01163fb>] do_exit+0x198/0x4de
 [<b010321d>] die+0xe3/0xe8
 [<b010cd9e>] do_page_fault+0x430/0x4da
 [<b011780b>] irq_exit+0x3c/0x53
 [<b010c96e>] do_page_fault+0x0/0x4da
 [<b03328ea>] error_code+0x6a/0x70
 [<b01d9e1d>] sg_next+0x2/0x1a
 [<b0248bb2>] ide_pio_sector+0x99/0xdf
 [<b0248c6c>] ide_pio_datablock+0x74/0x80
 [<b0248ff7>] do_rw_taskfile+0x10c/0x1bb
 [<b0245394>] ide_do_request+0x45c/0x7d3
 [<b01cbded>] __blk_end_request+0x30/0x37
 [<b01ca33f>] elv_queue_empty+0x1d/0x1e
hdi: task_out_intr: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: 0x30
 [<b0124348>] getnstimeofday+0x2b/0xac
 [<b01cacd3>] elv_insert+0x64/0x134
 [<b0245863>] ide_do_drive_cmd+0x8a/0xc4
 [<b0248aab>] ide_raw_taskfile+0x83/0x8e
 [<b01cdf34>] blk_end_sync_rq+0x0/0x24
 [<b0249937>] ide_taskfile_ioctl+0x354/0x419
 [<b02444c4>] generic_ide_ioctl+0x1d2/0x495
 [<b024c2e0>] idedisk_ioctl+0xb9/0x126
 [<b024c227>] idedisk_ioctl+0x0/0x126
 [<b01cea95>] blkdev_driver_ioctl+0x39/0x3f
 [<b01cf0f9>] blkdev_ioctl+0x65e/0x68d
 [<b01236f2>] atomic_notifier_call_chain+0x9/0xc
 [<b0217b92>] do_con_write+0x1777/0x17c0
 [<b01310e8>] generic_writepages+0x1a/0x21
 [<b020d8e4>] write_chan+0x283/0x298
 [<b011174f>] __wake_up+0xf/0x15
 [<b020a28e>] tty_ldisc_deref+0x43/0x49
 [<b015ec4e>] block_ioctl+0x0/0x13
 [<b015ec5e>] block_ioctl+0x10/0x13
 [<b014c1da>] vfs_ioctl+0x16/0x48
 [<b014c3f3>] do_vfs_ioctl+0x1e7/0x1f3
 [<b014c42b>] sys_ioctl+0x2c/0x45
 [<b01027fe>] sysenter_past_esp+0x5f/0x85
 =======================
