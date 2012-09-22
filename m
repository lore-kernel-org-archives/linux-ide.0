From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 47781] New: ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002
 action 0xe frozen
Date: Sat, 22 Sep 2012 06:54:31 +0000 (UTC)
Message-ID: <bug-47781-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38696 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab2IVGym (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Sep 2012 02:54:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 63008201F9
	for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2012 06:54:37 +0000 (UTC)
Received: from bugzilla.kernel.org (unknown [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 1C3C5201F4
	for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2012 06:54:32 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=47781

           Summary: ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002
                    action 0xe frozen
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.6 rc6 i386
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: dyvazar@numericable.fr
        Regression: No


Created an attachment (id=80691)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=80691)
dmesg bootlog

I'm getting some errors at boot time, since a while, on a ubuntu quantal i386
system:

prereset failed (errno -19)

then the system continue to boot. But today i get some more errors after that
one:

ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
ata2: irq_stat 0x00000040, connection status changed
ata2: SError: { RecovComm PHYRdyChg CommWake DevExch }
ata2: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: unsupported device, disabling
ata2.00: disabled
ata2: EH complete

note: i'm not sure thats a IO error about ide, so please feel free to change
for good debug team if needed.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
