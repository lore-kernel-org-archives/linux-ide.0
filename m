Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A51DC19E;
	Mon, 21 Oct 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512447; cv=none; b=M1OyHkKHP8FJ8hKSBdDX/Tj2MYkO+yYQ0c9ErFfakoDU24l7mXf6XObk/y+BuKb5cAiGgGPd+0D9mTl4ikA0NLtdtD57jFNgNRT+klIUkukmCW2wp/GAK7+9SuwvAN781aj1gIAgjrF0JVTcERiZaG/w86/voxmYxq465r5+4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512447; c=relaxed/simple;
	bh=SXAGUl03uFG7TwT8wyjUdl+5xsUMxRpKP847NFUPwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJc1SJJSQ79QeiYiSKAj2yN8xQdc7E7eHUG/2WVwgEgKD9rhHiiNfEMtra3V6UiYlPoloSyOtUbze90BYrPrdi/bD/i1KOVQJQNwTP2gHm4CxMttQY+ciVgsdvPWpNXjH7o8rI/K1vVyOJTDmTv7fuxgxTiaS3mMLdnExbKcYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foPVe60O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foPVe60O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73923C4CEC3;
	Mon, 21 Oct 2024 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729512446;
	bh=SXAGUl03uFG7TwT8wyjUdl+5xsUMxRpKP847NFUPwcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foPVe60OulEUph6l/ek4avOzvABk1XmFVL4nDhEwA3geNo3qDPiCdGm5txQMe2AbK
	 z1xVG+uuG5lODLRcqL3vvEoZwTlML7U5sMFR7qBlI0kVaT+x2bu0TIK1nC1QlpSuGs
	 v1XbppUBdOHnM2PDyHzg01KIG4elrib+80QSG63EtAb0DXYf2YCcvNrPC2IWVi8uNS
	 ai8XLZMKT5gtHO8S7ub6Di7GWz85gKxCDNkcohjNyi+sE5DJ8RCFmeWTvkSRFdM+52
	 FRk+7EKuCFHQax7X6vqEWwrcN+dxtNnQqy2nttDPjLRHPCttsZp7ICHVvlW4PGJpzB
	 98LI54xg3kM0Q==
Date: Mon, 21 Oct 2024 14:07:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <ZxZD-doogmnZGfRI@ryzen.lan>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYz871I3Blsi30F@ly-workstation>

Hello Yi Lai,

On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> Hi Niklas Cassel,
> 
> Greetings!
> 
> I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> 
> After bisection and the first bad commit is:
> "
> e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> "

It might be that your bisection results are accurate.

However, after looking at the stacktraces, I find it way more likely that
bisection has landed on the wrong commit.

See this series that was just queued (for 6.13) a few days ago that solves a
similar starvation:
https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block

You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
and then try v6.14-rc4 + that series applied, to see if you can still trigger
the bug?


Kind regards,
Niklas


> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241018_105830_blk_mq_get_tag/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241018_105830_blk_mq_get_tag/bzImage_8e929cb546ee42c9a61d24fae60605e9e3192354
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241018_105830_blk_mq_get_tag/8e929cb546ee42c9a61d24fae60605e9e3192354_dmesg.log
> 
> "
> [  300.375482] INFO: task kworker/u8:0:11 blocked for more than 147 seconds.
> [  300.375906]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.376204] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.376646] task:kworker/u8:0    state:D stack:0     pid:11    tgid:11    ppid:2      flags:0x00004000
> [  300.377158] Workqueue: writeback wb_workfn (flush-8:0)
> [  300.377479] Call Trace:
> [  300.377624]  <TASK>
> [  300.377760]  __schedule+0xe13/0x33a0
> [  300.377985]  ? __pfx___schedule+0x10/0x10
> [  300.378222]  ? lock_release+0x441/0x870
> [  300.378457]  ? __pfx_lock_release+0x10/0x10
> [  300.378704]  ? trace_lock_acquire+0x139/0x1b0
> [  300.378982]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.379296]  ? kthread_data+0x61/0xd0
> [  300.379555]  schedule+0xf6/0x3f0
> [  300.379754]  io_schedule+0xce/0x150
> [  300.379968]  rq_qos_wait+0x1c5/0x310
> [  300.380181]  ? __pfx_wbt_cleanup_cb+0x10/0x10
> [  300.380437]  ? __pfx_rq_qos_wait+0x10/0x10
> [  300.380681]  ? __pfx_lock_release+0x10/0x10
> [  300.380925]  ? __pfx_rq_qos_wake_function+0x10/0x10
> [  300.381214]  ? __pfx_wbt_inflight_cb+0x10/0x10
> [  300.381479]  ? do_raw_spin_unlock+0x15c/0x210
> [  300.381743]  wbt_wait+0x1ec/0x400
> [  300.381946]  ? __pfx_wbt_wait+0x10/0x10
> [  300.382174]  ? __pfx_dd_bio_merge+0x10/0x10
> [  300.382437]  ? __pfx_wbt_wait+0x10/0x10
> [  300.382667]  __rq_qos_throttle+0x5f/0xb0
> [  300.382913]  blk_mq_submit_bio+0x8ad/0x2a20
> [  300.383157]  ? __kasan_check_read+0x15/0x20
> [  300.383438]  ? __pfx_blk_mq_submit_bio+0x10/0x10
> [  300.383708]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.383974]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.384260]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.384532]  ? lock_release+0x441/0x870
> [  300.384765]  __submit_bio+0x18d/0x500
> [  300.384985]  ? __pfx___submit_bio+0x10/0x10
> [  300.385234]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.385509]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.385875]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.386186]  ? kvm_clock_get_cycles+0x43/0x70
> [  300.386451]  submit_bio_noacct_nocheck+0x6a0/0xcc0
> [  300.386729]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
> [  300.387049]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.387361]  submit_bio_noacct+0x61d/0x1dc0
> [  300.387612]  submit_bio+0xce/0x480
> [  300.387819]  submit_bh_wbc+0x58a/0x740
> [  300.388052]  __block_write_full_folio+0x7a1/0xed0
> [  300.388327]  ? __pfx_blkdev_get_block+0x10/0x10
> [  300.388599]  block_write_full_folio+0x2e6/0x3a0
> [  300.388880]  ? __pfx_blkdev_get_block+0x10/0x10
> [  300.389147]  ? __pfx_blkdev_get_block+0x10/0x10
> [  300.389414]  write_cache_pages+0xbc/0x140
> [  300.389654]  ? __pfx_block_write_full_folio+0x10/0x10
> [  300.389954]  ? __pfx_write_cache_pages+0x10/0x10
> [  300.390224]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.390504]  blkdev_writepages+0xa5/0xf0
> [  300.390738]  ? __pfx_blkdev_writepages+0x10/0x10
> [  300.391016]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  300.391293]  ? do_raw_spin_unlock+0x15c/0x210
> [  300.391573]  ? __pfx_blkdev_writepages+0x10/0x10
> [  300.391841]  do_writepages+0x1c3/0x8a0
> [  300.392068]  ? __pfx_do_writepages+0x10/0x10
> [  300.392323]  ? __pfx_lock_release+0x10/0x10
> [  300.392568]  ? lock_release+0x441/0x870
> [  300.392805]  __writeback_single_inode+0x124/0xe10
> [  300.393081]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
> [  300.393397]  writeback_sb_inodes+0x63b/0x1000
> [  300.393661]  ? __pfx_writeback_sb_inodes+0x10/0x10
> [  300.393935]  ? lock_acquire.part.0+0x152/0x390
> [  300.394230]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [  300.394544]  __writeback_inodes_wb+0xc8/0x280
> [  300.394806]  wb_writeback+0x717/0xaf0
> [  300.395039]  ? __pfx_wb_writeback+0x10/0x10
> [  300.395290]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.395589]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.395868]  ? get_nr_dirty_inodes+0x12c/0x1b0
> [  300.396134]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.396393]  wb_workfn+0x76c/0xc90
> [  300.396597]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  300.396882]  ? __pfx_wb_workfn+0x10/0x10
> [  300.397110]  ? rcu_is_watching+0x19/0xc0
> [  300.397354]  process_one_work+0x92e/0x1b50
> [  300.397594]  ? lock_acquire.part.0+0x152/0x390
> [  300.397879]  ? __pfx_process_one_work+0x10/0x10
> [  300.398150]  ? move_linked_works+0x1bf/0x2c0
> [  300.398407]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.398690]  ? assign_work+0x19f/0x250
> [  300.398920]  ? lock_is_held_type+0xef/0x150
> [  300.399174]  worker_thread+0x68d/0xe90
> [  300.399428]  kthread+0x35a/0x470
> [  300.399623]  ? __pfx_worker_thread+0x10/0x10
> [  300.399874]  ? __pfx_kthread+0x10/0x10
> [  300.400100]  ret_from_fork+0x56/0x90
> [  300.400315]  ? __pfx_kthread+0x10/0x10
> [  300.400540]  ret_from_fork_asm+0x1a/0x30
> [  300.400783]  </TASK>
> [  300.400928] INFO: task kworker/u8:2:36 blocked for more than 147 seconds.
> [  300.401309]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.401613] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.402046] task:kworker/u8:2    state:D stack:0     pid:36    tgid:36    ppid:2      flags:0x00004000
> [  300.402638] Workqueue: writeback wb_workfn (flush-8:0)
> [  300.402941] Call Trace:
> [  300.403083]  <TASK>
> [  300.403214]  __schedule+0xe13/0x33a0
> [  300.403458]  ? __pfx___schedule+0x10/0x10
> [  300.403686]  ? lock_release+0x441/0x870
> [  300.403909]  ? __pfx_lock_release+0x10/0x10
> [  300.404146]  ? trace_lock_acquire+0x139/0x1b0
> [  300.404399]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.404701]  ? kthread_data+0x61/0xd0
> [  300.404915]  schedule+0xf6/0x3f0
> [  300.405106]  io_schedule+0xce/0x150
> [  300.405309]  blk_mq_get_tag+0x5e7/0xce0
> [  300.405531]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.405771]  ? __pfx_wbt_cleanup_cb+0x10/0x10
> [  300.406011]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.406288]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.406579]  ? __pfx_rq_qos_wake_function+0x10/0x10
> [  300.406848]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.407136]  ? dd_limit_depth+0x21e/0x2a0
> [  300.407380]  ? __pfx_dd_limit_depth+0x10/0x10
> [  300.407625]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.407901]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.408186]  ? __pfx_wbt_wait+0x10/0x10
> [  300.408405]  blk_mq_submit_bio+0x93c/0x2a20
> [  300.408632]  ? __kasan_check_read+0x15/0x20
> [  300.408866]  ? __pfx_blk_mq_submit_bio+0x10/0x10
> [  300.409117]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.409364]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.409626]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.409883]  ? lock_release+0x441/0x870
> [  300.410098]  __submit_bio+0x18d/0x500
> [  300.410303]  ? __pfx___submit_bio+0x10/0x10
> [  300.410534]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.410790]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.411135]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.411440]  ? kvm_clock_get_cycles+0x43/0x70
> [  300.411690]  submit_bio_noacct_nocheck+0x6a0/0xcc0
> [  300.411958]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
> [  300.412249]  ? lock_is_held_type+0xef/0x150
> [  300.412484]  submit_bio_noacct+0x61d/0x1dc0
> [  300.412718]  submit_bio+0xce/0x480
> [  300.412911]  ext4_io_submit+0xb0/0x150
> [  300.413128]  ext4_do_writepages+0xa54/0x2f30
> [  300.413372]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.413638]  ? __pfx_ext4_do_writepages+0x10/0x10
> [  300.413892]  ? rcu_is_watching+0x19/0xc0
> [  300.414113]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.414376]  ? lock_is_held_type+0xef/0x150
> [  300.414616]  ext4_writepages+0x35c/0x7c0
> [  300.414836]  ? __pfx_ext4_writepages+0x10/0x10
> [  300.415087]  ? lock_release+0x441/0x870
> [  300.415313]  ? do_raw_spin_unlock+0x15c/0x210
> [  300.415576]  ? __pfx_ext4_writepages+0x10/0x10
> [  300.415824]  do_writepages+0x1c3/0x8a0
> [  300.416039]  ? __pfx_do_writepages+0x10/0x10
> [  300.416278]  ? __pfx_lock_release+0x10/0x10
> [  300.416510]  ? __pfx_lock_release+0x10/0x10
> [  300.416754]  __writeback_single_inode+0x124/0xe10
> [  300.417016]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
> [  300.417301]  writeback_sb_inodes+0x63b/0x1000
> [  300.417546]  ? lock_release+0x441/0x870
> [  300.417772]  ? __pfx_writeback_sb_inodes+0x10/0x10
> [  300.418039]  ? lock_acquire.part.0+0x152/0x390
> [  300.418321]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [  300.418616]  __writeback_inodes_wb+0xc8/0x280
> [  300.418865]  wb_writeback+0x717/0xaf0
> [  300.419082]  ? __pfx_wb_writeback+0x10/0x10
> [  300.419335]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.419598]  ? get_nr_dirty_inodes+0x12c/0x1b0
> [  300.419847]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.420094]  wb_workfn+0x7b5/0xc90
> [  300.420291]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  300.420561]  ? __pfx_wb_workfn+0x10/0x10
> [  300.420780]  ? rcu_is_watching+0x19/0xc0
> [  300.421017]  process_one_work+0x92e/0x1b50
> [  300.421245]  ? lock_acquire.part.0+0x152/0x390
> [  300.421498]  ? __pfx_process_one_work+0x10/0x10
> [  300.421743]  ? move_linked_works+0x1bf/0x2c0
> [  300.421976]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.422236]  ? assign_work+0x19f/0x250
> [  300.422442]  ? lock_is_held_type+0xef/0x150
> [  300.422673]  worker_thread+0x68d/0xe90
> [  300.422896]  kthread+0x35a/0x470
> [  300.423074]  ? __pfx_worker_thread+0x10/0x10
> [  300.423306]  ? __pfx_kthread+0x10/0x10
> [  300.423538]  ret_from_fork+0x56/0x90
> [  300.423735]  ? __pfx_kthread+0x10/0x10
> [  300.423944]  ret_from_fork_asm+0x1a/0x30
> [  300.424171]  </TASK>
> [  300.424303] INFO: task kworker/1:2:80 blocked for more than 147 seconds.
> [  300.424649]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.424930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.425332] task:kworker/1:2     state:D stack:0     pid:80    tgid:80    ppid:2      flags:0x00004000
> [  300.425818] Workqueue: events ata_scsi_dev_rescan
> [  300.426080] Call Trace:
> [  300.426217]  <TASK>
> [  300.426340]  __schedule+0xe13/0x33a0
> [  300.426545]  ? __pfx___schedule+0x10/0x10
> [  300.426761]  ? lock_release+0x441/0x870
> [  300.426977]  ? __pfx_lock_release+0x10/0x10
> [  300.427204]  ? _raw_spin_unlock_irq+0x3c/0x60
> [  300.427452]  schedule+0xf6/0x3f0
> [  300.427631]  io_schedule+0xce/0x150
> [  300.427820]  blk_mq_get_tag+0x5e7/0xce0
> [  300.428032]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.428264]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.428542]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.428790]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.429077]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.429352]  blk_mq_alloc_request+0x655/0x930
> [  300.429586]  ? __pfx_blk_mq_alloc_request+0x10/0x10
> [  300.429840]  ? __lock_acquire+0xd87/0x5c90
> [  300.430067]  scsi_execute_cmd+0x223/0x1040
> [  300.430294]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.430540]  ? __pfx_scsi_execute_cmd+0x10/0x10
> [  300.430781]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  300.431038]  scsi_vpd_inquiry+0xdf/0x220
> [  300.431251]  ? __pfx_scsi_vpd_inquiry+0x10/0x10
> [  300.431502]  ? debug_smp_processor_id+0x20/0x30
> [  300.431741]  ? rcu_is_watching+0x19/0xc0
> [  300.431953]  scsi_get_vpd_size+0x11e/0x310
> [  300.432168]  ? __mutex_lock+0x230/0x1490
> [  300.432377]  ? __pfx_scsi_get_vpd_size+0x10/0x10
> [  300.432619]  ? scsi_rescan_device+0x33/0x360
> [  300.432845]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.433083]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.433330]  ? lock_acquire.part.0+0x152/0x390
> [  300.433565]  ? __pfx___mutex_lock+0x10/0x10
> [  300.433791]  scsi_get_vpd_buf+0x30/0x180
> [  300.434006]  scsi_attach_vpd+0xf8/0x5b0
> [  300.434218]  scsi_rescan_device+0x106/0x360
> [  300.434446]  ata_scsi_dev_rescan+0x1d2/0x470
> [  300.434684]  process_one_work+0x92e/0x1b50
> [  300.434904]  ? lock_acquire.part.0+0x152/0x390
> [  300.435154]  ? __pfx_process_one_work+0x10/0x10
> [  300.435412]  ? move_linked_works+0x1bf/0x2c0
> [  300.435639]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.435891]  ? assign_work+0x19f/0x250
> [  300.436089]  ? lock_is_held_type+0xef/0x150
> [  300.436313]  worker_thread+0x68d/0xe90
> [  300.436525]  kthread+0x35a/0x470
> [  300.436699]  ? __pfx_worker_thread+0x10/0x10
> [  300.436924]  ? __pfx_kthread+0x10/0x10
> [  300.437125]  ret_from_fork+0x56/0x90
> [  300.437317]  ? __pfx_kthread+0x10/0x10
> [  300.437517]  ret_from_fork_asm+0x1a/0x30
> [  300.437736]  </TASK>
> [  300.437858] INFO: task jbd2/sda-8:104 blocked for more than 147 seconds.
> [  300.438192]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.438465] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.438852] task:jbd2/sda-8      state:D stack:0     pid:104   tgid:104   ppid:2      flags:0x00004000
> [  300.439339] Call Trace:
> [  300.439475]  <TASK>
> [  300.439595]  __schedule+0xe13/0x33a0
> [  300.439794]  ? __pfx___schedule+0x10/0x10
> [  300.440005]  ? lock_release+0x441/0x870
> [  300.440212]  ? __pfx_lock_release+0x10/0x10
> [  300.440431]  ? trace_lock_acquire+0x139/0x1b0
> [  300.440666]  ? lock_acquire+0x80/0xb0
> [  300.440860]  ? schedule+0x216/0x3f0
> [  300.441051]  schedule+0xf6/0x3f0
> [  300.441229]  io_schedule+0xce/0x150
> [  300.441417]  blk_mq_get_tag+0x5e7/0xce0
> [  300.441628]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.441859]  ? lock_release+0x441/0x870
> [  300.442063]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.442326]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.442596]  ? blk_mq_sched_try_merge+0xce/0x650
> [  300.442841]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.443123]  ? dd_limit_depth+0x21e/0x2a0
> [  300.443358]  ? __pfx_dd_limit_depth+0x10/0x10
> [  300.443591]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.443846]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.444131]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.444403]  ? __pfx_wbt_wait+0x10/0x10
> [  300.444610]  blk_mq_submit_bio+0x93c/0x2a20
> [  300.444829]  ? __pfx___lock_acquire+0x10/0x10
> [  300.445064]  ? __pfx_blk_mq_submit_bio+0x10/0x10
> [  300.445307]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.445559]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.445807]  ? lock_release+0x441/0x870
> [  300.446014]  __submit_bio+0x18d/0x500
> [  300.446211]  ? __pfx___submit_bio+0x10/0x10
> [  300.446432]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.446677]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.447005]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.447282]  ? kvm_clock_get_cycles+0x43/0x70
> [  300.447534]  submit_bio_noacct_nocheck+0x6a0/0xcc0
> [  300.447787]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
> [  300.448067]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.448330]  submit_bio_noacct+0x61d/0x1dc0
> [  300.448556]  submit_bio+0xce/0x480
> [  300.448742]  submit_bh_wbc+0x58a/0x740
> [  300.448947]  submit_bh+0x2b/0x40
> [  300.449124]  jbd2_journal_commit_transaction+0x2a09/0x65e0
> [  300.449431]  ? __pfx_jbd2_journal_commit_transaction+0x10/0x10
> [  300.449737]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.449983]  ? lock_release+0x441/0x870
> [  300.450196]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.450445]  ? _raw_spin_unlock_irqrestore+0x45/0x70
> [  300.450703]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.450998]  kjournald2+0x204/0x790
> [  300.451194]  ? __pfx_kjournald2+0x10/0x10
> [  300.451416]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.451647]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.451917]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.452194]  ? __kthread_parkme+0x15d/0x230
> [  300.452419]  kthread+0x35a/0x470
> [  300.452594]  ? __pfx_kjournald2+0x10/0x10
> [  300.452803]  ? __pfx_kthread+0x10/0x10
> [  300.453004]  ret_from_fork+0x56/0x90
> [  300.453198]  ? __pfx_kthread+0x10/0x10
> [  300.453406]  ret_from_fork_asm+0x1a/0x30
> [  300.453639]  </TASK>
> [  300.453765] INFO: task auditd:239 blocked for more than 147 seconds.
> [  300.454094]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.454367] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.454757] task:auditd          state:D stack:0     pid:239   tgid:239   ppid:1      flags:0x00000002
> [  300.455219] Call Trace:
> [  300.455363]  <TASK>
> [  300.455481]  __schedule+0xe13/0x33a0
> [  300.455676]  ? __pfx___schedule+0x10/0x10
> [  300.455883]  ? lock_release+0x441/0x870
> [  300.456086]  ? __pfx_lock_release+0x10/0x10
> [  300.456300]  ? trace_lock_acquire+0x139/0x1b0
> [  300.456530]  ? lock_acquire+0x80/0xb0
> [  300.456722]  ? schedule+0x216/0x3f0
> [  300.456911]  schedule+0xf6/0x3f0
> [  300.457085]  io_schedule+0xce/0x150
> [  300.457271]  bit_wait_io+0x1f/0x100
> [  300.457457]  __wait_on_bit+0x68/0x1b0
> [  300.457649]  ? __pfx_bit_wait_io+0x10/0x10
> [  300.457867]  out_of_line_wait_on_bit+0xe6/0x120
> [  300.458102]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
> [  300.458369]  ? __pfx_wake_bit_function+0x10/0x10
> [  300.458606]  ? __might_sleep+0xa3/0x170
> [  300.458808]  do_get_write_access+0x83b/0x1010
> [  300.459045]  jbd2_journal_get_write_access+0x1e4/0x270
> [  300.459308]  __ext4_journal_get_write_access+0x72/0x3b0
> [  300.459591]  ext4_reserve_inode_write+0x199/0x280
> [  300.459833]  ? ext4_dirty_inode+0xeb/0x140
> [  300.460044]  __ext4_mark_inode_dirty+0x18b/0x8c0
> [  300.460282]  ? debug_smp_processor_id+0x20/0x30
> [  300.460515]  ? __pfx___ext4_mark_inode_dirty+0x10/0x10
> [  300.460773]  ? trace_jbd2_handle_start+0x77/0x210
> [  300.461017]  ? jbd2__journal_start+0xff/0x6b0
> [  300.461246]  ? __ext4_journal_start_sb+0x1f8/0x600
> [  300.461490]  ? ext4_dirty_inode+0xb3/0x140
> [  300.461703]  ? __pfx_ext4_dirty_inode+0x10/0x10
> [  300.461937]  ext4_dirty_inode+0xeb/0x140
> [  300.462139]  ? rcu_is_watching+0x19/0xc0
> [  300.462343]  __mark_inode_dirty+0x1d0/0xd50
> [  300.462557]  ? __pfx_generic_write_checks+0x10/0x10
> [  300.462810]  generic_update_time+0xe0/0x110
> [  300.463032]  file_modified+0x1af/0x1e0
> [  300.463233]  ext4_buffered_write_iter+0x101/0x3e0
> [  300.463493]  ext4_file_write_iter+0x8b8/0x1ab0
> [  300.463722]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  300.463971]  ? debug_smp_processor_id+0x20/0x30
> [  300.464208]  ? __pfx_ext4_file_write_iter+0x10/0x10
> [  300.464459]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.464701]  ? lock_is_held_type+0xef/0x150
> [  300.464920]  vfs_write+0xc46/0x1120
> [  300.465106]  ? __pfx_ext4_file_write_iter+0x10/0x10
> [  300.465356]  ? __pfx_vfs_write+0x10/0x10
> [  300.465572]  ? mutex_lock_nested+0x1f/0x30
> [  300.465788]  ksys_write+0x14f/0x290
> [  300.465974]  ? __pfx_ksys_write+0x10/0x10
> [  300.466189]  __x64_sys_write+0x7b/0xc0
> [  300.466384]  ? syscall_trace_enter+0x9b/0x230
> [  300.466610]  x64_sys_call+0x1685/0x20d0
> [  300.466810]  do_syscall_64+0x6d/0x140
> [  300.467007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.467264] RIP: 0033:0x7f0f0ad3ebcf
> [  300.467465] RSP: 002b:00007fffd00b5a30 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  300.467838] RAX: ffffffffffffffda RBX: 00000000000000e0 RCX: 00007f0f0ad3ebcf
> [  300.468186] RDX: 00000000000000e0 RSI: 000055b1be1b80a0 RDI: 0000000000000005
> [  300.468535] RBP: 000055b1be1b80a0 R08: 0000000000000000 R09: 00007f0f0adb14e0
> [  300.468883] R10: 00007f0f0adb13e0 R11: 0000000000000293 R12: 00000000000000e0
> [  300.469231] R13: 000055b1be1ae2a0 R14: 00000000000000e0 R15: 00007f0f0adf69e0
> [  300.469591]  </TASK>
> [  300.469711] INFO: task in:imjournal:321 blocked for more than 147 seconds.
> [  300.470045]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.470311] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.470687] task:in:imjournal    state:D stack:0     pid:321   tgid:302   ppid:1      flags:0x00000002
> [  300.471144] Call Trace:
> [  300.471273]  <TASK>
> [  300.471406]  __schedule+0xe13/0x33a0
> [  300.471601]  ? __pfx___schedule+0x10/0x10
> [  300.471807]  ? lock_release+0x441/0x870
> [  300.472008]  ? __pfx_lock_release+0x10/0x10
> [  300.472221]  ? trace_lock_acquire+0x139/0x1b0
> [  300.472450]  ? lock_acquire+0x80/0xb0
> [  300.472640]  ? schedule+0x216/0x3f0
> [  300.472826]  schedule+0xf6/0x3f0
> [  300.472999]  io_schedule+0xce/0x150
> [  300.473183]  bit_wait_io+0x1f/0x100
> [  300.473368]  __wait_on_bit+0x68/0x1b0
> [  300.473560]  ? __pfx_bit_wait_io+0x10/0x10
> [  300.473778]  out_of_line_wait_on_bit+0xe6/0x120
> [  300.474010]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
> [  300.474273]  ? __pfx_wake_bit_function+0x10/0x10
> [  300.474512]  ? __might_sleep+0xa3/0x170
> [  300.474714]  do_get_write_access+0x83b/0x1010
> [  300.474951]  jbd2_journal_get_write_access+0x1e4/0x270
> [  300.475215]  __ext4_journal_get_write_access+0x72/0x3b0
> [  300.475496]  __ext4_new_inode+0xfef/0x5320
> [  300.475720]  ? __pfx___ext4_new_inode+0x10/0x10
> [  300.475955]  ? __pfx___dquot_initialize+0x10/0x10
> [  300.476202]  ? _raw_spin_unlock+0x31/0x60
> [  300.476409]  ? d_splice_alias+0x4e8/0xe30
> [  300.476619]  ext4_create+0x32e/0x550
> [  300.476815]  ? __pfx_ext4_create+0x10/0x10
> [  300.477030]  ? inode_permission+0xf4/0x650
> [  300.477239]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.477510]  ? __pfx_ext4_create+0x10/0x10
> [  300.477723]  lookup_open.isra.0+0x117c/0x1580
> [  300.477954]  ? __pfx_lookup_open.isra.0+0x10/0x10
> [  300.478200]  ? lock_acquire+0x80/0xb0
> [  300.478391]  ? path_openat+0xd40/0x2bf0
> [  300.478599]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.478873]  path_openat+0xdbf/0x2bf0
> [  300.479085]  ? __pfx_path_openat+0x10/0x10
> [  300.479298]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.479553]  ? lock_is_held_type+0xef/0x150
> [  300.479770]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.480019]  do_filp_open+0x1cc/0x420
> [  300.480213]  ? __pfx_do_filp_open+0x10/0x10
> [  300.480429]  ? lock_release+0x441/0x870
> [  300.480638]  ? do_raw_spin_unlock+0x15c/0x210
> [  300.480877]  do_sys_openat2+0x185/0x1f0
> [  300.481078]  ? __pfx_do_sys_openat2+0x10/0x10
> [  300.481306]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.481548]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.481864]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.482094]  __x64_sys_openat+0x17a/0x240
> [  300.482304]  ? __pfx___x64_sys_openat+0x10/0x10
> [  300.482539]  ? __audit_syscall_entry+0x39c/0x500
> [  300.482784]  x64_sys_call+0x1a52/0x20d0
> [  300.482988]  do_syscall_64+0x6d/0x140
> [  300.483182]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.483450] RIP: 0033:0x7fd79d13e8c4
> [  300.483639] RSP: 002b:00007fd79c1fea40 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> [  300.484009] RAX: ffffffffffffffda RBX: 00007fd794000c50 RCX: 00007fd79d13e8c4
> [  300.484357] RDX: 0000000000000241 RSI: 00007fd79c1feb80 RDI: 00000000ffffff9c
> [  300.484705] RBP: 00007fd79c1feb80 R08: 0000000000000000 R09: 0000000000000001
> [  300.485053] R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000000241
> [  300.485400] R13: 00007fd794000c50 R14: 0000000000000001 R15: 00007fd79402aba0
> [  300.485761]  </TASK>
> [  300.485918] INFO: task repro:686 blocked for more than 147 seconds.
> [  300.486225]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.486491] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.486868] task:repro           state:D stack:0     pid:686   tgid:686   ppid:680    flags:0x00000006
> [  300.487345] Call Trace:
> [  300.487476]  <TASK>
> [  300.487595]  __schedule+0xe13/0x33a0
> [  300.487790]  ? __pfx___schedule+0x10/0x10
> [  300.487995]  ? lock_release+0x441/0x870
> [  300.488196]  ? __pfx_lock_release+0x10/0x10
> [  300.488411]  ? trace_lock_acquire+0x139/0x1b0
> [  300.488640]  ? lock_acquire+0x80/0xb0
> [  300.488831]  ? schedule+0x216/0x3f0
> [  300.489019]  schedule+0xf6/0x3f0
> [  300.489193]  io_schedule+0xce/0x150
> [  300.489378]  blk_mq_get_tag+0x5e7/0xce0
> [  300.489584]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.489811]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.490082]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.490323]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.490603]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.490863]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.491108]  ? lock_acquire.part.0+0x152/0x390
> [  300.491375]  blk_mq_alloc_request+0x655/0x930
> [  300.491604]  ? __pfx_blk_mq_alloc_request+0x10/0x10
> [  300.491865]  scsi_execute_cmd+0x223/0x1040
> [  300.492081]  ? debug_smp_processor_id+0x20/0x30
> [  300.492317]  ? __pfx_scsi_execute_cmd+0x10/0x10
> [  300.492548]  ? rcu_is_watching+0x19/0xc0
> [  300.492754]  ? __kmalloc_noprof+0x34f/0x4a0
> [  300.492970]  ? ata_cmd_ioctl+0x375/0x570
> [  300.493179]  ata_cmd_ioctl+0x23c/0x570
> [  300.493378]  ? __pfx_ata_cmd_ioctl+0x10/0x10
> [  300.493597]  ? lock_release+0x441/0x870
> [  300.493802]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.494052]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.494321]  ? security_capable+0x19d/0x1e0
> [  300.494545]  ata_sas_scsi_ioctl+0x60a/0x7c0
> [  300.494758]  ? mark_lock.part.0+0xf3/0x17b0
> [  300.494979]  ? __pfx_ata_sas_scsi_ioctl+0x10/0x10
> [  300.495218]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.495473]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.495715]  ? lock_is_held_type+0xef/0x150
> [  300.495935]  ? __pfx_ata_scsi_ioctl+0x10/0x10
> [  300.496161]  ata_scsi_ioctl+0x70/0x90
> [  300.496355]  scsi_ioctl+0xb6f/0x1630
> [  300.496546]  ? __might_sleep+0xa3/0x170
> [  300.496748]  ? __pfx_scsi_ioctl+0x10/0x10
> [  300.496954]  ? scsi_block_when_processing_errors+0x2c4/0x390
> [  300.497244]  ? __pfx_scsi_block_when_processing_errors+0x10/0x10
> [  300.497546]  ? __pfx___lock_acquire+0x10/0x10
> [  300.497770]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.498028]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [  300.498298]  ? do_vfs_ioctl+0x4fa/0x1920
> [  300.498502]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [  300.498718]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.498996]  sg_ioctl+0xfb8/0x2880
> [  300.499180]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.499436]  ? lock_release+0x441/0x870
> [  300.499640]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.499842]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.500081]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.500394]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.500621]  ? trace_hardirqs_on+0x51/0x60
> [  300.500834]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [  300.501149]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.501395]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [  300.501649]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.501849]  __x64_sys_ioctl+0x1b5/0x230
> [  300.502055]  x64_sys_call+0x1209/0x20d0
> [  300.502255]  do_syscall_64+0x6d/0x140
> [  300.502447]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.502702] RIP: 0033:0x7f8b9783ee5d
> [  300.502890] RSP: 002b:00007ffc0329c228 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  300.503265] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9783ee5d
> [  300.503629] RDX: 0000000020000080 RSI: 000000000000031f RDI: 0000000000000003
> [  300.503978] RBP: 00007ffc0329c240 R08: 00007ffc0329bfb8 R09: 00007ffc0329c240
> [  300.504326] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc0329c398
> [  300.504674] R13: 0000000000401972 R14: 0000000000403e08 R15: 00007f8b97aff000
> [  300.505034]  </TASK>
> [  300.505153] INFO: task repro:687 blocked for more than 147 seconds.
> [  300.505459]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.505724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.506102] task:repro           state:D stack:0     pid:687   tgid:687   ppid:683    flags:0x00000006
> [  300.506557] Call Trace:
> [  300.506686]  <TASK>
> [  300.506803]  __schedule+0xe13/0x33a0
> [  300.507000]  ? __pfx___schedule+0x10/0x10
> [  300.507206]  ? lock_release+0x441/0x870
> [  300.507419]  ? __pfx_lock_release+0x10/0x10
> [  300.507633]  ? trace_lock_acquire+0x139/0x1b0
> [  300.507865]  ? lock_acquire+0x80/0xb0
> [  300.508055]  ? schedule+0x216/0x3f0
> [  300.508243]  schedule+0xf6/0x3f0
> [  300.508418]  io_schedule+0xce/0x150
> [  300.508602]  blk_mq_get_tag+0x5e7/0xce0
> [  300.508807]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.509034]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.509306]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.509548]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.509829]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.510092]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.510335]  ? lock_acquire.part.0+0x152/0x390
> [  300.510570]  blk_mq_alloc_request+0x655/0x930
> [  300.510801]  ? __pfx_blk_mq_alloc_request+0x10/0x10
> [  300.511072]  scsi_execute_cmd+0x223/0x1040
> [  300.511290]  ? debug_smp_processor_id+0x20/0x30
> [  300.511546]  ? __pfx_scsi_execute_cmd+0x10/0x10
> [  300.511780]  ? rcu_is_watching+0x19/0xc0
> [  300.511984]  ? __kmalloc_noprof+0x34f/0x4a0
> [  300.512200]  ? ata_cmd_ioctl+0x375/0x570
> [  300.512407]  ata_cmd_ioctl+0x23c/0x570
> [  300.512607]  ? __pfx_ata_cmd_ioctl+0x10/0x10
> [  300.512827]  ? lock_release+0x441/0x870
> [  300.513032]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.513282]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.513552]  ? security_capable+0x19d/0x1e0
> [  300.513772]  ata_sas_scsi_ioctl+0x60a/0x7c0
> [  300.513985]  ? mark_lock.part.0+0xf3/0x17b0
> [  300.514200]  ? __pfx_ata_sas_scsi_ioctl+0x10/0x10
> [  300.514439]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.514676]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.514919]  ? lock_is_held_type+0xef/0x150
> [  300.515136]  ? __pfx_ata_scsi_ioctl+0x10/0x10
> [  300.515374]  ata_scsi_ioctl+0x70/0x90
> [  300.515568]  scsi_ioctl+0xb6f/0x1630
> [  300.515759]  ? __might_sleep+0xa3/0x170
> [  300.515962]  ? __pfx_scsi_ioctl+0x10/0x10
> [  300.516170]  ? scsi_block_when_processing_errors+0x2c4/0x390
> [  300.516459]  ? __pfx_scsi_block_when_processing_errors+0x10/0x10
> [  300.516759]  ? __pfx___lock_acquire+0x10/0x10
> [  300.516983]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.517239]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [  300.517511]  ? do_vfs_ioctl+0x4fa/0x1920
> [  300.517715]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [  300.517931]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.518204]  sg_ioctl+0xfb8/0x2880
> [  300.518383]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.518623]  ? lock_release+0x441/0x870
> [  300.518826]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.519034]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.519274]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.519601]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.519828]  ? trace_hardirqs_on+0x51/0x60
> [  300.520039]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [  300.520351]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.520598]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [  300.520853]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.521053]  __x64_sys_ioctl+0x1b5/0x230
> [  300.521260]  x64_sys_call+0x1209/0x20d0
> [  300.521459]  do_syscall_64+0x6d/0x140
> [  300.521651]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.521907] RIP: 0033:0x7f8b9783ee5d
> [  300.522092] RSP: 002b:00007ffc0329c228 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  300.522464] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9783ee5d
> [  300.522815] RDX: 0000000020000080 RSI: 000000000000031f RDI: 0000000000000003
> [  300.523169] RBP: 00007ffc0329c240 R08: 00007ffc0329bfb8 R09: 00007ffc0329c240
> [  300.523531] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc0329c398
> [  300.523881] R13: 0000000000401972 R14: 0000000000403e08 R15: 00007f8b97aff000
> [  300.524241]  </TASK>
> [  300.524359] INFO: task repro:688 blocked for more than 147 seconds.
> [  300.524666]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.524932] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.525308] task:repro           state:D stack:0     pid:688   tgid:688   ppid:685    flags:0x00000006
> [  300.525762] Call Trace:
> [  300.525893]  <TASK>
> [  300.526011]  __schedule+0xe13/0x33a0
> [  300.526207]  ? __pfx___schedule+0x10/0x10
> [  300.526413]  ? lock_release+0x441/0x870
> [  300.526614]  ? __pfx_lock_release+0x10/0x10
> [  300.526827]  ? trace_lock_acquire+0x139/0x1b0
> [  300.527060]  ? lock_acquire+0x80/0xb0
> [  300.527251]  ? schedule+0x216/0x3f0
> [  300.527450]  schedule+0xf6/0x3f0
> [  300.527624]  io_schedule+0xce/0x150
> [  300.527807]  blk_mq_get_tag+0x5e7/0xce0
> [  300.528012]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.528238]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.528508]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.528749]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.529029]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.529291]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.529533]  ? lock_acquire.part.0+0x152/0x390
> [  300.529767]  blk_mq_alloc_request+0x655/0x930
> [  300.529996]  ? __pfx_blk_mq_alloc_request+0x10/0x10
> [  300.530259]  scsi_execute_cmd+0x223/0x1040
> [  300.530476]  ? debug_smp_processor_id+0x20/0x30
> [  300.530712]  ? __pfx_scsi_execute_cmd+0x10/0x10
> [  300.530946]  ? rcu_is_watching+0x19/0xc0
> [  300.531156]  ? __kmalloc_noprof+0x34f/0x4a0
> [  300.531389]  ? ata_cmd_ioctl+0x375/0x570
> [  300.531596]  ata_cmd_ioctl+0x23c/0x570
> [  300.531795]  ? __pfx_ata_cmd_ioctl+0x10/0x10
> [  300.532014]  ? lock_release+0x441/0x870
> [  300.532219]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.532468]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.532738]  ? security_capable+0x19d/0x1e0
> [  300.532959]  ata_sas_scsi_ioctl+0x60a/0x7c0
> [  300.533172]  ? mark_lock.part.0+0xf3/0x17b0
> [  300.533386]  ? __pfx_ata_sas_scsi_ioctl+0x10/0x10
> [  300.533624]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.533863]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.534105]  ? lock_is_held_type+0xef/0x150
> [  300.534323]  ? __pfx_ata_scsi_ioctl+0x10/0x10
> [  300.534547]  ata_scsi_ioctl+0x70/0x90
> [  300.534742]  scsi_ioctl+0xb6f/0x1630
> [  300.534937]  ? __might_sleep+0xa3/0x170
> [  300.535139]  ? __pfx_scsi_ioctl+0x10/0x10
> [  300.535363]  ? scsi_block_when_processing_errors+0x2c4/0x390
> [  300.535652]  ? __pfx_scsi_block_when_processing_errors+0x10/0x10
> [  300.535953]  ? __pfx___lock_acquire+0x10/0x10
> [  300.536176]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.536432]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [  300.536702]  ? do_vfs_ioctl+0x4fa/0x1920
> [  300.536906]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [  300.537122]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.537395]  sg_ioctl+0xfb8/0x2880
> [  300.537574]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.537815]  ? lock_release+0x441/0x870
> [  300.538019]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.538221]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.538462]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.538777]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.539006]  ? trace_hardirqs_on+0x51/0x60
> [  300.539219]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [  300.539546]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.539792]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [  300.540047]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.540246]  __x64_sys_ioctl+0x1b5/0x230
> [  300.540452]  x64_sys_call+0x1209/0x20d0
> [  300.540650]  do_syscall_64+0x6d/0x140
> [  300.540842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.541097] RIP: 0033:0x7f8b9783ee5d
> [  300.541282] RSP: 002b:00007ffc0329c228 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  300.541652] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9783ee5d
> [  300.541999] RDX: 0000000020000080 RSI: 000000000000031f RDI: 0000000000000003
> [  300.542347] RBP: 00007ffc0329c240 R08: 00007ffc0329bfb8 R09: 00007ffc0329c240
> [  300.542695] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc0329c398
> [  300.543048] R13: 0000000000401972 R14: 0000000000403e08 R15: 00007f8b97aff000
> [  300.543422]  </TASK>
> [  300.543540] INFO: task repro:690 blocked for more than 147 seconds.
> [  300.543847]       Not tainted 6.12.0-rc3-8e929cb546ee+ #1
> [  300.544111] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.544487] task:repro           state:D stack:0     pid:690   tgid:690   ppid:689    flags:0x00000006
> [  300.544939] Call Trace:
> [  300.545069]  <TASK>
> [  300.545186]  __schedule+0xe13/0x33a0
> [  300.545380]  ? __pfx___schedule+0x10/0x10
> [  300.545585]  ? lock_release+0x441/0x870
> [  300.545787]  ? __pfx_lock_release+0x10/0x10
> [  300.546000]  ? trace_lock_acquire+0x139/0x1b0
> [  300.546230]  ? lock_acquire+0x80/0xb0
> [  300.546420]  ? schedule+0x216/0x3f0
> [  300.546607]  schedule+0xf6/0x3f0
> [  300.546781]  io_schedule+0xce/0x150
> [  300.546967]  blk_mq_get_tag+0x5e7/0xce0
> [  300.547174]  ? __pfx_blk_mq_get_tag+0x10/0x10
> [  300.547416]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.547687]  __blk_mq_alloc_requests+0x6f6/0x1720
> [  300.547929]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.548210]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
> [  300.548471]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.548714]  ? lock_acquire.part.0+0x152/0x390
> [  300.548948]  blk_mq_alloc_request+0x655/0x930
> [  300.549181]  ? __pfx_blk_mq_alloc_request+0x10/0x10
> [  300.549443]  scsi_execute_cmd+0x223/0x1040
> [  300.549660]  ? debug_smp_processor_id+0x20/0x30
> [  300.549895]  ? __pfx_scsi_execute_cmd+0x10/0x10
> [  300.550126]  ? rcu_is_watching+0x19/0xc0
> [  300.550329]  ? __kmalloc_noprof+0x34f/0x4a0
> [  300.550543]  ? ata_cmd_ioctl+0x375/0x570
> [  300.550749]  ata_cmd_ioctl+0x23c/0x570
> [  300.550950]  ? __pfx_ata_cmd_ioctl+0x10/0x10
> [  300.551170]  ? lock_release+0x441/0x870
> [  300.551391]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.551641]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.551911]  ? security_capable+0x19d/0x1e0
> [  300.552131]  ata_sas_scsi_ioctl+0x60a/0x7c0
> [  300.552344]  ? mark_lock.part.0+0xf3/0x17b0
> [  300.552558]  ? __pfx_ata_sas_scsi_ioctl+0x10/0x10
> [  300.552796]  ? __pfx_mark_lock.part.0+0x10/0x10
> [  300.553033]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.553274]  ? lock_is_held_type+0xef/0x150
> [  300.553491]  ? __pfx_ata_scsi_ioctl+0x10/0x10
> [  300.553716]  ata_scsi_ioctl+0x70/0x90
> [  300.553909]  scsi_ioctl+0xb6f/0x1630
> [  300.554099]  ? __might_sleep+0xa3/0x170
> [  300.554301]  ? __pfx_scsi_ioctl+0x10/0x10
> [  300.554510]  ? scsi_block_when_processing_errors+0x2c4/0x390
> [  300.554800]  ? __pfx_scsi_block_when_processing_errors+0x10/0x10
> [  300.555103]  ? __pfx___lock_acquire+0x10/0x10
> [  300.555350]  ? __sanitizer_cov_trace_switch+0x58/0xa0
> [  300.555608]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [  300.555877]  ? do_vfs_ioctl+0x4fa/0x1920
> [  300.556082]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [  300.556297]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.556569]  sg_ioctl+0xfb8/0x2880
> [  300.556747]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.556987]  ? lock_release+0x441/0x870
> [  300.557189]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.557391]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.557631]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  300.557945]  ? lockdep_hardirqs_on+0x89/0x110
> [  300.558171]  ? trace_hardirqs_on+0x51/0x60
> [  300.558382]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [  300.558695]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  300.558944]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [  300.559201]  ? __pfx_sg_ioctl+0x10/0x10
> [  300.559427]  __x64_sys_ioctl+0x1b5/0x230
> [  300.559635]  x64_sys_call+0x1209/0x20d0
> [  300.559833]  do_syscall_64+0x6d/0x140
> [  300.560025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.560278] RIP: 0033:0x7f8b9783ee5d
> [  300.560463] RSP: 002b:00007ffc0329c228 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  300.560832] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9783ee5d
> [  300.561180] RDX: 0000000020000080 RSI: 000000000000031f RDI: 0000000000000003
> [  300.561527] RBP: 00007ffc0329c240 R08: 00007ffc0329bfb8 R09: 00007ffc0329c240
> [  300.561877] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc0329c398
> [  300.562227] R13: 0000000000401972 R14: 0000000000403e08 R15: 00007f8b97aff000
> [  300.562588]  </TASK>
> [  300.562706] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> [  300.563102]
> [  300.563102] Showing all locks held in the system:
> [  300.563420] 3 locks held by kworker/u8:0/11:
> [  300.563636]  #0: ffff88800df9a148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
> [  300.564146]  #1: ffff88800dcd7d78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
> [  300.564687]  #2: ffff88800d77a0e0 (&type->s_umount_key#52){.+.+}-{3:3}, at: super_trylock_shared+0x2b/0x110
> [  300.565179] 4 locks held by kworker/u8:1/31:
> [  300.565394]  #0: ffff8880125bd148 ((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
> [  300.565924]  #1: ffff88800df4fd78 ((work_completion)(&ei->i_rsv_conversion_work)){+.+.}-{0:0}, at: process_one_work+0x80
> [  300.566500]  #2: ffff888012672958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
> [  300.566948]  #3: ffff888023638c60 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x344/0x1390
> [  300.567407] 1 lock held by khungtaskd/33:
> [  300.567612]  #0: ffffffff8705c9c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
> [  300.568064] 4 locks held by kworker/u8:2/36:
> [  300.568281]  #0: ffff88800df9a148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
> [  300.568774]  #1: ffff88800e4efd78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
> [  300.569316]  #2: ffff8880126740e0 (&type->s_umount_key#38){++++}-{3:3}, at: super_trylock_shared+0x2b/0x110
> [  300.569806]  #3: ffff888012670b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1c3/0x8a0
> [  300.570281] 4 locks held by kworker/1:2/80:
> [  300.570491]  #0: ffff88800d45ad48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
> [  300.570973]  #1: ffff888011fefd78 ((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at: process_one_work0
> [  300.571572]  #2: ffff888010a8c430 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x42/0x470
> [  300.572044]  #3: ffff888010b46378 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x33/0x360
> [  300.572480] 4 locks held by auditd/239:
> [  300.572674]  #0: ffff8880134ccef8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x25e/0x380
> [  300.573087]  #1: ffff888012674408 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x14f/0x290
> [  300.573505]  #2: ffff888017c87040 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb8/0x3e0
> [  300.574025]  #3: ffff888012672958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
> [  300.574469] 3 locks held by in:imjournal/321:
> [  300.574690]  #0: ffff888012674408 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x1f7c/0x2bf0
> [  300.575118]  #1: ffff88801b708dd0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: path_openat+0xd40/0x2bf0
> [  300.575606]  #2: ffff888012672958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
> [  300.576052]
> [  300.576138] =============================================
> "
> 
> I hope you find it useful.
> 
> Regards,
> Yi Lai
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install 
> 
> On Mon, Sep 09, 2024 at 05:42:38PM +0200, Niklas Cassel wrote:
> > When ata_qc_complete() schedules a command for EH using
> > ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> > req->q->mq_ops->timeout() / scsi_timeout() being called.
> > 
> > scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> > handler), will set host byte to DID_TIME_OUT, and then call
> > scsi_eh_scmd_add() to add the command to EH.
> > 
> > Thus, when commands first enter libata's EH strategy_handler, all the
> > commands that have been added to EH will have DID_TIME_OUT set.
> > 
> > libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> > have not received a completion at the time of entering EH.
> > 
> > Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
> > clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
> > scsi_eh_finish_cmd() is called.
> > 
> > However, this clearing in ata_scsi_qc_complete() is currently only done
> > for commands that are not ATA passthrough commands.
> > 
> > Since the host byte is visible in the completion that we return to user
> > space for ATA passthrough commands, for ATA passthrough commands that got
> > completed via EH (commands with sense data), the user will incorrectly see:
> > ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
> > 
> > Fix this by moving the clearing of the host byte (which is currently only
> > done for commands that are not ATA passthrough commands) from
> > ata_scsi_qc_complete() to the start of EH (regardless if the command is
> > ATA passthrough or not).
> > 
> > While at it, use the proper helper function to clear the host byte, rather
> > than open coding the clearing.
> > 
> > This will make sure that we:
> > -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
> >  commands that are not ATA passthrough commands.
> > -Do not needlessly clear the host byte for commands that did not go via EH.
> >  ata_scsi_qc_complete() is called both for commands that are completed
> >  normally (without going via EH), and for commands that went via EH,
> >  however, only commands that went via EH will have DID_TIME_OUT set.
> > 
> > Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> > Reported-by: Igor Pylypiv <ipylypiv@google.com>
> > Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v2: use set_host_byte() as suggested by Damien.
> > 
> >  drivers/ata/libata-eh.c   | 8 ++++++++
> >  drivers/ata/libata-scsi.c | 3 ---
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 7de97ee8e78b..703f5ce26765 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -630,6 +630,14 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
> >  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> >  		struct ata_queued_cmd *qc;
> >  
> > +		/*
> > +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> > +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> > +		 * have set DID_TIME_OUT (since libata does not have an abort
> > +		 * handler). Thus, to clear DID_TIME_OUT, clear the host byte.
> > +		 */
> > +		set_host_byte(scmd, DID_OK);
> > +
> >  		ata_qc_for_each_raw(ap, qc, i) {
> >  			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> >  			    qc->scsicmd == scmd)
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 3a442f564b0d..6a90062c8b55 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> >  	} else if (is_error && !have_sense) {
> >  		ata_gen_ata_sense(qc);
> > -	} else {
> > -		/* Keep the SCSI ML and status byte, clear host byte. */
> > -		cmd->result &= 0x0000ffff;
> >  	}
> >  
> >  	ata_qc_done(qc);
> > -- 
> > 2.46.0
> > 
