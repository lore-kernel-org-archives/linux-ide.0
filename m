From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Fri,  2 Nov 2012 12:07:38 +0000 (UTC)
Message-ID: <20121102120738.70E9911FB80@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51962 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2KBMHm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Nov 2012 08:07:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E455E20278
	for <linux-ide@vger.kernel.org>; Fri,  2 Nov 2012 12:07:40 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id CCCE420257
	for <linux-ide@vger.kernel.org>; Fri,  2 Nov 2012 12:07:39 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #31 from Roland Bogner <geist1@sms.at>  2012-11-02 12:07:37 ---
Re-Compiled ubuntu mainline kernel without enabling "ATA-ACPI Support" then i
was able to boot the kernel without the freeze.

Unfortunaly none IDE HDD's works then.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
