From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13520] New: WARNING: at lib/dma-debug.c:576
 check_for_illegal_area+0xd3/0xfd()
Date: Fri, 12 Jun 2009 13:43:11 GMT
Message-ID: <bug-13520-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34450 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933672AbZFLNnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 09:43:10 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5CDhBpD005173
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 13:43:11 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13520

           Summary: WARNING: at lib/dma-debug.c:576
                    check_for_illegal_area+0xd3/0xfd()
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: randrik@mail.ru
        Regression: No


Created an attachment (id=21877)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21877)
My .config

Nothing dangerous, I hope, but i saw this warning twice.



Adding 399992k swap on /swap.file.  Priority:-1 extents:728 across:2152036k
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:576 check_for_illegal_area+0xd3/0xfd()
Hardware name: MS-6380E
VIA_IDE 0000:00:11.1: DMA-API: device driver maps memory from kernel text or
rodata [addr=c0ffc000] [size=16384]
Modules linked in: snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss sg sd_mod ipv6 nfsd lockd nfs_acl auth_rpcgss sunrpc
usb_storage scsi_mod usb_libusual tuner_simple tuner_types tda9887 tda8290
nouveau ppdev snd_cs4236 snd_mpu401 ttm snd_wavefront uhci_hcd fb saa7134
snd_emu10k1 snd_via82xx snd_ac97_codec snd_wss_lib ac97_bus ehci_hcd ir_common
snd_opl3_lib snd_mpu401_uart snd_pcm videobuf_dma_sg snd_timer snd_page_alloc
snd_rawmidi videobuf_core tveeprom snd_util_mem snd_seq_device snd_hwdep
rtc_cmos drm usbcore i2c_algo_bit cfbcopyarea emu10k1_gp cfbimgblt cfbfillrect
rtc_core parport_pc rtc_lib ns558 snd 8139too floppy parport soundcore gameport
shpchp via_agp pci_hotplug xfs exportfs ufs agpgart tuner v4l2_common videodev
v4l1_compat w83627hf hwmon_vid hwmon i2c_viapro i2c_dev
Pid: 87, comm: kblockd/0 Not tainted 2.6.30-i486 #4
Call Trace:
 [<c1031c86>] warn_slowpath_common+0x65/0x95
 [<c1031cf4>] warn_slowpath_fmt+0x29/0x2c
 [<c11611df>] check_for_illegal_area+0xd3/0xfd
 [<c11622a4>] debug_dma_map_sg+0x13b/0x147
 [<c11cfae1>] ide_dma_prepare+0xc2/0x10b
 [<c11cbaba>] do_rw_taskfile+0x221/0x261
 [<c11d9990>] ide_do_rw_disk+0x23d/0x2b4
 [<c114ee9b>] ? delay_tsc+0x47/0x6c
 [<c11d9077>] ide_gd_do_request+0xf/0x12
 [<c11c8cc8>] do_ide_request+0x345/0x4a1
 [<c105374a>] ? trace_hardirqs_off_caller+0x18/0xa3
 [<c10537e0>] ? trace_hardirqs_off+0xb/0xd
 [<c128f8e1>] ? _spin_unlock_irqrestore+0x34/0x41
 [<c103ae8f>] ? del_timer+0x4a/0x52
 [<c113d670>] ? blk_remove_plug+0x109/0x114
 [<c113d736>] __generic_unplug_device+0x46/0x4a
 [<c113d77b>] blk_start_queueing+0x41/0x45
 [<c1146460>] cfq_kick_queue+0x21/0x2f
 [<c10412b2>] worker_thread+0x1d4/0x2ce
 [<c1041265>] ? worker_thread+0x187/0x2ce
 [<c114643f>] ? cfq_kick_queue+0x0/0x2f
 [<c1044d0c>] ? autoremove_wake_function+0x0/0x38
 [<c10410de>] ? worker_thread+0x0/0x2ce
 [<c1044a09>] kthread+0x4a/0x70
 [<c10449bf>] ? kthread+0x0/0x70
 [<c1003a87>] kernel_thread_helper+0x7/0x10
---[ end trace fa41507272d4fe04 ]---

and second time today

reconnect_path: npd != pd
mtrr: no MTRR for c0000000,10000000 found
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:576 check_for_illegal_area+0xd3/0xfd()
Hardware name: MS-6380E
VIA_IDE 0000:00:11.1: DMA-API: device driver maps memory from kernel text or
rodata [addr=c0fff000] [size=4096]
Modules linked in: sg sd_mod snd_seq_dummy snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss ipv6 nfsd lockd nfs_acl auth_rpcgss sunrpc
usb_storage scsi_mod usb_libusual tuner_simple tuner_types tda9887 snd_cs4236
tda8290 snd_mpu401 ppdev snd_via82xx snd_emu10k1 snd_wavefront snd_wss_lib
snd_ac97_codec ac97_bus saa7134 uhci_hcd snd_pcm ehci_hcd ir_common
snd_opl3_lib videobuf_dma_sg snd_mpu401_uart snd_timer snd_page_alloc
videobuf_core snd_rawmidi snd_util_mem tveeprom snd_seq_device usbcore shpchp
snd_hwdep 8139too emu10k1_gp rtc_cmos pci_hotplug via_agp parport_pc rtc_core
ns558 rtc_lib snd parport floppy gameport soundcore xfs exportfs ufs agpgart
tuner v4l2_common videodev v4l1_compat w83627hf hwmon_vid hwmon i2c_viapro
i2c_dev [last unloaded: cfbfillrect]
Pid: 1542, comm: kjournald Not tainted 2.6.30-i486 #4
Call Trace:
 [<c1031c86>] warn_slowpath_common+0x65/0x95
 [<c1031cf4>] warn_slowpath_fmt+0x29/0x2c
 [<c11611df>] check_for_illegal_area+0xd3/0xfd
 [<c11622a4>] debug_dma_map_sg+0x13b/0x147
 [<c11cfae1>] ide_dma_prepare+0xc2/0x10b
 [<c11cbaba>] do_rw_taskfile+0x221/0x261
 [<c11d9990>] ide_do_rw_disk+0x23d/0x2b4
 [<c114ee9b>] ? delay_tsc+0x47/0x6c
 [<c11d9077>] ide_gd_do_request+0xf/0x12
 [<c11c8cc8>] do_ide_request+0x345/0x4a1
 [<c105374a>] ? trace_hardirqs_off_caller+0x18/0xa3
 [<c10537e0>] ? trace_hardirqs_off+0xb/0xd
 [<c128f8e1>] ? _spin_unlock_irqrestore+0x34/0x41
 [<c103ae8f>] ? del_timer+0x4a/0x52
 [<c113d670>] ? blk_remove_plug+0x109/0x114
 [<c113d736>] __generic_unplug_device+0x46/0x4a
 [<c113de7c>] __make_request+0x3d5/0x3ea
 [<c113ba4d>] ? trace_block_remap+0x2f/0x5f
 [<c113c5ab>] generic_make_request+0x262/0x2a5
 [<c1093ac0>] ? mempool_alloc+0x5f/0x111
 [<c113c6b7>] submit_bio+0xc9/0xd1
 [<c10df797>] ? bio_alloc_bioset+0x8d/0x10e
 [<c10dafcc>] submit_bh+0x10d/0x12b
 [<c10dc87d>] sync_dirty_buffer+0x72/0xaf
 [<c11195bc>] journal_commit_transaction+0xb0b/0xf4f
 [<c10537e0>] ? trace_hardirqs_off+0xb/0xd
 [<c103ae3d>] ? try_to_del_timer_sync+0x44/0x4c
 [<c111c806>] kjournald+0xcc/0x1ed
 [<c1044d0c>] ? autoremove_wake_function+0x0/0x38
 [<c111c73a>] ? kjournald+0x0/0x1ed
 [<c1044a09>] kthread+0x4a/0x70
 [<c10449bf>] ? kthread+0x0/0x70
 [<c1003a87>] kernel_thread_helper+0x7/0x10
---[ end trace a9c5ff347ea44ae3 ]---

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
