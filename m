From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] New: warn_on_slowpath when playing audio CD
Date: Sun, 28 Dec 2008 22:31:46 -0800 (PST)
Message-ID: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33290 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbYL2Gbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 01:31:48 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBT6Vkvh023351
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2008 22:31:47 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320

           Summary: warn_on_slowpath when playing audio CD
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.28
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: nm127@freemail.hu


Latest working kernel version:
Earliest failing kernel version: 
Distribution:
Hardware Environment: Clevo D410J + Optiarc DVD RW AD-7543A
Software Environment: Debian 
Problem Description:

The following warning appears in dmesg with Linux 2.6.28 when playing an audio
CD with kaffeine 0.8.7. The warning message repeats until the audio playback is
not stopped.

[  623.491756] ------------[ cut here ]------------
[  623.491770] WARNING: at arch/x86/kernel/pci-nommu.c:62
nommu_map_sg+0x22/0xb0()
[  623.491776] Modules linked in: ppdev lp cpufreq_ondemand
cpufreq_conservative ipv6 xt_tcpudp iptable_filter ip_tables x_tables l
eds_clevo_mail led_class via via_agp drm agpgart eeprom snd_pcm_oss
snd_mixer_oss cpufreq_userspace cpufreq_powersave powernow_k8 f
an snd_via82xx snd_mpu401_uart snd_seq_midi snd_seq_midi_event mousedev
snd_via82xx_modem snd_ac97_codec ac97_bus snd_rawmidi snd_p
cm snd_seq snd_timer snd_seq_device pcmcia firmware_class i2c_viapro snd
ehci_hcd pcspkr uhci_hcd k8temp hwmon psmouse serio_raw 81
39too mii snd_page_alloc soundcore ide_cd_mod cdrom i2c_core usbcore bitrev
crc32 yenta_socket rsrc_nonstatic pcmcia_core 8250_pnp 
8250 video backlight output serial_core parport_pc parport battery ac thermal
button processor evdev
[  623.491932] Pid: 4418, comm: kaffeine Not tainted 2.6.28 #1
[  623.491939] Call Trace:
[  623.491952]  [<c0338dcf>] ? printk+0x18/0x21
[  623.491962]  [<c0123664>] warn_on_slowpath+0x54/0x80
[  623.491976]  [<c01ab0b5>] ? __find_get_block_slow+0x75/0x130
[  623.491985]  [<c0107d42>] nommu_map_sg+0x22/0xb0
[  623.491995]  [<c02b378a>] ide_build_sglist+0x4a/0x60
[  623.492004]  [<c02b3ae6>] ide_build_dmatable+0x36/0x1a0
[  623.492012]  [<c02b3c8c>] ide_dma_setup+0x3c/0x100
[  623.492017]  [<f819bb30>] ? cdrom_do_newpc_cont+0x0/0x20 [ide_cd_mod]
[  623.492017]  [<f819b0a3>] ide_cd_do_request+0x473/0x8b0 [ide_cd_mod]
[  623.492017]  [<c023fb6c>] ? delay_tsc+0x6c/0xb4
[  623.492017]  [<c023fabb>] ? __const_udelay+0x1b/0x20
[  623.492017]  [<c02abe92>] ? __ide_wait_stat+0x52/0x120
[  623.492017]  [<c02ac7cf>] ? ide_wait_stat+0x3f/0x90
[  623.492017]  [<c02aa01c>] ide_do_request+0x48c/0xab0
[  623.492017]  [<c033bf8d>] ? _spin_lock_irqsave+0x4d/0x60
[  623.492017]  [<c0144c0b>] ? trace_hardirqs_off+0xb/0x10
[  623.492017]  [<c033bc99>] ? _spin_unlock_irqrestore+0x39/0x70
[  623.492017]  [<c012cb46>] ? del_timer+0x66/0x80
[  623.492017]  [<c02aa849>] do_ide_request+0x19/0x20
[  623.492017]  [<c022f848>] blk_start_queueing+0x18/0x40
[  623.492017]  [<c022d6e4>] elv_insert+0x114/0x1e0
[  623.492017]  [<c012cd97>] ? mod_timer+0x37/0x80
[  623.492017]  [<c022d821>] __elv_add_request+0x71/0xc0
[  623.492017]  [<c02321f5>] blk_execute_rq_nowait+0x55/0xa0
[  623.492017]  [<c02322b0>] blk_execute_rq+0x70/0xc0
[  623.492017]  [<c0232170>] ? blk_end_sync_rq+0x0/0x30
[  623.492017]  [<c0146366>] ? trace_hardirqs_on_caller+0xf6/0x140
[  623.492017]  [<c02378c0>] ? cfq_set_request+0x0/0x330
[  623.492017]  [<c022c88f>] ? elv_set_request+0x1f/0x50
[  623.492017]  [<c022f38c>] ? get_request+0x25c/0x290
[  623.492017]  [<c022f91d>] ? get_request_wait+0x1d/0x100
[  623.492017]  [<f819c488>] ide_cd_queue_pc+0xb8/0x1b0 [ide_cd_mod]
[  623.492017]  [<c0144c0b>] ? trace_hardirqs_off+0xb/0x10
[  623.492017]  [<c033bc99>] ? _spin_unlock_irqrestore+0x39/0x70
[  623.492017]  [<c02aa849>] ? do_ide_request+0x19/0x20
[  623.492017]  [<f819d46e>] ide_cdrom_packet+0x8e/0xc0 [ide_cd_mod]
[  623.492017]  [<f818f3b3>] cdrom_read_block+0xa3/0xd0 [cdrom]
[  623.492017]  [<f8192283>] mmc_ioctl+0x1633/0x19b0 [cdrom]
[  623.492017]  [<c01461a1>] ? mark_held_locks+0x41/0x80
[  623.492017]  [<c033bc32>] ? _spin_unlock_irq+0x22/0x50
[  623.492017]  [<c01462df>] ? trace_hardirqs_on_caller+0x6f/0x140
[  623.492017]  [<c01463bb>] ? trace_hardirqs_on+0xb/0x10
[  623.492017]  [<c033bc3d>] ? _spin_unlock_irq+0x2d/0x50
[  623.492017]  [<c012c2cf>] ? run_timer_softirq+0x15f/0x1e0
[  623.492017]  [<c013b780>] ? hrtimer_interrupt+0x160/0x190
[  623.492017]  [<c023a402>] ? kobject_get+0x12/0x20
[  623.492017]  [<c022f51d>] ? blk_put_queue+0xd/0x10
[  623.492017]  [<c0235b13>] ? scsi_cmd_ioctl+0xa3/0x4d0
[  623.492017]  [<c02a8eac>] ? generic_ide_ioctl+0x2c/0x5d0
[  623.492017]  [<f819267a>] cdrom_ioctl+0x7a/0xe20 [cdrom]
[  623.492017]  [<c016852b>] ? __rmqueue+0x1b/0x1f0
[  623.492017]  [<f819a6b4>] idecd_ioctl+0x104/0x180 [ide_cd_mod]
[  623.492017]  [<c0164590>] ? find_get_page+0x0/0xd0
[  623.492017]  [<c01649b3>] ? find_lock_page+0x33/0x80
[  623.492017]  [<c0233350>] __blkdev_driver_ioctl+0x70/0x80
[  623.492017]  [<c023341f>] blkdev_ioctl+0x8f/0xa90
[  623.492017]  [<c0164970>] ? unlock_page+0x40/0x50
[  623.492017]  [<c0173a53>] ? __do_fault+0x1d3/0x3c0
[  623.492017]  [<c0175101>] ? handle_mm_fault+0x101/0x610
[  623.492017]  [<c033e411>] ? do_page_fault+0xf1/0x840
[  623.492017]  [<c013baa6>] ? up_read+0x16/0x30
[  623.492017]  [<c033e59a>] ? do_page_fault+0x27a/0x840
[  623.492017]  [<c0146db7>] ? __lock_acquire+0x147/0x1600
[  623.492017]  [<c01b056b>] block_ioctl+0x3b/0x50
[  623.492017]  [<c01b0530>] ? block_ioctl+0x0/0x50
[  623.492017]  [<c0198568>] vfs_ioctl+0x28/0x80
[  623.492017]  [<c019871e>] do_vfs_ioctl+0x5e/0x4b0
[  623.492017]  [<c018cd92>] ? fget_light+0x112/0x140
[  623.492017]  [<c018cccd>] ? fget_light+0x4d/0x140
[  623.492017]  [<c0198ba9>] sys_ioctl+0x39/0x70
[  623.492017]  [<c01033d9>] sysenter_do_call+0x12/0x31
[  623.492017] ---[ end trace 2ca35fe06a780316 ]---

Steps to reproduce:
1. Boot Linux 2.6.28 on Clevo D410J laptop
2. Insert an audio CD
3. start playing it with kaffeine 0.8.7


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
