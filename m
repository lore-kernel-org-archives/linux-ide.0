Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DA4F1F2;
	Tue, 22 Oct 2024 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575908; cv=none; b=JmwSgVRfqZTn+9E8tPPI31IYI6r96IwcrbspPiIn1uv0An7NPQriqj7eZyyujc1cPYJwE23WXKO/HJi5tYjQjNokL+rAo4LPUKy3542giVaHR0qPdFQ/MjhKpdOkpndsMdlPv9AH9EbWM+/sCc8+LUQAfX/cei0wZ6z3ETPr8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575908; c=relaxed/simple;
	bh=B3pG9X5crDIySTcDDTz/bjgMjyb1qA1GkQNrGRCmfTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCa6Rd5Tz4na6BqsvWr2M7Vce3TDy8aaipIXVINbpeRDkZjNQyHFhU1fdaNQUr8SoU9CHnUD3pExPYHrq/cDSpiqGlxTGXDigC6aqYu8PWo3m9Vg6ZEcFtgX+RItrzTlWdDdT/7fcbrC9CAv5oyY7E+WwItwik+pzq42cAxHwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGfXD0t0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGfXD0t0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575905; x=1761111905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3pG9X5crDIySTcDDTz/bjgMjyb1qA1GkQNrGRCmfTI=;
  b=kGfXD0t0ildNrbiL3eVxrehLvK/GsmDAg9e5+WoCGjPI0LZiOA6uUs86
   PWNT71MkPnklL4TJ8o02U6ZneAKACvcx4UmH/Yl5NehLBWG9waWK/renU
   kC7+gka3OXrmMHViLis5QD+6znEvcVSW1Cw1+xf90un5P1mQLohedxFFC
   6OvRUzI5fGVnBKH1dN0foz4i+s43Be6LPh/NjUqfj/CDoUhvzTUGi2qFq
   7tNgYKmcg5HBZl/2LayBnnXfLOm/y8nWqvxCVM204o27cdXIi6aiP67xu
   2WDearzErXbIGQgZVbWxJa8zP6oi6YeQey5Gcjh0lqx+0IyTetRVrmCRI
   g==;
X-CSE-ConnectionGUID: EGgB4k8VQf6qykS7fd3iYw==
X-CSE-MsgGUID: 84z4xdcfTWGv9SIXq0/G3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46575330"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="46575330"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:45:04 -0700
X-CSE-ConnectionGUID: KOORin68RIuhqnefIwmZYw==
X-CSE-MsgGUID: gPHVmzNvSXuGFceVXbw/Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84345877"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:45:02 -0700
Date: Tue, 22 Oct 2024 13:44:08 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <Zxc7qLHYr60FJrD4@ly-workstation>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZxLK7eSQ_bwkLe@ryzen.lan>

On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > Hello Yi Lai,
> > 
> > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > Hi Niklas Cassel,
> > > 
> > > Greetings!
> > > 
> > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > 
> > > After bisection and the first bad commit is:
> > > "
> > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > "
> > 
> > It might be that your bisection results are accurate.
> > 
> > However, after looking at the stacktraces, I find it way more likely that
> > bisection has landed on the wrong commit.
> > 
> > See this series that was just queued (for 6.13) a few days ago that solves a
> > similar starvation:
> > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > 
> > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > the bug?
> 
> Another patch that might be relevant:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e972b08b91ef48488bae9789f03cfedb148667fb
> 
> Which fixes a use after delete in rq_qos_wake_function().
> (We can see that the stack trace has rq_qos_wake_function() before
> getting stuck forever in rq_qos_wait())
> 
> Who knows what could go wrong when accessing a deleted entry, in the
> report there was a crash, but I could image other surprises :)
> The fix was first included in v6.12-rc4.
> 
>
Hi Niklas,

Thanks for the info. I have tried using v6.12-rc4 kernel to reproduce
the issue. Using the same repro binary, the issue still exists.

[  300.430914] INFO: task kworker/u8:0:11 blocked for more than 147 seconds.
[  300.431593]       Not tainted 6.12.0-rc4-kvm #1
[  300.431988] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.432640] task:kworker/u8:0    state:D stack:0     pid:11    tgid:11    ppid:2      flags:0x00004000
[  300.433431] Workqueue: writeback wb_workfn (flush-8:0)
[  300.433908] Call Trace:
[  300.434132]  <TASK>
[  300.434335]  __schedule+0xe13/0x33a0
[  300.434687]  ? __pfx___schedule+0x10/0x10
[  300.435055]  ? lock_release+0x441/0x870
[  300.435393]  ? __pfx_lock_release+0x10/0x10
[  300.435730]  ? trace_lock_acquire+0x139/0x1b0
[  300.436100]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.436533]  ? kthread_data+0x61/0xd0
[  300.436848]  schedule+0xf6/0x3f0
[  300.437123]  io_schedule+0xce/0x150
[  300.437413]  bit_wait_io+0x1f/0x100
[  300.437707]  __wait_on_bit+0x68/0x1b0
[  300.438011]  ? __pfx_bit_wait_io+0x10/0x10
[  300.438351]  out_of_line_wait_on_bit+0xe6/0x120
[  300.438750]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
[  300.439162]  ? __pfx_wake_bit_function+0x10/0x10
[  300.439540]  ? __might_sleep+0xa3/0x170
[  300.439864]  do_get_write_access+0x83b/0x1010
[  300.440241]  jbd2_journal_get_write_access+0x1e4/0x270
[  300.440655]  __ext4_journal_get_write_access+0x72/0x3b0
[  300.441238]  ext4_mb_mark_context+0x184/0xe30
[  300.441709]  ? __pfx_lock_release+0x10/0x10
[  300.442156]  ? __pfx_ext4_mb_mark_context+0x10/0x10
[  300.442650]  ? ext4_sb_block_valid+0x3a6/0x670
[  300.443134]  ext4_mb_mark_diskspace_used+0x44d/0x9e0
[  300.443595]  ? ext4_get_group_no_and_offset+0x186/0x1f0
[  300.444074]  ? __pfx_ext4_mb_mark_diskspace_used+0x10/0x10
[  300.444582]  ext4_mb_new_blocks+0x779/0x4790
[  300.444966]  ? lock_is_held_type+0xef/0x150
[  300.445349]  ? kasan_save_track+0x18/0x40
[  300.445727]  ? __pfx_ext4_mb_new_blocks+0x10/0x10
[  300.446139]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.446598]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.447066]  ? ext4_inode_to_goal_block+0x340/0x450
[  300.447486]  ext4_ext_map_blocks+0x16f0/0x6060
[  300.447877]  ? __pfx___lock_acquire+0x10/0x10
[  300.448251]  ? stack_trace_save+0x97/0xd0
[  300.448599]  ? __pfx_ext4_ext_map_blocks+0x10/0x10
[  300.449001]  ? debug_smp_processor_id+0x20/0x30
[  300.449372]  ? rcu_is_watching+0x19/0xc0
[  300.449701]  ? trace_lock_acquire+0x139/0x1b0
[  300.450065]  ? lock_acquire+0x80/0xb0
[  300.450359]  ? ext4_map_blocks+0x344/0x1390
[  300.450696]  ? __pfx_down_write+0x10/0x10
[  300.451048]  ext4_map_blocks+0x421/0x1390
[  300.451373]  ? __pfx_ext4_map_blocks+0x10/0x10
[  300.451718]  ? kasan_save_track+0x18/0x40
[  300.452030]  ? debug_smp_processor_id+0x20/0x30
[  300.452374]  ? rcu_is_watching+0x19/0xc0
[  300.452674]  ? kmem_cache_alloc_noprof+0x2e7/0x370
[  300.453040]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.453430]  ext4_do_writepages+0x18e0/0x2f30
[  300.453775]  ? __pfx_ext4_do_writepages+0x10/0x10
[  300.454115]  ? rcu_is_watching+0x19/0xc0
[  300.454411]  ? __this_cpu_preempt_check+0x21/0x30
[  300.454760]  ? lock_is_held_type+0xef/0x150
[  300.455063]  ext4_writepages+0x35c/0x7c0
[  300.455345]  ? __pfx_ext4_writepages+0x10/0x10
[  300.455658]  ? lock_release+0x441/0x870
[  300.455948]  ? do_raw_spin_unlock+0x15c/0x210
[  300.456250]  ? __pfx_ext4_writepages+0x10/0x10
[  300.456557]  do_writepages+0x1c3/0x8a0
[  300.456833]  ? __pfx_do_writepages+0x10/0x10
[  300.457127]  ? __pfx_lock_release+0x10/0x10
[  300.457413]  ? __pfx_lock_release+0x10/0x10
[  300.457711]  __writeback_single_inode+0x124/0xe10
[  300.458033]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
[  300.458385]  writeback_sb_inodes+0x63b/0x1000
[  300.458675]  ? lock_release+0x441/0x870
[  300.458956]  ? __pfx_writeback_sb_inodes+0x10/0x10
[  300.459270]  ? lock_acquire.part.0+0x152/0x390
[  300.459605]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  300.459959]  __writeback_inodes_wb+0xc8/0x280
[  300.460248]  wb_writeback+0x717/0xaf0
[  300.460496]  ? __pfx_wb_writeback+0x10/0x10
[  300.460772]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.461086]  ? get_nr_dirty_inodes+0x12c/0x1b0
[  300.461374]  ? lockdep_hardirqs_on+0x89/0x110
[  300.461660]  wb_workfn+0x7b5/0xc90
[  300.461888]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.462198]  ? __pfx_wb_workfn+0x10/0x10
[  300.462446]  ? rcu_is_watching+0x19/0xc0
[  300.462707]  process_one_work+0x92e/0x1b50
[  300.462994]  ? lock_acquire.part.0+0x152/0x390
[  300.463285]  ? __pfx_process_one_work+0x10/0x10
[  300.463566]  ? move_linked_works+0x1bf/0x2c0
[  300.463839]  ? __this_cpu_preempt_check+0x21/0x30
[  300.464138]  ? assign_work+0x19f/0x250
[  300.464375]  ? lock_is_held_type+0xef/0x150
[  300.464641]  worker_thread+0x68d/0xe90
[  300.464893]  kthread+0x35a/0x470
[  300.465095]  ? __pfx_worker_thread+0x10/0x10
[  300.465355]  ? __pfx_kthread+0x10/0x10
[  300.465587]  ret_from_fork+0x56/0x90
[  300.465812]  ? __pfx_kthread+0x10/0x10
[  300.466043]  ret_from_fork_asm+0x1a/0x30
[  300.466297]  </TASK>
[  300.466451] INFO: task kworker/u8:1:31 blocked for more than 147 seconds.
[  300.466858]       Not tainted 6.12.0-rc4-kvm #1
[  300.467127] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.467573] task:kworker/u8:1    state:D stack:0     pid:31    tgid:31    ppid:2      flags:0x00004000
[  300.468115] Workqueue: writeback wb_workfn (flush-8:0)
[  300.468426] Call Trace:
[  300.468579]  <TASK>
[  300.468717]  __schedule+0xe13/0x33a0
[  300.468951]  ? __pfx___schedule+0x10/0x10
[  300.469194]  ? lock_release+0x441/0x870
[  300.469433]  ? __pfx_lock_release+0x10/0x10
[  300.469686]  ? trace_lock_acquire+0x139/0x1b0
[  300.469957]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.470270]  ? kthread_data+0x61/0xd0
[  300.470492]  schedule+0xf6/0x3f0
[  300.470692]  io_schedule+0xce/0x150
[  300.470917]  blk_mq_get_tag+0x5e7/0xce0
[  300.471160]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  300.471417]  ? __pfx_wbt_cleanup_cb+0x10/0x10
[  300.471677]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  300.471971]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.472275]  ? __pfx_rq_qos_wake_function+0x10/0x10
[  300.472558]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.472863]  ? dd_limit_depth+0x21e/0x2a0
[  300.473098]  ? __pfx_dd_limit_depth+0x10/0x10
[  300.473349]  __blk_mq_alloc_requests+0x6f6/0x1720
[  300.473632]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  300.473926]  ? __pfx_wbt_wait+0x10/0x10
[  300.474152]  blk_mq_submit_bio+0x93c/0x2a20
[  300.474391]  ? __kasan_check_read+0x15/0x20
[  300.474645]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[  300.474921]  ? __pfx_mark_lock.part.0+0x10/0x10
[  300.475182]  ? __this_cpu_preempt_check+0x21/0x30
[  300.475457]  ? __this_cpu_preempt_check+0x21/0x30
[  300.475727]  ? lock_release+0x441/0x870
[  300.475953]  __submit_bio+0x18d/0x500
[  300.476169]  ? __pfx___submit_bio+0x10/0x10
[  300.476407]  ? __this_cpu_preempt_check+0x21/0x30
[  300.476668]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.477018]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.477313]  ? kvm_clock_get_cycles+0x43/0x70
[  300.477566]  submit_bio_noacct_nocheck+0x6a0/0xcc0
[  300.477834]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  300.478127]  ? lock_is_held_type+0xef/0x150
[  300.478369]  submit_bio_noacct+0x61d/0x1dc0
[  300.478610]  submit_bio+0xce/0x480
[  300.478819]  ext4_io_submit+0xb0/0x150
[  300.479036]  ext4_do_writepages+0xa54/0x2f30
[  300.479284]  ? __this_cpu_preempt_check+0x21/0x30
[  300.479556]  ? __pfx_ext4_do_writepages+0x10/0x10
[  300.479817]  ? rcu_is_watching+0x19/0xc0
[  300.480042]  ? __this_cpu_preempt_check+0x21/0x30
[  300.480304]  ? lock_is_held_type+0xef/0x150
[  300.480544]  ext4_writepages+0x35c/0x7c0
[  300.480766]  ? __pfx_ext4_writepages+0x10/0x10
[  300.481019]  ? lock_release+0x441/0x870
[  300.481247]  ? do_raw_spin_unlock+0x15c/0x210
[  300.481491]  ? __pfx_ext4_writepages+0x10/0x10
[  300.481734]  do_writepages+0x1c3/0x8a0
[  300.481947]  ? __pfx_do_writepages+0x10/0x10
[  300.482181]  ? __pfx_lock_release+0x10/0x10
[  300.482409]  ? __pfx_lock_release+0x10/0x10
[  300.482646]  __writeback_single_inode+0x124/0xe10
[  300.482912]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
[  300.483192]  writeback_sb_inodes+0x63b/0x1000
[  300.483431]  ? lock_release+0x441/0x870
[  300.483652]  ? __pfx_writeback_sb_inodes+0x10/0x10
[  300.483911]  ? lock_acquire.part.0+0x152/0x390
[  300.484187]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  300.484478]  __writeback_inodes_wb+0xc8/0x280
[  300.484724]  wb_writeback+0x717/0xaf0
[  300.484938]  ? __pfx_wb_writeback+0x10/0x10
[  300.485172]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.485433]  ? get_nr_dirty_inodes+0x12c/0x1b0
[  300.485675]  ? lockdep_hardirqs_on+0x89/0x110
[  300.485917]  wb_workfn+0x7b5/0xc90
[  300.486111]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.486375]  ? __pfx_wb_workfn+0x10/0x10
[  300.486591]  ? rcu_is_watching+0x19/0xc0
[  300.486831]  process_one_work+0x92e/0x1b50
[  300.487055]  ? lock_acquire.part.0+0x152/0x390
[  300.487308]  ? __pfx_process_one_work+0x10/0x10
[  300.487555]  ? move_linked_works+0x1bf/0x2c0
[  300.487791]  ? __this_cpu_preempt_check+0x21/0x30
[  300.488053]  ? assign_work+0x19f/0x250
[  300.488260]  ? lock_is_held_type+0xef/0x150
[  300.488493]  worker_thread+0x68d/0xe90
[  300.488701]  ? lockdep_hardirqs_on+0x89/0x110
[  300.488960]  kthread+0x35a/0x470
[  300.489141]  ? __pfx_worker_thread+0x10/0x10
[  300.489377]  ? __pfx_kthread+0x10/0x10
[  300.489586]  ret_from_fork+0x56/0x90
[  300.489785]  ? __pfx_kthread+0x10/0x10
[  300.489993]  ret_from_fork_asm+0x1a/0x30
[  300.490221]  </TASK>
[  300.490347] INFO: task kworker/u8:2:35 blocked for more than 147 seconds.
[  300.490698]       Not tainted 6.12.0-rc4-kvm #1
[  300.490952] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.491353] task:kworker/u8:2    state:D stack:0     pid:35    tgid:35    ppid:2      flags:0x00004000
[  300.491835] Workqueue: writeback wb_workfn (flush-8:0)
[  300.492115] Call Trace:
[  300.492252]  <TASK>
[  300.492377]  __schedule+0xe13/0x33a0
[  300.492585]  ? __pfx___schedule+0x10/0x10
[  300.492811]  ? lock_release+0x441/0x870
[  300.493031]  ? __pfx_lock_release+0x10/0x10
[  300.493259]  ? trace_lock_acquire+0x139/0x1b0
[  300.493502]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.493784]  ? kthread_data+0x61/0xd0
[  300.493985]  schedule+0xf6/0x3f0
[  300.494165]  io_schedule+0xce/0x150
[  300.494358]  blk_mq_get_tag+0x5e7/0xce0
[  300.494570]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  300.494815]  ? __pfx___mod_timer+0x10/0x10
[  300.495036]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.495311]  ? __pfx_rq_qos_wake_function+0x10/0x10
[  300.495571]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.495852]  ? dd_limit_depth+0x21e/0x2a0
[  300.496069]  ? __pfx_dd_limit_depth+0x10/0x10
[  300.496303]  __blk_mq_alloc_requests+0x6f6/0x1720
[  300.496552]  ? mod_timer+0x29/0x40
[  300.496749]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  300.497028]  ? __pfx_wbt_wait+0x10/0x10
[  300.497239]  blk_mq_submit_bio+0x93c/0x2a20
[  300.497461]  ? __kasan_check_read+0x15/0x20
[  300.497691]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[  300.497935]  ? __pfx_mark_lock.part.0+0x10/0x10
[  300.498177]  ? __this_cpu_preempt_check+0x21/0x30
[  300.498433]  ? __this_cpu_preempt_check+0x21/0x30
[  300.498683]  ? lock_release+0x441/0x870
[  300.498905]  __submit_bio+0x18d/0x500
[  300.499105]  ? __pfx___submit_bio+0x10/0x10
[  300.499329]  ? __this_cpu_preempt_check+0x21/0x30
[  300.499578]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.499908]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.500192]  ? kvm_clock_get_cycles+0x43/0x70
[  300.500430]  submit_bio_noacct_nocheck+0x6a0/0xcc0
[  300.500687]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  300.500985]  submit_bio_noacct+0x61d/0x1dc0
[  300.501216]  submit_bio+0xce/0x480
[  300.501405]  ext4_io_submit+0xb0/0x150
[  300.501611]  ext4_do_writepages+0x1103/0x2f30
[  300.501862]  ? __pfx_ext4_do_writepages+0x10/0x10
[  300.502111]  ? rcu_is_watching+0x19/0xc0
[  300.502326]  ? __this_cpu_preempt_check+0x21/0x30
[  300.502577]  ? lock_is_held_type+0xef/0x150
[  300.502820]  ext4_writepages+0x35c/0x7c0
[  300.503034]  ? __pfx_ext4_writepages+0x10/0x10
[  300.503271]  ? lock_release+0x441/0x870
[  300.503489]  ? do_raw_spin_unlock+0x15c/0x210
[  300.503725]  ? __pfx_ext4_writepages+0x10/0x10
[  300.503964]  do_writepages+0x1c3/0x8a0
[  300.504171]  ? __pfx_do_writepages+0x10/0x10
[  300.504400]  ? __pfx_lock_release+0x10/0x10
[  300.504623]  ? __pfx_lock_release+0x10/0x10
[  300.504865]  __writeback_single_inode+0x124/0xe10
[  300.505117]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
[  300.505399]  writeback_sb_inodes+0x63b/0x1000
[  300.505641]  ? lock_release+0x441/0x870
[  300.505863]  ? __pfx_writeback_sb_inodes+0x10/0x10
[  300.506123]  ? lock_acquire.part.0+0x152/0x390
[  300.506400]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  300.506692]  __writeback_inodes_wb+0xc8/0x280
[  300.506953]  wb_writeback+0x717/0xaf0
[  300.507164]  ? __pfx_wb_writeback+0x10/0x10
[  300.507394]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.507656]  ? get_nr_dirty_inodes+0x12c/0x1b0
[  300.507898]  ? lockdep_hardirqs_on+0x89/0x110
[  300.508140]  wb_workfn+0x7b5/0xc90
[  300.508337]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.508601]  ? __pfx_wb_workfn+0x10/0x10
[  300.508822]  ? rcu_is_watching+0x19/0xc0
[  300.509047]  process_one_work+0x92e/0x1b50
[  300.509265]  ? lock_acquire.part.0+0x152/0x390
[  300.509512]  ? __pfx_process_one_work+0x10/0x10
[  300.509752]  ? move_linked_works+0x1bf/0x2c0
[  300.509982]  ? __this_cpu_preempt_check+0x21/0x30
[  300.510238]  ? assign_work+0x19f/0x250
[  300.510440]  ? lock_is_held_type+0xef/0x150
[  300.510667]  worker_thread+0x68d/0xe90
[  300.510895]  kthread+0x35a/0x470
[  300.511073]  ? __pfx_worker_thread+0x10/0x10
[  300.511302]  ? __pfx_kthread+0x10/0x10
[  300.511507]  ret_from_fork+0x56/0x90
[  300.511702]  ? __pfx_kthread+0x10/0x10
[  300.511906]  ret_from_fork_asm+0x1a/0x30
[  300.512128]  </TASK>
[  300.512270] INFO: task jbd2/sda-8:104 blocked for more than 147 seconds.
[  300.512609]       Not tainted 6.12.0-rc4-kvm #1
[  300.512847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.513237] task:jbd2/sda-8      state:D stack:0     pid:104   tgid:104   ppid:2      flags:0x00004000
[  300.513707] Call Trace:
[  300.513840]  <TASK>
[  300.513961]  __schedule+0xe13/0x33a0
[  300.514162]  ? __pfx___schedule+0x10/0x10
[  300.514376]  ? lock_release+0x441/0x870
[  300.514586]  ? __pfx_lock_release+0x10/0x10
[  300.514819]  ? trace_lock_acquire+0x139/0x1b0
[  300.515057]  ? lock_acquire+0x80/0xb0
[  300.515254]  ? schedule+0x216/0x3f0
[  300.515448]  schedule+0xf6/0x3f0
[  300.515629]  io_schedule+0xce/0x150
[  300.515820]  blk_mq_get_tag+0x5e7/0xce0
[  300.516033]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  300.516266]  ? lock_release+0x441/0x870
[  300.516471]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  300.516737]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.517014]  ? blk_mq_sched_try_merge+0xce/0x650
[  300.517261]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.517542]  ? dd_limit_depth+0x21e/0x2a0
[  300.517758]  ? __pfx_dd_limit_depth+0x10/0x10
[  300.517992]  __blk_mq_alloc_requests+0x6f6/0x1720
[  300.518246]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.518534]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  300.518818]  ? __pfx_wbt_wait+0x10/0x10
[  300.519029]  blk_mq_submit_bio+0x93c/0x2a20
[  300.519251]  ? __pfx___lock_acquire+0x10/0x10
[  300.519490]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[  300.519736]  ? __this_cpu_preempt_check+0x21/0x30
[  300.519991]  ? __this_cpu_preempt_check+0x21/0x30
[  300.520242]  ? lock_release+0x441/0x870
[  300.520451]  __submit_bio+0x18d/0x500
[  300.520650]  ? __pfx___submit_bio+0x10/0x10
[  300.520879]  ? __this_cpu_preempt_check+0x21/0x30
[  300.521130]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.521458]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.521738]  ? kvm_clock_get_cycles+0x43/0x70
[  300.521977]  submit_bio_noacct_nocheck+0x6a0/0xcc0
[  300.522226]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  300.522504]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  300.522782]  submit_bio_noacct+0x61d/0x1dc0
[  300.523006]  submit_bio+0xce/0x480
[  300.523190]  submit_bh_wbc+0x58a/0x740
[  300.523397]  submit_bh+0x2b/0x40
[  300.523572]  jbd2_journal_commit_transaction+0x2a09/0x65e0
[  300.523873]  ? __pfx_jbd2_journal_commit_transaction+0x10/0x10
[  300.524176]  ? __this_cpu_preempt_check+0x21/0x30
[  300.524420]  ? lock_release+0x441/0x870
[  300.524630]  ? __this_cpu_preempt_check+0x21/0x30
[  300.524879]  ? _raw_spin_unlock_irqrestore+0x45/0x70
[  300.525135]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.525417]  ? kjournald2+0x5e7/0x790
[  300.525616]  kjournald2+0x204/0x790
[  300.525809]  ? __pfx_kjournald2+0x10/0x10
[  300.526017]  ? lockdep_hardirqs_on+0x89/0x110
[  300.526245]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.526513]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.526797]  ? __kthread_parkme+0x15d/0x230
[  300.527019]  kthread+0x35a/0x470
[  300.527192]  ? __pfx_kjournald2+0x10/0x10
[  300.527399]  ? __pfx_kthread+0x10/0x10
[  300.527597]  ret_from_fork+0x56/0x90
[  300.527787]  ? __pfx_kthread+0x10/0x10
[  300.527984]  ret_from_fork_asm+0x1a/0x30
[  300.528200]  </TASK>
[  300.528319] INFO: task kworker/u8:4:167 blocked for more than 147 seconds.
[  300.528657]       Not tainted 6.12.0-rc4-kvm #1
[  300.528891] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.529273] task:kworker/u8:4    state:D stack:0     pid:167   tgid:167   ppid:2      flags:0x00004000
[  300.529732] Workqueue: writeback wb_workfn (flush-8:0)
[  300.529998] Call Trace:
[  300.530128]  <TASK>
[  300.530246]  __schedule+0xe13/0x33a0
[  300.530443]  ? __pfx___schedule+0x10/0x10
[  300.530651]  ? lock_release+0x441/0x870
[  300.530867]  ? __pfx_lock_release+0x10/0x10
[  300.531084]  ? trace_lock_acquire+0x139/0x1b0
[  300.531316]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.531589]  ? kthread_data+0x61/0xd0
[  300.531785]  schedule+0xf6/0x3f0
[  300.531961]  io_schedule+0xce/0x150
[  300.532148]  rq_qos_wait+0x1c5/0x310
[  300.532336]  ? __pfx_wbt_cleanup_cb+0x10/0x10
[  300.532563]  ? __pfx_rq_qos_wait+0x10/0x10
[  300.532780]  ? __pfx_lock_release+0x10/0x10
[  300.533000]  ? __pfx_rq_qos_wake_function+0x10/0x10
[  300.533254]  ? __pfx_wbt_inflight_cb+0x10/0x10
[  300.533487]  ? do_raw_spin_unlock+0x15c/0x210
[  300.533719]  wbt_wait+0x1ec/0x400
[  300.533898]  ? __pfx_wbt_wait+0x10/0x10
[  300.534100]  ? __pfx_dd_bio_merge+0x10/0x10
[  300.534321]  ? __pfx_wbt_wait+0x10/0x10
[  300.534523]  __rq_qos_throttle+0x5f/0xb0
[  300.534748]  blk_mq_submit_bio+0x8ad/0x2a20
[  300.534966]  ? __kasan_check_read+0x15/0x20
[  300.535188]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[  300.535426]  ? __pfx_mark_lock.part.0+0x10/0x10
[  300.535663]  ? __this_cpu_preempt_check+0x21/0x30
[  300.535912]  ? __this_cpu_preempt_check+0x21/0x30
[  300.536156]  ? lock_release+0x441/0x870
[  300.536362]  __submit_bio+0x18d/0x500
[  300.536556]  ? __pfx___submit_bio+0x10/0x10
[  300.536777]  ? __this_cpu_preempt_check+0x21/0x30
[  300.537021]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.537342]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.537616]  ? kvm_clock_get_cycles+0x43/0x70
[  300.537849]  submit_bio_noacct_nocheck+0x6a0/0xcc0
[  300.538098]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  300.538375]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  300.538637]  submit_bio_noacct+0x61d/0x1dc0
[  300.538874]  submit_bio+0xce/0x480
[  300.539059]  submit_bh_wbc+0x58a/0x740
[  300.539263]  __block_write_full_folio+0x7a1/0xed0
[  300.539506]  ? __pfx_blkdev_get_block+0x10/0x10
[  300.539749]  block_write_full_folio+0x2e6/0x3a0
[  300.539985]  ? __pfx_blkdev_get_block+0x10/0x10
[  300.540224]  ? __pfx_blkdev_get_block+0x10/0x10
[  300.540460]  write_cache_pages+0xbc/0x140
[  300.540670]  ? __pfx_block_write_full_folio+0x10/0x10
[  300.540933]  ? __pfx_write_cache_pages+0x10/0x10
[  300.541178]  ? __this_cpu_preempt_check+0x21/0x30
[  300.541427]  blkdev_writepages+0xa5/0xf0
[  300.541634]  ? __pfx_blkdev_writepages+0x10/0x10
[  300.541874]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  300.542117]  ? do_raw_spin_unlock+0x15c/0x210
[  300.542349]  ? __pfx_blkdev_writepages+0x10/0x10
[  300.542590]  do_writepages+0x1c3/0x8a0
[  300.542809]  ? __pfx_do_writepages+0x10/0x10
[  300.543017]  ? __pfx_lock_release+0x10/0x10
[  300.543216]  ? lock_release+0x441/0x870
[  300.543410]  __writeback_single_inode+0x124/0xe10
[  300.543649]  ? wbc_attach_and_unlock_inode+0x5a9/0x950
[  300.543918]  writeback_sb_inodes+0x63b/0x1000
[  300.544159]  ? __pfx_writeback_sb_inodes+0x10/0x10
[  300.544405]  ? lock_acquire.part.0+0x152/0x390
[  300.544669]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  300.544949]  __writeback_inodes_wb+0xc8/0x280
[  300.545184]  wb_writeback+0x717/0xaf0
[  300.545385]  ? __pfx_wb_writeback+0x10/0x10
[  300.545604]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.545859]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.546109]  ? get_nr_dirty_inodes+0x12c/0x1b0
[  300.546342]  ? lockdep_hardirqs_on+0x89/0x110
[  300.546574]  wb_workfn+0x76c/0xc90
[  300.546773]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.547026]  ? __pfx_wb_workfn+0x10/0x10
[  300.547234]  ? rcu_is_watching+0x19/0xc0
[  300.547452]  process_one_work+0x92e/0x1b50
[  300.547666]  ? lock_acquire.part.0+0x152/0x390
[  300.547908]  ? __pfx_process_one_work+0x10/0x10
[  300.548144]  ? move_linked_works+0x1bf/0x2c0
[  300.548370]  ? __this_cpu_preempt_check+0x21/0x30
[  300.548620]  ? assign_work+0x19f/0x250
[  300.548821]  ? lock_is_held_type+0xef/0x150
[  300.549043]  worker_thread+0x68d/0xe90
[  300.549242]  ? lockdep_hardirqs_on+0x89/0x110
[  300.549481]  kthread+0x35a/0x470
[  300.549655]  ? __pfx_worker_thread+0x10/0x10
[  300.549880]  ? __pfx_kthread+0x10/0x10
[  300.550080]  ret_from_fork+0x56/0x90
[  300.550270]  ? __pfx_kthread+0x10/0x10
[  300.550470]  ret_from_fork_asm+0x1a/0x30
[  300.550687]  </TASK>
[  300.550826] INFO: task kworker/1:3:233 blocked for more than 147 seconds.
[  300.551165]       Not tainted 6.12.0-rc4-kvm #1
[  300.551396] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.551780] task:kworker/1:3     state:D stack:0     pid:233   tgid:233   ppid:2      flags:0x00004000
[  300.552242] Workqueue: events ata_scsi_dev_rescan
[  300.552501] Call Trace:
[  300.552635]  <TASK>
[  300.552754]  __schedule+0xe13/0x33a0
[  300.552955]  ? __pfx___schedule+0x10/0x10
[  300.553165]  ? lock_release+0x441/0x870
[  300.553370]  ? __pfx_lock_release+0x10/0x10
[  300.553594]  ? _raw_spin_unlock_irq+0x3c/0x60
[  300.553825]  schedule+0xf6/0x3f0
[  300.554002]  io_schedule+0xce/0x150
[  300.554190]  blk_mq_get_tag+0x5e7/0xce0
[  300.554398]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  300.554629]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.554934]  __blk_mq_alloc_requests+0x6f6/0x1720
[  300.555181]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.555466]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  300.555740]  blk_mq_alloc_request+0x655/0x930
[  300.555973]  ? __pfx_blk_mq_alloc_request+0x10/0x10
[  300.556225]  ? __lock_acquire+0xd87/0x5c90
[  300.556450]  scsi_execute_cmd+0x223/0x1040
[  300.556684]  ? __this_cpu_preempt_check+0x21/0x30
[  300.556933]  ? __pfx_scsi_execute_cmd+0x10/0x10
[  300.557178]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.557431]  scsi_vpd_inquiry+0xdf/0x220
[  300.557641]  ? __pfx_scsi_vpd_inquiry+0x10/0x10
[  300.557877]  ? debug_smp_processor_id+0x20/0x30
[  300.558113]  ? rcu_is_watching+0x19/0xc0
[  300.558325]  scsi_get_vpd_size+0x11e/0x310
[  300.558539]  ? __mutex_lock+0x230/0x1490
[  300.558763]  ? __pfx_scsi_get_vpd_size+0x10/0x10
[  300.559004]  ? scsi_rescan_device+0x33/0x360
[  300.559227]  ? __pfx_mark_lock.part.0+0x10/0x10
[  300.559465]  ? __this_cpu_preempt_check+0x21/0x30
[  300.559713]  ? lock_acquire.part.0+0x152/0x390
[  300.559947]  ? __pfx___mutex_lock+0x10/0x10
[  300.560172]  scsi_get_vpd_buf+0x30/0x180
[  300.560382]  scsi_attach_vpd+0xf8/0x5b0
[  300.560591]  scsi_rescan_device+0x106/0x360
[  300.560820]  ata_scsi_dev_rescan+0x1d2/0x470
[  300.561051]  process_one_work+0x92e/0x1b50
[  300.561264]  ? lock_acquire.part.0+0x152/0x390
[  300.561505]  ? __pfx_process_one_work+0x10/0x10
[  300.561741]  ? move_linked_works+0x1bf/0x2c0
[  300.561972]  ? __this_cpu_preempt_check+0x21/0x30
[  300.562220]  ? assign_work+0x19f/0x250
[  300.562421]  ? lock_is_held_type+0xef/0x150
[  300.562645]  worker_thread+0x68d/0xe90
[  300.562856]  ? lockdep_hardirqs_on+0x89/0x110
[  300.563105]  kthread+0x35a/0x470
[  300.563278]  ? __pfx_worker_thread+0x10/0x10
[  300.563501]  ? __pfx_kthread+0x10/0x10
[  300.563700]  ret_from_fork+0x56/0x90
[  300.563892]  ? __pfx_kthread+0x10/0x10
[  300.564093]  ret_from_fork_asm+0x1a/0x30
[  300.564313]  </TASK>
[  300.564432] INFO: task auditd:240 blocked for more than 147 seconds.
[  300.564749]       Not tainted 6.12.0-rc4-kvm #1
[  300.564984] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.565375] task:auditd          state:D stack:0     pid:240   tgid:240   ppid:1      flags:0x00000002
[  300.565832] Call Trace:
[  300.565963]  <TASK>
[  300.566084]  __schedule+0xe13/0x33a0
[  300.566284]  ? __pfx___schedule+0x10/0x10
[  300.566495]  ? lock_release+0x441/0x870
[  300.566700]  ? __pfx_lock_release+0x10/0x10
[  300.566932]  ? trace_lock_acquire+0x139/0x1b0
[  300.567165]  ? lock_acquire+0x80/0xb0
[  300.567362]  ? schedule+0x216/0x3f0
[  300.567553]  schedule+0xf6/0x3f0
[  300.567730]  io_schedule+0xce/0x150
[  300.567921]  bit_wait_io+0x1f/0x100
[  300.568110]  __wait_on_bit+0x68/0x1b0
[  300.568307]  ? __pfx_bit_wait_io+0x10/0x10
[  300.568528]  out_of_line_wait_on_bit+0xe6/0x120
[  300.568775]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
[  300.569042]  ? __pfx_wake_bit_function+0x10/0x10
[  300.569286]  ? __might_sleep+0xa3/0x170
[  300.569495]  do_get_write_access+0x83b/0x1010
[  300.569733]  jbd2_journal_get_write_access+0x1e4/0x270
[  300.570003]  __ext4_journal_get_write_access+0x72/0x3b0
[  300.570276]  ext4_reserve_inode_write+0x199/0x280
[  300.570522]  ? ext4_dirty_inode+0xeb/0x140
[  300.570754]  __ext4_mark_inode_dirty+0x18b/0x8c0
[  300.570999]  ? debug_smp_processor_id+0x20/0x30
[  300.571238]  ? __pfx___ext4_mark_inode_dirty+0x10/0x10
[  300.571502]  ? trace_jbd2_handle_start+0x77/0x210
[  300.571750]  ? jbd2__journal_start+0xff/0x6b0
[  300.571986]  ? __ext4_journal_start_sb+0x1f8/0x600
[  300.572237]  ? ext4_dirty_inode+0xb3/0x140
[  300.572460]  ? __pfx_ext4_dirty_inode+0x10/0x10
[  300.572702]  ext4_dirty_inode+0xeb/0x140
[  300.572911]  ? rcu_is_watching+0x19/0xc0
[  300.573121]  __mark_inode_dirty+0x1d0/0xd50
[  300.573343]  ? __pfx_generic_write_checks+0x10/0x10
[  300.573608]  generic_update_time+0xe0/0x110
[  300.573832]  file_modified+0x1af/0x1e0
[  300.574039]  ext4_buffered_write_iter+0x101/0x3e0
[  300.574292]  ext4_file_write_iter+0x8b8/0x1ab0
[  300.574524]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.574791]  ? debug_smp_processor_id+0x20/0x30
[  300.575035]  ? __pfx_ext4_file_write_iter+0x10/0x10
[  300.575288]  ? __this_cpu_preempt_check+0x21/0x30
[  300.575531]  ? lock_is_held_type+0xef/0x150
[  300.575758]  vfs_write+0xc46/0x1120
[  300.575950]  ? __pfx_ext4_file_write_iter+0x10/0x10
[  300.576211]  ? __pfx_vfs_write+0x10/0x10
[  300.576429]  ? mutex_lock_nested+0x1f/0x30
[  300.576647]  ksys_write+0x14f/0x290
[  300.576839]  ? __pfx_ksys_write+0x10/0x10
[  300.577058]  __x64_sys_write+0x7b/0xc0
[  300.577256]  ? syscall_trace_enter+0x9b/0x230
[  300.577490]  x64_sys_call+0x1685/0x20d0
[  300.577692]  do_syscall_64+0x6d/0x140
[  300.577889]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.578156] RIP: 0033:0x7fe1ebf3ebcf
[  300.578348] RSP: 002b:00007ffebc24a5e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[  300.578741] RAX: ffffffffffffffda RBX: 00000000000000e0 RCX: 00007fe1ebf3ebcf
[  300.579094] RDX: 00000000000000e0 RSI: 0000559099024040 RDI: 0000000000000005
[  300.579448] RBP: 0000559099024040 R08: 0000000000000000 R09: 00007fe1ebfb14e0
[  300.579802] R10: 00007fe1ebfb13e0 R11: 0000000000000293 R12: 00000000000000e0
[  300.580154] R13: 000055909901a2a0 R14: 00000000000000e0 R15: 00007fe1ebff69e0
[  300.580518]  </TASK>
[  300.580641] INFO: task in:imjournal:319 blocked for more than 147 seconds.
[  300.580981]       Not tainted 6.12.0-rc4-kvm #1
[  300.581211] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.581591] task:in:imjournal    state:D stack:0     pid:319   tgid:300   ppid:1      flags:0x00000002
[  300.582047] Call Trace:
[  300.582177]  <TASK>
[  300.582296]  __schedule+0xe13/0x33a0
[  300.582492]  ? __pfx___schedule+0x10/0x10
[  300.582700]  ? lock_release+0x441/0x870
[  300.582918]  ? __pfx_lock_release+0x10/0x10
[  300.583135]  ? trace_lock_acquire+0x139/0x1b0
[  300.583366]  ? lock_acquire+0x80/0xb0
[  300.583558]  ? schedule+0x216/0x3f0
[  300.583747]  schedule+0xf6/0x3f0
[  300.583923]  io_schedule+0xce/0x150
[  300.584109]  bit_wait_io+0x1f/0x100
[  300.584297]  __wait_on_bit+0x68/0x1b0
[  300.584491]  ? __pfx_bit_wait_io+0x10/0x10
[  300.584710]  out_of_line_wait_on_bit+0xe6/0x120
[  300.584950]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
[  300.585216]  ? __pfx_wake_bit_function+0x10/0x10
[  300.585457]  ? __might_sleep+0xa3/0x170
[  300.585662]  do_get_write_access+0x83b/0x1010
[  300.585899]  jbd2_journal_get_write_access+0x1e4/0x270
[  300.586166]  __ext4_journal_get_write_access+0x72/0x3b0
[  300.586436]  __ext4_new_inode+0xd66/0x5320
[  300.586661]  ? __pfx___ext4_new_inode+0x10/0x10
[  300.586910]  ? __pfx___dquot_initialize+0x10/0x10
[  300.587163]  ? _raw_spin_unlock+0x31/0x60
[  300.587372]  ? d_splice_alias+0x4e8/0xe30
[  300.587585]  ext4_create+0x32e/0x550
[  300.587783]  ? __pfx_ext4_create+0x10/0x10
[  300.588000]  ? inode_permission+0xf4/0x650
[  300.588215]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.588489]  ? __pfx_ext4_create+0x10/0x10
[  300.588704]  lookup_open.isra.0+0x117c/0x1580
[  300.588942]  ? __pfx_lookup_open.isra.0+0x10/0x10
[  300.589192]  ? lock_acquire+0x80/0xb0
[  300.589385]  ? path_openat+0xd40/0x2bf0
[  300.589597]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.589876]  path_openat+0xdbf/0x2bf0
[  300.590080]  ? __pfx_path_openat+0x10/0x10
[  300.590294]  ? __this_cpu_preempt_check+0x21/0x30
[  300.590540]  ? lock_is_held_type+0xef/0x150
[  300.590777]  ? __this_cpu_preempt_check+0x21/0x30
[  300.591026]  do_filp_open+0x1cc/0x420
[  300.591221]  ? __pfx_do_filp_open+0x10/0x10
[  300.591440]  ? lock_release+0x441/0x870
[  300.591652]  ? do_raw_spin_unlock+0x15c/0x210
[  300.591895]  do_sys_openat2+0x185/0x1f0
[  300.592097]  ? __pfx_do_sys_openat2+0x10/0x10
[  300.592327]  ? __this_cpu_preempt_check+0x21/0x30
[  300.592570]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.592891]  ? lockdep_hardirqs_on+0x89/0x110
[  300.593122]  __x64_sys_openat+0x17a/0x240
[  300.593332]  ? __pfx___x64_sys_openat+0x10/0x10
[  300.593569]  ? __audit_syscall_entry+0x39c/0x500
[  300.593816]  x64_sys_call+0x1a52/0x20d0
[  300.594017]  do_syscall_64+0x6d/0x140
[  300.594212]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.594470] RIP: 0033:0x7f4af113e8c4
[  300.594657] RSP: 002b:00007f4af01fea40 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  300.595043] RAX: ffffffffffffffda RBX: 00007f4ae8000c50 RCX: 00007f4af113e8c4
[  300.595396] RDX: 0000000000000241 RSI: 00007f4af01feb80 RDI: 00000000ffffff9c
[  300.595748] RBP: 00007f4af01feb80 R08: 0000000000000000 R09: 0000000000000001
[  300.596099] R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000000241
[  300.596451] R13: 00007f4ae8000c50 R14: 0000000000000001 R15: 00007f4ae8010540
[  300.596818]  </TASK>
[  300.596937] INFO: task rs:main Q:Reg:322 blocked for more than 147 seconds.
[  300.597279]       Not tainted 6.12.0-rc4-kvm #1
[  300.597508] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.597889] task:rs:main Q:Reg   state:D stack:0     pid:322   tgid:300   ppid:1      flags:0x00000002
[  300.598345] Call Trace:
[  300.598479]  <TASK>
[  300.598597]  __schedule+0xe13/0x33a0
[  300.598804]  ? __pfx___schedule+0x10/0x10
[  300.599013]  ? lock_release+0x441/0x870
[  300.599217]  ? __pfx_lock_release+0x10/0x10
[  300.599433]  ? trace_lock_acquire+0x139/0x1b0
[  300.599664]  ? lock_acquire+0x80/0xb0
[  300.599857]  ? schedule+0x216/0x3f0
[  300.600046]  schedule+0xf6/0x3f0
[  300.600221]  io_schedule+0xce/0x150
[  300.600408]  bit_wait_io+0x1f/0x100
[  300.600595]  __wait_on_bit+0x68/0x1b0
[  300.600791]  ? __pfx_bit_wait_io+0x10/0x10
[  300.601010]  out_of_line_wait_on_bit+0xe6/0x120
[  300.601246]  ? __pfx_out_of_line_wait_on_bit+0x10/0x10
[  300.601512]  ? __pfx_wake_bit_function+0x10/0x10
[  300.601753]  ? __might_sleep+0xa3/0x170
[  300.601959]  do_get_write_access+0x83b/0x1010
[  300.602196]  jbd2_journal_get_write_access+0x1e4/0x270
[  300.602462]  __ext4_journal_get_write_access+0x72/0x3b0
[  300.602744]  ext4_reserve_inode_write+0x199/0x280
[  300.602990]  ? ext4_dirty_inode+0xeb/0x140
[  300.603204]  __ext4_mark_inode_dirty+0x18b/0x8c0
[  300.603446]  ? debug_smp_processor_id+0x20/0x30
[  300.603683]  ? __pfx___ext4_mark_inode_dirty+0x10/0x10
[  300.603945]  ? trace_jbd2_handle_start+0x77/0x210
[  300.604192]  ? jbd2__journal_start+0xff/0x6b0
[  300.604425]  ? __ext4_journal_start_sb+0x1f8/0x600
[  300.604672]  ? ext4_dirty_inode+0xb3/0x140
[  300.604892]  ? __pfx_ext4_dirty_inode+0x10/0x10
[  300.605127]  ext4_dirty_inode+0xeb/0x140
[  300.605332]  ? rcu_is_watching+0x19/0xc0
[  300.605539]  __mark_inode_dirty+0x1d0/0xd50
[  300.605756]  ? __pfx_generic_write_checks+0x10/0x10
[  300.606011]  generic_update_time+0xe0/0x110
[  300.606232]  file_modified+0x1af/0x1e0
[  300.606432]  ext4_buffered_write_iter+0x101/0x3e0
[  300.606678]  ext4_file_write_iter+0x8b8/0x1ab0
[  300.606924]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  300.607175]  ? debug_smp_processor_id+0x20/0x30
[  300.607414]  ? __pfx_ext4_file_write_iter+0x10/0x10
[  300.607667]  ? __this_cpu_preempt_check+0x21/0x30
[  300.607912]  ? lock_is_held_type+0xef/0x150
[  300.608135]  vfs_write+0xc46/0x1120
[  300.608324]  ? __pfx_ext4_file_write_iter+0x10/0x10
[  300.608577]  ? __pfx_vfs_write+0x10/0x10
[  300.608797]  ? mutex_lock_nested+0x1f/0x30
[  300.609016]  ksys_write+0x14f/0x290
[  300.609206]  ? __pfx_ksys_write+0x10/0x10
[  300.609420]  ? __audit_syscall_entry+0x39c/0x500
[  300.609663]  __x64_sys_write+0x7b/0xc0
[  300.609860]  ? syscall_trace_enter+0x14a/0x230
[  300.610093]  x64_sys_call+0x1685/0x20d0
[  300.610294]  do_syscall_64+0x6d/0x140
[  300.610490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.610763] RIP: 0033:0x7f4af113ebcf
[  300.610950] RSP: 002b:00007f4aefbff890 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[  300.611326] RAX: ffffffffffffffda RBX: 00007f4ae0000e70 RCX: 00007f4af113ebcf
[  300.611678] RDX: 0000000000000040 RSI: 00007f4ae0001150 RDI: 0000000000000005
[  300.612031] RBP: 00007f4ae0001150 R08: 0000000000000000 R09: 0000000000000000
[  300.612384] R10: 0000000000000007 R11: 0000000000000293 R12: 0000000000000000
[  300.612738] R13: 000055979b901330 R14: 00007f4ae0000e70 R15: 0000000000000040
[  300.613110]  </TASK>
[  300.613251] INFO: task repro:684 blocked for more than 147 seconds.
[  300.613537]       Not tainted 6.12.0-rc4-kvm #1
[  300.613749] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.614135] task:repro           state:D stack:0     pid:684   tgid:684   ppid:679    flags:0x00000006
[  300.614606] Call Trace:
[  300.614754]  <TASK>
[  300.614874]  __schedule+0xe13/0x33a0
[  300.615073]  ? __pfx___schedule+0x10/0x10
[  300.615283]  ? lock_release+0x441/0x870
[  300.615489]  ? __pfx_lock_release+0x10/0x10
[  300.615708]  ? trace_lock_acquire+0x139/0x1b0
[  300.615942]  ? lock_acquire+0x80/0xb0
[  300.616136]  ? schedule+0x216/0x3f0
[  300.616327]  schedule+0xf6/0x3f0
[  300.616507]  io_schedule+0xce/0x150
[  300.616695]  blk_mq_get_tag+0x5e7/0xce0
[  300.616909]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  300.617146]  ? __pfx_autoremove_wake_function+0x10/0x10
[  300.617429]  __blk_mq_alloc_requests+0x6f6/0x1720
[  300.617678]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  300.617970]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  300.618236]  ? __this_cpu_preempt_check+0x21/0x30
[  300.618480]  ? lock_acquire.part.0+0x152/0x390
[  300.618733]  blk_mq_alloc_request+0x655/0x930
[  300.618967]  ? __pfx_blk_mq_alloc_request+0x10/0x10
[  300.619234]  scsi_execute_cmd+0x223/0x1040
[  300.619455]  ? debug_smp_processor_id+0x20/0x30
[  300.619695]  ? __pfx_scsi_execute_cmd+0x10/0x10
[  300.619931]  ? rcu_is_watching+0x19/0xc0
[  300.620139]  ? __kmalloc_noprof+0x34f/0x4a0
[  300.620358]  ? ata_cmd_ioctl+0x375/0x570
[  300.620570]  ata_cmd_ioctl+0x23c/0x570
[  300.620775]  ? __pfx_ata_cmd_ioctl+0x10/0x10
[  300.621000]  ? lock_release+0x441/0x870
[  300.621209]  ? __this_cpu_preempt_check+0x21/0x30
[  300.621463]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.621740]  ? security_capable+0x19d/0x1e0
[  300.621976]  ata_sas_scsi_ioctl+0x60a/0x7c0
[  300.622195]  ? mark_lock.part.0+0xf3/0x17b0
[  300.622415]  ? __pfx_ata_sas_scsi_ioctl+0x10/0x10
[  300.622658]  ? __pfx_mark_lock.part.0+0x10/0x10
[  300.622915]  ? __this_cpu_preempt_check+0x21/0x30
[  300.623161]  ? lock_is_held_type+0xef/0x150
[  300.623382]  ? __pfx_ata_scsi_ioctl+0x10/0x10
[  300.623610]  ata_scsi_ioctl+0x70/0x90
[  300.623807]  scsi_ioctl+0xb6f/0x1630
[  300.624001]  ? __might_sleep+0xa3/0x170
[  300.624208]  ? __pfx_scsi_ioctl+0x10/0x10
[  300.624419]  ? scsi_block_when_processing_errors+0x2c4/0x390
[  300.624711]  ? __pfx_scsi_block_when_processing_errors+0x10/0x10
[  300.625022]  ? __pfx___lock_acquire+0x10/0x10
[  300.625250]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  300.625512]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[  300.625787]  ? do_vfs_ioctl+0x4fa/0x1920
[  300.625997]  ? __pfx_do_vfs_ioctl+0x10/0x10
[  300.626217]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.626497]  sg_ioctl+0xfb8/0x2880
[  300.626686]  ? __this_cpu_preempt_check+0x21/0x30
[  300.626947]  ? lock_release+0x441/0x870
[  300.627155]  ? __pfx_sg_ioctl+0x10/0x10
[  300.627366]  ? __this_cpu_preempt_check+0x21/0x30
[  300.627615]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.627932]  ? lockdep_hardirqs_on+0x89/0x110
[  300.628160]  ? trace_hardirqs_on+0x51/0x60
[  300.628381]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[  300.628697]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  300.628949]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[  300.629210]  ? __pfx_sg_ioctl+0x10/0x10
[  300.629421]  __x64_sys_ioctl+0x1b5/0x230
[  300.629639]  x64_sys_call+0x1209/0x20d0
[  300.629844]  do_syscall_64+0x6d/0x140
[  300.630044]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.630310] RIP: 0033:0x7fc80ee3ee5d
[  300.630502] RSP: 002b:00007fffa979c518 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  300.630915] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc80ee3ee5d
[  300.631281] RDX: 0000000020000080 RSI: 000000000000031f RDI: 0000000000000003
[  300.631640] RBP: 00007fffa979c530 R08: 00007fffa979c2a8 R09: 00007fffa979c530
[  300.631997] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fffa979c688
[  300.632354] R13: 0000000000401972 R14: 0000000000403e08 R15: 00007fc80f193000
[  300.632722]  </TASK>
[  300.632849] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[  300.633253]
[  300.633253] Showing all locks held in the system:
[  300.633567] 7 locks held by kworker/u8:0/11:
[  300.633790]  #0: ffff88800e4a8948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
[  300.634296]  #1: ffff88800dcd7d78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
[  300.634871]  #2: ffff888011f480e0 (&type->s_umount_key#38){++++}-{3:3}, at: super_trylock_shared+0x2b/0x110
[  300.635370]  #3: ffff888011f4ab98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1c3/0x8a0
[  300.635848]  #4: ffff888011f4c958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
[  300.636299]  #5: ffff888023bb33c0 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x344/0x1390
[  300.636754]  #6: ffffe8ffffc077f8 (&lg->lg_mutex){+.+.}-{3:3}, at: ext4_mb_initialize_context+0x8a3/0xd20
[  300.637257] 4 locks held by kworker/u8:1/31:
[  300.637479]  #0: ffff88800e4a8948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
[  300.637979]  #1: ffff88800df47d78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
[  300.638532]  #2: ffff888011f480e0 (&type->s_umount_key#38){++++}-{3:3}, at: super_trylock_shared+0x2b/0x110
[  300.639046]  #3: ffff888011f4ab98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1c3/0x8a0
[  300.639525] 1 lock held by khungtaskd/33:
[  300.639732]  #0: ffffffff8705ca00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
[  300.640191] 4 locks held by kworker/u8:2/35:
[  300.640411]  #0: ffff88800e4a8948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
[  300.640917]  #1: ffff88800e4bfd78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
[  300.641479]  #2: ffff888011f480e0 (&type->s_umount_key#38){++++}-{3:3}, at: super_trylock_shared+0x2b/0x110
[  300.641990]  #3: ffff888011f4ab98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1c3/0x8a0
[  300.642483] 3 locks held by kworker/u8:4/167:
[  300.642709]  #0: ffff88800e4a8948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
[  300.643228]  #1: ffff888013e07d78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a0/0x1b0
[  300.643782]  #2: ffff88800d77e0e0 (&type->s_umount_key#52){.+.+}-{3:3}, at: super_trylock_shared+0x2b/0x110
[  300.644282] 4 locks held by kworker/1:3/233:
[  300.644503]  #0: ffff88800d45ad48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x11fc/0x1b50
[  300.644995]  #1: ffff888014ea7d78 ((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at: process_one_work0
[  300.645610]  #2: ffff88801042c430 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x42/0x470
[  300.646096]  #3: ffff8880103e8378 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x33/0x360
[  300.646542] 4 locks held by auditd/240:
[  300.646757]  #0: ffff8880111580f8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x25e/0x380
[  300.647182]  #1: ffff888011f48408 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x14f/0x290
[  300.647605]  #2: ffff888017c8d2b8 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb8/0x3e0
[  300.648137]  #3: ffff888011f4c958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
[  300.648591] 3 locks held by in:imjournal/319:
[  300.648820]  #0: ffff888011f48408 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x1f7c/0x2bf0
[  300.649260]  #1: ffff88801ae1f040 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: path_openat+0xd40/0x2bf0
[  300.649745]  #2: ffff888011f4c958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
[  300.650205] 4 locks held by rs:main Q:Reg/322:
[  300.650437]  #0: ffff888013b782b8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x25e/0x380
[  300.650880]  #1: ffff888011f48408 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x14f/0x290
[  300.651306]  #2: ffff8880195183f8 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb8/0x3e0
[  300.651844]  #3: ffff888011f4c958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x107b/0x1590
[  300.652307]
[  300.652397] =============================================


> Kind regards,
> Niklas
