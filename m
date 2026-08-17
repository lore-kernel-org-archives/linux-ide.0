Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10636215F
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2026 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952790; cv=none; b=UrUtT/Fz6bjpNd97idjRYhH8YcaTikQumtbhB/+scx+KeXCd4W2DoCb15F6/zibJl+vXqRCMdY5igXFrgzkBQtyUv/hIgbj8FmbNwB88BviKJ1o5aEZOWzBIc0mL3qo6PCwJU4Wfoqm0YJPi5a1XOFlj7i16YY+VC2vPYJmHKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952790; c=relaxed/simple;
	bh=HGpAnMCZD+ikVev/WPttfuQdj/EliM09Qrbrrwn4oEo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SO8V3QdRGejv0zdfAOc//EJhTIpJl79/6FlCbY9x8cWiD/3OGirar2vIi4q84h3HqqWeRcdS/nw/yZLEZKz7vuTqHSSSyx1Cq04/5XP052bJWwIJLufSHhExCQcYeLE+SNeop4FHDct445ODCd2nxTuJOqD8sw5A+0M4nhlnx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7ec5495f105so3017146a34.3
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2026 00:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786952788; x=1787557588;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/5lc5qytsZVKJTVf4RxI+Gbt4q2OL5is9f5h20Ppd8=;
        b=qjYBHuvyK1nt4tOuEcNZqyNbDkq3cbGX398mU8vPoZieVcWI2VHQM1234pdmWyjKiw
         TggY32MOzYFbyHrBBCD3rN2S0G2tfhM9sdfoRtJNOxEvUDwJ2ZQy/o5tFk3S3WNQaAvu
         Ssk2QSPmuetIUC/k1eJwvrVj2+VQ8UO68zeA0zJtn+358rNPp6BcsDpyQnhfzuA49tTB
         cHodeUMiF+i80gmtDfrs4j2qrwC1zRy09G6DPz7T+5HqHUpn9SIUbF78CC82nBcpOYmR
         ceHupqqzGOKhtJmLxpxl1i4e24sQFA1Hzr46zv65KRe9eWjAbRbeVm+LUcLtvIS8WrOM
         rFrA==
X-Forwarded-Encrypted: i=1; AHgh+RoHYhpSLiMxXe4WESxXtcuZyJDyQ6cyrD0QPSDhGv2ba3zcbocrKiLgn9xY5gbQ5B/w7ZdXMScMDtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi64hHZFVkfiqnhtmA5xKcz4Znq/L3t05O/kKIcG4RsDTAEdn6
	TlkRDOzsjtLSbzx2XqOy1YMNpcKZF8bq5b/pimI9OkYW2tSoUBimXE87vX5iPY3Ak8IiCTG6bGf
	KiYmUAeN7QBsg8U4FBlf3fI7uCkUpUb92wYoRRggZmOcQ0myNeEJpPozRDX4=
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1626:b0:6aa:d6bd:f6e5 with SMTP id
 006d021491bc7-6b0d69715fbmr17951342eaf.35.1786952788058; Mon, 17 Aug 2026
 00:46:28 -0700 (PDT)
Date: Mon, 17 Aug 2026 00:46:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a82bc54.10853dc7.22f513.001b.GAE@google.com>
Subject: [syzbot] [ide?] Internal error in ata_sff_freeze
From: syzbot <syzbot+891c7b195b408052e519@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=1564469e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=97ba2e017420cdcb
dashboard link: https://syzkaller.appspot.com/bug?extid=891c7b195b408052e519
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-2f1baf1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b4adcfb67df/vmlinux-2f1baf1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72646a392f58/Image-2f1baf1f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com

EXT4-fs (vda): shut down requested (2)
Aborting journal on device vda-8.
Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 14268 Comm: syz.1.3901 Tainted: G   M                syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK
Hardware name: linux,dummy-virt (DT)
pstate: 814020c9 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __raw_writeb arch/arm64/include/asm/io.h:29 [inline]
pc : writeb include/asm-generic/io.h:265 [inline]
pc : iowrite8 include/asm-generic/io.h:924 [inline]
pc : ata_sff_set_devctl drivers/ata/libata-sff.c:233 [inline]
pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606
lr : __ata_port_freeze drivers/ata/libata-eh.c:1124 [inline]
lr : ata_eh_freeze_port+0x34/0x5c drivers/ata/libata-eh.c:1167
sp : ffff800083c83960
x29: ffff800083c83960 x28: fdf0000006125500 x27: 0000000000000000
x26: 0000000000000001 x25: ffff800081f190d0 x24: ffff800082753b40
x23: 0000000000000000 x22: 0000000000000000 x21: f3f000003c8c0000
x20: 0000000000000000 x19: f3f000003c8c0000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: f3f000003c8c23f6
x14: 0000000000000000 x13: 000000000006bb51 x12: ffff80007fffffff
x11: fff00000030ea808 x10: 000000800000c000 x9 : 0000000000000000
x8 : fcf0000004ada000 x7 : ffffc1ffc012b640 x6 : 0000000000000001
x5 : 00000c0000000000 x4 : ffffc1ffc012b640 x3 : ffff800082ceb208
x2 : 0000000000000000 x1 : 000000000000000a x0 : ffff8000885b1002
Call trace:
 writeb include/asm-generic/io.h:264 [inline] (P)
 iowrite8 include/asm-generic/io.h:924 [inline] (P)
 ata_sff_set_devctl drivers/ata/libata-sff.c:233 [inline] (P)
 ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606 (P)
 __ata_port_freeze drivers/ata/libata-eh.c:1124 [inline]
 ata_eh_freeze_port+0x34/0x5c drivers/ata/libata-eh.c:1167
 ata_host_start+0x13c/0x228 drivers/ata/libata-core.c:6041
 ata_pci_sff_activate_host+0x50/0x340 drivers/ata/libata-sff.c:2275
 ata_pci_init_one+0x19c/0x1d8 drivers/ata/libata-sff.c:2402
 ata_pci_bmdma_init_one+0x14/0x20 drivers/ata/libata-sff.c:3170
 ata_generic_init_one+0xc4/0x1ac drivers/ata/ata_generic.c:209
 local_pci_probe+0x40/0xa8 drivers/pci/pci-driver.c:332
 pci_call_probe drivers/pci/pci-driver.c:394 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0xd8/0x288 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0xbc/0x2bc drivers/base/dd.c:706
 __driver_probe_device+0x118/0x16c drivers/base/dd.c:868
 device_driver_attach+0x48/0xb4 drivers/base/dd.c:1203
 bind_store+0x7c/0xd8 drivers/base/bus.c:267
 drv_attr_store+0x24/0x40 drivers/base/bus.c:125
 sysfs_kf_write+0x7c/0x98 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x138/0x200 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x244/0x36c fs/read_write.c:687
 ksys_write+0x70/0x108 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x1c/0x30 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0xa0/0xf0 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:594
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
