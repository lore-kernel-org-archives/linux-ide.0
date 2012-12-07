From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Fri,  7 Dec 2012 07:00:38 +0000 (UTC)
Message-ID: <20121207070038.DB4DF11FEEA@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36025 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2LGHAp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2012 02:00:45 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 79F4620293
	for <linux-ide@vger.kernel.org>; Fri,  7 Dec 2012 07:00:43 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 3E6FD2026A
	for <linux-ide@vger.kernel.org>; Fri,  7 Dec 2012 07:00:42 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #51 from Aaron Lu <aaron.lu@intel.com>  2012-12-07 07:00:37 ---
The patch 'libata: set dma_mode to 0xff in reset' is taken by Jeff so this bug
can be closed, thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
