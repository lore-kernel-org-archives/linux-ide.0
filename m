From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Tue, 01 Oct 2013 14:44:21 +0000
Message-ID: <bug-62351-11633-kFx92qKnYw@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45390 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab3JAOo2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Oct 2013 10:44:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9B12720420
	for <linux-ide@vger.kernel.org>; Tue,  1 Oct 2013 14:44:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 9410B20417
	for <linux-ide@vger.kernel.org>; Tue,  1 Oct 2013 14:44:21 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

--- Comment #6 from Tejun Heo <tj@kernel.org> ---
So, if you set "max_performance" explicitly, it works fine before suspending
but after resuming it causes problems? What happens if you set
"max_performance" explicitly instead of "min_power" after resume while the
errors are happening? Does that resolve the issue too?

Thanks.

-- 
You are receiving this mail because:
You are on the CC list for the bug.
