Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7A4A00
	for <linux-ide@vger.kernel.org>; Thu,  2 Jan 2025 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735784237; cv=none; b=o+qFBLxk176AS/6Jr1ditChxvyK27yZmn3zAI8tQ3E4Odn1KxQR/nrn+b8i3KgoIBOyjed63J+IUlwhrqnv218P6JwYEW++9yOec5l5wgFfT5V6ziZ2a6KgR7OcxF+5m/YkDjLplerXr2mZqlwrEHm6dnDeuhygl19jFxcjvgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735784237; c=relaxed/simple;
	bh=+NDiXG6euTPWrtk/84BKJDYBzJ7PujBrr8Oj9WGsS+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B5GPm3lanmYUsaZU7X8laP9k2gZ/bjEwWDPa4j5VGt1oMtBH/g8kgnyMr+sipIjhHlaC++dGaPxSCNz2fP3rgYarp92FhtxBXky/jFrQb722iCR/AB6CpdddeuDWgpsGN8Mov0zw0+GJ+fW58WsipzGWCwCvcCYxcl8PqCMIwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTHLjU42; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTHLjU42"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d91653e9d7so97203076d6.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jan 2025 18:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735784233; x=1736389033; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bU4vNE6hwgGbrVBZqW3CHYB/DL8tPQwk53wzjoJKdj8=;
        b=JTHLjU42RuhFvtbu1NG2dgA2RBA9M5JtLFGOp4+O7Ok+mk1cLo2+IfU9OPYkN/OOvb
         W+VO3D/aYZYiX0YnEihPwnzwhqmc6XBa0yMFKrYhRDsP5jCEmISb4Kv3HL7MqhNyhlhU
         KL8R+A0YmbSkWAlyp/AJVKJxCNZxQXmmx44Z6N+NvdJStF7iXkrDy3Dp1r6dzZnVnQVd
         6rtal9xOftGIqzKYp3LFXSjqfB41absFAiUGjyRqcDQmT1Zk1XaCkQumPyosvChUvTly
         vysmVt//hWu4p6kJYvPD8Zart9Raz1JkYsEPPzH/UNsLJtC5K8HuIdSKeOlkUp65chrM
         yW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735784233; x=1736389033;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU4vNE6hwgGbrVBZqW3CHYB/DL8tPQwk53wzjoJKdj8=;
        b=Wxke5CAw7NV8macgD4nxe3/Sq+9lKRcufT0R+Bo5gTP5HFATx+79Jcrf843ep8nU1Q
         UwJB/RW9zS0tMRgpgOJEnIRFShyNQib6D+alk0s/NdITbB6XE0B0STAigw0oW+DhfPCK
         l+HrAe7MTewR4RV/XY3rwhb0/T18RaQM9734yXYemp+ZEx0Cl9Kwku5eJXNWCSkmlWCN
         0x7eDWMbwjvPSqlfUwEEAt9TrIsv9eHkbkKI/U+spDc6d3vL42KOW3B4aXLkftYUkyJt
         PFgAsPnlZb7dXb0Z4DNMFDOkKxowqLf/E7LHOY5JaJ72fW/0C4ARRe5Dd8SCEz4QpQkV
         PlzA==
X-Forwarded-Encrypted: i=1; AJvYcCVulrQCroGFudzyrjkU/Gp50SHi1q2NvM8w6GCEb1Kag9e0VB/Qs//9R4pA8+7yepsiwsZI/mPzNes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPf78yL6Fs6GkPlh3ibdgLiCCIqEnVhDsu3S8usvpJwPJkC1bF
	iQdLXCvWcJoOwcGmx2xHjAMw7AcKkl6KyNjIXPK4L2yAdCOEt2Awrcpx0Ul3DEtJeBWsJb4nECR
	nwIwnAAEXN+Bl+BZyGDpUOW8yW5tOUDOT
X-Gm-Gg: ASbGncusTJxeWEhHuBJNXp+riVDN9yWRAqJU8JmoKRvgHCzLgNsQusKkxmSZiIv/njX
	KjMVCju8aOMUTl3HBoZc99aPRqprpODQalpsgMqt9
X-Google-Smtp-Source: AGHT+IHm0gNoaiuj3OPiwB94JkyB2EdjLbCKFiSD16TRHmh56f3l8pdrmKLH2XN3qzOkisdfxsB11+V/hvP5Efgx3yU=
X-Received: by 2002:ad4:5c4b:0:b0:6d8:a70d:5e48 with SMTP id
 6a1803df08f44-6dd2339fdeamr646172626d6.30.1735784233297; Wed, 01 Jan 2025
 18:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Wed, 1 Jan 2025 21:17:02 -0500
Message-ID: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
Subject: out-of-bounds write in the function ata_pio_sector
To: damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

We found an out-of-bounds write in the function ata_pio_sector, which can cause
the kernel to crash. We would like to report it for your reference.

## Problem in ata_pio_sector
ata_pio_sector uses the following code to decide which page to use for the I/O:
page = sg_page(qc->cursg);
offset = qc->cursg->offset + qc->cursg_ofs;

/* get the current page and offset */
page = nth_page(page, (offset >> PAGE_SHIFT));
offset %= PAGE_SIZE;
but we found that `offset` could be as high as 0x5000---qc->cursg_ofs==0x5000,
qc->cursg->offset == 0x0, making `page` point to a higher-position page that
belongs to other threads.

## Example crash
This out-of-bound write can cause the kernel to crash at arbitrary places,
depending on when the corrupted page is accessed by the other thread.

We found this problem can happen in Linux kernel 6.1~6.12. Here is one crash in
Linux kernel 6.1:
executing program
[   15.461899] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[   79.990338] ata1: lost interrupt (Status 0x58)
[   80.510447] ata1: found unknown device (class 0)
[   80.519176] BUG: kernel NULL pointer dereference, address: 0000000000000030
[   80.527336] #PF: supervisor read access in kernel mode
[   80.533045] #PF: error_code(0x0000) - not-present page
[   80.538614] PGD 0 P4D 0
[   80.543339] Oops: 0000 [#1] PREEMPT SMP PTI
[   80.547027] CPU: 0 PID: 195 Comm: syz-executor Not tainted
6.1.0-rc7-g29106f2b0871 #774
[   80.551328] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   80.555779] RIP: 0010:do_exit+0x34a/0xa40
[   80.557528] Code: 08 4c 89 64 24 10 e8 15 ec 7e 00 48 8b 93 78 05
00 00 48 8d 83 78 05 00 00 48 39 c2 0f 85 7e 05 00 00 48 89 df e8 26
7e 01 00 <48> 8b 68 30 49 89 c5 48 39 e0
[   80.562666] RSP: 0018:ffffc900004cbd80 EFLAGS: 00010046
[   80.564524] RAX: 0000000000000000 RBX: ffff888003b30f80 RCX: 0000000000000000
[   80.566399] RDX: 0000000000000000 RSI: ffff888003ec84a8 RDI: ffff888003b30f80
[   80.568231] RBP: ffff888003d003c0 R08: ffff888003b31870 R09: ffffc900004cbcb0
[   80.570042] R10: ffff888003b08090 R11: fffffffffffcc2c7 R12: ffffc900004cbd88
[   80.571629] R13: ffff888003d00420 R14: ffff888003b30f01 R15: ffff888003b31768
[   80.573237] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000)
knlGS:0000000000000000
[   80.574916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.576221] CR2: 0000000000000030 CR3: 000000000220a000 CR4: 0000000000350eb0
[   80.577652] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   80.579075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   80.580435] Call Trace:
[   80.581092]  <TASK>
[   80.581704]  do_group_exit+0x28/0x80
[   80.582514]  get_signal+0x8de/0x910
[   80.583309]  ? sg_ioctl+0x331/0xb20
[   80.584112]  arch_do_signal_or_restart+0x1b/0x660
[   80.585093]  ? __x64_sys_ioctl+0x178/0x9b0
[   80.585973]  ? handle_mm_fault+0x6a/0x1b0
[   80.586817]  exit_to_user_mode_prepare+0x89/0x150
[   80.587766]  syscall_exit_to_user_mode+0x1d/0x40
[   80.588739]  do_syscall_64+0x50/0x90
[   80.589572]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   80.590552] RIP: 0033:0x7f5e0333aaad
[   80.591358] Code: Unable to access opcode bytes at 0x7f5e0333aa83.
[   80.592529] RSP: 002b:00007ffc19613458 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   80.593999] RAX: 0000000000000002 RBX: 00007ffc19613480 RCX: 00007f5e0333aaad
[   80.595319] RDX: 0000000020000040 RSI: 0000000000000001 RDI: 0000000000000003
[   80.596569] RBP: 0000000000000000 R08: 0000000000000012 R09: 0000000000000000
[   80.597824] R10: 00007f5e0338803c R11: 0000000000000246 R12: 00007ffc19613490
[   80.599134] R13: 00007f5e033b2df0 R14: 0000000000000000 R15: 0000000000000000
[   80.600467]  </TASK>
[   80.601090] Modules linked in:
[   80.602009] CR2: 0000000000000030
[   80.602904] ---[ end trace 0000000000000000 ]---
[   80.603834] RIP: 0010:do_exit+0x34a/0xa40
[   80.604703] Code: 08 4c 89 64 24 10 e8 15 ec 7e 00 48 8b 93 78 05
00 00 48 8d 83 78 05 00 00 48 39 c2 0f 85 7e 05 00 00 48 89 df e8 26
7e 01 00 <48> 8b 68 30 49 89 c5 48 39 e0
[   80.607601] RSP: 0018:ffffc900004cbd80 EFLAGS: 00010046
[   80.608740] RAX: 0000000000000000 RBX: ffff888003b30f80 RCX: 0000000000000000
[   80.610073] RDX: 0000000000000000 RSI: ffff888003ec84a8 RDI: ffff888003b30f80
[   80.611394] RBP: ffff888003d003c0 R08: ffff888003b31870 R09: ffffc900004cbcb0
[   80.612717] R10: ffff888003b08090 R11: fffffffffffcc2c7 R12: ffffc900004cbd88
[   80.614027] R13: ffff888003d00420 R14: ffff888003b30f01 R15: ffff888003b31768
[   80.615335] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000)
knlGS:0000000000000000
[   80.616721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.617845] CR2: 0000000000000030 CR3: 000000000220a000 CR4: 0000000000350eb0
[   80.619171] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   80.620385] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   80.621706] note: syz-executor[195] exited with preempt_count 1
[   80.622850] Fixing recursive fault but reboot is needed!
[   80.623910] BUG: scheduling while atomic: syz-executor/195/0x00000000
[   80.625128] Modules linked in:
[   80.626096] Preemption disabled at:
[   80.626202] [<0000000000000000>] 0x0
[   80.627687] CPU: 0 PID: 195 Comm: syz-executor Tainted: G      D
        6.1.0-rc7-g29106f2b0871 #774
[   80.629278] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   80.631147] Call Trace:
[   80.631834]  <TASK>
[   80.632459]  dump_stack_lvl+0x33/0x46
[   80.633285]  __schedule_bug.cold+0x7d/0x8e
[   80.634181]  __schedule+0x63b/0x700
[   80.634986]  ? _printk+0x43/0x49
[   80.635775]  do_task_dead+0x3f/0x50
[   80.636575]  make_task_dead.cold+0x51/0xab
[   80.637446]  rewind_stack_and_make_dead+0x17/0x20
[   80.638434] RIP: 0033:0x7f5e0333aaad
[   80.639306] Code: Unable to access opcode bytes at 0x7f5e0333aa83.
[   80.640466] RSP: 002b:00007ffc19613458 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   80.641901] RAX: 0000000000000002 RBX: 00007ffc19613480 RCX: 00007f5e0333aaad
[   80.643213] RDX: 0000000020000040 RSI: 0000000000000001 RDI: 0000000000000003
[   80.644474] RBP: 0000000000000000 R08: 0000000000000012 R09: 0000000000000000
[   80.645789] R10: 00007f5e0338803c R11: 0000000000000246 R12: 00007ffc19613490
[   80.647105] R13: 00007f5e033b2df0 R14: 0000000000000000 R15: 0000000000000000
[   80.648441]  </TASK>
