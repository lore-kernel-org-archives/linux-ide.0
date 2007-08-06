From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.23-rc2: check_irq_resend on resume (ali15x3)
Date: Mon, 6 Aug 2007 11:11:43 +0200
Message-ID: <200708061111.43340.bzolnier@gmail.com>
References: <200708042238.00368.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:8398 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760157AbXHFJRa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 05:17:30 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1993076mue
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 02:17:29 -0700 (PDT)
In-Reply-To: <200708042238.00368.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>


commit 0fc4969b866671dfe39b1a9119d0fdc7ea0f63e5

I doubt that this particular report helps in debugging ne2k-pci problem...

;)

On Saturday 04 August 2007, Andrey Borzenkov wrote:
> Just noticed this; I do not remember having seen it before, but I also do not 
> check dmesg every time after resume.
> 
> [   54.154078] pnp: Failed to activate device 00:05.
> [   54.154120] pnp: Failed to activate device 00:06.
> [   54.159608] pnp: Device 00:09 activated.
> [   54.205284] WARNING: at /home/bor/src/linux-git/kernel/irq/resend.c:70 
> check_irq_resend()
> [   54.205299]  [<c01047fa>] show_trace_log_lvl+0x1a/0x30
> [   54.205332]  [<c0105292>] show_trace+0x12/0x20
> [   54.205343]  [<c01052f5>] dump_stack+0x15/0x20
> [   54.205353]  [<c014ce7e>] check_irq_resend+0x9e/0xb0
> [   54.205388]  [<c014c991>] enable_irq+0xb1/0xc0
> [   54.205397]  [<df82f6fa>] ide_config_drive_speed+0x18a/0x3e0 [ide_core]
> [   54.205570]  [<df80f3cc>] ali15x3_tune_drive+0x1c/0x20 [alim15x3]
> [   54.205592]  [<df82da33>] ide_do_request+0x8a3/0xa10 [ide_core]
> [   54.205623]  [<df82dc60>] ide_do_drive_cmd+0xc0/0x110 [ide_core]
> [   54.205652]  [<df82c868>] generic_ide_resume+0x98/0xe0 [ide_core]
> [   54.205681]  [<c023793c>] resume_device+0x4c/0xa0
> [   54.205717]  [<c02379ee>] dpm_resume+0x5e/0x90
> [   54.205727]  [<c0237a46>] device_resume+0x26/0x40
> [   54.205736]  [<c0141849>] hibernation_snapshot+0x69/0xd0
> [   54.205747]  [<c0141a1c>] hibernate+0xac/0x170
> [   54.205755]  [<c01407ae>] state_store+0xbe/0xd0
> [   54.205764]  [<c01ab2d2>] subsys_attr_store+0x32/0x50
> [   54.205784]  [<c01ab5ab>] sysfs_write_file+0xdb/0x120
> [   54.205795]  [<c016f8b9>] vfs_write+0x99/0x130
> [   54.205819]  [<c016fe2d>] sys_write+0x3d/0x70
> [   54.205829]  [<c0104112>] sysenter_past_esp+0x5f/0x99
> [   54.205839]  =======================
> [   54.206084] hda: selected mode 0x42
> [   54.225580] hdc: selected mode 0x42
> [   54.228619] usb usb1: root hub lost power or was reset
> [   54.714012] eth1: PRI 31 variant 2 version 9.48
> [   54.714075] eth1: NIC 5 variant 2 version 1.02
> [   54.810451] Restarting tasks ... <5>toshiba_acpi: Re-enabled hotkeys
> [   54.925054] done.
> [   54.925134] swsusp: Basic memory bitmaps freed
> [   59.560144] eth1: PRI 31 variant 2 version 9.48
> [   59.560231] eth1: NIC 5 variant 2 version 1.02
> [   59.835398] eth1: PRI 31 variant 2 version 9.48
> [   59.835487] eth1: NIC 5 variant 2 version 1.02
> [   60.079468] eth1: PRI 31 variant 2 version 9.48
> [   60.079553] eth1: NIC 5 variant 2 version 1.02
