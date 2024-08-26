Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D817E1
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705197; cv=none; b=Rk5AguCVXWazE0u2FncNTDAvkC0lfwpsy3HT+8EhV/o2YXnCW09Ufo6umeF/ZHIYFwRJhlvkzo418VLjGm45uvh+6sa5JRyn6ZzveWb14HFFKJZXVQqVMwsJD5LYjL3wZUpZ0ZqDZ50WxJeNi/dOIgzyu+t3UnpDQZKuS0VkR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705197; c=relaxed/simple;
	bh=TJeCpJKrPLtHHje4+K0RvD0/V3ZiOLvU46uexNoBhrI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mceRmcHjCLDVWE805XX4kiSsVfqeVfEIeBJ4v4/v+l9kTrDTMqeOwA+LyeXRO0gPBePiAGAtGLDGM3rlQtjn1TiKibHMa779YMYdqJ9h/p1uRTSP4L7Lw41BPBiCqsX6eZWkCdkcFKcy9XJ/BWQX4ch2X3XGpD0iFSZeGW1l0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=rM9S/7mE; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=P5aVWEmL; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rM9S/7mE";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="P5aVWEmL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724705194; x=1756241194;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TJeCpJKrPLtHHje4+K0RvD0/V3ZiOLvU46uexNoBhrI=;
  b=rM9S/7mENaRzBnKW4BtkJbA6ujVoYaee27qlkvOUTcPljGflAWLaTWfp
   0yrBw7UWr3wodrXWI6YmEk7dJiYm99Fbits5UOCdl+7ZQsklvv5Z1eMRN
   nsOmO4KPNV7hcQILhch4rxvu8rsi+KV9SBg3ly4AFfXDFg9JUyroRNNw1
   N8C4EyvYclociYuazCHK0grFgEC8mWU2tC8xPjgB9IEOb3Mm4OsefTQ2y
   V4QDvFLbcK/ZPgRslCMN+bXef7GkK1DORrTe0pLjkdNuDyjD8A+QQigyl
   0wqZxzicQs6QzCnhcmxL1tuc4CWi2zJeaX3kapghsQ+Vk/hXljjt83OD2
   Q==;
X-CSE-ConnectionGUID: BWFiKXrUS9uHyt6XIb0tvg==
X-CSE-MsgGUID: SvhjOC4nQqGfof646yhhKw==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Aug 2024 13:46:28 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8edd7370so551276739f.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724705187; x=1725309987; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a6aPs8RPT1W/3J4EoOqjZmsd0cWvED3hygNtzaHMoy0=;
        b=P5aVWEmLGQl+918rr8klKN7OUqdC0L1JBnxq1q/9AuizzvqElkqgVG61dgtn/lOgtv
         wOvdmvPEPik33H6VfcRCflH5MXGSjdelC7hZPjff2ErHMGEu/byj5UIIYz8v76lnQaDt
         3TdAe6h4/AQUHyOkmropIfED2a2tCJVVnp+MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705187; x=1725309987;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6aPs8RPT1W/3J4EoOqjZmsd0cWvED3hygNtzaHMoy0=;
        b=cWelS6JTuHZFW2FfHpL7hlIBbx5vAwckUntuxrzU5LQ7CCbCDVPV/qBmNrKnb9qFi9
         Fvh3Ndn8VmdAF5Xj5+VgePhWAnsz5NSeRr73Fjzy2G8Y7EwDrZ7HBo8qWwTCkDV+sOVo
         UeEIYOAJzLO0LmfWmr5S4OiaxVNlmBxp06+HUWKWmiSRZUk5B0OzpaUtEOcFA1bMnD3j
         7v2qRTG8u3DsujaXP+1+ge5IuM5ivykyTlrbSTjiszyS+fHsncuHvNHnfmBXQWUAHsq7
         by1EtL6VxHgKtr777HBbGD3wg56TUR6JuecAxlndxNwyHhJKt6Lnr5WJ7YuR8eMZrABm
         x8yg==
X-Forwarded-Encrypted: i=1; AJvYcCXNvNzQ5STez64jXNNml7AB4qGrj114dI4GB8rm/KfvUCv0RUj7z5aWJhGdcuiGOKqhehNYmCSAOzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNN3PF06b76U5uZ3OgWKBLiTSvJXl488eFaeRx4YQNmef8j2i
	oem0hXw9dWwaipaLALC7FRC91hT1NuJhz2AZb4QVCzuSFoq/YYmSwZTj85TbLu9d89gO5uQjHWE
	ZwUEmIKBxKbtikH9fILlQRz4U8allqDgF4qhRaB1Oqsjb8FpRNLMUhgB0gY8vAbslUgC7G8WudH
	fJupW/HzrYmxuksQ/CBJdBTMhCljZfW/h3dA==
X-Received: by 2002:a05:6e02:1c09:b0:39d:46f6:b92e with SMTP id e9e14a558f8ab-39e3c982e21mr117932905ab.11.1724705187326;
        Mon, 26 Aug 2024 13:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHMfj7Tud+aGgQBPP9qVjkCSBT9UPQ024NV19zYFAJii8kUPkD0O2r/e/YluVuGHK0EEj3g5MmVIzHOV3QdSY=
X-Received: by 2002:a05:6e02:1c09:b0:39d:46f6:b92e with SMTP id
 e9e14a558f8ab-39e3c982e21mr117932675ab.11.1724705186904; Mon, 26 Aug 2024
 13:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 26 Aug 2024 13:46:15 -0700
Message-ID: <CANikGpf3VaRCW+m48E+k7CDGKv89gwd12Q1=qM_uP3N=az-T7A@mail.gmail.com>
Subject: BUG: possible deadlock in __ata_sff_interrupt
To: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
A possible deadlock issue was discovered in function
`__ata_sff_interrupt` when it attempted to acquire lock `host->lock`.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

sr 1:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_ERROR
driverbyte=DRIVER_OK cmd_age=0s
sr 1:0:0:0: [sr0] tag#0 CDB: opcode=0x98 98 61 1e 1d 47 a1 77 90 29 76
7f 40 b8 5e 03 63
=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.10.0 #13 Not tainted
-----------------------------------------------------
syz.1.961/19801 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88802d3a4018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu
fs/fcntl.c:1028 [inline]
ffff88802d3a4018 (&new->fa_lock){....}-{2:2}, at:
kill_fasync+0x196/0x4d0 fs/fcntl.c:1049

and this task is already holding:
ffff88801ca06018 (&host->lock){-.-.}-{2:2}, at:
ata_scsi_queuecmd+0x8a/0x520 drivers/ata/libata-scsi.c:4197
which would create a new lock dependency:
 (&host->lock){-.-.}-{2:2} -> (&new->fa_lock){....}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&host->lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
  __ata_sff_interrupt+0x2d/0x6a0 drivers/ata/libata-sff.c:1470
  __handle_irq_event_percpu+0x1f2/0x5f0 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x257/0xc10 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
  handle_irq arch/x86/kernel/irq.c:247 [inline]
  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
  __common_interrupt+0x134/0x230 arch/x86/kernel/irq.c:285
  common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:278
  asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
  _raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
  process_one_work kernel/workqueue.c:3248 [inline]
  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
  kthread+0x2eb/0x380 kernel/kthread.c:389
  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
  __do_wait+0x126/0x870 kernel/exit.c:1585
  do_wait+0x13e/0x310 kernel/exit.c:1629
  kernel_wait+0xe4/0x230 kernel/exit.c:1805
  call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
  call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:164
  process_one_work kernel/workqueue.c:3248 [inline]
  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
  kthread+0x2eb/0x380 kernel/kthread.c:389
  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &host->lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&host->lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&host->lock);

 *** DEADLOCK ***

3 locks held by syz.1.961/19801:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
blk_mq_run_hw_queue+0x442/0xab0 block/blk-mq.c:2250
 #1: ffff88801ca06018 (&host->lock){-.-.}-{2:2}, at:
ata_scsi_queuecmd+0x8a/0x520 drivers/ata/libata-scsi.c:4197
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
kill_fasync+0x51/0x4d0 fs/fcntl.c:1048

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&host->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd1/0x120
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt+0x2d/0x6a0 drivers/ata/libata-sff.c:1470
                    __handle_irq_event_percpu+0x1f2/0x5f0
kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x257/0xc10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
                    handle_irq arch/x86/kernel/irq.c:247 [inline]
                    call_irq_handler arch/x86/kernel/irq.c:259 [inline]
                    __common_interrupt+0x134/0x230 arch/x86/kernel/irq.c:285
                    common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:278
                    asm_common_interrupt+0x22/0x40
arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irq
include/linux/spinlock_api_smp.h:160 [inline]
                    _raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
                    process_one_work kernel/workqueue.c:3248 [inline]
                    process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
                    worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
                    kthread+0x2eb/0x380 kernel/kthread.c:389
                    ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd1/0x120
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt+0x2d/0x6a0 drivers/ata/libata-sff.c:1470
                    __handle_irq_event_percpu+0x1f2/0x5f0
kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x83/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x257/0xc10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
                    handle_irq arch/x86/kernel/irq.c:247 [inline]
                    call_irq_handler arch/x86/kernel/irq.c:259 [inline]
                    __common_interrupt+0x134/0x230 arch/x86/kernel/irq.c:285
                    common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:278
                    asm_common_interrupt+0x22/0x40
arch/x86/include/asm/idtentry.h:693
                    __sanitizer_cov_trace_cmp8+0x4/0xa0 kernel/kcov.c:284
                    orc_find arch/x86/kernel/unwind_orc.c:206 [inline]
                    unwind_next_frame+0x1a5/0x2930
arch/x86/kernel/unwind_orc.c:494
                    arch_stack_walk+0x14d/0x1a0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x112/0x1c0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3b/0x70 mm/kasan/common.c:68
                    kasan_save_free_info+0x3c/0x50 mm/kasan/generic.c:579
                    poison_slab_object+0xe0/0x140 mm/kasan/common.c:240
                    __kasan_slab_free+0x33/0x50 mm/kasan/common.c:256
                    kasan_slab_free include/linux/kasan.h:184 [inline]
                    slab_free_hook mm/slub.c:2196 [inline]
                    slab_free mm/slub.c:4438 [inline]
                    kmem_cache_free+0x117/0x280 mm/slub.c:4513
                    put_signal_struct kernel/fork.c:965 [inline]
                    __put_task_struct+0x1c5/0x280 kernel/fork.c:980
                    put_task_struct include/linux/sched/task.h:138 [inline]
                    delayed_put_task_struct+0x8e/0xf0 kernel/exit.c:228
                    rcu_do_batch kernel/rcu/tree.c:2535 [inline]
                    rcu_core+0xaeb/0x17f0 kernel/rcu/tree.c:2809
                    handle_softirqs+0x272/0x750 kernel/softirq.c:554
                    run_ksoftirqd+0xc6/0x120 kernel/softirq.c:928
                    smpboot_thread_fn+0x542/0xa00 kernel/smpboot.c:164
                    kthread+0x2eb/0x380 kernel/kthread.c:389
                    ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
   INITIAL USE at:
                   lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd1/0x120
kernel/locking/spinlock.c:162
                   ata_dev_init drivers/ata/libata-core.c:5361 [inline]
                   ata_link_init+0x236/0x880 drivers/ata/libata-core.c:5406
                   ata_port_alloc+0x3f4/0x4a0 drivers/ata/libata-core.c:5481
                   ata_host_alloc+0x189/0x2b0 drivers/ata/libata-core.c:5602
                   ata_host_alloc_pinfo+0x27/0x420
drivers/ata/libata-core.c:5643
                   ata_pci_sff_prepare_host+0x40/0xe0
drivers/ata/libata-sff.c:2235
                   ata_pci_bmdma_prepare_host+0x20/0x70
drivers/ata/libata-sff.c:3144
                   piix_init_one+0x6d1/0x1e90 drivers/ata/ata_piix.c:1704
                   local_pci_probe drivers/pci/pci-driver.c:324 [inline]
                   pci_call_probe drivers/pci/pci-driver.c:392 [inline]
                   __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
                   pci_device_probe+0x51f/0xa10 drivers/pci/pci-driver.c:451
                   call_driver_probe+0x9a/0x1b0
                   really_probe+0x274/0x8e0 drivers/base/dd.c:656
                   __driver_probe_device+0x199/0x380 drivers/base/dd.c:798
                   driver_probe_device+0x50/0x240 drivers/base/dd.c:828
                   __driver_attach+0x366/0x5a0 drivers/base/dd.c:1214
                   bus_for_each_dev+0x269/0x2e0 drivers/base/bus.c:368
                   bus_add_driver+0x369/0x680 drivers/base/bus.c:673
                   driver_register+0x236/0x310 drivers/base/driver.c:246
                   piix_init+0x1b/0x50 drivers/ata/ata_piix.c:1774
                   do_one_initcall+0xc4/0x310 init/main.c:1267
                   do_initcall_level+0x14e/0x270 init/main.c:1329
                   do_initcalls+0x3f/0x80 init/main.c:1345
                   kernel_init_freeable+0x42e/0x5c0 init/main.c:1578
                   kernel_init+0x19/0x2a0 init/main.c:1467
                   ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 }
 ... key      at: [<ffffffff92c39040>] ata_host_alloc.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{2:2} {
     HARDIRQ-ON-R at:
                        lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                        __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                        __do_wait+0x126/0x870 kernel/exit.c:1585
                        do_wait+0x13e/0x310 kernel/exit.c:1629
                        kernel_wait+0xe4/0x230 kernel/exit.c:1805
                        call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                        call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:164
                        process_one_work kernel/workqueue.c:3248 [inline]
                        process_scheduled_works+0x977/0x1410
kernel/workqueue.c:3329
                        worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
                        kthread+0x2eb/0x380 kernel/kthread.c:389
                        ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x11/0x20
arch/x86/entry/entry_64.S:244
     SOFTIRQ-ON-R at:
                        lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                        __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                        __do_wait+0x126/0x870 kernel/exit.c:1585
                        do_wait+0x13e/0x310 kernel/exit.c:1629
                        kernel_wait+0xe4/0x230 kernel/exit.c:1805
                        call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                        call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:164
                        process_one_work kernel/workqueue.c:3248 [inline]
                        process_scheduled_works+0x977/0x1410
kernel/workqueue.c:3329
                        worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
                        kthread+0x2eb/0x380 kernel/kthread.c:389
                        ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x11/0x20
arch/x86/entry/entry_64.S:244
     INITIAL USE at:
                       lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                       __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xcf/0x110
kernel/locking/spinlock.c:326
                       copy_process+0x226b/0x3d80 kernel/fork.c:2516
                       kernel_clone+0x224/0x6c0 kernel/fork.c:2797
                       user_mode_thread+0x12d/0x190 kernel/fork.c:2875
                       rest_init+0x23/0x300 init/main.c:712
                       start_kernel+0x486/0x500 init/main.c:1103
                       x86_64_start_reservations+0x26/0x30
arch/x86/kernel/head64.c:507
                       x86_64_start_kernel+0x5c/0x60
arch/x86/kernel/head64.c:488
                       common_startup_64+0x13e/0x147
     INITIAL READ USE at:
                            lock_acquire+0x1a9/0x400
kernel/locking/lockdep.c:5754
                            __raw_read_lock
include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x32/0x40
kernel/locking/spinlock.c:228
                            __do_wait+0x126/0x870 kernel/exit.c:1585
                            do_wait+0x13e/0x310 kernel/exit.c:1629
                            kernel_wait+0xe4/0x230 kernel/exit.c:1805
                            call_usermodehelper_exec_sync
kernel/umh.c:137 [inline]
                            call_usermodehelper_exec_work+0xb4/0x220
kernel/umh.c:164
                            process_one_work kernel/workqueue.c:3248 [inline]
                            process_scheduled_works+0x977/0x1410
kernel/workqueue.c:3329
                            worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
                            kthread+0x2eb/0x380 kernel/kthread.c:389
                            ret_from_fork+0x49/0x80
arch/x86/kernel/process.c:147
                            ret_from_fork_asm+0x11/0x20
arch/x86/entry/entry_64.S:244
   }
   ... key      at: [<ffffffff8d80a058>] tasklist_lock+0x18/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
   send_sigio+0xf7/0x360 fs/fcntl.c:830
   kill_fasync_rcu fs/fcntl.c:1035 [inline]
   kill_fasync+0x232/0x4d0 fs/fcntl.c:1049
   __receive_buf drivers/tty/n_tty.c:1656 [inline]
   n_tty_receive_buf_common+0x9ea/0x1370 drivers/tty/n_tty.c:1739
   tiocsti+0x24a/0x300 drivers/tty/tty_io.c:2299
   tty_ioctl+0x514/0xdb0 drivers/tty/tty_io.c:2717
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:907 [inline]
   __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x67/0x6f

 -> (&f->f_owner.lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                     __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xcf/0x110
kernel/locking/spinlock.c:326
                     f_modown+0x38/0x340 fs/fcntl.c:93
                     __tty_fasync drivers/tty/tty_io.c:2246 [inline]
                     tty_fasync+0x24c/0x330 drivers/tty/tty_io.c:2261
                     ioctl_fioasync fs/ioctl.c:380 [inline]
                     do_vfs_ioctl+0x196a/0x2d60 fs/ioctl.c:822
                     __do_sys_ioctl fs/ioctl.c:905 [inline]
                     __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
                     entry_SYSCALL_64_after_hwframe+0x67/0x6f
    INITIAL READ USE at:
                          lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                          __raw_read_lock_irqsave
include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0xd9/0x120
kernel/locking/spinlock.c:236
                          send_sigio+0x2f/0x360 fs/fcntl.c:816
                          kill_fasync_rcu fs/fcntl.c:1035 [inline]
                          kill_fasync+0x232/0x4d0 fs/fcntl.c:1049
                          __receive_buf drivers/tty/n_tty.c:1656 [inline]
                          n_tty_receive_buf_common+0x9ea/0x1370
drivers/tty/n_tty.c:1739
                          tiocsti+0x24a/0x300 drivers/tty/tty_io.c:2299
                          tty_ioctl+0x514/0xdb0 drivers/tty/tty_io.c:2717
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:907 [inline]
                          __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
                          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                          do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
                          entry_SYSCALL_64_after_hwframe+0x67/0x6f
  }
  ... key      at: [<ffffffff92962060>] init_file.__key+0x0/0x20
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   send_sigio+0x2f/0x360 fs/fcntl.c:816
   kill_fasync_rcu fs/fcntl.c:1035 [inline]
   kill_fasync+0x232/0x4d0 fs/fcntl.c:1049
   __receive_buf drivers/tty/n_tty.c:1656 [inline]
   n_tty_receive_buf_common+0x9ea/0x1370 drivers/tty/n_tty.c:1739
   tiocsti+0x24a/0x300 drivers/tty/tty_io.c:2299
   tty_ioctl+0x514/0xdb0 drivers/tty/tty_io.c:2717
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:907 [inline]
   __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x67/0x6f

-> (&new->fa_lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                   __raw_write_lock_irq
include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xfb/0x1c0 fs/fcntl.c:905
                   __tty_fasync drivers/tty/tty_io.c:2228 [inline]
                   tty_fasync+0x101/0x330 drivers/tty/tty_io.c:2261
                   __fput+0x738/0x8a0 fs/file_table.c:419
                   task_work_run+0x239/0x2f0 kernel/task_work.c:180
                   resume_user_mode_work
include/linux/resume_user_mode.h:50 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
                   exit_to_user_mode_prepare
include/linux/entry-common.h:328 [inline]
                   __syscall_exit_to_user_mode_work
kernel/entry/common.c:207 [inline]
                   syscall_exit_to_user_mode+0x12d/0x280
kernel/entry/common.c:218
                   do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
                   entry_SYSCALL_64_after_hwframe+0x67/0x6f
   INITIAL READ USE at:
                        lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
                        __raw_read_lock_irqsave
include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xd9/0x120
kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1028 [inline]
                        kill_fasync+0x196/0x4d0 fs/fcntl.c:1049
                        __receive_buf drivers/tty/n_tty.c:1656 [inline]
                        n_tty_receive_buf_common+0x9ea/0x1370
drivers/tty/n_tty.c:1739
                        tiocsti+0x24a/0x300 drivers/tty/tty_io.c:2299
                        tty_ioctl+0x514/0xdb0 drivers/tty/tty_io.c:2717
                        vfs_ioctl fs/ioctl.c:51 [inline]
                        __do_sys_ioctl fs/ioctl.c:907 [inline]
                        __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
                        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                        do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
                        entry_SYSCALL_64_after_hwframe+0x67/0x6f
 }
 ... key      at: [<ffffffff92962cc0>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1028 [inline]
   kill_fasync+0x196/0x4d0 fs/fcntl.c:1049
   sg_rq_end_io+0x76a/0xd50 drivers/scsi/sg.c:1407
   __blk_mq_end_request+0x4a4/0x620 block/blk-mq.c:1047
   scsi_end_request+0x4eb/0x850 drivers/scsi/scsi_lib.c:665
   scsi_io_completion_action+0xe85/0x14f0 drivers/scsi/scsi_lib.c:932
   scsi_io_completion+0x372/0x420 drivers/scsi/scsi_lib.c:1087
   __ata_scsi_queuecmd+0x2ef/0x1020
   ata_scsi_queuecmd+0x3b1/0x520 drivers/ata/libata-scsi.c:4201
   scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1609 [inline]
   scsi_queue_rq+0x1d8e/0x2b40 drivers/scsi/scsi_lib.c:1851
   blk_mq_dispatch_rq_list+0x4f2/0x1ba0 block/blk-mq.c:2037
   __blk_mq_sched_dispatch_requests+0x3c2/0x17e0 block/blk-mq-sched.c:301
   blk_mq_sched_dispatch_requests+0xc7/0x130 block/blk-mq-sched.c:331
   blk_mq_run_hw_queue+0x995/0xab0 block/blk-mq.c:2250
   blk_execute_rq_nowait+0x1cf/0x240 block/blk-mq.c:1342
   sg_common_write+0x911/0x1480 drivers/scsi/sg.c:835
   sg_write+0xa4d/0xef0 drivers/scsi/sg.c:710
   vfs_write+0x2ac/0xc70 fs/read_write.c:588
   ksys_write+0x19b/0x2c0 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x67/0x6f


stack backtrace:
CPU: 0 PID: 19801 Comm: syz.1.961 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x71bb/0x8050 kernel/locking/lockdep.c:5137
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1028 [inline]
 kill_fasync+0x196/0x4d0 fs/fcntl.c:1049
 sg_rq_end_io+0x76a/0xd50 drivers/scsi/sg.c:1407
 __blk_mq_end_request+0x4a4/0x620 block/blk-mq.c:1047
 scsi_end_request+0x4eb/0x850 drivers/scsi/scsi_lib.c:665
 scsi_io_completion_action+0xe85/0x14f0 drivers/scsi/scsi_lib.c:932
 scsi_io_completion+0x372/0x420 drivers/scsi/scsi_lib.c:1087
 __ata_scsi_queuecmd+0x2ef/0x1020
 ata_scsi_queuecmd+0x3b1/0x520 drivers/ata/libata-scsi.c:4201
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1609 [inline]
 scsi_queue_rq+0x1d8e/0x2b40 drivers/scsi/scsi_lib.c:1851
 blk_mq_dispatch_rq_list+0x4f2/0x1ba0 block/blk-mq.c:2037
 __blk_mq_sched_dispatch_requests+0x3c2/0x17e0 block/blk-mq-sched.c:301
 blk_mq_sched_dispatch_requests+0xc7/0x130 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x995/0xab0 block/blk-mq.c:2250
 blk_execute_rq_nowait+0x1cf/0x240 block/blk-mq.c:1342
 sg_common_write+0x911/0x1480 drivers/scsi/sg.c:835
 sg_write+0xa4d/0xef0 drivers/scsi/sg.c:710
 vfs_write+0x2ac/0xc70 fs/read_write.c:588
 ksys_write+0x19b/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fd3231809b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd324039038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd323345f80 RCX: 00007fd3231809b9
RDX: 0000000000000034 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007fd3231f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd323345f80 R15: 00007ffe6d3672d8
 </TASK>
