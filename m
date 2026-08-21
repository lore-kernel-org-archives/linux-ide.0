Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48129312825
	for <linux-ide@vger.kernel.org>; Fri, 21 Aug 2026 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346168; cv=none; b=jVIVPJU5LOMyNO/E+rLU+x8EAqhE0k+rfTouDC1pYJwfoOdUExWlrfTNYOxy+sQUVgp2jwwzGwamKiY5KT+V4MQeiLYkgJWRSGrgMIxn9oABZPGb1MpFMgvDwBkBDbv9JlXUI3uoG2YHWBuH8RUyNJDnjUBZ4fWUffcGfYlX9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346168; c=relaxed/simple;
	bh=DMlZ1Njee3nENwYQkjFZmXgbUZOPmlkbDpMZehjc3uY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PuRoLwzr937RglBnrG0krePwsyke2pZ3yAsR0Dm0sibDgJBzwyr5EQpKeAywiNMdAryh5md5VWAidUnOpKmyC6do0jFzpxTta6uAat13pfJw2aXflDDZ0L1uqKY1qDQZfE3UGXL50gjyb9uboe7Znb8uXOpOCY6YsXzX7JoerFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso475649b6e.0
        for <linux-ide@vger.kernel.org>; Fri, 21 Aug 2026 14:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346166; x=1787950966;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qx2O44ZYXcXU3XKrRNTOR7UWQo6XeJleD2RdLgyaXds=;
        b=mQ1AZT9hyqure50QYYpCFyyzx6qdCebtTnF+S8jcJ2xt40MZm6RyC0czQ7WL9ixCiE
         0H5aEaJ6V+hBn9XoUK8cOVH7BOBZ+8rugm4UA1XJHz4WwkWK1QlKfex3VHlRRV7bsqqr
         BK9MOfiBJ4BDTBxlut6v6BH4dQyA1dAfMpCBL5NyiBNOARKOn1ekpcDkWa6qUb73JlS2
         7W9wUGcieBpTh5M275FwTplOW3xYEq3UPSJVUSS1rjj2dTq6CyZ98AEqtgcLYENE8ZRN
         r9ySmWI4JnqBs0wElIuvXmjsPCmGlkidPpcLdtx2coS146w9ZXp67fsbJNKRVSohXNDK
         HQ8g==
X-Forwarded-Encrypted: i=1; AHgh+RqLzttFsHaRoGrR8yu7sBGVoEOF2juGneZIsrXLqk/37quw3wC+HbQaK1fZOwwtXjaWoACmuunVR8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNxwXOA7r0ZIziwmzgUmf6Xy28t1uwn8Is5vfnLvFD8OpURDM
	L6MXeGsx0hlRZCfUVp462AAwUdnF8O4xxdENH5TdVfu5SXVx1+XJUIe5RiChzXaJUwRiOKy/C4R
	h13BX2NAl3PchnOheCx3eCFxcl7mEhSZM4gHakQFOXASr2LnpOIJSxnSTS08=
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:150f:b0:495:f85b:38c0 with SMTP id
 5614622812f47-4b309b0ed12mr1891748b6e.12.1787346166208; Fri, 21 Aug 2026
 14:02:46 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:02:46 -0700
In-Reply-To: <6a82bc54.10853dc7.22f513.001b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88bcf6.dbb3a75c.13dd47.001f.GAE@google.com>
Subject: Re: [syzbot] [ide?] Internal error in ata_sff_freeze
From: syzbot <syzbot+891c7b195b408052e519@syzkaller.appspotmail.com>
To: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=139f8415580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2050ae6a504f163
dashboard link: https://syzkaller.appspot.com/bug?extid=891c7b195b408052e519
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10021549580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6059523242a9/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5c6a1cf5025/Image-818bebeb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com

EXT4-fs (vda): shut down requested (2)
Aborting journal on device vda-8.
Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3667 Comm: syz.2.17 Tainted: G   M                syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK
Hardware name: linux,dummy-virt (DT)
pstate: 414020c9 (nZcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __raw_writeb arch/arm64/include/asm/io.h:29 [inline]
pc : writeb include/asm-generic/io.h:265 [inline]
pc : iowrite8 include/asm-generic/io.h:924 [inline]
pc : ata_sff_set_devctl drivers/ata/libata-sff.c:233 [inline]
pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1616
lr : __ata_port_freeze drivers/ata/libata-eh.c:1124 [inline]
lr : ata_eh_freeze_port+0x34/0x5c drivers/ata/libata-eh.c:1167
sp : ffff800089dab960
x29: ffff800089dab960 x28: f2f00000061cb300 x27: 0000000000000000
x26: 0000000000000001 x25: ffff800081f4bcc0 x24: ffff80008279aa48
x23: 0000000000000000 x22: 0000000000000000 x21: f0f0000013e58000
x20: 0000000000000000 x19: f0f0000013e58000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: f0f0000013e5a3f6
x14: 0000000000000000 x13: 0000000000067000 x12: 0000000000004308
x11: fff000000314a808 x10: ffff800082ea0000 x9 : 0000000000000000
x8 : fbf0000003ff2000 x7 : ffffc1ffc00ffc40 x6 : ffffc1ffc00ffc40
x5 : 0000100000000000 x4 : 01ffdc0000000000 x3 : ffff800082d46be8
x2 : 0000000000000000 x1 : 000000000000000a x0 : ffff800083f55002
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
 local_pci_probe+0x40/0xa8 drivers/pci/pci-driver.c:332
 pci_call_probe drivers/pci/pci-driver.c:394 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0xd8/0x288 drivers/pci/pci-driver.c:489
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
