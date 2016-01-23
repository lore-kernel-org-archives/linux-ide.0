From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 17:09:36 +0000
Message-ID: <bug-111151-11633-iqvDaVqF0S@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59696 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcAWRJi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2016 12:09:38 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DF7CA203B0
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 17:09:37 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 48781203B6
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 17:09:36 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

--- Comment #6 from Alan <alan@lxorguk.ukuu.org.uk> ---
Just boot a live USB distro with a modern kernel - that will let yo do the
lspci -vvxxx running from USB even with no working hard disc

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
