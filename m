From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] Suspend to disk no longer works in 2.6.30.2 with an EIDE
 drive
Date: Sat, 1 Aug 2009 10:22:04 GMT
Message-ID: <200908011022.n71AM4nb014527@demeter.kernel.org>
References: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55210 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbZHAKWE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 06:22:04 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71AM4EA014528
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 10:22:04 GMT
In-Reply-To: <bug-13886-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886


Andrew Morton <akpm@linux-foundation.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |akpm@linux-foundation.org,
                   |                            |pavel@suse.cz, rjw@sisk.pl
         Regression|No                          |Yes




--- Comment #1 from Andrew Morton <akpm@linux-foundation.org>  2009-08-01 10:22:03 ---
marked as regression, cc'ed s2d developers.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
