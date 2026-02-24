Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB82BE048
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931605; cv=none; b=IJ2sxdF/2qtZWmlPkNtYv7G5AX6lkRdJMl76a9u43M+yKrsFjxi1HMdhnq6EmG2rTS0vudaQqdNKBKZ/Ga2ngR3m5whrNJQwf9GlioBl8AlnZgBF3i0P155wwJZ8u+WyfPXwkH5GA6DzigWySotgE68ovzkiFhvOcYK7sxPRUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931605; c=relaxed/simple;
	bh=kMiaks7xiUrIVFlvzE/mQZda3u9BKAnG+YkYp/17yow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u56lPMHfHMxmNnAgUvA4UCAnO/B6ze/ZIgUZ4PT+WZH3G5wqJ4Ly/Ns394zfyxn3RF5KLc1VAEQDvGKTi2UhfKSkIfxOvFEKTCKNDm63G/RnBTfyC3A0ts3fUwp641YmHzkTM/qwc3L0lDSPk4LYGkpRSew4vq4x73y+o4viknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679943693c0so82717262eaf.3
        for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 03:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931603; x=1772536403;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqGKpgU7Y9MSDlF3tb5I3kiochKIUksL5yOplT2ZXQI=;
        b=wKEHe2PDxZfZUbxAx2MX1R65mXkJ79Hs7TCFRLWp98nfUCvoxq42IjcQnHkdRu/rEp
         Sver7PTWQwEbXQWrO3/qiKXM7QycseBQ/PkF4koQe3Ckuz4G9+kCiXqlByDBkbLlzley
         YwRWd/nfZvOFpc1Ccev3Yz90ZuTuVZc5ZcTSx25qnKp0CHF6ViYVb3HYlUS/tnJxYZ5p
         Dkmz+/J6wHEnTgqOP/cbNJyUgGTa4BJeEPuShHNqGRxcsnznpid3K1mUNWEdOrlpwC6Z
         6JSwF4Xmes1vvJxS4MoR2sGVP7J+r4HTBSK4RTqUwPbvtA9FyomfsaWy7hFO2fhBSHKi
         ndbg==
X-Forwarded-Encrypted: i=1; AJvYcCWyirR/YFwxq0LszqCgBIwYDjcJjFOaWNVTmSD/iztbD1+UyXcS+iiaDh6vCp3K4Zp8CboqruG7wIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHRF1RtYRImUbhVurmsHKo0o1SR5Cv1Xg7wkold319My2uKbx
	/5JpasNILSaDscY5iOBGAGfR3PSvUl35PHLDx6+PR0sbFIte1CCj54TakL0MZpn2mPdwDVdee2x
	YgxXopdrrtwvBgrGr1WJoMy4ZE0md0FmfK825G6OZzHc5Op4D17C7YFSEChM=
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221e:b0:679:bbd4:605e with SMTP id
 006d021491bc7-679c4268b94mr6347000eaf.16.1771931603041; Tue, 24 Feb 2026
 03:13:23 -0800 (PST)
Date: Tue, 24 Feb 2026 03:13:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699d87d3.050a0220.247d23.040e.GAE@google.com>
Subject: [syzbot] [ide?] WARNING in ata_scsi_deferred_qc_work
From: syzbot <syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bf22c33e7a1 Merge tag 'net-7.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1500795a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2f061f80b102378
dashboard link: https://syzkaller.appspot.com/bug?extid=bcaf842a1e8ead8dfb89
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8bf22c33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e8e85f2840a/vmlinux-8bf22c33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/246ca754a755/bzImage-8bf22c33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com

------------[ cut here ]------------
ap->ops->qc_defer(qc)
WARNING: drivers/ata/libata-scsi.c:1677 at ata_scsi_deferred_qc_work+0x199/0x1f0 drivers/ata/libata-scsi.c:1677, CPU#2: kworker/2:1H/796
Modules linked in:
CPU: 2 UID: 0 PID: 796 Comm: kworker/2:1H Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_highpri ata_scsi_deferred_qc_work
RIP: 0010:ata_scsi_deferred_qc_work+0x199/0x1f0 drivers/ata/libata-scsi.c:1677
Code: 48 48 8b bb 90 df ff ff 48 89 ee 5b 5d 41 5c 41 5d 41 5e 41 5f e9 f7 58 15 05 e8 12 03 f8 fb e9 0d ff ff ff e8 98 a3 8b fb 90 <0f> 0b 90 eb 86 4c 89 ff e8 2a 03 f8 fb e9 bb fe ff ff 4c 89 ef e8
RSP: 0018:ffffc90004b3fc10 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff888029a32080 RCX: ffffffff867cf7ef
RDX: ffff888027ab2480 RSI: ffffffff867cf868 RDI: ffff888027ab2480
RBP: 0000000000000246 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000760b R12: 0000000000000001
R13: ffff888029a30010 R14: ffff888029a31710 R15: ffff888029a320c8
FS:  0000000000000000(0000) GS:ffff8880d6548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c347c45 CR3: 0000000027487000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
