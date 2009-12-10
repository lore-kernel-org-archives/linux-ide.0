From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 10 Dec 2009 00:50:04 GMT
Message-ID: <200912100050.nBA0o4E2008956@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59787 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbZLJAt5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Dec 2009 19:49:57 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBA0o4ni008957
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2009 00:50:04 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #27 from Robert Hancock <hancockrwd@gmail.com>  2009-12-10 00:50:02 ---
Well, it is quite possible that a number of SSD devices would have the same
bug. There are only a few different manufacturers of the actual controller that
talks on the ATA bus, regardless of who makes the flash chips or who prints
their name on the device.

If 2.6.28 is indeed OK (not just that the problem happens less frequently) then
likely the easiest way to track it down would be for someone to try bisecting.
That's assuming the problem is caused by a single bad commit, though. If the
problem isn't actually due to any change in behavior but just a difference in
timing or something like that, then it's possible the bisect may not come up
with anything useful. It'd be an important troubleshooting step nonetheless,
however.

If there were any really "erroneous" exchanges before that we would have seen
error reports about them, unless I misunderstand what you mean..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
