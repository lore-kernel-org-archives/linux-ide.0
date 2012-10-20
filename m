From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Sat, 20 Oct 2012 10:19:22 +0000 (UTC)
Message-ID: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39175 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab2JTKT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2012 06:19:26 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E424D2019A
	for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2012 10:19:25 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id DDC9020197
	for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2012 10:19:23 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151

           Summary: NULL pointer dereference in pata_acpi
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.6.2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: phillip.wood@dunelm.org.uk
        Regression: No


Just upgraded from 3.2.20 to 3.6.2 and when I try to boot a get

BUG unable to handle kernel NULL pointer dereference at 00000010
IP [<efe4c2407>] pacpi_set_dmamode+0x50/0xa0 [pata_acpi]

and it wont find my hard disc. I'm using the standard arch linux kernel config
available at
https://projects.archlinux.org/svntogit/packages.git/tree/trunk/config?h=packages/linux

I've attached a couple of photos of the message and backtrace

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
