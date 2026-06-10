Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E903750CA
	for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075020; cv=pass; b=j9f91Bi5J6GEMVcJsC+KmsFCzo/CHaN50Ga8UGRgzmFuXo3PLQTGykKUTUHBvC69kWe0Fy9D5OW3lGAinpsHqMS0UliCg2oJPRP+rkqY6wOTF4yU9+ScTCwrFehuO7alCFmBFo2FcgMEfBBbTM3S913XkdO4nLPXsz9ntjiQ8hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075020; c=relaxed/simple;
	bh=Rqo6nXCG/4xpEHsqyO6fzfoASPlRyayY59iGmReIsAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7fBDGycnL1v0UJmkM5y25Plknn+M6L20IrQqMJaWf4zrMsLAnaT6RgoChTJZht8RKiKeKo4bDVQffRKkNxC5iwmq8QnjXfPyDoOCvsxI1aEvUZvK3/AHghxsBBG0b+RT+DZrEeAPLA4LR0DG5CJQWTHH8BHnp9FlFgJ4qz3cB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSUkMG2T; arc=pass smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSUkMG2T"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-51788280e71so69209361cf.0
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2026 00:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781075017; cv=none;
        d=google.com; s=arc-20240605;
        b=AuuGrwwM7dLWflp8xHGt9ZCc4vOTDgH8GQhJ2END+u1hKzaAZAfs8yfRK7MUqxAbZ6
         feFyqXxiNH3FjER0ONWyTxD3YvEeuP+XxwaEpp6x2B8zTdIzny8ZZ4Ulkz7mYn3rpUQJ
         4n+IDo09NwyLPMfCLWY+VgkZFi1yHzEq0xeZAoFasI1dEerU9FEy/YRtgSXq68PBrVzj
         2zsDOFd8iWIXlREFX4nIFxxSzF+6GHJ/RnS16uBtmpzlqvbZajnyGEZTlk7i/2cmUeau
         Gpy5JeUu4sA+DT4XgrsZLnOwlTU1dhnc1KG4LZYojKR+2eicDc9PpbZLeF9QglXBQlfP
         RRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNQFjscmRK0xOWJEmjMudO8TaIiP4+lT8VmjB6NaT5U=;
        fh=KYBQFTxtFEM23+uOZF9IJ3yDvu8iZKvJmiao6K7Vhx4=;
        b=N5jpGH4qbSVCmiPiY+NspK73QFTzTDtdVCUf3cBl0znqUmqPAtiIO3wbTtdp+vLTpv
         rSOYMlLYBhKpH4zc2zwOe+M9l71qe1DgwxxwK+Mw3CZzVVA13CvTsRuUVJm/LtAzZgaS
         +jGAMHGbwsORHKa8HCfY3uFDbhPWuRsU/dDz2xqw2sUoMkoWKZ7sBQuKgCvdkdjIKc7/
         ja4oPvjntXm3MAD2ww83GlfPjHQB0Pj0T5kYkazCG7wMFT2FhihSPER9czFYs75SLrDw
         8jYJsRet9b1P7E+amb/xhalpGvk7PI9xrQ3d0PaaBB1H24OGEnz5eEx3ABlfT66E5kaM
         f3ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075017; x=1781679817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNQFjscmRK0xOWJEmjMudO8TaIiP4+lT8VmjB6NaT5U=;
        b=FSUkMG2T4UgaIK9fYURsklCcgcHZK7mFsSaqvPc2LwtupSg6rj7lTuBgrdtp1tnMAD
         +OU7a7e+ZO/nA0b40mcXdb5zFetWkybDDTFII3Z6OwVoTWFGXKTyfu+xioUahSnB7JkJ
         sS8FbBEgYdjzwZ7T3KA344EpEMKwt4m4KTsaFQQAWlN5jvETJmDQ7winqUrbeE654WtN
         BG9wkCvHhiSySKQbjLrvvrGHqSQPIXCv8NuvsHuDACCVZy888Ydmg0Vu9oqHX5LPDzp4
         GVL38hpxFfwWW2CBEsf8i9uxml0z4dNd49w2yuUSxqa30T+HxO/MFSq90sOi57A2Uh4i
         583w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075017; x=1781679817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNQFjscmRK0xOWJEmjMudO8TaIiP4+lT8VmjB6NaT5U=;
        b=A256AU1p3LlgLNq1e2QGB8VYwH1wXDnL9Kp+t7pJ90DtTkdIy/yGwlkqHfKrc8MrlJ
         dO1nl5SbwzD0s+SiIN/bVoG1dMbpiznaPUWm3Orm3uxjxCpGH+gl1KECEAcU9y9JFBCr
         H+9S/hxLeZW0IvhB7EPxAXAoPnsE2zLYLqsarUAffuW8tUnlilwYp57ompoVrXC2ZEvt
         vQ3eh3VcG36yB1f1X8u1XkqLFQ2kwKBzzb4wG9L9qXwNnMW3vdKcJKPKByUEkwadHv9l
         4mstIEUJp3CWO+45bJM20k0n7yFRrwbmVf3bpzuTWZQJXLW3+544l7WHS7yhZjKH2xtN
         klTw==
X-Forwarded-Encrypted: i=1; AFNElJ9jKXmWTG+a0Cu4f16zP68PirUoLfUZ290ydhkqGSVt7KJyFs1v7hPSRj4q6XlEopbzUZcn7gHipvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqy35blnoXzYWiwaxSnmA6zgR/5QnX5AE8Dqqudt8y/TJx2+U
	vtctF9HNHoKS3KG+6PFF9karOda8HnY1XhEZZ2u/d+00faM5+AqjE2FNERrhID/vMB+ewt34koi
	cE7qZQ1xKkJDND4zB8ZClM/v1vi/Q5Ls=
X-Gm-Gg: Acq92OFSVEudblisbnPL7US+Y+JORPd+X6mSov35vovClJJBIxT7u3OlhSk7ADTe0he
	XGl4ssChkzkaAmIwODZNOoL1WA0pu2SwCVRdunYERuX46ZjRnZ4QKy+OXs9co8xO+yzqfk+ayKV
	7cxMCtI5mToMxGzE1hqpAvMxYhYNL+gy59iluny3SlHBV4QKH0wKlvaYBNOsgR5mXq6xMi7LV6d
	SvPidiqHq0AOAUecLuPVeK4SaMutGX9TSOUvM4cEbSYAiDuULXnR+iHcZIARsprPDg2kV14tkgy
	2kNyeKdDeXO/A6kG4Y0L
X-Received: by 2002:a05:622a:248:b0:517:74af:641f with SMTP id
 d75a77b69052e-517ca516f6amr86625091cf.2.1781075016809; Wed, 10 Jun 2026
 00:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmx0LUYXWW1n_Su0BEOGqF20qDHj3CNvXBLuR3E7LLBOBg@mail.gmail.com>
 <aigECzOctNIPbMeY@ryzen>
In-Reply-To: <aigECzOctNIPbMeY@ryzen>
From: Longxing Li <coregee2000@gmail.com>
Date: Wed, 10 Jun 2026 15:03:24 +0800
X-Gm-Features: AVVi8Ce9KNLuZzCuZN7arpOcnonprhqvlclvZG1_TANZzpJgEoDF0V5OHmM4jEM
Message-ID: <CAHPqNmyWTYP54Np6bCctYBTc-NyJu9DvUwRfKPaQm6iAmo7WRA@mail.gmail.com>
Subject: Re: [Kernel Bug] possible deadlock in ata_bmdma_interrupt
To: Niklas Cassel <cassel@kernel.org>
Cc: syzkaller@googlegroups.com, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the report plain text is as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
7.0.6 #1 Tainted: G             L
-----------------------------------------------------
syz-executor.14/94929 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff8880463402b8 (&new->fa_lock){....}-{3:3}, at: kill_fasync_rcu
fs/fcntl.c:1135 [inline]
ffff8880463402b8 (&new->fa_lock){....}-{3:3}, at: kill_fasync
fs/fcntl.c:1159 [inline]
ffff8880463402b8 (&new->fa_lock){....}-{3:3}, at:
kill_fasync+0x137/0x520 fs/fcntl.c:1152

and this task is already holding:
ffff88802620d418 (&host->lock){-.-.}-{3:3}, at:
ata_scsi_queuecmd+0x87/0x170 drivers/ata/libata-scsi.c:4513
which would create a new lock dependency:
 (&host->lock){-.-.}-{3:3} -> (&new->fa_lock){....}-{3:3}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&host->lock){-.-.}-{3:3}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
  __ata_sff_interrupt drivers/ata/libata-sff.c:1471 [inline]
  ata_bmdma_interrupt+0x26/0x6d0 drivers/ata/libata-sff.c:2755
  __handle_irq_event_percpu+0x237/0x940 kernel/irq/handle.c:209
  handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
  handle_edge_irq+0x3ca/0x9b0 kernel/irq/chip.c:855
  generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
  handle_irq arch/x86/kernel/irq.c:262 [inline]
  call_irq_handler arch/x86/kernel/irq.c:286 [inline]
  __common_interrupt+0xd1/0x2f0 arch/x86/kernel/irq.c:333
  common_interrupt+0xf2/0x110 arch/x86/kernel/irq.c:326
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:188 [inline]
  _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
  process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
  process_scheduled_works kernel/workqueue.c:3371 [inline]
  worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
  kthread+0x38d/0x4a0 kernel/kthread.c:436
  ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
  __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
  _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
  __do_wait+0x105/0x880 kernel/exit.c:1678
  do_wait+0x1e5/0x5f0 kernel/exit.c:1722
  kernel_wait+0x9f/0x160 kernel/exit.c:1898
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:163
  process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
  process_scheduled_works kernel/workqueue.c:3371 [inline]
  worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
  kthread+0x38d/0x4a0 kernel/kthread.c:436
  ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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

3 locks held by syz-executor.14/94929:
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
blk_mq_run_hw_queue+0x3a3/0x650 block/blk-mq.c:2386
 #1: ffff88802620d418 (&host->lock){-.-.}-{3:3}, at:
ata_scsi_queuecmd+0x87/0x170 drivers/ata/libata-scsi.c:4513
 #2: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #2: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:850 [inline]
 #2: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at: kill_fasync
fs/fcntl.c:1158 [inline]
 #2: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
kill_fasync+0x61/0x520 fs/fcntl.c:1152

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&host->lock){-.-.}-{3:3} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5868 [inline]
                    lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:132 [inline]
                    _raw_spin_lock_irqsave+0x3d/0x60
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt drivers/ata/libata-sff.c:1471 [inli=
ne]
                    ata_bmdma_interrupt+0x26/0x6d0 drivers/ata/libata-sff.c=
:2755
                    __handle_irq_event_percpu+0x237/0x940
kernel/irq/handle.c:209
                    handle_irq_event_percpu kernel/irq/handle.c:246 [inline=
]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
                    handle_edge_irq+0x3ca/0x9b0 kernel/irq/chip.c:855
                    generic_handle_irq_desc include/linux/irqdesc.h:186 [in=
line]
                    handle_irq arch/x86/kernel/irq.c:262 [inline]
                    call_irq_handler arch/x86/kernel/irq.c:286 [inline]
                    __common_interrupt+0xd1/0x2f0 arch/x86/kernel/irq.c:333
                    common_interrupt+0xf2/0x110 arch/x86/kernel/irq.c:326
                    asm_common_interrupt+0x26/0x40
arch/x86/include/asm/idtentry.h:688
                    __raw_spin_unlock_irq
include/linux/spinlock_api_smp.h:188 [inline]
                    _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.=
c:202
                    process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
                    process_scheduled_works kernel/workqueue.c:3371 [inline=
]
                    worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
                    kthread+0x38d/0x4a0 kernel/kthread.c:436
                    ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:2=
45
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5868 [inline]
                    lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
                    __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:132 [inline]
                    _raw_spin_lock_irqsave+0x3d/0x60
kernel/locking/spinlock.c:162
                    __ata_sff_interrupt drivers/ata/libata-sff.c:1471 [inli=
ne]
                    ata_bmdma_interrupt+0x26/0x6d0 drivers/ata/libata-sff.c=
:2755
                    __handle_irq_event_percpu+0x237/0x940
kernel/irq/handle.c:209
                    handle_irq_event_percpu kernel/irq/handle.c:246 [inline=
]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
                    handle_edge_irq+0x3ca/0x9b0 kernel/irq/chip.c:855
                    generic_handle_irq_desc include/linux/irqdesc.h:186 [in=
line]
                    handle_irq arch/x86/kernel/irq.c:262 [inline]
                    call_irq_handler arch/x86/kernel/irq.c:286 [inline]
                    __common_interrupt+0xd1/0x2f0 arch/x86/kernel/irq.c:333
                    common_interrupt+0x8d/0x110 arch/x86/kernel/irq.c:326
                    asm_common_interrupt+0x26/0x40
arch/x86/include/asm/idtentry.h:688
                    variable_ffs arch/x86/include/asm/bitops.h:312 [inline]
                    handle_softirqs+0x196/0x9b0 kernel/softirq.c:610
                    __do_softirq kernel/softirq.c:656 [inline]
                    invoke_softirq kernel/softirq.c:496 [inline]
                    __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
                    common_interrupt+0xf7/0x110 arch/x86/kernel/irq.c:326
                    asm_common_interrupt+0x26/0x40
arch/x86/include/asm/idtentry.h:688
                    __raw_spin_unlock_irq
include/linux/spinlock_api_smp.h:188 [inline]
                    _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.=
c:202
                    process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
                    process_scheduled_works kernel/workqueue.c:3371 [inline=
]
                    worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
                    kthread+0x38d/0x4a0 kernel/kthread.c:436
                    ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:2=
45
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
                   __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:132 [inline]
                   _raw_spin_lock_irqsave+0x3d/0x60
kernel/locking/spinlock.c:162
                   ata_dev_init+0x1b4/0x400 drivers/ata/libata-core.c:5547
                   ata_link_init+0x1a3/0x300 drivers/ata/libata-core.c:5592
                   ata_port_alloc+0x5d7/0x900 drivers/ata/libata-core.c:567=
3
                   ata_host_alloc+0x215/0x2d0 drivers/ata/libata-core.c:579=
4
                   ata_host_alloc_pinfo+0x2d/0x3e0
drivers/ata/libata-core.c:5835
                   ata_pci_sff_prepare_host+0x4c/0x100
drivers/ata/libata-sff.c:2228
                   ata_pci_bmdma_prepare_host+0x24/0x90
drivers/ata/libata-sff.c:3137
                   piix_init_one+0x576/0x1d00 drivers/ata/ata_piix.c:1704
                   local_pci_probe+0xdf/0x1b0 drivers/pci/pci-driver.c:323
                   pci_call_probe+0x176/0x7e0 drivers/pci/pci-driver.c:385
                   __pci_device_probe drivers/pci/pci-driver.c:446 [inline]
                   pci_device_probe+0x1d5/0x2c0 drivers/pci/pci-driver.c:48=
0
                   call_driver_probe drivers/base/dd.c:643 [inline]
                   really_probe+0x252/0xb20 drivers/base/dd.c:721
                   __driver_probe_device+0x3d3/0x4f0 drivers/base/dd.c:883
                   driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:913
                   __driver_attach+0x288/0x5f0 drivers/base/dd.c:1307
                   bus_for_each_dev+0x12c/0x1c0 drivers/base/bus.c:383
                   bus_add_driver+0x30f/0x6c0 drivers/base/bus.c:756
                   driver_register+0x162/0x4a0 drivers/base/driver.c:249
                   piix_init+0x20/0x50 drivers/ata/ata_piix.c:1774
                   do_one_initcall+0x10c/0x720 init/main.c:1381
                   do_initcall_level init/main.c:1443 [inline]
                   do_initcalls init/main.c:1459 [inline]
                   do_basic_setup init/main.c:1478 [inline]
                   kernel_init_freeable+0x5af/0x8d0 init/main.c:1691
                   kernel_init+0x1e/0x2d0 init/main.c:1581
                   ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:24=
5
 }
 ... key      at: [<ffffffff9b2873e0>] __key.5+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5=
825
                        __raw_read_lock
include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:=
228
                        __do_wait+0x105/0x880 kernel/exit.c:1678
                        do_wait+0x1e5/0x5f0 kernel/exit.c:1722
                        kernel_wait+0x9f/0x160 kernel/exit.c:1898
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inl=
ine]
                        call_usermodehelper_exec_work+0xf9/0x180
kernel/umh.c:163
                        process_one_work+0x9de/0x1c60 kernel/workqueue.c:32=
88
                        process_scheduled_works kernel/workqueue.c:3371 [in=
line]
                        worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
                        kthread+0x38d/0x4a0 kernel/kthread.c:436
                        ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c=
:158
                        ret_from_fork_asm+0x1a/0x30
arch/x86/entry/entry_64.S:245
     SOFTIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5=
825
                        __raw_read_lock
include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:=
228
                        __do_wait+0x105/0x880 kernel/exit.c:1678
                        do_wait+0x1e5/0x5f0 kernel/exit.c:1722
                        kernel_wait+0x9f/0x160 kernel/exit.c:1898
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inl=
ine]
                        call_usermodehelper_exec_work+0xf9/0x180
kernel/umh.c:163
                        process_one_work+0x9de/0x1c60 kernel/workqueue.c:32=
88
                        process_scheduled_works kernel/workqueue.c:3371 [in=
line]
                        worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
                        kthread+0x38d/0x4a0 kernel/kthread.c:436
                        ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c=
:158
                        ret_from_fork_asm+0x1a/0x30
arch/x86/entry/entry_64.S:245
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5868 [inline]
                       lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:58=
25
                       __raw_write_lock_irq
include/linux/rwlock_api_smp.h:211 [inline]
                       _raw_write_lock_irq+0x36/0x50
kernel/locking/spinlock.c:326
                       copy_process+0x4c9f/0x76d0 kernel/fork.c:2371
                       kernel_clone+0xea/0x8f0 kernel/fork.c:2655
                       user_mode_thread+0xc8/0x110 kernel/fork.c:2731
                       rest_init+0x23/0x2b0 init/main.c:725
                       start_kernel+0x3ed/0x4d0 init/main.c:1209
                       x86_64_start_reservations+0x18/0x30
arch/x86/kernel/head64.c:310
                       x86_64_start_kernel+0x13c/0x1a0
arch/x86/kernel/head64.c:291
                       common_startup_64+0x13e/0x148
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5868 [inl=
ine]
                            lock_acquire+0x1ba/0x360
kernel/locking/lockdep.c:5825
                            __raw_read_lock
include/linux/rwlock_api_smp.h:161 [inline]
                            _raw_read_lock+0x5f/0x70
kernel/locking/spinlock.c:228
                            __do_wait+0x105/0x880 kernel/exit.c:1678
                            do_wait+0x1e5/0x5f0 kernel/exit.c:1722
                            kernel_wait+0x9f/0x160 kernel/exit.c:1898
                            call_usermodehelper_exec_sync
kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xf9/0x180
kernel/umh.c:163
                            process_one_work+0x9de/0x1c60
kernel/workqueue.c:3288
                            process_scheduled_works
kernel/workqueue.c:3371 [inline]
                            worker_thread+0x693/0xeb0 kernel/workqueue.c:34=
52
                            kthread+0x38d/0x4a0 kernel/kthread.c:436
                            ret_from_fork+0x942/0xe50
arch/x86/kernel/process.c:158
                            ret_from_fork_asm+0x1a/0x30
arch/x86/entry/entry_64.S:245
   }
   ... key      at: [<ffffffff8e20c098>] tasklist_lock+0x18/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   send_sigurg+0xed/0xcf0 fs/fcntl.c:978
   sk_send_sigurg+0x76/0x360 net/core/sock.c:3669
   queue_oob net/unix/af_unix.c:2354 [inline]
   unix_stream_sendmsg+0xfd1/0x1350 net/unix/af_unix.c:2488
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg net/socket.c:742 [inline]
   ____sys_sendmsg+0x9ba/0xb20 net/socket.c:2592
   ___sys_sendmsg+0x11c/0x1b0 net/socket.c:2646
   __sys_sendmmsg+0x1f5/0x420 net/socket.c:2735
   __do_sys_sendmmsg net/socket.c:2762 [inline]
   __se_sys_sendmmsg net/socket.c:2759 [inline]
   __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2759
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5868 [inline]
                     lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
                     __raw_write_lock_irq
include/linux/rwlock_api_smp.h:211 [inline]
                     _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.=
c:326
                     __f_setown+0x60/0x3c0 fs/fcntl.c:136
                     generic_add_lease fs/locks.c:1908 [inline]
                     generic_setlease+0xb60/0x12f0 fs/locks.c:1984
                     kernel_setlease fs/locks.c:2031 [inline]
                     vfs_setlease+0x28d/0x380 fs/locks.c:2065
                     do_fcntl_add_lease+0x3b0/0x540 fs/locks.c:2086
                     fcntl_setlease+0xfa/0x180 fs/locks.c:2111
                     do_fcntl+0xfb4/0x1640 fs/fcntl.c:535
                     __do_sys_fcntl fs/fcntl.c:602 [inline]
                     __se_sys_fcntl fs/fcntl.c:587 [inline]
                     __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:=
94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5868 [inlin=
e]
                          lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c=
:5825
                          __raw_read_lock_irqsave
include/linux/rwlock_api_smp.h:172 [inline]
                          _raw_read_lock_irqsave+0x78/0xa0
kernel/locking/spinlock.c:236
                          send_sigurg+0x60/0xcf0 fs/fcntl.c:962
                          sk_send_sigurg+0x76/0x360 net/core/sock.c:3669
                          queue_oob net/unix/af_unix.c:2354 [inline]
                          unix_stream_sendmsg+0xfd1/0x1350
net/unix/af_unix.c:2488
                          sock_sendmsg_nosec net/socket.c:727 [inline]
                          __sock_sendmsg net/socket.c:742 [inline]
                          ____sys_sendmsg+0x9ba/0xb20 net/socket.c:2592
                          ___sys_sendmsg+0x11c/0x1b0 net/socket.c:2646
                          __sys_sendmmsg+0x1f5/0x420 net/socket.c:2735
                          __do_sys_sendmmsg net/socket.c:2762 [inline]
                          __se_sys_sendmmsg net/socket.c:2759 [inline]
                          __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2759
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [in=
line]
                          do_syscall_64+0x11b/0xf80
arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff9afcc660>] __key.1+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x78/0xa0 kernel/locking/spinlock.c:236
   send_sigio+0x31/0x3e0 fs/fcntl.c:918
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x218/0x520 fs/fcntl.c:1152
   lease_break_callback+0x23/0x30 fs/locks.c:577
   __break_lease+0x7d2/0x18b0 fs/locks.c:1657
   break_lease include/linux/filelock.h:484 [inline]
   break_lease include/linux/filelock.h:469 [inline]
   do_dentry_open+0x10df/0x1680 fs/open.c:940
   vfs_open+0x82/0x3f0 fs/open.c:1081
   do_open fs/namei.c:4677 [inline]
   path_openat+0x1fc5/0x2cf0 fs/namei.c:4836
   do_file_open+0x216/0x470 fs/namei.c:4865
   do_sys_openat2+0xe6/0x250 fs/open.c:1366
   do_sys_open fs/open.c:1372 [inline]
   __do_sys_creat fs/open.c:1450 [inline]
   __se_sys_creat fs/open.c:1444 [inline]
   __x64_sys_creat+0xcc/0x120 fs/open.c:1444
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
                   __raw_write_lock_irq
include/linux/rwlock_api_smp.h:211 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:=
326
                   fasync_insert_entry+0x1cd/0x2a0 fs/fcntl.c:1059
                   lease_setup+0x9d/0x160 fs/locks.c:592
                   generic_add_lease fs/locks.c:1908 [inline]
                   generic_setlease+0xb60/0x12f0 fs/locks.c:1984
                   kernel_setlease fs/locks.c:2031 [inline]
                   vfs_setlease+0x28d/0x380 fs/locks.c:2065
                   do_fcntl_add_lease+0x3b0/0x540 fs/locks.c:2086
                   fcntl_setlease+0xfa/0x180 fs/locks.c:2111
                   do_fcntl+0xfb4/0x1640 fs/fcntl.c:535
                   __do_sys_fcntl fs/fcntl.c:602 [inline]
                   __se_sys_fcntl fs/fcntl.c:587 [inline]
                   __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5=
825
                        __raw_read_lock_irqsave
include/linux/rwlock_api_smp.h:172 [inline]
                        _raw_read_lock_irqsave+0x78/0xa0
kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1135 [inline]
                        kill_fasync fs/fcntl.c:1159 [inline]
                        kill_fasync+0x137/0x520 fs/fcntl.c:1152
                        lease_break_callback+0x23/0x30 fs/locks.c:577
                        __break_lease+0x7d2/0x18b0 fs/locks.c:1657
                        break_lease include/linux/filelock.h:484 [inline]
                        break_lease include/linux/filelock.h:469 [inline]
                        do_dentry_open+0x10df/0x1680 fs/open.c:940
                        vfs_open+0x82/0x3f0 fs/open.c:1081
                        do_open fs/namei.c:4677 [inline]
                        path_openat+0x1fc5/0x2cf0 fs/namei.c:4836
                        do_file_open+0x216/0x470 fs/namei.c:4865
                        do_sys_openat2+0xe6/0x250 fs/open.c:1366
                        do_sys_open fs/open.c:1372 [inline]
                        __do_sys_creat fs/open.c:1450 [inline]
                        __se_sys_creat fs/open.c:1444 [inline]
                        __x64_sys_creat+0xcc/0x120 fs/open.c:1444
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inli=
ne]
                        do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64=
.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9afcc620>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x78/0xa0 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1135 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x137/0x520 fs/fcntl.c:1152
   sg_rq_end_io+0x694/0xe90 drivers/scsi/sg.c:1402
   __blk_mq_end_request+0x1d9/0x3c0 block/blk-mq.c:1168
   scsi_end_request+0x46a/0x9f0 drivers/scsi/scsi_lib.c:680
   scsi_io_completion+0x179/0x17b0 drivers/scsi/scsi_lib.c:1088
   scsi_complete+0x4d9/0x6d0 drivers/scsi/scsi_lib.c:1568
   blk_mq_complete_request block/blk-mq.c:1356 [inline]
   blk_mq_complete_request+0x8b/0xb0 block/blk-mq.c:1353
   scsi_done_internal+0x36f/0x450 drivers/scsi/scsi_lib.c:1754
   ata_scsi_translate drivers/ata/libata-scsi.c:1888 [inline]
   __ata_scsi_queuecmd+0x103b/0x16a0 drivers/ata/libata-scsi.c:4471
   ata_scsi_queuecmd+0xad/0x170 drivers/ata/libata-scsi.c:4517
   scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1647 [inline]
   scsi_queue_rq+0x1707/0x38f0 drivers/scsi/scsi_lib.c:1904
   blk_mq_dispatch_rq_list+0x3dd/0x1bc0 block/blk-mq.c:2148
   __blk_mq_sched_dispatch_requests+0x215/0x1470 block/blk-mq-sched.c:299
   blk_mq_sched_dispatch_requests+0xd7/0x1b0 block/blk-mq-sched.c:329
   blk_mq_run_hw_queue+0x3da/0x650 block/blk-mq.c:2386
   blk_execute_rq_nowait+0x156/0x200 block/blk-mq.c:1461
   sg_common_write.constprop.0+0xac4/0x1d40 drivers/scsi/sg.c:830
   sg_new_write.isra.0+0x58e/0xb40 drivers/scsi/sg.c:769
   sg_ioctl_common drivers/scsi/sg.c:933 [inline]
   sg_ioctl+0x98a/0x2770 drivers/scsi/sg.c:1158
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl fs/ioctl.c:583 [inline]
   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 0 PID: 94929 Comm: syz-executor.14 Tainted: G
L      7.0.6 #1 PREEMPT(full)
Tainted: [L]=3DSOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage+0x869/0xb70 kernel/locking/lockdep.c:2857
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15ff/0x2740 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1ba/0x360 kernel/locking/lockdep.c:5825
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
 _raw_read_lock_irqsave+0x78/0xa0 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1135 [inline]
 kill_fasync fs/fcntl.c:1159 [inline]
 kill_fasync+0x137/0x520 fs/fcntl.c:1152
 sg_rq_end_io+0x694/0xe90 drivers/scsi/sg.c:1402
 __blk_mq_end_request+0x1d9/0x3c0 block/blk-mq.c:1168
 scsi_end_request+0x46a/0x9f0 drivers/scsi/scsi_lib.c:680
 scsi_io_completion+0x179/0x17b0 drivers/scsi/scsi_lib.c:1088
 scsi_complete+0x4d9/0x6d0 drivers/scsi/scsi_lib.c:1568
 blk_mq_complete_request block/blk-mq.c:1356 [inline]
 blk_mq_complete_request+0x8b/0xb0 block/blk-mq.c:1353
 scsi_done_internal+0x36f/0x450 drivers/scsi/scsi_lib.c:1754
 ata_scsi_translate drivers/ata/libata-scsi.c:1888 [inline]
 __ata_scsi_queuecmd+0x103b/0x16a0 drivers/ata/libata-scsi.c:4471
 ata_scsi_queuecmd+0xad/0x170 drivers/ata/libata-scsi.c:4517
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1647 [inline]
 scsi_queue_rq+0x1707/0x38f0 drivers/scsi/scsi_lib.c:1904
 blk_mq_dispatch_rq_list+0x3dd/0x1bc0 block/blk-mq.c:2148
 __blk_mq_sched_dispatch_requests+0x215/0x1470 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xd7/0x1b0 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x3da/0x650 block/blk-mq.c:2386
 blk_execute_rq_nowait+0x156/0x200 block/blk-mq.c:1461
 sg_common_write.constprop.0+0xac4/0x1d40 drivers/scsi/sg.c:830
 sg_new_write.isra.0+0x58e/0xb40 drivers/scsi/sg.c:769
 sg_ioctl_common drivers/scsi/sg.c:933 [inline]
 sg_ioctl+0x98a/0x2770 drivers/scsi/sg.c:1158
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x471ecd
Code: c3 e8 17 28 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa642fe3058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059bf80 RCX: 0000000000471ecd
RDX: 0000000020000480 RSI: 0000000000002285 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059bf8c
R13: 000000000000000b R14: 000000000059bf80 R15: 00007fa642fc3000
 </TASK>

Niklas Cassel <cassel@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C 20:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 09, 2026 at 07:39:30PM +0800, Longxing Li wrote:
> > Dear Linux kernel developers and maintainers,
> >
> > We would like to report a new kernel bug found by our tool. possible
> > deadlock in ata_bmdma_interrupt. Details are as follows.
> >
> > Kernel commit: v7.0.6
> > Kernel config: see attachment
> > report: see attachment
> >
> > We are currently analyzing the root cause and  working on a
> > reproducible PoC. We will provide further updates in this thread as
> > soon as we have more information.
> >
> > Best regards,
> > Longxing Li
> >
> > report:
> > https://drive.google.com/file/d/1krb648PgTy0zRrwtf-cV7ahPwvaT9mv_/view?=
usp=3Ddrive_link
>
> Hello Longxing Li,
>
>
> Thank you for the report.
>
> However, please send the report itself as plain text, to the mailing list=
.
>
>
> Kind regards,
> Niklas
