From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Tue, 10 Nov 2009 00:02:33 +0900
Message-ID: <4AF82F09.9080403@kernel.org>
References: <4AE86292.2090303@jackowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33231 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446AbZKIPCi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 10:02:38 -0500
In-Reply-To: <4AE86292.2090303@jackowski.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <thomas@jackowski.de>
Cc: linux-ide@vger.kernel.org

Thomas Jackowski wrote:
> Hi,
> 
> sorry, I lost the reference in the mail headers. Please see:
> http://www.spinics.net/lists/linux-ide/msg33340.html
> 
> Well, I will post now the result with Tejun's debug patch:
> 
> [15714.808535] XXX sdc: elv_insert(ATA_CHK_POWER)
> [15714.808540] Pid: 22034, comm: smartctl Tainted: P           2.6.30 #1
> [15714.808542] Call Trace:
> [15714.808550]  [<ffffffff8033e456>] ? blk_plug_device+0x5a/0x83
> [15714.808555]  [<ffffffff8033c2d2>] ? elv_insert+0x5e/0x2b0
> [15714.808559]  [<ffffffff80341008>] ? blk_execute_rq_nowait+0x65/0x92
> [15714.808562]  [<ffffffff803410c0>] ? blk_execute_rq+0x8b/0xab
> [15714.808565]  [<ffffffff8033e831>] ? get_request_wait+0x21/0x17e
> [15714.808569]  [<ffffffff8033da3d>] ? __freed_request+0x26/0x82
> [15714.808572]  [<ffffffff8033dabc>] ? freed_request+0x23/0x43
> [15714.808575]  [<ffffffff80344030>] ? sg_io+0x277/0x392
> [15714.808578]  [<ffffffff803445df>] ? scsi_cmd_ioctl+0x1db/0x3a0
> [15714.808583]  [<ffffffff80235c12>] ? check_preempt_wakeup+0x183/0x1dd
> [15714.808587]  [<ffffffff802d350f>] ? __lookup_mnt+0x12/0x4b
> [15714.808603]  [<ffffffffa00d9ae9>] ? sd_ioctl+0x9d/0xcb [sd_mod]
> [15714.808606]  [<ffffffff803420b9>] ? __blkdev_driver_ioctl+0x69/0x7e
> [15714.808615]  [<ffffffff803428d6>] ? blkdev_ioctl+0x7e4/0x81a
> [15714.808618]  [<ffffffff802a41f3>] ? __do_fault+0x374/0x3af
> [15714.808621]  [<ffffffff80297bbb>] ? __alloc_pages_internal+0xd2/0x427
> [15714.808625]  [<ffffffff802e1a07>] ? block_ioctl+0x38/0x3c
> [15714.808628]  [<ffffffff802cc0de>] ? vfs_ioctl+0x21/0x6c
> [15714.808630]  [<ffffffff802cc554>] ? do_vfs_ioctl+0x42b/0x464
> [15714.808634]  [<ffffffff8022cce1>] ? do_page_fault+0x1f3/0x208
> [15714.808636]  [<ffffffff802cc5de>] ? sys_ioctl+0x51/0x70
> [15714.808640]  [<ffffffff8020fa42>] ? system_call_fastpath+0x16/0x1b
> [15715.216145] XXX sda: elv_insert(ATA_CHK_POWER)
> [15715.216149] Pid: 22125, comm: hdparm Tainted: P           2.6.30 #1
> [15715.216151] Call Trace:
> [15715.216158]  [<ffffffff8033e456>] ? blk_plug_device+0x5a/0x83
> [15715.216161]  [<ffffffff8033c2d2>] ? elv_insert+0x5e/0x2b0
> [15715.216164]  [<ffffffff80341008>] ? blk_execute_rq_nowait+0x65/0x92
> [15715.216167]  [<ffffffff803410c0>] ? blk_execute_rq+0x8b/0xab
> [15715.216169]  [<ffffffff8033e831>] ? get_request_wait+0x21/0x17e
> [15715.216173]  [<ffffffff803af118>] ? mix_pool_bytes_extract+0x57/0x14a
> [15715.216176]  [<ffffffff80344030>] ? sg_io+0x277/0x392
> [15715.216178]  [<ffffffff803445df>] ? scsi_cmd_ioctl+0x1db/0x3a0
> [15715.216182]  [<ffffffff802d0180>] ? __d_lookup+0xc3/0x107
> [15715.216185]  [<ffffffff802a1ab0>] ? zone_statistics+0x3c/0x5d
> [15715.216188]  [<ffffffff802d350f>] ? __lookup_mnt+0x12/0x4b
> [15715.216202]  [<ffffffffa00d9ae9>] ? sd_ioctl+0x9d/0xcb [sd_mod]
> [15715.216204]  [<ffffffff803420b9>] ? __blkdev_driver_ioctl+0x69/0x7e
> [15715.216207]  [<ffffffff803428d6>] ? blkdev_ioctl+0x7e4/0x81a
> [15715.216210]  [<ffffffff802a41f3>] ? __do_fault+0x374/0x3af
> [15715.216213]  [<ffffffff80297bbb>] ? __alloc_pages_internal+0xd2/0x427
> [15715.216216]  [<ffffffff802e1a07>] ? block_ioctl+0x38/0x3c
> [15715.216219]  [<ffffffff802cc0de>] ? vfs_ioctl+0x21/0x6c
> [15715.216221]  [<ffffffff802cc554>] ? do_vfs_ioctl+0x42b/0x464
> [15715.216224]  [<ffffffff8022cce1>] ? do_page_fault+0x1f3/0x208
> [15715.216227]  [<ffffffff802cc5de>] ? sys_ioctl+0x51/0x70
> [15715.216230]  [<ffffffff8020fa42>] ? system_call_fastpath+0x16/0x1b
> 
> As you can see I am using Kernel 2.6.30 (Debian 2.6.30-8).
> 
> So, what to do now?

Hmm.... Probably the best thing to do is to update firmwares on those
drives as timing out on CPM is simply broken.  Another approach would
be hunting down who's invoking hdparm and smartctl and shut it down.

Thanks.

-- 
tejun
