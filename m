From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 12:15:27 +0000
Message-ID: <bug-111151-11633-RvAzmKlSKz@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52245 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbcAWMPa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2016 07:15:30 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E4138202F0
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 12:15:28 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 730C8202E5
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 12:15:27 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

--- Comment #5 from Andreas E <andi3@gmx.net> ---
OK, I will.
Let me think...when booting FAILED, it stopped at the initramfs prompt.

I'm not sure if initramfs supports lspci, but I can try.
Also thought of forcing the system into a certain runlevel in both cases.
The Ubuntus have a very crazy "trick" to stop booting in mid-air: have an
additional drive defined in /etc/fstab which you physically disconnect.

Ubuntu will then issue the well-known "A starting job has been running for...1m
30s" and eventually give up, sardonically "welcoming" you to emergency mode.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
