From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Mon, 30 Sep 2013 21:47:14 +0000
Message-ID: <bug-62351-11633-po8hTZ5ziT@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44643 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab3I3VrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Sep 2013 17:47:17 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 95F5320336
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 21:47:16 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A125A20268
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 21:47:15 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

--- Comment #4 from Tejun Heo <tj@kernel.org> ---
So, when the machine boots up libata doesn't touch the LPM setting and just
considers it "max_performance", which may or may not be true. I think it'd work
the same if you just set the lpm knob to max_performance explicitly. The
problem is that your BIOS is most likely configuring DIPM on both the device
and host sides during boot; however, after coming back from suspend, the device
side seems to be configured but the host side isn't, so the device's LPM
operations register as link events to the controller leading to the spurious
failures.

Maybe we should set max_performance mode explicitly during boot requiring the
user to explicitly set min_power mode if [s]he wants to but then we might cause
power regression on some setups.

Anyways, can you please verify echoing max_performance also makes the issue go
away?

-- 
You are receiving this mail because:
You are on the CC list for the bug.
