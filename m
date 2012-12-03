From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon,  3 Dec 2012 00:51:47 +0000 (UTC)
Message-ID: <20121203005147.7C13D11FEA5@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57588 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122Ab2LCAvw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 19:51:52 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 209882036B
	for <linux-ide@vger.kernel.org>; Mon,  3 Dec 2012 00:51:51 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 6747820361
	for <linux-ide@vger.kernel.org>; Mon,  3 Dec 2012 00:51:49 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #49 from Aaron Lu <aaron.lu@intel.com>  2012-12-03 00:51:46 ---
Thank you all for your test result, I'll update the patch with all of your
Tested-by tag, please let me know if you don't think I can add yours. And then
I'll send it to linux-ide mailing list, then Jeff will probably take this
patch.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
