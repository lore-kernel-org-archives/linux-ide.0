From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 01:17:12 +0000
Message-ID: <bug-111151-11633-wAiVJdhIyy@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38896 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbcAWBRQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 20:17:16 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6B681205DC
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 01:17:15 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DC599205DD
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 01:17:12 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

--- Comment #2 from Andreas E <andi3@gmx.net> ---
Alan, thanks a lot for your input.

First of all...this stuff DOES work in Kernel 2.6.xx, go figure.

I can prove that because I made a mistake yesterday by cleaning up my root
partition a little bit too thoroughly. Well, both the empty (!) /run and /usr
dirs must exist on the partition to hook in /usr at bootup. Thought either
upstart or systemd would be as intelligent as creating either of them when not
there. Bleh. (PEBKAC: find . -maxdepth 1 -type d ! -xtype l -empty -delete)
;-))

To cut it short, I had to fix this by booting off an old CD-based 2.6.xx kernel
"mini linux", so I could watch the startup process AND ... !

amd74xx, the ancient IDE controller kernel module compiled in there, actaually
*DID* initialize the drive properly. (Well, to make it tougher for testing, I
intentionally booted off an _IDE_ CD-ROM drive! If amd74xx had shown the same
behavior as pata_amd, it would've choked _while_ booting up the old linux!)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
