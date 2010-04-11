From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 09:51:22 GMT
Message-ID: <201004110951.o3B9pM3X017674@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42161 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0DKJvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 05:51:24 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3B9pMIq017691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 09:51:22 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994


Marc H. Thoben <kernelbug@develz.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernelbug@develz.org




--- Comment #3 from Marc H. Thoben <kernelbug@develz.org>  2010-04-11 09:51:05 ---
I'm having the same kernel panics. i5 750, P55A-UD4, 4 sata harddisks, 1 ide
cdrom. Running Debian's latest 2.6.32 kernel from sid/unstable.

Like Dario I've been using netconsole to see this:

Kernel panic - not syncing: Fatal exception in interrupt
...
# BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
# IP: [<ffffffffa0afe288>] ide_complete_rq+0x10/0x3b [ide_core]
...
Call Trace of the kernel oops:
 <IRQ>
 [<ffffffffa0e2fe01>] ? cdrom_newpc_intr+0x6f9/0x72a [ide_cd_mod]
 [<ffffffffa0e2f708>] ? cdrom_newpc_intr+0x0/0x72a [ide_cd_mod]
 [<ffffffffa0afdedd>] ? ide_intr+0x170/0x1ff [ide_core]
 [<ffffffff81093c50>] ? handle_IRQ_event+0x58/0x126
 [<ffffffff810170cd>] ? read_tsc+0xa/0x20
 [<ffffffff81095536>] ? handle_fasteoi_irq+0x7d/0xb5
 [<ffffffff81013957>] ? handle_irq+0x17/0x1d
 [<ffffffff81012fb1>] ? do_IRQ+0x57/0xb6
 [<ffffffff810114d3>] ? ret_from_intr+0x0/0x11
 <EOI>
 [<ffffffff8102b5ac>] ? hpet_msi_next_event+0x0/0x8
 [<ffffffffa00e14ff>] ? acpi_idle_enter_bm+0x273/0x2a5 [processor]
 [<ffffffffa00e14f8>] ? acpi_idle_enter_bm+0x26c/0x2a5 [processor]
 [<ffffffff81231ae3>] ? cpuidle_idle_call+0x95/0xee
 [<ffffffff8100fea5>] ? cpu_idle+0xa2/0xda

Call Trace of the kernel panic:
 <IRQ>
 [<ffffffff812f19e9>] ? panic+0x86/0x141
 [<ffffffff81068078>] ? up+0xe/0x36
 [<ffffffff8104e215>] ? release_console_sem+0x17e/0x1af
 [<ffffffff81014a7a>] ? oops_end+0xa7/0xb4
 [<ffffffff810322b8>] ? no_context+0x1e9/0x1f8
 [<ffffffff8103246d>] ? __bad_area_nosemaphore+0x1a6/0x1ca
 [<ffffffff8103fa5c>] ? __wake_up+0x30/0x44
 [<ffffffff811ef53c>] ? credit_entropy_bits+0x7b/0x97
 [<ffffffff812f3c35>] ? page_fault+0x25/0x30
 [<ffffffffa0afe288>] ? ide_complete_rq+0x10/0x3b [ide_core]
 [<ffffffffa0afe2a2>] ? ide_complete_rq+0x2a/0x3b [ide_core]
 [<ffffffffa0e2fe01>] ? cdrom_newpc_intr+0x6f9/0x72a [ide_cd_mod]
 [<ffffffffa0e2f708>] ? cdrom_newpc_intr+0x0/0x72a [ide_cd_mod]
 [<ffffffffa0afdedd>] ? ide_intr+0x170/0x1ff [ide_core]
 [<ffffffff81093c50>] ? handle_IRQ_event+0x58/0x126
 [<ffffffff810170cd>] ? read_tsc+0xa/0x20
 [<ffffffff81095536>] ? handle_fasteoi_irq+0x7d/0xb5
 [<ffffffff81013957>] ? handle_irq+0x17/0x1d
 [<ffffffff81012fb1>] ? do_IRQ+0x57/0xb6
 [<ffffffff810114d3>] ? ret_from_intr+0x0/0x11
 <EOI>
 [<ffffffff8102b5ac>] ? hpet_msi_next_event+0x0/0x8
 [<ffffffffa00e14ff>] ? acpi_idle_enter_bm+0x273/0x2a5 [processor]
 [<ffffffffa00e14f8>] ? acpi_idle_enter_bm+0x26c/0x2a5 [processor]
 [<ffffffff81231ae3>] ? cpuidle_idle_call+0x95/0xee
 [<ffffffff8100fea5>] ? cpu_idle+0xa2/0xda

As a workaround I have blacklisted ide-cd_mod from loading.

Please let me know if I can help by providing more data. I'd really like to get
this cdrom going again :)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
