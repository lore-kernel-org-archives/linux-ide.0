From: Mark Lord <liml@rtr.ca>
Subject: Re: bad sectors, suspicious behaviour
Date: Fri, 08 Aug 2008 09:34:38 -0400
Message-ID: <489C4B6E.9070306@rtr.ca>
References: <489C19CE.6030708@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45222 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYHHNeh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 09:34:37 -0400
In-Reply-To: <489C19CE.6030708@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan wrote:
..
> I'm trying to emulate OS behaviour when something goes wrong with sata 
> hard drive, for example, unrecoverable "bad blocks". By some reason I do 
> not want to use any sw/hw raid.
..

Note that you can create/remove *real* bad sectors on most drives
by using "hdparm --make-bad-sector" and "hdparm --repair-sector".

> I took new hard drive, because it should contain (and it contains) 
> unreadable (not reallocated yet) sectros, and did
> 
> 'dd if=/dev/sda of=/dev/null bs=1M'.
> 
> first run dd log (errors1.txt) looks OK, drive recovers, as I suppose, 
> approximately at time
> 
> cat
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout 
> 
> 30
> 
> but when running dd second time, log looks strange (errors2.txt)
..
> [75702.039300] ata5.00: NCQ disabled due to excessive errors
> [75702.039382]          res 41/00:08:00:a8:36/00:00:01:00:00/40 Emask 0x1 (device error)
> [75702.039452]          res 41/00:00:01:00:00/00:00:01:00:00/40 Emask 0x1 (device error)
> [75702.039522] ata5: hard resetting link
> [75702.936061] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [75702.996080] ata5.00: max_sectors limited to 256 for NCQ
> [75703.296058] ata5.00: max_sectors limited to 256 for NCQ
> [75703.296061] ata5.00: configured for UDMA/133
> [75703.296069] ata5: EH complete
> [75703.296098] ------------[ cut here ]------------
> [75703.296100] WARNING: at drivers/ata/libata-core.c:4732 ata_qc_issue+0x1ca/0x230 [libata]()
> [75703.296102] Modules linked in: dm_mod autofs4 ipv6 iptable_filter ip_tables x_tables lp loop af_packet sr_mod cdrom container e1000e button parport_pc parport iTCO_wdt iTCO_vendor_support pcspkr shpchp pci_hotplug psmouse evdev ext3 jbd mbcache sg sd_mod pata_it8213 ata_piix pata_acpi floppy ata_generic sata_mv libata scsi_mod dock ehci_hcd uhci_hcd usbcore thermal processor fan thermal_sys fuse
> [75703.296131] Pid: 2235, comm: scsi_eh_4 Tainted: G        W 2.6.26.2.030320 #1
> [75703.296133]
> [75703.296133] Call Trace:
> [75703.296140]  [ext3:warn_on_slowpath+0x64/0x320] warn_on_slowpath+0x64/0xa0
> [75703.296145]  [sched_clock_cpu+0xc1/0x150] sched_clock_cpu+0xc1/0x150
> [75703.296148]  [usbcore:up+0x16/0xc0] up+0x16/0x50
> [75703.296150]  [release_console_sem+0x19d/0x1e0] release_console_sem+0x19d/0x1e0
> [75703.296156]  [sata_mv:mv_qc_issue+0x3c0/0x500] :sata_mv:mv_qc_issue+0x3c0/0x500
> [75703.296159]  [nommu_map_sg+0x6b/0xe0] nommu_map_sg+0x6b/0xe0
> [75703.296170]  [libata:ata_build_rw_tf+0xc1/0x290] :libata:ata_build_rw_tf+0xc1/0x290
> [75703.296181]  [libata:ata_qc_issue+0x1ca/0x230] :libata:ata_qc_issue+0x1ca/0x230
> [75703.296193]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
> [75703.296203]  [libata:ata_scsi_translate+0xf8/0x190] :libata:ata_scsi_translate+0xf8/0x190
> [75703.296213]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
> [75703.296224]  [sata_mv:ata_scsi_queuecmd+0xbb/0x240] :libata:ata_scsi_queuecmd+0xbb/0x240
> [75703.296235]  [scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0] :scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0
> [75703.296246]  [scsi_mod:scsi_request_fn+0x213/0x3c0] :scsi_mod:scsi_request_fn+0x213/0x3c0
> [75703.296251]  [scsi_mod:__blk_run_queue+0x43/0xd0] __blk_run_queue+0x43/0xd0
> [75703.296253]  [scsi_mod:blk_run_queue+0x28/0x50] blk_run_queue+0x28/0x50
> [75703.296264]  [scsi_mod:scsi_error_handler+0x0/0x570] :scsi_mod:scsi_error_handler+0x0/0x570
> [75703.296274]  [scsi_mod:scsi_run_host_queues+0x19/0x40] :scsi_mod:scsi_run_host_queues+0x19/0x40
> [75703.296284]  [scsi_mod:scsi_error_handler+0x1d9/0x570] :scsi_mod:scsi_error_handler+0x1d9/0x570
> [75703.296296]  [scsi_mod:scsi_error_handler+0x0/0x570] :scsi_mod:scsi_error_handler+0x0/0x570
> [75703.296299]  [kthread+0x4b/0x80] kthread+0x4b/0x80
> [75703.296303]  [child_rip+0xa/0x12] child_rip+0xa/0x12
> [75703.296307]  [kthread+0x0/0x80] kthread+0x0/0x80
> [75703.296309]  [child_rip+0x0/0x12] child_rip+0x0/0x12
> [75703.296311]
> [75703.296312] ---[ end trace 98cca564749c28e3 ]---

Mmmm.. something bad there, and also here:
> [76898.778051] ------------[ cut here ]------------
> [76898.778051] WARNING: at drivers/ata/libata-core.c:4732 ata_qc_issue+0x1ca/0x230 [libata]()
> [76898.778051] Modules linked in: dm_mod autofs4 ipv6 iptable_filter ip_tables x_tables lp loop af_packet sr_mod cdrom container e1000e button parport_pc parport iTCO_wdt iTCO_vendor_support pcspkr shpchp pci_hotplug psmouse evdev ext3 jbd mbcache sg sd_mod pata_it8213 ata_piix pata_acpi floppy ata_generic sata_mv libata scsi_mod dock ehci_hcd uhci_hcd usbcore thermal processor fan thermal_sys fuse
> [76898.778051] Pid: 4150, comm: dd Tainted: G        W 2.6.26.2.030320 #1
> [76898.778051]
> [76898.778051] Call Trace:
> [76898.778051]  [ext3:warn_on_slowpath+0x64/0x320] warn_on_slowpath+0x64/0xa0
> [76898.778051]  [sg:sg_init_table+0x20/0x663e0] sg_init_table+0x20/0x50
> [76898.778051]  [scsi_mod:blk_rq_map_sg+0x7c/0x25e0] blk_rq_map_sg+0x7c/0x2b0
> [76898.778051]  [scsi_mod:scsi_sg_alloc+0x0/0x50] :scsi_mod:scsi_sg_alloc+0x0/0x50
> [76898.778051]  [scsi_mod:scsi_init_sgtable+0x54/0xb0] :scsi_mod:scsi_init_sgtable+0x54/0xb0
> [76898.778051]  [libata:ata_build_rw_tf+0xc1/0x290] :libata:ata_build_rw_tf+0xc1/0x290
> [76898.778051]  [libata:ata_qc_issue+0x1ca/0x230] :libata:ata_qc_issue+0x1ca/0x230
> [76898.778051]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
> [76898.778051]  [libata:ata_scsi_translate+0xf8/0x190] :libata:ata_scsi_translate+0xf8/0x190
> [76898.778051]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
> [76898.778051]  [sata_mv:ata_scsi_queuecmd+0xbb/0x240] :libata:ata_scsi_queuecmd+0xbb/0x240
> [76898.778051]  [scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0] :scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0
> [76898.778051]  [scsi_mod:scsi_request_fn+0x213/0x3c0] :scsi_mod:scsi_request_fn+0x213/0x3c0
> [76898.778051]  [sync_page_killable+0x0/0x40] sync_page_killable+0x0/0x40
> [76898.778051]  [floppy:generic_unplug_device+0x24/0xa0] generic_unplug_device+0x24/0x30
> [76898.778051]  [blk_unplug+0x35/0x70] blk_unplug+0x35/0x70
> [76898.778051]  [sync_page+0x2e/0x50] sync_page+0x2e/0x50
> [76898.778051]  [sync_page_killable+0x9/0x40] sync_page_killable+0x9/0x40
> [76898.778051]  [__wait_on_bit_lock+0x4a/0x80] __wait_on_bit_lock+0x4a/0x80
> [76898.778051]  [__lock_page_killable+0x5f/0x70] __lock_page_killable+0x5f/0x70
> [76898.778051]  [<ffffffff8024ac30>] wake_bit_function+0x0/0x30
> [76898.778051]  [fuse:generic_file_aio_read+0x36a/0x710] generic_file_aio_read+0x36a/0x570
> [76898.778051]  [ext3:do_sync_read+0xd9/0xbc0] do_sync_read+0xd9/0x120
> [76898.778051]  [<ffffffff8024ac00>] autoremove_wake_function+0x0/0x30
> [76898.778051]  [handle_mm_fault+0x575/0x810] handle_mm_fault+0x575/0x810
> [76898.778051]  [block_ioctl+0x1b/0x30] block_ioctl+0x1b/0x30
> [76898.778051]  [vfs_read+0xc5/0x180] vfs_read+0xc5/0x180
> [76898.778051]  [sys_read+0x53/0x90] sys_read+0x53/0x90
> [76898.778051]  [system_call_after_swapgs+0x7b/0x80] system_call_after_swapgs+0x7b/0x80
> [76898.778051]
> [76898.778051] ---[ end trace 98cca564749c28e3 ]---
> 


