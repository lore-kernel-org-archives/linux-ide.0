Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A171B85CC
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155888; cv=none; b=LSv7Ml/sJK6davpW64f9h7lMCnoCr9bqT/GpO4dFBEAlMp6sj5phNDX/iLfXVQqjDzv5Yp6zI3quDEwwh2YdNB5xO85xqU5YFvj5BzY6zmI+Gk+6QLefgQ2bVS2vzl04I87UBQiGbJHEUOb6B4HodDLDissOf/1DCkpWAohSMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155888; c=relaxed/simple;
	bh=R2V0e9FEXed2L/7xTmU6LuaMnvhpXnyOxXltXB8p6X8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JDkJ8u6EJGaBCeM7b52eFal0vu9P+rnUfOsdue0nWBylNpCGsdVefPn3qJmxIKwdcbXipAdwBad36VjVGOGsl/yM8rAEXW9yg00g9L6qUuyRrtVtfAyq35m3tuAA4KUeZCxWZIkHUuoMU111hl2QxA1xWfSkHfVns89QWtUEHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f53b1932aso58309405ab.3
        for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2024 22:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727155885; x=1727760685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3TIXU1ErVxNr9c4jDbjvWr5jcW27kWn5wluIIcPfBw=;
        b=aEo2xHGrsE0SDzGQWgUQ3SPkRlka0BgD5nDd0/H0KfZVnynQCvATFaCzKTf6P0Wa8s
         E3SR8KTVqEdsBv/T0t+FlL3WxdwcKkfsMF3HheOkIsl/RkfJEvJWZVYLeCPfFN6Za9Lt
         0pCZyxTzzoykXI6T8OEhH5U10XyrwsEFsEchd0x8G9fUEnvh00UTE1cnrukLYHzUSO+D
         jVegrQamlRAedTUeLvErLYC3BE5EnCO/+zJG2zE7aD9N2ztPFckpT5HX8NJVQYI5ytaY
         b2oYXp1nU8MQobgS30jxIxdZHPWA3h1tlF6NPNeyDo4h5mN+tqDheBsXV5lZNrhdETX/
         cARA==
X-Forwarded-Encrypted: i=1; AJvYcCV9dXXLyT9a85GSoEpxw/jnwKhmRmBjBghX6HJRFfVUqvI7hbkeKlXUeH0uQL2p4Uv/9PtFGwKbAPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1aKQOZjTmD6DWh+3pSa05yEXrPfd8ixZSD//SMhxQetRXef8
	r5aC9CoVqMyo9sKONqfuNcQxNbjXNa5jXbma9XQFjc6Zi9brb9QlkfhfBQTTnPhriWwXMe8LG/n
	PzlsTyKwqSYIAJUClIt/Asknou8pDk8QVlieeKCt+z9xyBWDjLZfESJc=
X-Google-Smtp-Source: AGHT+IEFFhkNDQoxk5ZxpQqlM0T7+36cV7ch6J+J8pKGSd0bAGhU73gwd2lHO5CEIxR7aWwOhG7KhDK/QacGvqaBqJPkWrh5mOWW
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:9b27:7d52 with SMTP id
 e9e14a558f8ab-3a0c8d39690mr109208215ab.20.1727155885548; Mon, 23 Sep 2024
 22:31:25 -0700 (PDT)
Date: Mon, 23 Sep 2024 22:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f24ead.050a0220.c23dd.001d.GAE@google.com>
Subject: [syzbot] [ide?] general protection fault in ata_msense_control_spgt2
From: syzbot <syzbot+fb415bc0af1b572478e1@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    baeb9a7d8b60 Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129b7f00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d3981d50a2855c2
dashboard link: https://syzkaller.appspot.com/bug?extid=fb415bc0af1b572478e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-baeb9a7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02c319355ed9/vmlinux-baeb9a7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41f9f78e928c/bzImage-baeb9a7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb415bc0af1b572478e1@syzkaller.appspotmail.com

program syz.1.2960 is using a deprecated SCSI ioctl, please convert it to SG_IO
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 13886 Comm: syz.1.2960 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ata_msense_control_spgt2.isra.0+0x4ce/0x610 drivers/ata/libata-scsi.c:2276
Code: 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 23 70 92 fb 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 12 01 00 00
RSP: 0018:ffffc900034d74f0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffffffff9a8cbffc RCX: ffffc900062e1000
RDX: 0000000000000000 RSI: ffffffff85fa94fd RDI: 0000000000000001
RBP: 0000000000000007 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff888026e72df8 R15: 00000000000000ff
FS:  00007f42191ff6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3efc33 CR3: 000000002a25a000 CR4: 0000000000350ef0
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
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1608 [inline]
 scsi_queue_rq+0x1273/0x3650 drivers/scsi/scsi_lib.c:1850
 blk_mq_dispatch_rq_list+0x443/0x1dc0 block/blk-mq.c:2032
 __blk_mq_sched_dispatch_requests+0x219/0x1620 block/blk-mq-sched.c:301
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2245
 blk_execute_rq+0x198/0x410 block/blk-mq.c:1398
 sg_scsi_ioctl drivers/scsi/scsi_ioctl.c:593 [inline]
 scsi_ioctl+0x983/0x1840 drivers/scsi/scsi_ioctl.c:901
 sg_ioctl_common drivers/scsi/sg.c:1109 [inline]
 sg_ioctl+0xaf3/0x2750 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18d/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f421977def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f42191ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4219935f80 RCX: 00007f421977def9
RDX: 0000000020000380 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 00007f42197f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4219935f80 R15: 00007ffcd901abf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ata_msense_control_spgt2.isra.0+0x4ce/0x610 drivers/ata/libata-scsi.c:2276
Code: 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 23 70 92 fb 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 12 01 00 00
RSP: 0018:ffffc900034d74f0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffffffff9a8cbffc RCX: ffffc900062e1000
RDX: 0000000000000000 RSI: ffffffff85fa94fd RDI: 0000000000000001
RBP: 0000000000000007 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff888026e72df8 R15: 00000000000000ff
FS:  00007f42191ff6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3efc33 CR3: 000000002a25a000 CR4: 0000000000350ef0
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
  13:	e8 23 70 92 fb       	call   0xfb92703b
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
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
