From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Fri, 18 Dec 2009 08:45:20 GMT
Message-ID: <200912180845.nBI8jKCS003565@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53332 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZLRIpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 03:45:20 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id nBI8jKki003566
	for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 08:45:20 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #42 from Tejun Heo <tj@kernel.org>  2009-12-18 08:45:17 ---
(In reply to comment #41)
> (In reply to comment #36)
> 
> > * Spinning up drives in standby mode (smartmontools uses CHK_POWER to check
> > power state before issuing SMART commands).
> 
> We do that too.

Strange.  If I put my WD green drives into powersave mode, the devkit smart
polling always wakes it up.  On openSUSE 11.1, I had smartmontools running and
it never happened.  I'll try to find out what the difference is.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
