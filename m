From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: CPU usage is very high while io'ing a sata disk
Date: Tue, 29 Nov 2005 23:23:20 +0200
Message-ID: <5d96567b0511291323j4fa468d7t66d1cdd7e47061a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7078_15171067.1133299400625"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:13433 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932410AbVK2VXV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2005 16:23:21 -0500
Received: by wproxy.gmail.com with SMTP id 71so3979wri
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 13:23:20 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------=_Part_7078_15171067.1133299400625
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am using a maxtor sata disk. whenever an io is made to the disk
there is a huge impact over the cpu usage.
i am using kernel 2.6.12 but i have seen in 2.6.11 as well.
the folllwing test was made:

dd if=3D/dev/sdb of=3D/dev/zero bs=3D1M count=3D1000
it ended after 16 seconds.

during that time cpu usage was nearly 100% usage.
the bellow is a  "vmstat 1" output during the "dd'ing " time. as u can
see wait time  is high but idle is actully  zero.
i have also profile the  kernel with opprofile during that time but i
have found out
that most of the time it spends in mwait_idle ( 98%) which is vert odd
considering
the fact that vmstat reports the opposite.
I have seen it happen in HITACHI disks as well as MAXTOR and whenver i
use a hardware raid the cpu usage is logically low ( since it is a
scsi driver ).
Also, the kernel PREMPT flag is on ( if that really matters ?).

the driver is sata_piix which i believe has something to do with this probl=
em.

A kernel profiling output is added to this posting.
thank u
Raz.


 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 1  1      0 1867128  88308  57996    0    0  2546    20 1022   151  0  1 9=
4  5
 1  1      0 1801780 152820  57996    0    0 64512     0 1263   533  0  8  =
0 92
 0  1      0 1736060 217588  57996    0    0 64768     0 1260   535  0 10  =
0 90
 0  1      0 1670340 282356  57996    0    0 64768     0 1261   537  0  9  =
0 91
 0  1      0 1604744 347132  57996    0    0 64768    72 1262   539  1  9  =
0 90
 0  1      0 1539272 411644  57996    0    0 64512     0 1261   537  0  6  =
0 94
 0  1      0 1474048 475900  57996    0    0 64256     0 1261   529  0  9  =
0 91
 0  1      0 1408328 540668  57996    0    0 64768     0 1260   537  0  7  =
0 93
 0  1      0 1343476 604668  57996    0    0 64000     0 1263   530  0  9  =
0 91
 0  1      0 1277756 669436  57996    0    0 64768     0 1261   535  0  9  =
0 91
 0  1      0 1212036 734204  57996    0    0 64768     0 1258   534  0  9  =
0 91
 0  1      0 1146564 798716  57996    0    0 64512     0 1265   532  0  9  =
0 91
 0  1      0 1085756 858688  57996    0    0 64768     0 1265   547  0  9  =
0 91
 0  1      0 1086372 858048  57996    0    0 64768     0 1262   721  0  8  =
0 92
 0  1      0 1085756 858688  57996    0    0 64768     0 1260   708  0  8  =
0 92
1

--
Raz

------=_Part_7078_15171067.1133299400625
Content-Type: application/octet-stream; name=prof.out
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="prof.out"

CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        symbol name
87831    98.3297  mwait_idle
741       0.8296  __copy_to_user_ll
61        0.0683  __make_request
51        0.0571  kmem_cache_free
46        0.0515  handle_IRQ_event
42        0.0470  kmem_cache_alloc
39        0.0437  buffered_rmqueue
33        0.0369  invalidate_complete_page
26        0.0291  end_buffer_async_read
25        0.0280  file_read_actor
24        0.0269  __mod_page_state
24        0.0269  free_hot_cold_page
23        0.0257  find_get_page
22        0.0246  scsi_request_fn
19        0.0213  block_read_full_page
13        0.0146  kmap_atomic
13        0.0146  shrink_list
11        0.0123  add_to_page_cache
11        0.0123  submit_bh
9         0.0101  ahci_interrupt
9         0.0101  scsi_dispatch_cmd
9         0.0101  test_clear_page_dirty
8         0.0090  drop_buffers
8         0.0090  release_pages
7         0.0078  __do_page_cache_readahead
7         0.0078  alloc_page_buffers
7         0.0078  init_buffer_head
7         0.0078  mempool_alloc
7         0.0078  schedule
6         0.0067  __alloc_pages
6         0.0067  __do_softirq
6         0.0067  __wake_up_bit
6         0.0067  generic_make_request
6         0.0067  page_address
6         0.0067  read_pages
6         0.0067  try_to_free_buffers
5         0.0056  do_generic_mapping_read
5         0.0056  do_page_fault
5         0.0056  unlock_page
4         0.0045  __pagevec_lru_add
4         0.0045  __wake_up
4         0.0045  bio_alloc_bioset
4         0.0045  create_empty_buffers
4         0.0045  max_block
3         0.0034  __d_lookup
3         0.0034  __end_that_request_first
3         0.0034  blkdev_get_block
3         0.0034  find_get_pages
3         0.0034  free_buffer_head
3         0.0034  page_waitqueue
3         0.0034  zap_pte_range
2         0.0022  __kmalloc
2         0.0022  bad_range
2         0.0022  bio_endio
2         0.0022  cond_resched
2         0.0022  del_timer
2         0.0022  do_wp_page
2         0.0022  finish_wait
2         0.0022  invalidate_mapping_pages
2         0.0022  kunmap_atomic
2         0.0022  mark_buffer_async_read
2         0.0022  page_cache_readahead
2         0.0022  prep_new_page
2         0.0022  recalc_bh_state
2         0.0022  scsi_finish_command
2         0.0022  strncpy_from_user
2         0.0022  submit_bio
2         0.0022  tg3_poll
1         0.0011  __find_get_block
1         0.0011  __insert_vm_struct
1         0.0011  __link_path_walk
1         0.0011  __mod_timer
1         0.0011  __pagevec_lru_add_active
1         0.0011  _atomic_dec_and_lock
1         0.0011  bio_alloc
1         0.0011  bio_destructor
1         0.0011  bio_put
1         0.0011  blk_run_queue
1         0.0011  cache_init_objs
1         0.0011  cap_bprm_apply_creds
1         0.0011  copy_process
1         0.0011  copy_pte_range
1         0.0011  dcache_readdir
1         0.0011  do_lookup
1         0.0011  dput
1         0.0011  ext3_htree_store_dirent
1         0.0011  fget
1         0.0011  fget_light
1         0.0011  filldir64
1         0.0011  find_vma_prev
1         0.0011  fput
1         0.0011  free_pgd_range
1         0.0011  get_io_context
1         0.0011  get_request
1         0.0011  handle_mm_fault
1         0.0011  invalidate_inode_buffers
1         0.0011  ip_nat_setup_info
1         0.0011  ipt_do_table
1         0.0011  journal_add_journal_head
1         0.0011  kmem_getpages
1         0.0011  make_ahead_window
1         0.0011  mark_page_accessed
1         0.0011  mempool_free
1         0.0011  mempool_free_slab
1         0.0011  nat_packet
1         0.0011  pagebuf_daemon
1         0.0011  prune_dcache
1         0.0011  put_device
1         0.0011  rb_insert_color
1         0.0011  scsi_decide_disposition
1         0.0011  scsi_init_cmd_errh
1         0.0011  sha_transform
1         0.0011  shrink_cache
1         0.0011  shrink_slab
1         0.0011  shrink_zone
1         0.0011  start_this_handle
1         0.0011  sys_mprotect
1         0.0011  sysenter_past_esp
1         0.0011  tcp_clean_rtx_queue
1         0.0011  tg3_rx
1         0.0011  tg3_start_xmit
1         0.0011  tiocspgrp
1         0.0011  udp_pkt_to_tuple
1         0.0011  unmap_vmas
1         0.0011  vfs_fstat
1         0.0011  zone_watermark_ok

------=_Part_7078_15171067.1133299400625--
