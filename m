From: Jim Cromie <jim.cromie@gmail.com>
Subject: BUG: sleeping function called from invalid context at /home/jimc/projects/lx/linux-2.6/drivers/ide/ide-io.c:468
Date: Mon, 8 Aug 2011 15:54:31 -0600
Message-ID: <CAJfuBxxX96V8KiSyNrV62UxKmQWjnqZb=MvUbS8FMG1sFMeHzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65183 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1HHVzC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2011 17:55:02 -0400
Received: by yie30 with SMTP id 30so1199455yie.19
        for <linux-ide@vger.kernel.org>; Mon, 08 Aug 2011 14:55:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I got this 2x,
once when running aptitude in one terminal, wc afile in another
again when running apt-get install file

this is running personal build of v3.0+, on voyage-0.7.5+ (daily build ~ 8/2)
with this bootline:
root=LABEL=ROOT_FS console=ttyS0,115200n8 all_generic_ide ide_core.nodma=0.1 ide
_core.nodma=0.0 panic=20 reboot=bios

The BUG listing is at end of this email.
I dont really know what Im doing, but Ive got lockdep built,
so here are the greps of the 2 locks held by flush:

root@voyage:~# grep 'type->s_umount_key' /proc/lockdep |wc
     26     222    1797

only 1 is for #15
root@voyage:~# grep -n 'type->s_umount_key#15' /proc/lockdep
2283:c04d8a24 OPS:     548 FD:   57 BD:    1 ++++..: &type->s_umount_key#15

it is:
c04d8a24 OPS:     548 FD:   57 BD:    1 ++++..: &type->s_umount_key#15c
 -> [c04d7ae0] dcache_lru_lock
 -> [c0a65698] &(&dentry->d_lock)->rlocky#15' /proc/lockdep
 -> [c04d8a34] &sb->s_type->i_lock_key#12
 -> [c04d5f78] rcu_kthread_wq.lock
 -> [c0547774] &rq->lock
 -> [c0a65cd4] &(&sbi->s_lock)->rlock
 -> [c0a656f8] &(&mapping->tree_lock)->rlock
 -> [c04d7f58] &sb->s_type->i_lock_key#3
 -> [c04d7b24] inode_wb_list_lock
 -> [c054d2c0] &(&base->lock)->rlock
 -> [c0a6893c] &(&q->__queue_lock)->rlock
 -> [c0a68984] &(&ret->lock)->rlock
 -> [c883c9ac] &(&hwif->lock)->rlock
 -> [c0a63d74] key#18
 -> [c0a6582c] vfsmount_lock
 -> [c0a656e8] &(&mapping->private_lock)->rlock
 -> [c0a63d5c] &(&zone->lru_lock)->rlock
 -> [c0a63f58] &(&bdi->wb_lock)->rlock
 -> [c0a658b8] key#22
 -> [c0a6511c] &(&parent->list_lock)->rlock
 -> [c04d7b04] inode_sb_list_lock
 -> [c0a63d64] &(&zone->lock)->rlock
 -> [c0a65184] files_lglock
 -> [c04d6c64] pcpu_alloc_mutex
 -> [c054d368] &(&gcwq->lock)->rlock
 -> [c04d6bfc] pcpu_lock
 -> [c0a63d6c] key#6
 -> [c0a656f0] &mapping->i_mmap_mutex
 -> [c0a65ce8] &ei->truncate_mutex
 -> [c05477d8] &p->pi_lock


root@voyage:~# grep 'type->s_umount_key' /proc/lockdep_chains |wc
    338     676   11652

108 of them are for #15, let me know if you want to see them..


root@voyage:~# grep -n 'mapping->i_mmap_mutex' /proc/lockdep |wc
     11      49     503
root@voyage:~# grep -n 'mapping->i_mmap_mutex' /proc/lockdep_chains |wc
     71     142    2829

heres one of the ones in /proc/lockdep,
which has the same +.+.-. flags, and has FD, BD

c0a656f0 OPS:  254395 FD:   23 BD:   46 +.+.-.: &mapping->i_mmap_mutex
 -> [c0547774] &rq->lock
 -> [c04d5f78] rcu_kthread_wq.lock
 -> [c0a63d64] &(&zone->lock)->rlock
 -> [c0547800] &(&mm->page_table_lock)->rlock
 -> [c0a6893c] &(&q->__queue_lock)->rlock
 -> [c054d368] &(&gcwq->lock)->rlock
 -> [c883c9ac] &(&hwif->lock)->rlock
 -> [c054d2c0] &(&base->lock)->rlock
 -> [c04c7614] pgd_lock


Again, Im just guessing blindly, let me know if something else would be helpful.

thanks
Jim Cromie


BUG: sleeping function called from invalid context at
/home/jimc/projects/lx/linux-2.6/drivers/ide/ide-io.c:468
in_atomic(): 1, irqs_disabled(): 0, pid: 2956, name: flush-3:0
2 locks held by flush-3:0/2956:
 #0:  (&type->s_umount_key#15){++++..}, at: [<c0199121>]
writeback_inodes_wb+0xcd/0x13b
 #1:  (&mapping->i_mmap_mutex){+.+.-.}, at: [<c0174cf1>] page_mkclean+0x65/0x10b
Pid: 2956, comm: flush-3:0 Not tainted 3.0.0-skc-dyndbg+ #349
Call Trace:
 [<c0117264>] __might_sleep+0xd4/0xdb
 [<c8830f53>] do_ide_request+0x3d/0x46d [ide_core]
 [<c025dca7>] ? cfq_service_tree_add+0x198/0x1fa
 [<c02535ff>] __blk_run_queue+0x14/0x16
 [<c025e789>] cfq_insert_request+0x3d0/0x404
 [<c0252f6e>] __elv_add_request+0x13e/0x169
 [<c025562d>] blk_flush_plug_list+0x11b/0x152
 [<c037b785>] schedule+0x1e0/0x445
 [<c0163843>] ? test_set_page_writeback+0xb7/0xc1
 [<c013e883>] ? mark_lock+0x26/0x1e4
 [<c013ea86>] ? mark_held_locks+0x45/0x61
 [<c037c189>] ? __mutex_lock_common+0x1ef/0x34e
 [<c0119285>] ? get_parent_ip+0xb/0x31
 [<c037c1b4>] __mutex_lock_common+0x21a/0x34e
 [<c037c3b2>] mutex_lock_nested+0x2d/0x36
 [<c0174cf1>] ? page_mkclean+0x65/0x10b
 [<c0174cf1>] page_mkclean+0x65/0x10b
 [<c013ea86>] ? mark_held_locks+0x45/0x61
 [<c01638dc>] ? clear_page_dirty_for_io+0x8f/0xa5
 [<c013ebca>] ? trace_hardirqs_on_caller+0x128/0x156
 [<c016387a>] clear_page_dirty_for_io+0x2d/0xa5
 [<c0163af3>] write_cache_pages+0x156/0x243
 [<c01a3bf9>] ? i_size_read+0x46/0x46
 [<c01d1e1b>] ? ext2_get_inode+0xdd/0xdd
 [<c01a3b18>] mpage_writepages+0x58/0x84
 [<c01d1e1b>] ? ext2_get_inode+0xdd/0xdd
 [<c01d1d1a>] ext2_writepages+0xd/0xf
 [<c016454c>] do_writepages+0x1a/0x27
 [<c0198622>] writeback_single_inode+0xa3/0x19d
 [<c037cd2f>] ? _raw_spin_lock+0x2c/0x34
 [<c0198bc7>] writeback_sb_inodes+0xb3/0x130
 [<c0199179>] writeback_inodes_wb+0x125/0x13b
 [<c0199332>] wb_writeback+0x1a3/0x21c
 [<c01994c6>] wb_do_writeback+0x11b/0x12f
 [<c0199525>] bdi_writeback_thread+0x4b/0xfe
 [<c01994da>] ? wb_do_writeback+0x12f/0x12f
 [<c013013e>] kthread+0x61/0x66
 [<c01300dd>] ? __init_kthread_worker+0x42/0x42
 [<c037e1c6>] kernel_thread_helper+0x6/0xd
BUG: sleeping function called from invalid context at
/home/jimc/projects/lx/linux-2.6/drivers/ide/ide-io.c:468
in_atomic(): 1, irqs_disabled(): 0, pid: 3448, name: aptitude
2 locks held by aptitude/3448:
 #0:  (&mm->mmap_sem){++++++}, at: [<c0113df7>] do_page_fault+0x101/0x2b6
 #1:  (&mapping->i_mmap_mutex){+.+.-.}, at: [<c0175c1e>]
page_referenced+0x125/0x1ab
Pid: 3448, comm: aptitude Not tainted 3.0.0-skc-dyndbg+ #349
Call Trace:
 [<c0117264>] __might_sleep+0xd4/0xdb
 [<c8830f53>] do_ide_request+0x3d/0x46d [ide_core]
 [<c025de16>] ? cfq_resort_rr_list+0x1f/0x23
 [<c025dca7>] ? cfq_service_tree_add+0x198/0x1fa
 [<c02535ff>] __blk_run_queue+0x14/0x16
 [<c025e789>] cfq_insert_request+0x3d0/0x404
 [<c0252f6e>] __elv_add_request+0x13e/0x169
 [<c025562d>] blk_flush_plug_list+0x11b/0x152
 [<c037b785>] schedule+0x1e0/0x445
 [<c013e883>] ? mark_lock+0x26/0x1e4
 [<c013ea86>] ? mark_held_locks+0x45/0x61
 [<c037c189>] ? __mutex_lock_common+0x1ef/0x34e
 [<c0119285>] ? get_parent_ip+0xb/0x31
 [<c037c1b4>] __mutex_lock_common+0x21a/0x34e
 [<c037c3b2>] mutex_lock_nested+0x2d/0x36
 [<c0175c1e>] ? page_referenced+0x125/0x1ab
 [<c0175c1e>] page_referenced+0x125/0x1ab
 [<c0116709>] ? need_resched+0x14/0x1e
 [<c0167206>] shrink_page_list+0x157/0x5a8
 [<c016576f>] ? __pagevec_release+0x18/0x21
 [<c013ea86>] ? mark_held_locks+0x45/0x61
 [<c037d219>] ? _raw_spin_unlock_irq+0x22/0x45
 [<c0167910>] shrink_inactive_list+0x172/0x22d
 [<c0167cba>] shrink_zone+0x2ef/0x397
 [<c0119285>] ? get_parent_ip+0xb/0x31
 [<c01683e1>] do_try_to_free_pages+0x77/0x201
 [<c01683e1>] ? do_try_to_free_pages+0x77/0x201
 [<c0168685>] try_to_free_pages+0x70/0x78
 [<c0163247>] __alloc_pages_nodemask+0x357/0x4d6
 [<c01648ab>] __do_page_cache_readahead+0xc5/0x1ac
 [<c0164a3c>] ra_submit+0x17/0x1c
 [<c0164be7>] ondemand_readahead+0x1a6/0x1ae
 [<c0164c45>] page_cache_async_readahead+0x56/0x61
 [<c015f9ad>] filemap_fault+0xc7/0x315
 [<c016e6ae>] __do_fault+0x39/0x280
 [<c025464b>] ? submit_bio+0x95/0x9d
 [<c017024c>] handle_pte_fault+0x1ee/0x51f
 [<c01705f3>] handle_mm_fault+0x76/0x87
 [<c0113f8d>] do_page_fault+0x297/0x2b6
 [<c013d5e6>] ? trace_hardirqs_off_caller+0x99/0xf8
 [<c0113cf6>] ? vmalloc_sync_all+0xa1/0xa1
 [<c037d9bd>] error_code+0x5d/0x70
 [<c0113cf6>] ? vmalloc_sync_all+0xa1/0xa1
 [<c015dfe0>] ? file_read_actor+0x28/0xb2
 [<c0119327>] ? sub_preempt_count+0x7c/0x89
 [<c015f5b9>] generic_file_aio_read+0x37b/0x55c
 [<c017fac1>] do_sync_read+0x89/0xc4
 [<c017fa38>] ? do_sync_write+0xc4/0xc4
 [<c018009e>] vfs_read+0x73/0x9f
 [<c0180105>] sys_read+0x3b/0x5d
 [<c037d605>] syscall_call+0x7/0xb
 [<c0370000>] ? svc_recv+0x650/0x685
