Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8B3BB102
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735844; cv=none; b=U/TcmbTqiX1dyciPiThYqJBgO8vxBk+6iD3vA2ba+LWrXb2o/aPVe/JgRjL+rARNBbPJE9rIP2NhoZVTuNBVRdltmMqpxqRLknCytDaA7OmtISmWZK2YpFR6gC++0fz9ipc2BnHBmp2hWudmvnfCP7oorf5fD7TT7HDXrUUHNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735844; c=relaxed/simple;
	bh=rwUJT3V9wg/rdzTfNigdBd+erv6pNPaYLBa9TwjYdwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JR4iv4x2MO+l9bYF06zkYjC01y6tjB3DbhuBF0w+pltVHN43OrMMuh8Y4XjJWJdRGgXzYDhPI8y5YjzbIPLo6SskGCRRovWRqB4hNUJ3Z9MyT2IgQNJrzt3ndU92WsIVx8IfF/572E5ksJVL6UNGDQewPeYajK2Zd4WXgYolsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4961058e787so126482b6e.0
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735842; x=1788340642;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HwTbrR9c5Gq+DUGCRQVWOrtgFJiU7bk5N63xH24BMjw=;
        b=GDaqhAv2aAiavb04PtEYYfGIzMTmfp2Xjk7m3rsS67MUVQIq9RsMzq1VlLpvuWTdUb
         IcFeR//edmpXCqMr5YpSodmhiqIhQ2B/UMqhJcPRxcp/05Ibfv3rsUyGMu2RuqS54BK+
         c9YnwzTH5h5I38f9or3FuxVmjOg0KgZREmkpWezgXUU/ptYoLGyFKAx2iDMkG2j5iaMe
         0zApHQfmmF3FSMlgpVFfBJHM3DTToGMG3B2co6wAI1dja6AUQQOJeXbaaQmPG8fn9UB3
         PJx5GmJ3C2ytRh1e+8v7kHO0N0ESgz1Jb0KoBtPUgkIRcVogS0pn2g9i2zhiDb1WLFZs
         G3jA==
X-Forwarded-Encrypted: i=1; AHgh+Rqs2f6GV3q24ZIQQcphAq3PLuICUETGFzqRJKifOG2Ra1hf9ie1xWQtksFcPxis+dgOp7NGVm6xYdU=@vger.kernel.org
X-Gm-Message-State: AFuF++lEmOMgHhxolCApRvvIwrpcx0Rad0ZN9zsHlBGSg+71uEo8eNeu
	1cn5iMvCD5Z/YHXgXG9Z4u8xDIdK3j5YmeGYEW1tA//IQW1KmwH9ESohJVlT7OlRHG3GmUCuuu/
	n5ihy7YHQ0oNZfl4Od86yNvzxsufqhclsShvoMUX+lHQ3lHs/dmWuoV8mjj8=
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:680a:b0:495:e16d:5d03 with SMTP id
 5614622812f47-4b366c2b4b9mr6465836b6e.21.1787735842377; Wed, 26 Aug 2026
 02:17:22 -0700 (PDT)
Date: Wed, 26 Aug 2026 02:17:22 -0700
In-Reply-To: <6a82bc54.10853dc7.22f513.001b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8eaf22.f718c3ee.3aa8ac.0000.GAE@google.com>
Subject: Re: [syzbot] [ide?] Internal error in ata_sff_freeze
From: syzbot <syzbot+891c7b195b408052e519@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    73ae59e97596 Merge tag 'erofs-for-7.3-rc1-2' of git://git...
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=10be6979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c35e49327a11721f
dashboard link: https://syzkaller.appspot.com/bug?extid=891c7b195b408052e519
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247f979580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f0d979580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-73ae59e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee58aef7a7b5/vmlinux-73ae59e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/629007cb8bf8/Image-73ae59e9.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com

EXT4-fs (vda): shut down requested (2)
Aborting journal on device vda-8.
Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3665 Comm: syz.2.17 Tainted: G   M    W           syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK, [W]=WARN
Hardware name: linux,dummy-virt (DT)
pstate: 414020c9 (nZcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __raw_writeb arch/arm64/include/asm/io.h:29 [inline]
pc : writeb include/asm-generic/io.h:265 [inline]
pc : iowrite8 include/asm-generic/io.h:924 [inline]
pc : ata_sff_set_devctl drivers/ata/libata-sff.c:233 [inline]
pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1616
lr : __ata_port_freeze drivers/ata/libata-eh.c:1124 [inline]
lr : ata_eh_freeze_port+0x34/0x5c drivers/ata/libata-eh.c:1167
sp : ffff800089c3b900
x29: ffff800089c3b900 x28: fcf000000690d500 x27: 0000000000000000
x26: 0000000000000001 x25: ffff800081f5bac0 x24: ffff8000827b1910
x23: 0000000000000000 x22: 0000000000000000 x21: fdf0000008db0000
x20: 0000000000000000 x19: fdf0000008db0000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: fdf0000008db23f6
x14: 0000000000000000 x13: 0000000000066e8b x12: 0000000000004308
x11: fff000000315b808 x10: ffff800082eb0000 x9 : 0000000000000000
x8 : fcf0000005aa6000 x7 : f7f0000003f950d0 x6 : ffffc1ffc016a940
x5 : 00000c0000000000 x4 : 01fffc0000000000 x3 : ffff800082d56c88
x2 : 0000000000000000 x1 : 000000000000000a x0 : ffff800083edd002
Call trace:
 writeb include/asm-generic/io.h:264 [inline] (P)
 iowrite8 include/asm-generic/io.h:924 [inline] (P)
 ata_sff_set_devctl drivers/ata/libata-sff.c:233 [inline] (P)
 ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1616 (P)
 __ata_port_freeze drivers/ata/libata-eh.c:1124 [inline]
 ata_eh_freeze_port+0x34/0x5c drivers/ata/libata-eh.c:1167
 ata_host_start+0x13c/0x228 drivers/ata/libata-core.c:6110
 ata_pci_sff_activate_host+0x50/0x340 drivers/ata/libata-sff.c:2285
 ata_pci_init_one+0x19c/0x1d4 drivers/ata/libata-sff.c:2412
 ata_pci_bmdma_init_one+0x14/0x20 drivers/ata/libata-sff.c:3180
 ata_generic_init_one+0xc4/0x1ac drivers/ata/ata_generic.c:209
 local_pci_probe+0x40/0xa8 drivers/pci/pci-driver.c:354
 pci_call_probe+0x68/0x198 drivers/pci/pci-driver.c:416
 __pci_device_probe drivers/pci/pci-driver.c:478 [inline]
 pci_device_probe+0xb8/0x158 drivers/pci/pci-driver.c:512
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0xbc/0x2bc drivers/base/dd.c:706
 __driver_probe_device+0x11c/0x184 drivers/base/dd.c:868
 device_driver_attach+0x48/0xac drivers/base/dd.c:1203
 bind_store+0x7c/0xd8 drivers/base/bus.c:267
 drv_attr_store+0x24/0x40 drivers/base/bus.c:125
 sysfs_kf_write+0x7c/0x98 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x138/0x200 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x244/0x36c fs/read_write.c:687
 ksys_write+0x70/0x108 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x18/0x24 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:590
Code: d65f03c0 f9404800 b4fffe60 d50332bf (39000001) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d65f03c0 	ret
   4:	f9404800 	ldr	x0, [x0, #144]
   8:	b4fffe60 	cbz	x0, 0xffffffffffffffd4
   c:	d50332bf 	dmb	oshst
* 10:	39000001 	strb	w1, [x0] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
