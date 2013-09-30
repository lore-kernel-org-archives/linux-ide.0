From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Mon, 30 Sep 2013 23:02:29 +0000
Message-ID: <bug-62351-11633-BHLQooxxCM@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46454 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab3I3XCd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Sep 2013 19:02:33 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 190FE20362
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 23:02:32 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id C61642035A
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 23:02:29 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

--- Comment #5 from Patrik Jakobsson <patrik.r.jakobsson@gmail.com> ---
Here are all the test cases:

After boot: LPM policy reports max_performance and min_power and
max_performance can be switched back and forth without any errors.

Before suspend: If I don't touch LPM policy after boot (still reporting
max_performance) I can successfully suspend and LPM policy still reports
max_performance (though probably incorrect) after resume.

Before suspend: If I explicity set max_performance after boot and go into
suspend it fails. If I set min_power back in this state, the errors stop.

Before suspend: If I explicity set min_power after boot and go into suspend it
succeeds.

So I must either never touch the LPM policy or set it to min_power to not get
the errors on resume. min_power seems to be what the hardware is set to but
doesn't get reported correctly (as you say) until I've actually set it to
something.

-- 
You are receiving this mail because:
You are on the CC list for the bug.
