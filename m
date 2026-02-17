Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12D280CC1
	for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361738; cv=none; b=k+/8Qfguhbpa81vA23ZqojpYqOClaFYwZZCQ9tGemUvonOq1HDaWnMHyoUNLtpflZlJ4vVnyqYmeC+ME3EGHW9K7RL4AoXLdP7ubwV9tEscwNs0m1mxqPLtihQ8SZOcGUJhiDWp2krJ/lEZYh7ZIrHkfFy0KUFvqwQ2IWKXK3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361738; c=relaxed/simple;
	bh=I2bq8O0Am4NgLaWqcg8bKuOyWoKEexJmylufUFpU8LI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MZhcZwhtAWGoW8u/HqAmbPl/RU2B+5VFrSDpbc+Mdo9gMRZTr9ygSzt0cc6hku7FZosfKIAnr32/4eoLRTDx+rf+ZyrLwy0HSFTyZto/XTwNhB3gmWElhVa8HXvs/58HWUX7IwYQJiguH89GwYepMCsZWIgOru9XZkirBlFMmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6781479fe9dso3660653eaf.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 12:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771361736; x=1771966536;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6qhyFXxTx03Z7ggdi9EDskkcx19mjBlIu8eZ/eEIY=;
        b=bWimurfmm3JkQeFKLI2bSKhRAGmgcEbY+3whMaR7Bp9/XEld7ITNAQK6IYHSoVH1s9
         tMdKQnY1to+uh8hso6HPydD3/eGZzpVgIIQroJTuIosdEDiEEuqfgqdIam18DLD+moVu
         c9ws8u594FQnvaVkiNQrPzyjA/2r62q/4qUcKM2gNy1umGGgNJFH44rWxEBPDkgmliby
         c9dNjIOVtFNTFKyZy71MepybdUOm3FnsJfTBHuXR5dUDVPtBD3lCmQduRMO3zbszs5gF
         33xnxT+BYpf8I8x5sM5ryZnAcx2kQLsgkRzP7ooJPYzInpmdQ8GJeDzoYNxSyhuOlFzD
         NPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXm9dSGF/kGOXZw7ITGNuHJVLvNKcRm0ybw2LOFu8nG1u9TN1ru2QcNbH2XsRt/MlQnhwpYdYXWBco=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb14vdaU7K0BL1s8VpVhUxjh/PZsnrhhr9K9mi0DZ6zX8aFZlx
	1Bb/c8ckSmE8cY9I0Tsgxz81l+xkKmwncV2XxFmY3um9iMi0gj6DTi5MOTYbDJb1CpcTkxtyYWb
	/05vk4wI9O/IV8y8CFSyDy7KMfhPUK5wBQ/3sUoXR1cPdzjc1BYD1QcpO71k=
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3090:b0:662:fefa:9ee5 with SMTP id
 006d021491bc7-678221cdb37mr6222935eaf.27.1771361735998; Tue, 17 Feb 2026
 12:55:35 -0800 (PST)
Date: Tue, 17 Feb 2026 12:55:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
Subject: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
From: syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ca4ee40bf13d Partly revert "drm/hyperv: Remove reference t..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c6c722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a771bfd268751cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=1f77b8ca15336fff21ff
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ca4ee40b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c714adf37ddd/vmlinux-ca4ee40b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d56cd9f6175/bzImage-ca4ee40b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
CPU: 2 UID: 0 PID: 1282 Comm: kworker/2:1H Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_highpri ata_scsi_deferred_qc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
 ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 2 UID: 0 PID: 1282 Comm: kworker/2:1H Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_highpri ata_scsi_deferred_qc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 vpanic+0x552/0x970 kernel/panic.c:650
 panic+0xd1/0xe0 kernel/panic.c:787
 check_panic_on_warn kernel/panic.c:524 [inline]
 check_panic_on_warn.cold+0x19/0x34 kernel/panic.c:519
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
 ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
