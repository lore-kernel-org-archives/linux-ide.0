From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Fri, 18 Dec 2009 09:42:38 GMT
Message-ID: <200912180942.nBI9gcdw010404@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53227 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbZLRJmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 04:42:40 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id nBI9gcaL010405
	for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 09:42:38 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #44 from Tejun Heo <tj@kernel.org>  2009-12-18 09:42:36 ---
It says libatasmart4-0.14-3.2.x86_64 which has been shipped with openSUSE 11.2.
 So, too old by three minor versions.  I'll try newer one.

BTW, I just tried to reproduce the problem and it's a bit strange.  If I put
the hard drive into explicit standby using 'hdparm -y', it stays suspended but
if the standby timer puts the drive into standby mode, it gets woken up by
devkit smart refresh.

Anyways, will try newer one.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
