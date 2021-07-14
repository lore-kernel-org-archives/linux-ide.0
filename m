Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF19C11F66
	for <linux-ide@archiver.kernel.org>; Wed, 14 Jul 2021 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FD7613BF
	for <linux-ide@archiver.kernel.org>; Wed, 14 Jul 2021 09:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhGNKBW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239015AbhGNKBU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 14 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 082FC613C5
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2021 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626256709;
        bh=EpIX8KlHfDjHfXUanFJMZuiMayfKL4spzrew4kUInY0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R5aC3yP/Lp0K6Kio9GIODeUA4xNobi1DDJV5Q4DqU2YcPNm4x5YpupC1fjPcG+QRF
         U8GfXTaQCEwQl/0qaM/pSoLf6LhdAGfBq7Q9S791AfTzAJ/mgVGZXZUi+ZMpVzHg9S
         CF8cpYLRxZr97jMsHr308D9/drRpYOAbuvX0X3Jo5LmAVIRP0BMkd+T7AjAMxOOeFI
         CyMxRz9IG0r5j0ucp0LszoKhNZG++bCuXEwU/v75zBcMu4Bp7oezJroRVyUfVnNvMi
         PQsPEeB2cutflluwEb9IFMIsswshJNH+BZstf0Hw2+Kj7+3G+/0ym59HBN0oTs/Opg
         SrNiLHV/zpVBA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 213157] BUG: unable to handle page fault for address: fffbb000,
 Workqueue: ata_sff ata_sff_pio_task
Date:   Wed, 14 Jul 2021 09:58:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213157-11633-q51znpUZ1f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213157-11633@https.bugzilla.kernel.org/>
References: <bug-213157-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213157

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 297837
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297837&action=3Dedit
dmesg (kernel 5.14-rc1, Shuttle XPC FS51, Pentium 4)

No change in 5.14-rc1:

[...]
BUG: unable to handle page fault for address: fff9a000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
*pde =3D 1552a067 *pte =3D 00000000=20
Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.14.0-rc1-Pentium4 #3
Hardware name:  /FS51, BIOS 6.00 PG 12/02/2003
Workqueue: ata_sff ata_sff_pio_task
EIP: ioread16_rep+0x25/0x37
Code: ff ff 5f 5d c3 55 89 e5 57 89 d7 3d ff ff 03 00 76 0e 49 78 24 66 8b =
10
66 89 17 83 c7 02 eb f2 3d 00 00 01 00 76 08 0f b7 d0 <f3> 66 6d eb 0a ba 2=
8 7c
34 d5 e8 6b fd ff ff 5f 5d c3 55 89 e5 57
EAX: 000101f0 EBX: 00000100 ECX: 00000080 EDX: 000001f0
ESI: 00000200 EDI: fff9a000 EBP: c1227e7c ESP: c1227e78
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
CR0: 80050033 CR2: fff9a000 CR3: 15527000 CR4: 000006d0
Call Trace:
 ata_sff_data_xfer+0x2b/0x7e
 ? ata_qc_from_tag+0x44/0x44
 ata_pio_sector+0x81/0xee
 ata_pio_sectors+0x2d/0x69
 ata_sff_hsm_move+0x490/0x534
 ? __delay+0x10/0x12
 ? ata_sff_check_status+0xb/0xd
 ata_sff_pio_task+0x67/0xc6
 process_one_work+0x24f/0x3ba
 worker_thread+0x164/0x1f7
 kthread+0xd9/0xdb
 ? drain_workqueue+0xf5/0xf5
 ? set_kthread_struct+0x2c/0x2c
 ret_from_fork+0x1c/0x28
Modules linked in:
CR2: 00000000fff9a000
---[ end trace f06cc7f5ba75146c ]---
EIP: ioread16_rep+0x25/0x37
Code: ff ff 5f 5d c3 55 89 e5 57 89 d7 3d ff ff 03 00 76 0e 49 78 24 66 8b =
10
66 89 17 83 c7 02 eb f2 3d 00 00 01 00 76 08 0f b7 d0 <f3> 66 6d eb 0a ba 2=
8 7c
34 d5 e8 6b fd ff ff 5f 5d c3 55 89 e5 57
EAX: 000101f0 EBX: 00000100 ECX: 00000080 EDX: 000001f0
ESI: 00000200 EDI: fff9a000 EBP: c1227e7c ESP: c1227e78
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
CR0: 80050033 CR2: fff9a000 CR3: 15527000 CR4: 000006d0
note: kworker/1:1[32] exited with preempt_count 2
[...]

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
