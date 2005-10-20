From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Thu, 20 Oct 2005 09:51:15 +0200
Message-ID: <43574C73.4000404@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:62928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751780AbVJTHva (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2005 03:51:30 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Timothy Thelin wrote:
>>hdparm-6.3 is now out, with working security commands.
>>
>>But there is still a bug deep in the IDE taskfile code
>>that sometimes causes problems.  Someday I might have time
>>to dig deeper into the kernel and fix that issue.
>>
> 
> 
> And what bug is this? (Sorry if you already stated it, I didn't see it while
> going through the archives of this conversation).  I use taskfile and have a
> vested interest in getting all taskfile bugs fixed.  FYI there was a bug
> where pio-out taskfile commands could oops because of a null request
> pointer; the patch I submitted for that one should be in the 2.6.14 rc
> series now.
> 
> Regards,
> Tim Thelin
> 
> 

at runlevel 1 i get marks crashes too, first the null pointer (which is
evertime at same address and hopefully fixed with tims patch) then after
journal commit intervall (mounted xfs,ext3) panic in irq handler and on
unmounted drives lost interrupt without system stall.

(yes i want to be able to seclock down mounted fs drives)

strange: with the system full running at level 2 i got only what i
reported yesterday on 4 tries.

ive setup a debug 2.6.13.4 and check now, but i can patch up to latest
2.6.14 rc.

no logs from the irq-handler panic so far.


Oct 19 19:37:25 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:37:25 tom1 kernel:  printing eip:
Oct 19 19:37:25 tom1 kernel: c0369c6c
Oct 19 19:37:25 tom1 kernel: *pde = 00000000
Oct 19 19:37:25 tom1 kernel: Oops: 0000 [#1]
Oct 19 19:37:25 tom1 kernel: PREEMPT
Oct 19 19:37:25 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:37:25 tom1 kernel: CPU:    0
Oct 19 19:37:25 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:37:25 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:37:25 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:37:25 tom1 kernel: eax: 00000000   ebx: c0535df8   ecx:
ffff753e   edx: c05217d8
Oct 19 19:37:25 tom1 kernel: esi: 00000000   edi: c0535df8   ebp:
de1e9e18   esp: de1e9c54
Oct 19 19:37:25 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:37:25 tom1 kernel: Process hdparm (pid: 4439,
threadinfo=de1e8000 task=df3f1020)
Oct 19 19:37:25 tom1 kernel: Stack: c0535df8 c0369aa0 00001d4c 00000000
00000019 de1e9e10 de1e9e10 c0535b70
Oct 19 19:37:25 tom1 kernel:        c036a741 c0535df8 00000000 e0802f87
40000000 00001000 00000000 00000000
Oct 19 19:37:25 tom1 kernel:        c0535df8 de1e9d34 c0363e15 c0535df8
de1e9e10 00000040 00000088 000004e2
Oct 19 19:37:25 tom1 kernel: Call Trace:
Oct 19 19:37:25 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:37:25 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:37:25 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:37:25 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:37:25 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:37:25 tom1 kernel:  [__find_get_block+110/256]
__find_get_block+0x6e/0x100
Oct 19 19:37:25 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:37:25 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:37:25 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:37:25 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:37:25 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:37:25 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:37:25 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:37:25 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:37:25 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:37:25 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:37:25 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:37:25 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:37:25 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:37:25 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:37:25 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05

Oct 19 19:43:05 tom1 kernel: hde: status timeout: status=0xd0 { Busy }
Oct 19 19:43:05 tom1 kernel: ide: failed opcode was: 0xf2
Oct 19 19:43:05 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT
Oct 19 19:43:30 tom1 kernel: hde: status timeout: status=0xd0 { Busy }
Oct 19 19:43:30 tom1 kernel: ide: failed opcode was: 0xf2
Oct 19 19:43:30 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT
Oct 19 19:43:30 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:43:30 tom1 kernel:  printing eip:
Oct 19 19:43:30 tom1 kernel: c0369c6c
Oct 19 19:43:30 tom1 kernel: *pde = 00000000
Oct 19 19:43:30 tom1 kernel: Oops: 0000 [#1]
Oct 19 19:43:30 tom1 kernel: PREEMPT
Oct 19 19:43:30 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:43:30 tom1 kernel: CPU:    0
Oct 19 19:43:30 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:43:30 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:43:30 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:43:30 tom1 kernel: eax: 00000000   ebx: c0535c00   ecx:
ffffc48d   edx: c0521850
Oct 19 19:43:30 tom1 kernel: esi: 00000000   edi: c0535c00   ebp:
ddda7e18   esp: ddda7c54
Oct 19 19:43:30 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:43:30 tom1 kernel: Process hdparm (pid: 4439,
threadinfo=ddda6000 task=df31c5a0)
Oct 19 19:43:30 tom1 kernel: Stack: c0535c00 c0369aa0 00001d4c 00000000
00000019 ddda7e10 ddda7e10 c0535b70
Oct 19 19:43:30 tom1 kernel:        c036a741 c0535c00 00000000 e0802f87
40000000 00000000 00000000 00000000
Oct 19 19:43:30 tom1 kernel:        c0535c00 ddda7d34 c0363e15 c0535c00
ddda7e10 00000040 00000088 000004e2
Oct 19 19:43:30 tom1 kernel: Call Trace:
Oct 19 19:43:30 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:43:30 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:43:30 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:43:30 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:43:30 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:43:30 tom1 kernel:  [ext3_mark_iloc_dirty+40/64]
ext3_mark_iloc_dirty+0x28/0x40
Oct 19 19:43:30 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:43:30 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:43:30 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:43:30 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:43:30 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:43:30 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:43:30 tom1 kernel:  [preempt_schedule+74/112]
preempt_schedule+0x4a/0x70
Oct 19 19:43:30 tom1 kernel:  [preempt_schedule+74/112]
preempt_schedule+0x4a/0x70
Oct 19 19:43:30 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:43:30 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:43:30 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:43:30 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:43:30 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:43:30 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:43:30 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:43:30 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:43:30 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05
Oct 19 19:44:00 tom1 kernel:  <4>hde: lost interrupt
Oct 19 19:44:01 tom1 kernel: hde: task_out_intr: status=0x51 {
DriveReady SeekComplete Error }
Oct 19 19:44:01 tom1 kernel: hde: task_out_intr: error=0x04 {
DriveStatusError }
Oct 19 19:44:01 tom1 kernel: ide: failed opcode was: 0xf6
Oct 19 19:45:08 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:45:08 tom1 kernel:  printing eip:
Oct 19 19:45:08 tom1 kernel: c0369c6c
Oct 19 19:45:08 tom1 kernel: *pde = 00000000
Oct 19 19:45:08 tom1 kernel: Oops: 0000 [#2]
Oct 19 19:45:08 tom1 kernel: PREEMPT
Oct 19 19:45:08 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:45:08 tom1 kernel: CPU:    0
Oct 19 19:45:08 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:45:08 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:45:08 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:45:08 tom1 kernel: eax: 00000000   ebx: c0535df8   ecx:
000023ef   edx: c0521750
Oct 19 19:45:08 tom1 kernel: esi: 00000000   edi: c0535df8   ebp:
ddda7e18   esp: ddda7c54
Oct 19 19:45:08 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:45:08 tom1 kernel: Process hdparm (pid: 4441,
threadinfo=ddda6000 task=df31c5a0)
Oct 19 19:45:08 tom1 kernel: Stack: c0535df8 c0369aa0 00001d4c 00000000
00000019 ddda7e10 ddda7e10 c0535b70
Oct 19 19:45:08 tom1 kernel:        c036a741 c0535df8 00000000 e0802f87
40000000 00001000 00000000 00000000
Oct 19 19:45:08 tom1 kernel:        c0535df8 ddda7d34 c0363e15 c0535df8
ddda7e10 00000040 00000088 000004e2
Oct 19 19:45:08 tom1 kernel: Call Trace:
Oct 19 19:45:08 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:45:08 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:45:08 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:45:08 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:45:08 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:45:08 tom1 kernel:  [__find_get_block+110/256]
__find_get_block+0x6e/0x100
Oct 19 19:45:08 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:45:08 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:45:08 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:45:08 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:45:08 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:45:08 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:45:08 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:45:08 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:45:08 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:45:08 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:45:08 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:45:08 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:45:08 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:45:08 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:45:08 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05
Oct 19 19:45:38 tom1 kernel:  <4>hdf: lost interrupt
Oct 19 19:46:50 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:46:50 tom1 kernel:  printing eip:
Oct 19 19:46:50 tom1 kernel: c0369c6c
Oct 19 19:46:50 tom1 kernel: *pde = 00000000
Oct 19 19:46:50 tom1 kernel: Oops: 0000 [#3]
Oct 19 19:46:50 tom1 kernel: PREEMPT
Oct 19 19:46:50 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:46:50 tom1 kernel: CPU:    0
Oct 19 19:46:50 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:46:50 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:46:50 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:46:50 tom1 kernel: eax: 00000000   ebx: c0535df8   ecx:
0000878c   edx: c0521868
Oct 19 19:46:50 tom1 kernel: esi: 00000000   edi: c0535df8   ebp:
ddda7e18   esp: ddda7c54
Oct 19 19:46:50 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:46:50 tom1 kernel: Process hdparm (pid: 4442,
threadinfo=ddda6000 task=df31cac0)
Oct 19 19:46:50 tom1 kernel: Stack: c0535df8 c0369aa0 00001d4c 00000000
00000019 ddda7e10 ddda7e10 c0535b70
Oct 19 19:46:50 tom1 kernel:        c036a741 c0535df8 00000000 e0802f87
40000000 00000000 00000000 00000000
Oct 19 19:46:50 tom1 kernel:        c0535df8 ddda7d34 c0363e15 c0535df8
ddda7e10 00000040 00000088 000004e2
Oct 19 19:46:50 tom1 kernel: Call Trace:
Oct 19 19:46:50 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:46:50 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:46:50 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:46:50 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:46:50 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:46:50 tom1 kernel:  [ext3_mark_iloc_dirty+40/64]
ext3_mark_iloc_dirty+0x28/0x40
Oct 19 19:46:50 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:46:50 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:46:50 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:46:50 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:46:50 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:46:50 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:46:50 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:46:50 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:46:50 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:46:50 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:46:50 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:46:50 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:46:50 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:46:50 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:46:50 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05
Oct 19 19:47:20 tom1 kernel:  <4>hdf: lost interrupt
Oct 19 19:52:00 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:52:00 tom1 kernel:  printing eip:
Oct 19 19:52:00 tom1 kernel: c0369c6c
Oct 19 19:52:00 tom1 kernel: *pde = 00000000
Oct 19 19:52:00 tom1 kernel: Oops: 0000 [#4]
Oct 19 19:52:00 tom1 kernel: PREEMPT
Oct 19 19:52:00 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:52:00 tom1 kernel: CPU:    0
Oct 19 19:52:00 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:52:00 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:52:00 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:52:00 tom1 kernel: eax: 00000000   ebx: c0535df8   ecx:
0001b5eb   edx: c05217e0
Oct 19 19:52:00 tom1 kernel: esi: 00000000   edi: c0535df8   ebp:
ddda7e18   esp: ddda7c54
Oct 19 19:52:00 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:52:00 tom1 kernel: Process hdparm (pid: 4448,
threadinfo=ddda6000 task=df31cac0)
Oct 19 19:52:00 tom1 kernel: Stack: c0535df8 c0369aa0 00001d4c 00000000
00000019 ddda7e10 ddda7e10 c0535b70
Oct 19 19:52:00 tom1 kernel:        c036a741 c0535df8 00000000 e0802f87
40000000 00000000 00000000 00000000
Oct 19 19:52:00 tom1 kernel:        c0535df8 ddda7d34 c0363e15 c0535df8
ddda7e10 00000040 00000088 000004e2
Oct 19 19:52:00 tom1 kernel: Call Trace:
Oct 19 19:52:00 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:52:00 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:52:00 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:52:00 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:52:00 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:52:00 tom1 kernel:  [ext3_mark_iloc_dirty+40/64]
ext3_mark_iloc_dirty+0x28/0x40
Oct 19 19:52:00 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:52:00 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:52:00 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:52:00 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:52:00 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:52:00 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:52:00 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:52:00 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:52:00 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:52:00 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:52:00 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:52:00 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:52:00 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:52:00 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:52:00 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05
Oct 19 19:52:30 tom1 kernel:  <4>hdf: lost interrupt
Oct 19 19:53:54 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 19:53:54 tom1 kernel:  printing eip:
Oct 19 19:53:54 tom1 kernel: c0369c6c
Oct 19 19:53:54 tom1 kernel: *pde = 00000000
Oct 19 19:53:54 tom1 kernel: Oops: 0000 [#5]
Oct 19 19:53:54 tom1 kernel: PREEMPT
Oct 19 19:53:54 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib uhci_hcd usbcore dm_mod evdev w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 19:53:54 tom1 kernel: CPU:    0
Oct 19 19:53:54 tom1 kernel: EIP:    0060:[pre_task_out_intr+188/272]
 Not tainted VLI
Oct 19 19:53:54 tom1 kernel: EFLAGS: 00010096   (2.6.13.4)
Oct 19 19:53:54 tom1 kernel: EIP is at pre_task_out_intr+0xbc/0x110
Oct 19 19:53:54 tom1 kernel: eax: 00000000   ebx: c0535df8   ecx:
00022517   edx: c0521758
Oct 19 19:53:54 tom1 kernel: esi: 00000000   edi: c0535df8   ebp:
ddda7e18   esp: ddda7c54
Oct 19 19:53:54 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 19:53:54 tom1 kernel: Process hdparm (pid: 4451,
threadinfo=ddda6000 task=df31c5a0)
Oct 19 19:53:54 tom1 kernel: Stack: c0535df8 c0369aa0 00001d4c 00000000
00000019 ddda7e10 ddda7e10 c0535b70
Oct 19 19:53:54 tom1 kernel:        c036a741 c0535df8 00000000 e0802f87
40000000 00000000 00000000 00000000
Oct 19 19:53:54 tom1 kernel:        c0535df8 ddda7d34 c0363e15 c0535df8
ddda7e10 00000040 00000088 000004e2
Oct 19 19:53:54 tom1 kernel: Call Trace:
Oct 19 19:53:54 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:53:54 tom1 kernel:  [flagged_taskfile+337/848]
flagged_taskfile+0x151/0x350
Oct 19 19:53:54 tom1 kernel:  [start_request+341/576]
start_request+0x155/0x240
Oct 19 19:53:54 tom1 kernel:  [ide_do_request+519/928]
ide_do_request+0x207/0x3a0
Oct 19 19:53:54 tom1 kernel:  [ide_do_drive_cmd+204/304]
ide_do_drive_cmd+0xcc/0x130
Oct 19 19:53:54 tom1 kernel:  [ext3_mark_iloc_dirty+40/64]
ext3_mark_iloc_dirty+0x28/0x40
Oct 19 19:53:54 tom1 kernel:  [ide_diag_taskfile+158/208]
ide_diag_taskfile+0x9e/0xd0
Oct 19 19:53:54 tom1 kernel:  [blk_end_sync_rq+0/64]
blk_end_sync_rq+0x0/0x40
Oct 19 19:53:54 tom1 kernel:  [ide_taskfile_ioctl+436/1136]
ide_taskfile_ioctl+0x1b4/0x470
Oct 19 19:53:54 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 19:53:54 tom1 kernel:  [task_out_intr+0/272] task_out_intr+0x0/0x110
Oct 19 19:53:54 tom1 kernel:  [generic_ide_ioctl+733/1536]
generic_ide_ioctl+0x2dd/0x600
Oct 19 19:53:54 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 19:53:54 tom1 kernel:  [blkdev_driver_ioctl+82/144]
blkdev_driver_ioctl+0x52/0x90
Oct 19 19:53:54 tom1 kernel:  [blkdev_ioctl+168/432] blkdev_ioctl+0xa8/0x1b0
Oct 19 19:53:54 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 19:53:54 tom1 kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Oct 19 19:53:54 tom1 kernel:  [vfs_ioctl+101/480] vfs_ioctl+0x65/0x1e0
Oct 19 19:53:54 tom1 kernel:  [sys_ioctl+103/192] sys_ioctl+0x67/0xc0
Oct 19 19:53:54 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 19:53:54 tom1 kernel: Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 a0 9a 36 c0 89
1c 24 e8 64 be ff ff <8b> 46 2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43
6c 8b 80 48 05
Oct 19 19:54:24 tom1 kernel:  <4>hdf: lost interrupt
Oct 19 19:54:48 tom1 shutdown[4452]: shutting down for system reboot
Oct 19 19:54:48 tom1 exiting on signal 15
Oct 19 19:57:08 tom1 syslogd 1.4.1#17: restart.
Oct 19 19:58:47 tom1 shutdown[5027]: shutting down for system reboot
Oct 19 19:58:47 tom1 init: Switching to runlevel: 6
Oct 19 19:58:56 tom1 kernel: apm: BIOS not found.
Oct 19 19:58:56 tom1 modprobe: FATAL: Error inserting apm
(/lib/modules/2.6.12-1-k7/kernel/arch/i386/kernel/apm.ko): No such device
Oct 19 19:58:58 tom1 postfix/postfix-script: fatal: the Postfix mail
system is not running
Oct 19 19:59:00 tom1 kernel: Bluetooth: Core ver 2.7
Oct 19 19:59:00 tom1 kernel: NET: Registered protocol family 31
Oct 19 19:59:00 tom1 kernel: Bluetooth: HCI device and connection
manager initialized
Oct 19 19:59:00 tom1 kernel: Bluetooth: HCI socket layer initialized
Oct 19 19:59:00 tom1 kernel: Bluetooth: L2CAP ver 2.7
Oct 19 19:59:00 tom1 kernel: Bluetooth: L2CAP socket layer initialized
Oct 19 19:59:00 tom1 kernel: Bluetooth: RFCOMM ver 1.5
Oct 19 19:59:00 tom1 kernel: Bluetooth: RFCOMM socket layer initialized
Oct 19 19:59:00 tom1 kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 19 19:59:00 tom1 kernel: Kernel logging (proc) stopped.
Oct 19 19:59:00 tom1 kernel: Kernel log daemon terminating.
Oct 19 19:59:00 tom1 exiting on signal 15
Oct 19 20:00:53 tom1 syslogd 1.4.1#17: restart.
Oct 19 20:01:04 tom1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000002c
Oct 19 20:01:04 tom1 kernel:  printing eip:
Oct 19 20:01:04 tom1 kernel: c038b38f
Oct 19 20:01:04 tom1 kernel: *pde = 00000000
Oct 19 20:01:04 tom1 kernel: Oops: 0000 [#1]
Oct 19 20:01:04 tom1 kernel: PREEMPT
Oct 19 20:01:04 tom1 kernel: Modules linked in: af_packet ide_cd cdrom
psmouse pcspkr ns558 floppy via_agp agpgart via_rhine mii ehci_hcd
snd_usb_audio snd_usb_lib spca5xx uhci_hcd usbcore evdev dm_mod w83627hf
i2c_sensor i2c_isa i2c_viapro dvb_ttpci dvb_core l64781 saa7146_vv
video_buf saa7146 v4l1_compat v4l2_common videodev ves1820 stv0299
tda8083 stv0297 sp8870 firmware_class crc32 ves1x93 ttpci_eeprom
i2c_core snd_via82xx snd_ac97_codec snd_cmipci gameport snd_pcm_oss
snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc unix
Oct 19 20:01:04 tom1 kernel: CPU:    0
Oct 19 20:01:04 tom1 kernel: EIP:    0060:[pre_task_out_intr+175/272]
 Not tainted VLI
Oct 19 20:01:04 tom1 kernel: EFLAGS: 00010082   (2.6.13)
Oct 19 20:01:04 tom1 kernel: EIP is at pre_task_out_intr+0xaf/0x110
Oct 19 20:01:04 tom1 kernel: eax: 00000000   ebx: 00000000   ecx:
ffff2578   edx: c053d738
Oct 19 20:01:04 tom1 kernel: esi: c0551db8   edi: c0551db8   ebp:
de715d40   esp: de715c90
Oct 19 20:01:04 tom1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 20:01:04 tom1 kernel: Process hdparm (pid: 4626,
threadinfo=de714000 task=c17af540)
Oct 19 20:01:04 tom1 kernel: Stack: c0551db8 c038b180 00001d4c 00000000
00000019 00000000 00000000 00000000
Oct 19 20:01:04 tom1 kernel:        c0384cac c0551db8 00000000 00000040
00000088 000004e2 de715d40 de714000
Oct 19 20:01:04 tom1 kernel:        c0551db8 de715d40 c0551b30 c0384fc4
c0551db8 de715d40 ffffffff dfdae380
Oct 19 20:01:04 tom1 kernel: Call Trace:
Oct 19 20:01:04 tom1 kernel:  [task_out_intr+0/352] task_out_intr+0x0/0x160
Oct 19 20:01:04 tom1 kernel:  [start_request+540/736]
start_request+0x21c/0x2e0
Oct 19 20:01:04 tom1 kernel:  [ide_do_request+548/1024]
ide_do_request+0x224/0x400
Oct 19 20:01:04 tom1 kernel:  [ide_do_drive_cmd+197/336]
ide_do_drive_cmd+0xc5/0x150
Oct 19 20:01:04 tom1 kernel:  [ide_diag_taskfile+182/256]
ide_diag_taskfile+0xb6/0x100
Oct 19 20:01:04 tom1 kernel:  [blk_end_sync_rq+0/48]
blk_end_sync_rq+0x0/0x30
Oct 19 20:01:04 tom1 kernel:  [ide_taskfile_ioctl+741/1152]
ide_taskfile_ioctl+0x2e5/0x480
Oct 19 20:01:04 tom1 kernel:  [pre_task_out_intr+0/272]
pre_task_out_intr+0x0/0x110
Oct 19 20:01:04 tom1 kernel:  [task_out_intr+0/352] task_out_intr+0x0/0x160
Oct 19 20:01:04 tom1 kernel:  [generic_ide_ioctl+1508/1568]
generic_ide_ioctl+0x5e4/0x620
Oct 19 20:01:04 tom1 kernel:  [avc_has_perm+48/64] avc_has_perm+0x30/0x40
Oct 19 20:01:04 tom1 kernel:  [inode_has_perm+85/144]
inode_has_perm+0x55/0x90
Oct 19 20:01:04 tom1 kernel:  [idedisk_ioctl+58/64] idedisk_ioctl+0x3a/0x40
Oct 19 20:01:04 tom1 kernel:  [blkdev_driver_ioctl+131/176]
blkdev_driver_ioctl+0x83/0xb0
Oct 19 20:01:04 tom1 kernel:  [blkdev_ioctl+352/496]
blkdev_ioctl+0x160/0x1f0
Oct 19 20:01:04 tom1 kernel:  [block_ioctl+43/48] block_ioctl+0x2b/0x30
Oct 19 20:01:04 tom1 kernel:  [do_ioctl+59/160] do_ioctl+0x3b/0xa0
Oct 19 20:01:04 tom1 kernel:  [vfs_ioctl+107/560] vfs_ioctl+0x6b/0x230
Oct 19 20:01:04 tom1 kernel:  [sys_ioctl+136/160] sys_ioctl+0x88/0xa0
Oct 19 20:01:04 tom1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 20:01:04 tom1 kernel: Code: 5e c3 80 be 8e 00 00 00 00 74 61 c7
44 24 0c 00 00 00 00 c7 44 24 08 4c 1d 00 00 c7 44 24 04 80 b1 38 c0 89
34 24 e8 61 b8 ff ff <8b> 43 2c 85 c0 74 07 c7 43 44 00 00 00 00 8b 46
6c 8b 80 48 05













