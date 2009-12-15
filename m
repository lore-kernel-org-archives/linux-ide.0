From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 00:58:08 GMT
Message-ID: <200912150058.nBF0w8WR022101@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57984 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757798AbZLOA6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 19:58:09 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBF0w8NL022102
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 00:58:08 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kay.sievers@vrfy.org




--- Comment #36 from Tejun Heo <tj@kernel.org>  2009-12-15 00:58:06 ---
cc'ing Kay Sievers as he knows one or two things about how these things are
going.  Bartlomiej, yeah, it would have been nice if the code base were shared
but well nobody did that and it's good to have desktop integration.  It's
probably *lib*atasmart - it doesn't have anything to do with libata.  Anyways,
deviation from the command sequence used by smartmontools seems to cause two
problems till now.

* HSM violations on certain firmwares.

* Spinning up drives in standby mode (smartmontools uses CHK_POWER to check
power state before issuing SMART commands).

If someone is gonna report this to the upstream developer, please include both.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
