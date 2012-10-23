From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 16:39:42 +0000 (UTC)
Message-ID: <20121023163942.A950F11FC3E@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47356 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab2JWQjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 12:39:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 21A0720458
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 16:39:47 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 27BB920455
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 16:39:46 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151


Szymon Janc <szymon@janc.net.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |szymon@janc.net.pl




--- Comment #18 from Szymon Janc <szymon@janc.net.pl>  2012-10-23 16:39:42 ---
Hi,

I see this crash on pc with ASUS A8N-E board (about half of boot attempts).

But only if both pata_acpi and pata_amd are loaded... I've disabled pata_amd
and I'm not able to reproduce this (tried 10 reboots) if only pata_acpi is
used.


BR
Szymon

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
