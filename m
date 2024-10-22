Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84E19B5B4;
	Tue, 22 Oct 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612759; cv=none; b=BNOTV48Y7JVbgdyijRo59LNYcbpVT6SFhqRPWdskeCpyfl+h7THvVtuDtWL2kb4Q/HzJnJCHQg0SloxvdwQ91/F8Mrq9DSueIRUVbT72cmTabaq3LNoV76UA6Uho+V79RC/pLWIDfbyNz9xoRbem7CCgmZvxhUxsFO30QrxfUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612759; c=relaxed/simple;
	bh=2d/FITXGUvqwkKdRTP48peRBMO3ZgM8F25WuyBZPn7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwbuBZlgNp1EYK45nzYQvkx+TVOztXcUEPuQN5UPJ8VnZdQ2CUSilA7Oh0mtrlOcoyRE487cL1kTjFpPq3JEpVe+4Sb9HmZk2RGlp0HPfudLUbV5Q7FYwPwavto3XKz856oLCFsth2jGWufBv9xEh55APq98Mp7MjBcV0k2i8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQred8AH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQred8AH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1319BC4CEC3;
	Tue, 22 Oct 2024 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612758;
	bh=2d/FITXGUvqwkKdRTP48peRBMO3ZgM8F25WuyBZPn7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQred8AHlw1omIp76stq/mdPCQaFEIKDPP6JzTCbQq50/cZ7f821WXTcnixgg41wQ
	 2e+Ky5RGwmX+NOyDtr5rIIBoq49ZIcQgdahavQ2XlADRJPnTMI8IrUNPBFLKMHNVsG
	 THw4ln0uluJaWMh72QLOjMGxNovzWIVI333YbX4xL8Dif7eb5HfsjUbDPzBdlhBvEg
	 d72Mvvf7253Fsw7pea5gWbgNk5mejV6eQ78BavyH2fZMl7qOSgvTWYsLvo02d1FHvo
	 t1Ffmz5TrQzniyhwhMTEyj0Bk549l0rNHdAGfZ58e2q3fWJu25et4rQoBRmeGVzTU5
	 x0nePayggNFGQ==
Date: Tue, 22 Oct 2024 17:59:13 +0200
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
Message-ID: <ZxfL0Q023hSgzdI5@ryzen>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
 <Zxc7qLHYr60FJrD4@ly-workstation>
 <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>
 <Zxd2hZWt1zm4eW2q@ly-workstation>
 <ZxeGqrEpdg9Df5FS@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxeGqrEpdg9Df5FS@ryzen>

On Tue, Oct 22, 2024 at 01:04:10PM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 05:55:17PM +0800, Lai, Yi wrote:
> > On Tue, Oct 22, 2024 at 10:48:04AM +0200, Niklas Cassel wrote:
> > > On Tue, Oct 22, 2024 at 01:44:08PM +0800, Lai, Yi wrote:
> > > > On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> > > > > On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > > > > > Hello Yi Lai,
> > > > > > 
> > > > > > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > > > > > Hi Niklas Cassel,
> > > > > > > 
> > > > > > > Greetings!
> > > > > > > 
> > > > > > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > > > > > 
> > > > > > > After bisection and the first bad commit is:
> > > > > > > "
> > > > > > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > > > > > "
> > > > > > 
> > > > > > It might be that your bisection results are accurate.
> > > > > > 
> > > > > > However, after looking at the stacktraces, I find it way more likely that
> > > > > > bisection has landed on the wrong commit.
> > > > > > 
> > > > > > See this series that was just queued (for 6.13) a few days ago that solves a
> > > > > > similar starvation:
> > > > > > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > > > > > 
> > > > > > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > > > > > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > > > > > the bug?
> > > > >
> > 
> > I tried kernel linux-block
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > branch for-6.13/block commit c97f91b1807a7966077b69b24f28c2dbcde664e9.
> > 
> > Issue can still be reproduced.
> 
> Thanks again for your testing!
> 
> I will try to reproduce using your reproducer (repo.c),
> and see if I can make any sense of this.

Hello Yi Lai,


An important thing that I noticed is that even when I look at your good commit
(v5.11) - the first commit you marked as as good in git bisect, it has this:
https://github.com/laifryiee/syzkaller_logs/blob/main/241018_105830_blk_mq_get_tag/f40ddce88593482919761f74910f42f4b84c004b_dmesg.log

[  300.525626]  __schedule+0xb9f/0x2eb0^M
[  300.525843]  ? __pfx___schedule+0x10/0x10^M
[  300.526056]  ? lock_release+0x441/0x870^M
[  300.526286]  ? __pfx_lock_release+0x10/0x10^M
[  300.526512]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20^M
[  300.526801]  ? kthread_data+0x61/0xd0^M
[  300.527007]  schedule+0xf6/0x3f0^M
[  300.527225]  io_schedule+0xce/0x150^M
[  300.527408]  rq_qos_wait+0x1c5/0x310^M
[  300.527610]  ? __pfx_wbt_cleanup_cb+0x10/0x10^M
[  300.527847]  ? __pfx_rq_qos_wait+0x10/0x10^M
[  300.528070]  ? __pfx_lock_release+0x10/0x10^M
[  300.528296]  ? __pfx_rq_qos_wake_function+0x10/0x10^M
[  300.528562]  ? __pfx_wbt_inflight_cb+0x10/0x10^M
[  300.528806]  ? do_raw_spin_unlock+0x15c/0x210^M
[  300.529048]  wbt_wait+0x1ec/0x400^M

In fact, most *_dmesg.log logs in your syzlog directory has a stack trace that
contains a "blocked for more than 147 seconds" error.
Many of these logs are (with the "blocked for more than 147 seconds" error)
are commits that your bisect script has classified as "good".


If we look at your own dmesg with Linux 6.12-rc3 + e5dd410acb34 reverted,
which passes your git bisect script, even if it has a
"blocked for more than 147 seconds" error:
https://github.com/laifryiee/syzkaller_logs/blob/main/241018_105830_blk_mq_get_tag/8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert_dmesg.log
It seems that the reason is because you don't find "blk_mq_get_tag" in dmesg:
|1019_054406|/var/www/html/bzimage/bzImage_8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert didn't contain blk_mq_get_tag: in dmesg, pass|
|1019_054406|Bisect successfully! 8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert bzimage passed!|

So it seems that both v5.11 and "v6.12-rc3 + e5dd410acb34 reverted" has
problems.


I managed to reproduce using your reproducer, and with
v6.12-rc4 + e5dd410acb34 reverted, I see:
[  299.641187]  __schedule+0x1144/0x3200
[  299.641425]  ? __pfx___schedule+0x10/0x10
[  299.641651]  ? lock_release+0x4b0/0x870
[  299.641868]  ? debug_smp_processor_id+0x1b/0x30
[  299.642128]  ? __pfx_lock_release+0x10/0x10
[  299.642362]  ? srso_alias_return_thunk+0x5/0xfbef5
[  299.642640]  ? lock_acquire+0x80/0xb0
[  299.642852]  ? schedule+0x202/0x3d0
[  299.643068]  schedule+0xe7/0x3d0
[  299.643261]  io_schedule+0x96/0x100
[  299.643494]  bit_wait_io+0x17/0xf0
[  299.643703]  __wait_on_bit_lock+0x118/0x1a0
[  299.643941]  ? __pfx_bit_wait_io+0x10/0x10
[  299.644195]  out_of_line_wait_on_bit_lock+0xe8/0x120
[  299.644475]  ? __pfx_out_of_line_wait_on_bit_lock+0x10/0x10
[  299.644793]  ? __pfx_wake_bit_function+0x10/0x10
[  299.645060]  ? srso_alias_return_thunk+0x5/0xfbef5
[  299.645344]  __lock_buffer+0x72/0x80
[  299.645569]  do_get_write_access+0x7d0/0x1130
[  299.645838]  jbd2_journal_get_write_access+0x1e9/0x270
[  299.646136]  __ext4_journal_get_write_access+0x72/0x3b0
[  299.646436]  ext4_reserve_inode_write+0x145/0x280

So even with e5dd410acb34 reverted, we see a problem!



The difference seems to be the stack trace before and after e5dd410acb34 is
slightly different.
Before e5dd410acb34 the stack trace often looks like one of the two above.
After e5dd410acb34 the stack trace instead always has blk_mq_get (and seems
to be easier to reproduce).


I think that the stack trace that contains "blk_mq_get" actually indicates a
new problem though, so thank you for that!

I have a fix for it:
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index fa41ea57a978..3b303d4ae37a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -651,6 +651,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
                        /* the scmd has an associated qc */
                        if (!(qc->flags & ATA_QCFLAG_EH)) {
                                /* which hasn't failed yet, timeout */
+                               set_host_byte(scmd, DID_TIME_OUT);
                                qc->err_mask |= AC_ERR_TIMEOUT;
                                qc->flags |= ATA_QCFLAG_EH;
                                nr_timedout++;



I will post it as a real fix for the new problem (blk_mq_get) tomorrow.

This just solves the new problem though.

You probably need to do another bisection to find the problem that exists on
v5.11 and earlier kernels.


Kind regards,
Niklas
