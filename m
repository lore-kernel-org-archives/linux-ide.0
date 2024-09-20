Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D313D28A
	for <linux-ide@vger.kernel.org>; Fri, 20 Sep 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846348; cv=none; b=nVNxqb29Qk4gpyG2rZZdwH1DNkb7K0dCC1nFvgCz/ptMzu00z+xf7ozsIdChz/iJB1nYlyffIwHMB6kC24hf4t64X0l7Lok/+c4FT4cgm/Z0ccoHK5y7kDcwNnrcXTSMpPg0QfO5XmeHBDjaHBkHNASqrI3ABzAdnGqCjD1G2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846348; c=relaxed/simple;
	bh=uS/xK6WHlL3yd8HxVpgZrrLaaPnP5yYeifjuIKC26K0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hltVxONzEHdFp582Noseg0AwIZOrwSYDvyPn4xXYUyWaDv18IvebkTzA4WDiM0thojOcEbJaxobHZJh5YgfLcptBB+daDXnFQLOYWTWgM8IC7r7d13vh+HIp3bfKqZ0KMicQFcC4CH6A1gJrKlIUzQceUd8QoBNsYr/R/JR35Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso6162485ab.0
        for <linux-ide@vger.kernel.org>; Fri, 20 Sep 2024 08:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846346; x=1727451146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnd/VtqZ/fRhOhshf5rIh52ojkBprD6Sw3Rj/+8cUw8=;
        b=UFMVTn4heF9yV5DEGIiXJf9jpZJY6z2/VumlyVTgYIqFRbrDO5Mx5QoC+r3+NNqdcn
         Fj8NBhie1X5f5LRVOR5Jgmmom1tKSJEdhj+ZhkfHIao/oxSsr2hVqjCcRt56V06+j5qJ
         W9C2YRUAA9kfYaZFTP8YLc1/wOiLvGVBe0JtAh1v0ktqKr9BoY7AAuXsQeJcl+cA1NWm
         yBAvTPIUAZvI7vp8nl9A3S3UriDus/7tfakREIMk0QE9X5hfmktPzxb8ObYd1bu8WHs4
         YWXjiaQJUtxu5rOEivUsvXcj2/7G11bWyc+0mWN1m3V7KLFeuBM9N4tamYunPeXQKQoC
         gbQw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCyabc5teEtC1l9pAoZfCkpXGs4Q/qvDYGKyE3FBhlToY+bVCtqJGV2LuCZhax/1qTJJkw1DgG8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkvIPfz6dz/ogsvf4vQcisjej+sbc3NZQf3iW7LPLkhnsdmKE
	nyvif2r6S1r4K5EACCHLZa+Ke8MZr4A8OZYZpIk8dAuHdM1eYrPaoUtrCnGWqZYfjuXDqwnRmKy
	8ohFuOHumdrM6WMOVvgyCDlKXkQ7kD1zM7+oORkjG7POouxrE5xkJpAk=
X-Google-Smtp-Source: AGHT+IFgtlxRGBgfd3pEN2PL9heoiK+iy1Mt0zN6QQtur3Wqs7YJAnzziX9Jhokx/L1lSzpGJ0K9swJNMkIRt7QqZn+6gwxNGok+
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:3a0:ab86:928f with SMTP id
 e9e14a558f8ab-3a0c9d90ca6mr25233375ab.26.1726846345961; Fri, 20 Sep 2024
 08:32:25 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed9589.050a0220.2abe4d.0019.GAE@google.com>
Subject: [syzbot] [ide?] general protection fault in ata_msense_control
From: syzbot <syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2004cef11ea0 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14362427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=390864846727e762
dashboard link: https://syzkaller.appspot.com/bug?extid=37757dc11ee77ef850bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f5f69f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154afb00580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2004cef1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8654ff1e22d1/vmlinux-2004cef1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/049428496a18/bzImage-2004cef1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com

program syz-executor305 is using a deprecated SCSI ioctl, please convert it to SG_IO
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5092 Comm: syz-executor305 Not tainted 6.11.0-syzkaller-07337-g2004cef11ea0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ata_msense_control_spgt2 drivers/ata/libata-scsi.c:2276 [inline]
RIP: 0010:ata_msense_control+0x966/0x1cf0 drivers/ata/libata-scsi.c:2358
Code: b6 04 10 84 c0 0f 85 9b 0f 00 00 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 b6 0f 00 00 66 c7 03 00 e4 49 89 ec 49 c1 ec 03 <41> 0f b6 04 14 84 c0 0f 85 cc 0f 00 00 0f b6 5d 00 c0 e3 04 80 e3
RSP: 0018:ffffc90002d8f068 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffff9a7036be RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff9a7036bd
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000003
R10: ffffffff9a7036b3 R11: fffffbfff34e06d8 R12: 0000000000000000
R13: ffffffff9a7036bf R14: 0000000000000046 R15: ffff888034faadf8
FS:  00005555605c5380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000380 CR3: 000000003dd82000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ata_scsiop_mode_sense drivers/ata/libata-scsi.c:2474 [inline]
 ata_scsi_rbuf_fill drivers/ata/libata-scsi.c:1815 [inline]
 ata_scsi_simulate+0x1ae8/0x2320 drivers/ata/libata-scsi.c:4316
 __ata_scsi_queuecmd+0x21e/0x1030 drivers/ata/libata-scsi.c:4191
 ata_scsi_queuecmd+0x3bb/0x530 drivers/ata/libata-scsi.c:4234
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1608 [inline]
 scsi_queue_rq+0x1d7c/0x2e90 drivers/scsi/scsi_lib.c:1850
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_sched_dispatch_requests+0x424/0x1840 block/blk-mq-sched.c:301
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x9a5/0xae0 block/blk-mq.c:2245
 blk_execute_rq+0x239/0x4b0 block/blk-mq.c:1398
 sg_scsi_ioctl drivers/scsi/scsi_ioctl.c:593 [inline]
 scsi_ioctl+0x222f/0x2d80 drivers/scsi/scsi_ioctl.c:901
 sg_ioctl_common drivers/scsi/sg.c:1109 [inline]
 sg_ioctl+0x16e9/0x2e80 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f83297361a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb0f41208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffb0f413d8 RCX: 00007f83297361a9
RDX: 0000000020000380 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f83297a9610 R08: 002367732f766564 R09: 00007fffb0f413d8
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffb0f413c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ata_msense_control_spgt2 drivers/ata/libata-scsi.c:2276 [inline]
RIP: 0010:ata_msense_control+0x966/0x1cf0 drivers/ata/libata-scsi.c:2358
Code: b6 04 10 84 c0 0f 85 9b 0f 00 00 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 b6 0f 00 00 66 c7 03 00 e4 49 89 ec 49 c1 ec 03 <41> 0f b6 04 14 84 c0 0f 85 cc 0f 00 00 0f b6 5d 00 c0 e3 04 80 e3
RSP: 0018:ffffc90002d8f068 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffff9a7036be RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff9a7036bd
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000003
R10: ffffffff9a7036b3 R11: fffffbfff34e06d8 R12: 0000000000000000
R13: ffffffff9a7036bf R14: 0000000000000046 R15: ffff888034faadf8
FS:  00005555605c5380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000380 CR3: 000000003dd82000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	10 84 c0 0f 85 9b 0f 	adc    %al,0xf9b850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	4c 89 e8             	mov    %r13,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
  16:	84 c0                	test   %al,%al
  18:	0f 85 b6 0f 00 00    	jne    0xfd4
  1e:	66 c7 03 00 e4       	movw   $0xe400,(%rbx)
  23:	49 89 ec             	mov    %rbp,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	41 0f b6 04 14       	movzbl (%r12,%rdx,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 cc 0f 00 00    	jne    0x1003
  37:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
  3b:	c0 e3 04             	shl    $0x4,%bl
  3e:	80                   	.byte 0x80
  3f:	e3                   	.byte 0xe3


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
