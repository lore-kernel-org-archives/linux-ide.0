From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Thu, 03 Oct 2013 01:40:10 +0000
Message-ID: <bug-62351-11633-X1S1gy6QWM@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58602 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab3JCBkP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Oct 2013 21:40:15 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 90350202C1
	for <linux-ide@vger.kernel.org>; Thu,  3 Oct 2013 01:40:14 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 55E19202EB
	for <linux-ide@vger.kernel.org>; Thu,  3 Oct 2013 01:40:11 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

--- Comment #7 from Patrik Jakobsson <patrik.r.jakobsson@gmail.com> ---
> So, if you set "max_performance" explicitly, it works fine before suspending but after resuming it causes problems?

Yes, the only time I can set max_performance without getting errors is before
first suspend.

> What happens if you set "max_performance" explicitly instead of "min_power" after resume while the errors are happening? Does that resolve the issue too?

Setting max_performance explicitly after resume doesn't help. And if I first
set min_power after resume to stop the errors and then try max_performance
again, it will start spitting out errors again.

-- 
You are receiving this mail because:
You are on the CC list for the bug.
