From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 01:38:32 +0000
Message-ID: <bug-111151-11633-focYeNyVhI@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39868 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832AbcAWBif (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 20:38:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E5205DF
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 01:38:33 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id B7E79205DC
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 01:38:32 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

--- Comment #3 from Andreas E <andi3@gmx.net> ---
P.S. 
>So the BIOS hasn't configured the controller by the look of it. 

Hang on, there's another specialty to mention. The SATA controller must be
enabled in the "Genie BIOS" (Serial ATA control -- Enabled). That's a sort of
appendix to the AWARD Bios 6.00 PG known especially from those old DFI boards.
But I'm sure it's enabled, because instead of the IDE Primary Master normally
there, the SATA drive will show up.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
