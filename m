Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7DEC433ED
	for <linux-ide@archiver.kernel.org>; Thu, 20 May 2021 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F193D61358
	for <linux-ide@archiver.kernel.org>; Thu, 20 May 2021 11:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbhETL1g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 May 2021 07:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241825AbhETLZe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 20 May 2021 07:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C4B261090
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2021 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621508976;
        bh=n6AAHWd/g6h+iFVu79G+Ry+RoLva22F7SpOkOJ9H6JU=;
        h=From:To:Subject:Date:From;
        b=Ctn2yk90GP3g9yUGW1VcsLt9u3atEQr2TrhualCpM3fAuj50it8zVgrzQy9BeWA2F
         GEkrsyMElSRKaLXizLznNlCDWIr+UO+kEA8Cs2z0YeGPbLbvYdZpnkgxRC7sDxezXv
         njVY8ucWTtxd31fmr0QR7iaJoG0ZqMyIXFEzbGqsKnnvR8lAFYVkn0aCsTiQP659WG
         97J5bJaavNZtHRO84Trd618iQaJOEhOBOkx5fbVvK37Dat/H2PXa74dHxjoZs+hwFh
         J7zdIv3du8qb9zKXsTY3VPn66IceHTnIqBHeiPIzhL4lAOfiDHS+Tqak/jclL3ef/s
         B3tQKdDv5fzBQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 213157] New: BUG: unable to handle page fault for address:
 fffbb000, Workqueue: ata_sff ata_sff_pio_task
Date:   Thu, 20 May 2021 11:09:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-213157-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213157

            Bug ID: 213157
           Summary: BUG: unable to handle page fault for address:
                    fffbb000, Workqueue: ata_sff ata_sff_pio_task
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 5.13-rc2
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: erhard_f@mailbox.org
        Regression: No

Created attachment 296893
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296893&action=3Dedit
dmesg (kernel 5.13-rc2, Shuttle XPC FS51, Pentium 4)

Happens reproducibly at boot on this machine when DEBUG_HIGHMEM=3Dy is set.

[...]
BUG: unable to handle page fault for address: fffbb000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
*pde =3D 128f0067 *pte =3D 00000000=20
Oops: 0002 [#1] SMP
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.13.0-rc2-Pentium4 #3
Hardware name:  /FS51, BIOS 6.00 PG 12/02/2003
Workqueue: ata_sff ata_sff_pio_task
EIP: ioread16_rep+0x25/0x37
Code: ff ff 5f 5d c3 55 89 e5 57 89 d7 3d ff ff 03 00 76 0e 49 78 24 66 8b =
10
66 89 17 83 c7 02 eb f2 3d 00 00 01 00 76 08 0f b7 d0 <f3> 66 6d eb 0a ba e=
f f3
72 d2 e8 7a fd ff ff 5f 5d c3 55 89 e5 57
EAX: 000101f0 EBX: 00000100 ECX: 00000080 EDX: 000001f0
ESI: 00000200 EDI: fffbb000 EBP: c11a5e7c ESP: c11a5e78
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
CR0: 80050033 CR2: fffbb000 CR3: 128ed000 CR4: 000006d0
Call Trace:
 ata_sff_data_xfer+0x2b/0x7e
 ? ata_qc_from_tag+0x44/0x44
 ata_pio_sector+0x93/0xff
 ata_pio_sectors+0x2d/0x69
 ata_sff_hsm_move+0x49f/0x543
 ? __delay+0x10/0x12
 ? ata_sff_check_status+0xb/0xd
 ata_sff_pio_task+0x67/0xc6
 process_one_work+0x24f/0x3ba
 worker_thread+0x164/0x1f7
 kthread+0xe5/0xe7
 ? drain_workqueue+0xf5/0xf5
 ? cpu_online+0xb/0xb
 ret_from_fork+0x1c/0x28
Modules linked in:
CR2: 00000000fffbb000
---[ end trace f36e9c8f14912bb4 ]---
EIP: ioread16_rep+0x25/0x37
Code: ff ff 5f 5d c3 55 89 e5 57 89 d7 3d ff ff 03 00 76 0e 49 78 24 66 8b =
10
66 89 17 83 c7 02 eb f2 3d 00 00 01 00 76 08 0f b7 d0 <f3> 66 6d eb 0a ba e=
f f3
72 d2 e8 7a fd ff ff 5f 5d c3 55 89 e5 57
EAX: 000101f0 EBX: 00000100 ECX: 00000080 EDX: 000001f0
ESI: 00000200 EDI: fffbb000 EBP: c11a5e7c ESP: c11a5e78
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
CR0: 80050033 CR2: fffbb000 CR3: 128ed000 CR4: 000006d0
note: kworker/0:1[7] exited with preempt_count 2
random: fast init done
printk: console [netcon0] enabled
netconsole: network logging started
BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 56s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x0
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2/256 refcnt=3D3
    pending: vmstat_shepherd, tsc_refine_calibration_work
workqueue events_unbound: flags=3D0x2
  pwq 4: cpus=3D0-1 flags=3D0x4 nice=3D0 active=3D2/512 refcnt=3D4
    in-flight: 8:async_run_entry_fn, 49:async_run_entry_fn
workqueue events_power_efficient: flags=3D0x80
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D2
    pending: toggle_allocation_gate
workqueue mm_percpu_wq: flags=3D0x8
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D2
    pending: vmstat_update
workqueue ata_sff: flags=3D0x8
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/512 refcnt=3D3
    in-flight: 1802201963:ata_sff_pio_task BAR(52)
workqueue mld: flags=3D0x40008
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/1 refcnt=3D2
    pending: mld_ifc_work
workqueue ipv6_addrconf: flags=3D0x40008
  pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/1 refcnt=3D2
    pending: addrconf_dad_work
pool 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D56s workers=3D3 idle:=
 32 5
pool 4: cpus=3D0-1 flags=3D0x4 nice=3D0 hung=3D56s workers=3D4 idle: 56 64


 # lspci=20
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 651 Host (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] AGP Port (virtual
PCI-to-PCI bridge)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media I=
O]
LPC Controller (rev 14)
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2/3 SMBus controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 IDE Controller
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS70=
12
AC'97 Sound Controller (rev a0)
00:03.0 USB controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 0f)
00:03.1 USB controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 0f)
00:03.2 USB controller: Silicon Integrated Systems [SiS] USB 1.1 Controller
(rev 0f)
00:03.3 USB controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:0a.0 Network controller: Ralink corp. RT2500 Wireless 802.11bg (rev 01)
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 10)
00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)]
IEEE 1394 OHCI Controller (rev 46)
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] R=
V350
[Radeon 9550/9600/X1050 Series]
01:00.1 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] RV350
[Radeon 9550/9600/X1050 Series] (Secondary)

 # inxi -bZ
System:    Host: hakla04 Kernel: 5.12.5-gentoo-Pentium4 i686 bits: 32 Deskt=
op:
MATE 1.24.0=20
           Distro: Gentoo Base System release 2.7=20
Machine:   Type: Desktop Mobo: Shuttle model: FS51 serial: N/A BIOS: Phoeni=
x v:
6.00 PG date: 12/02/2003=20
CPU:       Info: Single Core Intel Pentium 4 [MT] speed: 3063 MHz=20
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] RV350 [Radeon
9550/9600/X1050 Series] driver: radeon v: kernel=20
           Display: server: X.Org 1.20.0 driver: ati,radeon unloaded:
fbdev,modesetting resolution: 1600x900~60Hz=20
           OpenGL: renderer: llvmpipe (LLVM 11.1.0 128 bits) v: 4.5 Mesa 20=
.3.5=20
Network:   Device-1: Ralink RT2500 Wireless 802.11bg driver: rt2500pci=20
           Device-2: Realtek RTL-8100/8101L/8139 PCI Fast Ethernet Adapter
driver: 8139too

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
