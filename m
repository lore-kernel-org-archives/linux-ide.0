From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Fri, 18 Dec 2009 09:28:08 GMT
Message-ID: <200912180928.nBI9S8tX008914@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:32807 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZLRJ2J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 04:28:09 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id nBI9S8q1008915
	for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 09:28:08 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #43 from Lennart Poettering <mzxreary@0pointer.de>  2009-12-18 09:28:06 ---
(In reply to comment #42)
> (In reply to comment #41)
> > (In reply to comment #36)
> > 
> > > * Spinning up drives in standby mode (smartmontools uses CHK_POWER to check
> > > power state before issuing SMART commands).
> > 
> > We do that too.
> 
> Strange.  If I put my WD green drives into powersave mode, the devkit smart
> polling always wakes it up.  On openSUSE 11.1, I had smartmontools running and
> it never happened.  I'll try to find out what the difference is.

Which version of libatasmart is that? We had some changes recently (oct) there
in the initialization order, because some commands apparently could cause a
wakeup on some drives which didnt cause one on others. You should have .17 for
this to work flawlessly.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
