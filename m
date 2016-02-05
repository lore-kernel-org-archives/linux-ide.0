From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may not enable PATA device(s) via
 pata_amd | pata_acpi unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 23:49:30 +0000
Message-ID: <bug-111901-11633-RlD8KzV7cQ@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50473 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcBEXtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 18:49:33 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 20003203E6
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 23:49:32 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id BDCAE203C2
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 23:49:30 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Andreas E <andi3@gmx.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Pre-2008 boards may show    |Pre-2008 boards may not
                   |errors in pata_amd |        |enable PATA device(s) via
                   |pata_acpi unless CRS is     |pata_amd | pata_acpi unless
                   |turned off by pci=nocrs     |CRS is turned off by
                   |                            |pci=nocrs

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
