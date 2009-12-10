From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 10 Dec 2009 14:44:04 GMT
Message-ID: <200912101444.nBAEi4Cl030562@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37062 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZLJOn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2009 09:43:57 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBAEi4CE030564
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2009 14:44:04 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #30 from Tejun Heo <tj@kernel.org>  2009-12-10 14:44:03 ---
One thing which changed with recent distros is the use of devicekit storage
stuff which seems to issue slightly different SMART commands than smartd, so
there's a slight chance that it might be causing some problem.  It would be
interesting to try new kernel on older distro and see whether the problem goes
away.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
