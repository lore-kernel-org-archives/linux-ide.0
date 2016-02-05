From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 21:06:47 +0000
Message-ID: <bug-111901-11633-fp53E88u2l@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42540 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcBEVGt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 16:06:49 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B9053203B5
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 21:06:48 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 5D557203AC
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 21:06:47 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

--- Comment #5 from Andreas E <andi3@gmx.net> ---
to comment 2.

Alan, I set 'Intel' as a collective term supposed to include both i386 and
x86-64. 
(at least I _thought_ the i originally stood for Intel)

Currently it's set to 64bit only. I'm on 32bit, though, FYI.

$10,000 question:
How can we set _both_ i386 and x86-64 in Hardware drop-down menu?
Looks impossible to me.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
