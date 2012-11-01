From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Thu,  1 Nov 2012 15:18:30 +0000 (UTC)
Message-ID: <20121101151830.30DB511FB81@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52147 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992455Ab2KAPSe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2012 11:18:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6EC9820411
	for <linux-ide@vger.kernel.org>; Thu,  1 Nov 2012 15:18:33 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 1E8E820412
	for <linux-ide@vger.kernel.org>; Thu,  1 Nov 2012 15:18:31 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #30 from Roland Bogner <geist1@sms.at>  2012-11-01 15:18:29 ---
crash on 3.7 rc-3 too.
Asus M2N32-SLI
Last working kernel was 3-5.x

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
