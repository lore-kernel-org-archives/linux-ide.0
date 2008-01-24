From: Mark Lord <liml@rtr.ca>
Subject: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Thu, 24 Jan 2008 10:20:44 -0500
Message-ID: <4798ACCC.3040104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1468 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbYAXPUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 10:20:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

During testing with NCQ on sata_mv (patches coming shortly),
I found this gem in the syslog.  This doesn't look like something
that a LLD could cause, but rather a race perhaps in libata-core.

System is a 2.4GHz 32-bit Core2Quad, 2GB RAM (during this test),
running 2.6.24-rc6-git12 + newer sata_mv, with two sata_mv controller
cards, each with one NCQ drive performing heavy R/W activity.

Other than that, I'm not sure what triggered this.


[  265.473596] EXT3-fs: mounted filesystem with ordered data mode.
[  289.892890] WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
[  289.892898] Pid: 4661, comm: mirrordir Not tainted 2.6.24-rc6-git12 #7
[  289.892911]  [ata_qc_issue+88/1512] ata_qc_issue+0x58/0x5e8
[  289.892922]  [scsi_get_cmd_from_req+23/51] scsi_get_cmd_from_req+0x17/0x33
[  289.892934]  [scsi_done+0/22] scsi_done+0x0/0x16
[  289.892939]  [ata_scsi_translate+233/272] ata_scsi_translate+0xe9/0x110
[  289.892949]  [scsi_done+0/22] scsi_done+0x0/0x16
[  289.892954]  [ata_scsi_queuecmd+412/443] ata_scsi_queuecmd+0x19c/0x1bb
[  289.892960]  [ata_scsi_rw_xlat+0/478] ata_scsi_rw_xlat+0x0/0x1de
[  289.892968]  [scsi_dispatch_cmd+422/547] scsi_dispatch_cmd+0x1a6/0x223
[  289.892976]  [scsi_request_fn+631/814] scsi_request_fn+0x277/0x32e
[  289.892982]  [blk_remove_plug+79/91] blk_remove_plug+0x4f/0x5b
[  289.892991]  [__generic_unplug_device+29/31] __generic_unplug_device+0x1d/0x1f
[  289.892998]  [elv_insert+166/326] elv_insert+0xa6/0x146
[  289.893006]  [__make_request+993/1109] __make_request+0x3e1/0x455
[  289.893012]  [swsusp_show_speed+15/237] swsusp_show_speed+0xf/0xed
[  289.893021]  [generic_make_request+425/471] generic_make_request+0x1a9/0x1d7
[  289.893028]  [bio_add_page+49/55] bio_add_page+0x31/0x37
[  289.893036]  [do_mpage_readpage+947/1108] do_mpage_readpage+0x3b3/0x454
[  289.893044]  [submit_bio+237/244] submit_bio+0xed/0xf4
[  289.893053]  [add_to_page_cache+111/140] add_to_page_cache+0x6f/0x8c
[  289.893061]  [mpage_end_io_read+0/83] mpage_end_io_read+0x0/0x53
[  289.893066]  [mpage_bio_submit+25/29] mpage_bio_submit+0x19/0x1d
[  289.893073]  [mpage_readpages+177/188] mpage_readpages+0xb1/0xbc
[  289.893080]  [<f8f2cbba>] ext2_get_block+0x0/0x5d8 [ext2]
[  289.893097]  [<f8f2bf0c>] ext2_readpages+0x0/0x15 [ext2]
[  289.893109]  [__do_page_cache_readahead+319/446] __do_page_cache_readahead+0x13f/0x1be
[  289.893115]  [<f8f2cbba>] ext2_get_block+0x0/0x5d8 [ext2]
[  289.893128]  [page_cache_sync_readahead+42/47] page_cache_sync_readahead+0x2a/0x2f
[  289.893136]  [do_generic_mapping_read+221/936] do_generic_mapping_read+0xdd/0x3a8
[  289.893143]  [file_read_actor+0/204] file_read_actor+0x0/0xcc
[  289.893153]  [generic_file_aio_read+353/412] generic_file_aio_read+0x161/0x19c
[  289.893160]  [file_read_actor+0/204] file_read_actor+0x0/0xcc
[  289.893170]  [do_sync_read+199/266] do_sync_read+0xc7/0x10a
[  289.893181]  [autoremove_wake_function+0/53] autoremove_wake_function+0x0/0x35
[  289.893195]  [do_sync_read+0/266] do_sync_read+0x0/0x10a
[  289.893201]  [vfs_read+136/266] vfs_read+0x88/0x10a
[  289.893207]  [sys_read+65/103] sys_read+0x41/0x67
[  289.893214]  [sysenter_past_esp+95/133] sysenter_past_esp+0x5f/0x85
[  289.893226]  =======================
[  319.846321] ata5.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
[  319.846435] ata5.00: cmd 60/08:08:6f:20:0b/00:00:00:00:00/40 tag 1 ncq 4096 in
[  319.846437]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  319.846542] ata5.00: status: { DRDY }
[  319.846615] ata5: hard resetting link
[  319.876280] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  320.029413] ata5.00: configured for UDMA/133
[  320.029422] ata5: EH complete
