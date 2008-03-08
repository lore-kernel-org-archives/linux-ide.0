From: "George Spelvin" <linux@horizon.com>
Subject: 2.6.25-rc4 IDE BUG()
Date: Sat, 08 Mar 2008 18:45:13 -0500
Message-ID: <20080308234513.20537.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:13676 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751498AbYCIAQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 19:16:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

32-bit x86, PDC20268 controller, IBM IC35L060AVER07 PATA drive.
Kernel is 2.6.24-rc4 plus two local patches (linuxpps & EDAC) that
have nothing to do with IDE.

The circumstances are perhaps a bit odd.  I have hdi in a removeable
drive tray (aluminum "mobile rack"), and had left it powered off when
starting multi-user mode.  Starting the hddtemp daemon produced some
complaints and a stuck task, so I turned the drive on and tried "hdparm
-w /dev/hdi" to clean things up, and I got the following BUG message.
Now that I'm in this state, it's perfectly repeatable.

Not exactly a common situation, but I figured a BUG() is always worth
reporting.

hdi: task_no_data_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdi: task_no_data_intr: error=0x65 { DriveStatusError UncorrectableError AddrMarkNotFound }, CHS=2056/8/8, sector=0
ide: failed opcode was: 0xe5
hdi: task_no_data_intr: status=0x18 { SeekComplete DataRequest }
ide: failed opcode was: 0x98
hdi: task_no_data_intr: status=0x30 { DeviceFault SeekComplete }
ide: failed opcode was: 0xb0
INFO: task hddtemp:2885 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
hddtemp       D 00000082     0  2885      1
       eaa06600 00000086 ef8bd340 00000082 eac5fbd4 7fffffff eac5fbbc 00000002 
       b0331b45 00000000 00000000 00000000 00000000 00000000 00000000 eac5fbd4 
       7fffffff b033179d 00000001 ec2be550 b0110d0d eac5fbd8 eac5fbd8 00000000 
Call Trace:
 [<b0331b45>] schedule_timeout+0x13/0x8d
 [<b033179d>] wait_for_common+0xb6/0x10f
 [<b0110d0d>] default_wake_function+0x0/0x5
 [<b0245881>] ide_do_drive_cmd+0xa8/0xc4
 [<b0248aab>] ide_raw_taskfile+0x83/0x8e
 [<b01cdf34>] blk_end_sync_rq+0x0/0x24
 [<b0249346>] ide_cmd_ioctl+0x1a8/0x23a
 [<b014ff4d>] dput+0x15/0xac
 [<b014a720>] __link_path_walk+0x823/0x954
 [<b01505b4>] __d_lookup+0x84/0xc6
 [<b0149093>] do_lookup+0x53/0x145
 [<b014ff4d>] dput+0x15/0xac
 [<b014a720>] __link_path_walk+0x823/0x954
 [<b02444e9>] generic_ide_ioctl+0x1f7/0x495
 [<b0149093>] do_lookup+0x53/0x145
 [<b014ff4d>] dput+0x15/0xac
 [<b014a720>] __link_path_walk+0x823/0x954
 [<b01505b4>] __d_lookup+0x84/0xc6
 [<b024c2e0>] idedisk_ioctl+0xb9/0x126
 [<b024c227>] idedisk_ioctl+0x0/0x126
 [<b01cea95>] blkdev_driver_ioctl+0x39/0x3f
 [<b01cf0f9>] blkdev_ioctl+0x65e/0x68d
 [<b012e215>] generic_file_aio_read+0x453/0x49a
 [<b012c7c3>] find_lock_page+0x15/0x60
 [<b012fca6>] get_page_from_freelist+0x74/0x300
 [<b01305a9>] __alloc_pages+0x57/0x2bc
 [<b01322d1>] __pagevec_lru_add_active+0x76/0x81
 [<b015ec4e>] block_ioctl+0x0/0x13
 [<b015ec5e>] block_ioctl+0x10/0x13
 [<b014c1da>] vfs_ioctl+0x16/0x48
 [<b014c3f3>] do_vfs_ioctl+0x1e7/0x1f3
 [<b010cb67>] do_page_fault+0x1f9/0x4da
 [<b014c42b>] sys_ioctl+0x2c/0x45
 [<b01027fe>] sysenter_past_esp+0x5f/0x85
 [<b0330000>] i8042_probe+0x161/0x4da
 =======================
------------[ cut here ]------------
Kernel BUG at b0244679 [verbose debug info unavailable]
invalid opcode: 0000 [#1] 

Pid: 6673, comm: hdparm Not tainted (2.6.25-rc4 #47)
EIP: 0060:[<b0244679>] EFLAGS: 00010082 CPU: 0
EIP is at generic_ide_ioctl+0x387/0x495
EAX: ef8bd340 EBX: b0452460 ECX: 00000003 EDX: 00000000
ESI: 00000000 EDI: 00000202 EBP: 00000000 ESP: eaa3add0
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process hdparm (pid: 6673, ti=eaa3a000 task=ec171a90 task.ti=eaa3a000)
Stack: ef40ad00 eaa3af38 eaa3af38 ef50bb80 ef86d67c b0149093 eaa3ae34 eaa3ae28 
       eaa3af38 ef0b9780 eaa3af38 00252a3a b014ff4d eaa3af38 b014a720 eaaba008 
       00000101 b01505b4 eb1cf180 b0452460 00000000 00000000 b024c2e0 0000031c 
Call Trace:
 [<b0149093>] do_lookup+0x53/0x145
 [<b014ff4d>] dput+0x15/0xac
 [<b014a720>] __link_path_walk+0x823/0x954
 [<b01505b4>] __d_lookup+0x84/0xc6
 [<b024c2e0>] idedisk_ioctl+0xb9/0x126
 [<b024c227>] idedisk_ioctl+0x0/0x126
 [<b01cea95>] blkdev_driver_ioctl+0x39/0x3f
 [<b01cf0f9>] blkdev_ioctl+0x65e/0x68d
 [<b0214d6d>] notify_update+0x1f/0x22
 [<b0217b92>] do_con_write+0x1777/0x17c0
 [<b012c7c3>] find_lock_page+0x15/0x60
 [<b012e41f>] filemap_fault+0x18c/0x2d0
 [<b0135b27>] __do_fault+0x27c/0x2b6
 [<b0136a89>] handle_mm_fault+0x208/0x440
 [<b015ec4e>] block_ioctl+0x0/0x13
 [<b015ec5e>] block_ioctl+0x10/0x13
 [<b014c1da>] vfs_ioctl+0x16/0x48
 [<b014c3f3>] do_vfs_ioctl+0x1e7/0x1f3
 [<b010cb67>] do_page_fault+0x1f9/0x4da
 [<b014c42b>] sys_ioctl+0x2c/0x45
 [<b01027fe>] sysenter_past_esp+0x5f/0x85
 =======================
Code: 40 08 f6 40 08 04 74 0c 57 9d ba f0 ff ff ff e9 1b 01 00 00 ba 42 3f 3b b0 89 d8 e8 b1 10 00 00 8b 43 24 8b 40 08 83 38 00 74 04 <0f> 0b eb fe c7 40 04 01 00 00 00 57 9d 89 d8 e8 19 1c 00 00 e9 
EIP: [<b0244679>] generic_ide_ioctl+0x387/0x495 SS:ESP 0068:eaa3add0
---[ end trace 011499e041e7beb2 ]---
------------[ cut here ]------------
Kernel BUG at b0244679 [verbose debug info unavailable]
invalid opcode: 0000 [#2] 

Pid: 6943, comm: hdparm Tainted: G      D  (2.6.25-rc4 #47)
EIP: 0060:[<b0244679>] EFLAGS: 00010082 CPU: 0
EIP is at generic_ide_ioctl+0x387/0x495
EAX: ef8bd340 EBX: b0452460 ECX: ef40ad15 EDX: 00000000
ESI: 00000000 EDI: 00000202 EBP: 00000000 ESP: eaab5dd0
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process hdparm (pid: 6943, ti=eaab5000 task=eae94aa0 task.ti=eaab5000)
Stack: ef40ad00 eaab5f38 eaab5f38 ef50bb80 ef86d67c b0149093 eaab5e34 eaab5e28 
       eaab5f38 ef0b9780 eaab5f38 00252a3a b014ff4d eaab5f38 b014a720 eae70008 
       00000101 b01505b4 ec24b000 b0452460 00000000 00000000 b024c2e0 0000031c 
Call Trace:
 [<b0149093>] do_lookup+0x53/0x145
 [<b014ff4d>] dput+0x15/0xac
 [<b014a720>] __link_path_walk+0x823/0x954
 [<b01505b4>] __d_lookup+0x84/0xc6
 [<b024c2e0>] idedisk_ioctl+0xb9/0x126
 [<b024c227>] idedisk_ioctl+0x0/0x126
 [<b01cea95>] blkdev_driver_ioctl+0x39/0x3f
 [<b01cf0f9>] blkdev_ioctl+0x65e/0x68d
 [<b01236f2>] atomic_notifier_call_chain+0x9/0xc
 [<b0217b92>] do_con_write+0x1777/0x17c0
 [<b012c7c3>] find_lock_page+0x15/0x60
 [<b012e41f>] filemap_fault+0x18c/0x2d0
 [<b0135b27>] __do_fault+0x27c/0x2b6
 [<b0136a89>] handle_mm_fault+0x208/0x440
 [<b015ec4e>] block_ioctl+0x0/0x13
 [<b015ec5e>] block_ioctl+0x10/0x13
 [<b014c1da>] vfs_ioctl+0x16/0x48
 [<b014c3f3>] do_vfs_ioctl+0x1e7/0x1f3
 [<b010cb67>] do_page_fault+0x1f9/0x4da
 [<b014c42b>] sys_ioctl+0x2c/0x45
 [<b01027fe>] sysenter_past_esp+0x5f/0x85
 =======================
Code: 40 08 f6 40 08 04 74 0c 57 9d ba f0 ff ff ff e9 1b 01 00 00 ba 42 3f 3b b0 89 d8 e8 b1 10 00 00 8b 43 24 8b 40 08 83 38 00 74 04 <0f> 0b eb fe c7 40 04 01 00 00 00 57 9d 89 d8 e8 19 1c 00 00 e9 
EIP: [<b0244679>] generic_ide_ioctl+0x387/0x495 SS:ESP 0068:eaab5dd0
---[ end trace 011499e041e7beb2 ]---
