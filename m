From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may fail to enable PATA device(s) via
 pata_amd | pata_acpi unless CRS is turned off by pci=nocrs
Date: Sat, 06 Feb 2016 00:01:29 +0000
Message-ID: <bug-111901-11633-jxrdCDxU4u@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50754 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcBFABc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 19:01:32 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5E29F203DB
	for <linux-ide@vger.kernel.org>; Sat,  6 Feb 2016 00:01:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id BD491203C0
	for <linux-ide@vger.kernel.org>; Sat,  6 Feb 2016 00:01:29 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Andreas E <andi3@gmx.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Pre-2008 boards may not     |Pre-2008 boards may fail to
                   |enable PATA device(s) via   |enable PATA device(s) via
                   |pata_amd | pata_acpi unless |pata_amd | pata_acpi unless
                   |CRS is turned off by        |CRS is turned off by
                   |pci=nocrs                   |pci=nocrs

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
