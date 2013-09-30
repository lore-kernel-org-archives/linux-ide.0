From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Mon, 30 Sep 2013 19:14:58 +0000
Message-ID: <bug-62351-11633-0sp6Kd5wAV@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40270 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab3I3TPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Sep 2013 15:15:01 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 135CB20265
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 19:15:00 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 2384E20237
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 19:14:59 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tj@kernel.org

--- Comment #2 from Tejun Heo <tj@kernel.org> ---
Hello, Patrik.

Can you please do "echo min_power >
/sys/class/scsi_host/host0/link_power_management_policy" before suspend and see
whether anything changes?

Thanks.

-- 
You are receiving this mail because:
You are on the CC list for the bug.
