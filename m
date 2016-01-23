From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 21:13:14 +0000
Message-ID: <bug-111151-11633-bjjEXED1A0@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36324 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbcAWVNR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2016 16:13:17 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 234A320394
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 21:13:16 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id BD3F52038A
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 21:13:14 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

--- Comment #8 from Andreas E <andi3@gmx.net> ---
Added Launchpad bug link above.
Shouldn't have missed that bug before.
"Sergey" claims it to be fixed in 4.4 And I'm on 4.2.0.
Must check!

*HOWEVER* Supposing it does work in 4.4, fix must be backported because
corporate servers can't take the risk of changing whole kernel branch, merely a
fraction of version (the y in x.y) will be appropriate.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
