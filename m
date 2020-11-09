Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7AC2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 22:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04DA20789
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 22:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIWS7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIWS7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 17:18:59 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Mon, 09 Nov 2020 22:18:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: amubtdx@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205107-11633-1wfSCZxC3j@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205107-11633@https.bugzilla.kernel.org/>
References: <bug-205107-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205107

Alexis Murzeau (amubtdx@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |amubtdx@gmail.com

--- Comment #17 from Alexis Murzeau (amubtdx@gmail.com) ---
Hi,

I think I have the same problem:
Shutting down with a connected USB hard drive does not graceful park its head
(according to ear and smart data).

In smart data, "not graceful" means "Power-Off_Retract_Count" field is
incremented.

Linux 5.9, USB 3.0 hard drive WD Elements plugged on USB 3.0 port
Model Family:     Western Digital Elements / My Passport (USB, AF)
Device Model:     WDC WD20NMVW-11EDZS7
uname: Linux Debian2 5.9.0-1-amd64 #1 SMP Debian 5.9.1-1 (2020-10-17) x86_64
GNU/Linux


Depending on when I plug the hard disk, the poweroff behavior regarding the
disk isn't the same.
It depends on if I've pluged the disk before booting Linux (while in GRUB)
which produce the issue, or after having logged in where in that case there is
no issue.

But it seems that even when it does not emit clic sound and
Power-Off_Retract_Count is not incremented, SMART data is lost it seems, as I
would expected Start_Stop_Count, Power_Cycle_Count or Load_Cycle_Count to at
least be incremented (as when using udiskctl).

According to tests by setting manage_start_stop to 1, the head parking is done
gracefully whatever when the hard disk was plugged.
So setting manage_start_stop seems to be the way to fix this issue (or
workaround it at least), but it seems never set by default for USB disks.

I've compared with Windows' behavior in a VM and using Wireshark to monitor USB
packets and I don't see any START_STOP SCSI command but it does park its head
properly in all cases (even when booting with the hard disk already plugged
in).
When shutting down the Windows VM, the only packets I see are reads and writes.

However I don't think I can properly see VM's hub related packets in wireshark
(and the hard disk doesn't really spin down anyway).

On linux side, I've tried to replace xhci_shutdown by xhci_remove, but the
behavior is exactly the same.

I don't know well how USB hard drives are supposed to be shutdown, I was
thinking about the USB 3.0 U3 suspend mode or a ClearFeature, but that doesn't
seem to be that easy to understand.


I wonder if manage_start_stop shoud be enabled for USB hard disk by default ?
According to docs, it should be kept disabled for shared SCSI disks, but I
think USB disk are never shared.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
