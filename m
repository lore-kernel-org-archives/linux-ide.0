From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sun, 10 Feb 2008 00:26:22 -0500
Message-ID: <20080210052621.GA22257@infradead.org>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802092128.39247.bzolnier@gmail.com> <20080209212237.GA22582@Chamillionaire.breakpoint.cc> <200802100006.11086.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:37757 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYBJF02 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 00:26:28 -0500
Content-Disposition: inline
In-Reply-To: <200802100006.11086.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sebastian Siewior <ide+bug@ml.breakpoint.cc>, Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Jens Axboe <jens.axboe@oracle.com>

On Sun, Feb 10, 2008 at 12:06:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >Please try booting with "hdx=noflush" kernel parameter or please try
> > >the attached patch which should fix the issue (if my theory is correct).

"hda=noflush hdb=noflush hdd=noflush" fixes the qemu setup for me.

> Thanks, I see now that there can be > 1 flush request queued at a given time.
> 
> Please dump the old patch and try this one.
> 
> [ Christoph: this may also fix your qemu/kvm+xfs problem. ]

It doesn't hang anymore but gives me the following oops instead (that is
after fixing the build as the bigger request->cmd breaks the scsi
build):

debian:~/xfs-cmds/xfstests# sh check 
[   95.710144] SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
[   95.742472] SGI XFS Quota Management subsystem
[   95.762573] BUG: unable to handle kernel NULL pointer dereference at 0000000d
[   95.763889] IP: [<c02e0132>] idedisk_prepare_flush+0x4a/0x75
[   95.763889] *pdpt = 000000002d87c001 *pde = 0000000000000000 
[   95.763889] Oops: 0002 [#1] SMP 
[   95.763889] Modules linked in: xfs binfmt_misc dm_snapshot dm_mirror i2c_piix4 i2c_core
[   95.763889] 
[   95.763889] Pid: 2331, comm: mount Not tainted (2.6.24-09479-g531021f-dirty #43)
[   95.763889] EIP: 0060:[<c02e0132>] EFLAGS: 00010093 CPU: 0
[   95.763889] EIP is at idedisk_prepare_flush+0x4a/0x75
[   95.763889] EAX: 00000000 EBX: eec92458 ECX: c083e9f4 EDX: eec92458
[   95.763889] ESI: eec92000 EDI: c025ab93 EBP: ed897bec ESP: ed897be8
[   95.763889]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   95.763889] Process mount (pid: 2331, ti=ed896000 task=ed8a2000 task.ti=ed896000)
[   95.763889] Stack: 00000000 ed897c00 c025ab80 eec92000 eec9237c ed897c20 ed897c14 c025ad60 
[   95.763889]        c083e9f4 eec92000 eec92000 ed897c30 c025783e c0107fb9 ed83d0e0 c083e9f4 
[   95.763889]        c083e9f4 eec92000 ed897c90 c02d7467 ffffffff eecce2a0 c083e700 ed8a26f0 
[   95.763889] Call Trace:
[   95.763889]  [<c025ab80>] ? queue_flush+0x5c/0x6f
[   95.763889]  [<c025ad60>] ? blk_do_ordered+0xfb/0x223
[   95.763889]  [<c025783e>] ? elv_next_request+0x17b/0x1ac
[   95.763889]  [<c0107fb9>] ? native_sched_clock+0x9a/0xaf
[   95.763889]  [<c02d7467>] ? ide_do_request+0x243/0x829
[   95.763889]  [<c012a29c>] ? del_timer+0x4c/0x53
[   95.763889]  [<c03c546b>] ? _spin_unlock_irqrestore+0x2f/0x3c
[   95.763889]  [<c012a29c>] ? del_timer+0x4c/0x53
[   95.763889]  [<c02d7d22>] ? do_ide_request+0x17/0x19
[   95.763889]  [<c025793c>] ? elv_insert+0xcd/0x1a3
[   95.763889]  [<c0258282>] ? drive_stat_acct+0x12c/0x140
[   95.763889]  [<c0257a98>] ? __elv_add_request+0x86/0x8b
[   95.763889]  [<c0259f7c>] ? __make_request+0x2d9/0x31a
[   95.763889]  [<c0104d3f>] ? dump_trace+0xcc/0xd8
[   95.763889]  [<c010a46e>] ? save_stack_address+0x0/0x28
[   95.763889]  [<c0258bda>] ? generic_make_request+0x360/0x38e
[   95.763889]  [<c010a4e8>] ? save_stack_trace+0x1d/0x3b
[   95.763889]  [<c015200e>] ? mempool_alloc_slab+0xe/0x10
[   95.763889]  [<c01520e6>] ? mempool_alloc+0x35/0xd0
[   95.763889]  [<c0259c9b>] ? submit_bio+0xc6/0xce
[   95.763889]  [<c018ef05>] ? bio_add_page+0x2a/0x31
[   95.763889]  [<f0904841>] ? _xfs_buf_ioapply+0x1e6/0x20a [xfs]
[   95.763889]  [<f09048a0>] ? xfs_buf_iorequest+0x3b/0x5e [xfs]
[   95.763889]  [<f0907cf1>] ? xfsbdstrat+0x1e/0x2c [xfs]
[   95.763889]  [<f090954e>] ? xfs_barrier_test+0x30/0x6a [xfs]
[   95.763889]  [<f09095d8>] ? xfs_mountfs_check_barriers+0x50/0x7a [xfs]
[   95.763889]  [<f08fbfee>] ? xfs_mount+0x249/0x2fb [xfs]
[   95.763889]  [<f090a456>] ? xfs_fs_fill_super+0xb2/0x1c8 [xfs]
[   95.763889]  [<c01718bd>] ? get_sb_bdev+0xe2/0x120
[   95.763889]  [<c016c613>] ? __kmalloc+0x38/0xae
[   95.763889]  [<f0908dc2>] ? xfs_fs_get_sb+0x13/0x15 [xfs]
[   95.763889]  [<f090a3a4>] ? xfs_fs_fill_super+0x0/0x1c8 [xfs]
[   95.763889]  [<c01714cb>] ? vfs_kern_mount+0x3b/0x76
[   95.763889]  [<c017154a>] ? do_kern_mount+0x32/0xba
[   95.763889]  [<c0183735>] ? do_new_mount+0x46/0x71
[   95.763889]  [<c01838c5>] ? do_mount+0x165/0x183
[   95.763889]  [<c0154755>] ? __get_free_pages+0x45/0x4c
[   95.763889]  [<c0181bd3>] ? copy_mount_options+0x27/0x10b
[   95.763889]  [<c018394b>] ? sys_mount+0x68/0xa4
[   95.763889]  [<c0103cae>] ? sysenter_past_esp+0x5f/0xa5
[   95.763889]  =======================
[   95.763889] Code: 24 00 00 3d 00 24 00 00 75 1e 83 b9 8c 00 00 00 00 77 0c 81 b9 88 00 00 00 ff ff ff 0f 76 09 c6 05 0d 00 00 00 ea eb 07 8b 45 fc <c6> 40 0d e7 8b 45 fc c7 40 10 00 7e 00 00 8b 45 fc c7 40 14 00 
[   95.763889] EIP: [<c02e0132>] idedisk_prepare_flush+0x4a/0x75 SS:ESP 0068:ed897be8
[   95.763889] ---[ end trace 3d3002e6db2539b3 ]---
