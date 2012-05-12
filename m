From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 43211] Pressing the DVD eject button renders the DVD-ROM
 unusable
Date: Sat, 12 May 2012 00:19:17 +0000 (UTC)
Message-ID: <20120512001917.6F14E11FCE3@bugzilla.kernel.org>
References: <bug-43211-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48884 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761481Ab2ELATU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 20:19:20 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2021920278
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 00:19:19 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.204])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB220275
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 00:19:18 +0000 (UTC)
In-Reply-To: <bug-43211-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=43211


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
          Component|IDE                         |Config-Hotplug
         AssignedTo|io_ide@kernel-bugs.osdl.org |acpi_config-hotplug@kernel-
                   |                            |bugs.osdl.org
            Product|IO/Storage                  |ACPI




--- Comment #3 from Alan <alan@lxorguk.ukuu.org.uk>  2012-05-12 00:19:17 ---
The eject button appears to be set via ACPI to physically disconnect and power
off the device. That's not usual behaviour and would explain this.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
