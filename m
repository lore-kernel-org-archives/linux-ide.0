Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8815D5C1
	for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419225; cv=none; b=bG5sL4rlYcNHLf/3mnOosbFAam2ROxGVMygX3h6pkczddU/szlAjJ0w+xvAwrJRYuPo2OFfxyiqu+sPwYbNPU+LLcapskLME9Yw2IwCqqOjlbX+xnc2gIjq6mk6Ly9gMnXthE9AvADOP7u+y0G+phyJAqflwpY6gb/ceWQ06SS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419225; c=relaxed/simple;
	bh=BFbPxhiLL3u740JeDOzsv8dfqldH8It/jattDFPGs6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fGinSJSPipEAnNhz4UQX7SPI136Di1xgd1NxbzWiEpOPdWd0V1C2Iz8+pjPYDKxwePQMjBWt1TbII/Ccy8HswCoDoPJOeF85MAzMABKTPK09jlRYdXUfrXQCnmSbvrZKPe5wf/yz93HZCt3cV+AgvWhcS82z/uJrpiKnk9+ge2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3412ecb29so16410075ab.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2024 23:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727419222; x=1728024022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LmyZ7ZlkrjTKkraSmB5uOTOQZj0ZwOqJs9k2gnjG7U=;
        b=aFuPsaoVB+dBTylsAiKURor5edgVC4O8REGFBbnU4Q95djzi4j8w35RUOYMTgf5y+A
         I6peCQ+P427KUxDh6RwcIeSHcvCQMPb2JCugBRT2tcZMr5W5OoOinFaF8HVnHGEFYceR
         0Pp1MZCNs9nWk2i4wABJy/edzkXzgPKxEBPTznULLDF9AK+rLXzUDWluMjhJjcG35LcH
         H2NHCYHkCrlpz5ZA5R09hredHzhjmYG5hrJsicMvDJFkBvEFr4JGH17FPwmb3fU6lyOJ
         TgU8+y1nTCe0fy5WifrtdD9pkxn/jq6hst1wkV5nE6/fKTtsN8/nq/WMjXxnvGtm3ORg
         ECEw==
X-Forwarded-Encrypted: i=1; AJvYcCUydMbHjaYeJvI6kErEVnQWDa33tBMoBCdUDRMO6nG4XmeuOVFuGwo9gTWQCe01jdXtvxU7YtaeVlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwa3jbIvhxrDSZ33VrsYGLICmsHJfqe9qw7vKTzScjCa1IxkgW
	8xPf0VbXoFwL2+F0MD0Wi9MbNF8Jixs2uV2rIfffN+oKQP1uEkn21RLjkAZXuYYTGxMBZ1tv0aa
	tJCvFZ7qX3TVVyJ9dvF66jFMTLmWtmeYRZMprw1yYCFOFJnLfVmTdELw=
X-Google-Smtp-Source: AGHT+IFLE0lf8txTQE+1pBUd8/yIGG5ZmXUUyMsnHbYAg5/fq5Y6xZRCew6gxnFvvGLIqIbN2HMTMLm8vU40whagSGw0oRMrRu9R
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a1:a69f:939a with SMTP id
 e9e14a558f8ab-3a34518428amr19837345ab.13.1727419222658; Thu, 26 Sep 2024
 23:40:22 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:40:22 -0700
In-Reply-To: <66f24ead.050a0220.c23dd.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f65356.050a0220.38ace9.000e.GAE@google.com>
Subject: Re: [syzbot] [ide?] general protection fault in ata_msense_control_spgt2
From: syzbot <syzbot+fb415bc0af1b572478e1@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a2ba80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27f034e5d7e70892
dashboard link: https://syzkaller.appspot.com/bug?extid=fb415bc0af1b572478e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13646aa9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed9e27980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75cd1cf4fe64/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/737a03861f46/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb415bc0af1b572478e1@syzkaller.appspotmail.com

program syz-executor248 is using a deprecated SCSI ioctl, please convert it to SG_IO
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5316 Comm: syz-executor248 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ata_msense_control_spgt2.isra.0+0x4ce/0x610 drivers/ata/libata-scsi.c:2276
Code: 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 a3 3c 8e fb 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 12 01 00 00
RSP: 0018:ffffc9000568f4f0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffffffff9aaf34fc RCX: ffffffff85feb145
RDX: 0000000000000000 RSI: ffffffff85feb51d RDI: 0000000000000001
RBP: 0000000000000007 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff888027032df8 R15: 00000000000000ff
FS:  00005555661e1380(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000048 CR3: 0000000025686000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ata_msense_control+0x1a4/0x6e0 drivers/ata/libata-scsi.c:2358
 ata_scsiop_mode_sense drivers/ata/libata-scsi.c:2474 [inline]
 ata_scsi_rbuf_fill drivers/ata/libata-scsi.c:1815 [inline]
 ata_scsi_simulate+0xcff/0x34c0 drivers/ata/libata-scsi.c:4316
 __ata_scsi_queuecmd+0xb35/0x13c0 drivers/ata/libata-scsi.c:4191
 ata_scsi_queuecmd+0xac/0x160 drivers/ata/libata-scsi.c:4234
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1602 [inline]
 scsi_queue_rq+0x1273/0x3650 drivers/scsi/scsi_lib.c:1844
 blk_mq_dispatch_rq_list+0x443/0x1dc0 block/blk-mq.c:2030
 __blk_mq_sched_dispatch_requests+0x219/0x1620 block/blk-mq-sched.c:301
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2243
 blk_execute_rq+0x198/0x410 block/blk-mq.c:1396
 sg_scsi_ioctl drivers/scsi/scsi_ioctl.c:593 [inline]
 scsi_ioctl+0x983/0x1840 drivers/scsi/scsi_ioctl.c:901
 sg_ioctl_common drivers/scsi/sg.c:1109 [inline]
 sg_ioctl+0xaf3/0x2750 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f930cc8a0e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca36a1418 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffca36a15e8 RCX: 00007f930cc8a0e9
RDX: 0000000020000380 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f930ccfd610 R08: 002367732f766564 R09: 00007ffca36a15e8
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffca36a15d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ata_msense_control_spgt2.isra.0+0x4ce/0x610 drivers/ata/libata-scsi.c:2276
Code: 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 a3 3c 8e fb 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 12 01 00 00
RSP: 0018:ffffc9000568f4f0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffffffff9aaf34fc RCX: ffffffff85feb145
RDX: 0000000000000000 RSI: ffffffff85feb51d RDI: 0000000000000001
RBP: 0000000000000007 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff888027032df8 R15: 00000000000000ff
FS:  00005555661e1380(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000048 CR3: 0000000025686000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 83 c4 08          	add    $0x8,%rsp
   4:	5b                   	pop    %rbx
   5:	5d                   	pop    %rbp
   6:	41 5c                	pop    %r12
   8:	41 5d                	pop    %r13
   a:	41 5e                	pop    %r14
   c:	41 5f                	pop    %r15
   e:	c3                   	ret
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	e8 a3 3c 8e fb       	call   0xfb8e3cbb
  18:	4c 89 e2             	mov    %r12,%rdx
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2d:	4c 89 e2             	mov    %r12,%rdx
  30:	83 e2 07             	and    $0x7,%edx
  33:	38 d0                	cmp    %dl,%al
  35:	7f 08                	jg     0x3f
  37:	84 c0                	test   %al,%al
  39:	0f 85 12 01 00 00    	jne    0x151


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
