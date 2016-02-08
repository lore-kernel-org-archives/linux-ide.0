From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may fail to enable PATA device(s) via
 pata_amd | pata_acpi unless CRS is turned off by pci=nocrs
Date: Mon, 08 Feb 2016 20:50:47 +0000
Message-ID: <bug-111901-11633-wSlQDq9Yyf@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36269 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbcBHUuv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Feb 2016 15:50:51 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 28939203B4
	for <linux-ide@vger.kernel.org>; Mon,  8 Feb 2016 20:50:50 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 28807203DC
	for <linux-ide@vger.kernel.org>; Mon,  8 Feb 2016 20:50:49 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Bjorn Helgaas <bhelgaas@google.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bhelgaas@google.com
          Component|IDE                         |PCI
           Hardware|x86-64                      |All
           Assignee|io_ide@kernel-bugs.osdl.org |drivers_pci@kernel-bugs.osd
                   |                            |l.org
            Product|IO/Storage                  |Drivers

--- Comment #7 from Bjorn Helgaas <bhelgaas@google.com> ---
Moving to drivers/pci category.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
