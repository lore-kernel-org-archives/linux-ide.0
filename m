From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sun,  2 Dec 2012 17:46:37 +0000 (UTC)
Message-ID: <20121202174637.F2AF211FEDD@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49465 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2LBRqn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 12:46:43 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9712E2032B
	for <linux-ide@vger.kernel.org>; Sun,  2 Dec 2012 17:46:41 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 06EAD20342
	for <linux-ide@vger.kernel.org>; Sun,  2 Dec 2012 17:46:40 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #48 from Szymon Janc <szymon@janc.net.pl>  2012-12-02 17:46:37 ---
Hi Aaron,

second patch works for me as well!

BR
Szymon Janc

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
