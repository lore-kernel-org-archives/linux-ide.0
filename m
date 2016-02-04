From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Thu, 04 Feb 2016 22:43:55 +0000
Message-ID: <bug-111151-11633-rZy5ArTp7Q@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57582 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345AbcBDWn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Feb 2016 17:43:58 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B37F82038E
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:43:57 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 37A6C20390
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:43:56 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

Andreas E <andi3@gmx.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |INVALID

--- Comment #10 from Andreas E <andi3@gmx.net> ---
Closing this!

With lots of help from Oleg B. ( @ Launchpad), it could be figured out that for
old and very old boards, it is mandatory to set pci=nocrs as a kernel cheat
code. Otherwise none of the kernels < 4.4.0 will boot in old machines, or at
least, there won't be any onboard IDE possible as the BAR is always (deemed) 0.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
