From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13696] Reading a DVD crashes the kernel
Date: Fri, 3 Jul 2009 12:09:50 GMT
Message-ID: <200907031209.n63C9oRT032697@demeter.kernel.org>
References: <bug-13696-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34523 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZGCMJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 08:09:47 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n63C9otX032698
	for <linux-ide@vger.kernel.org>; Fri, 3 Jul 2009 12:09:50 GMT
In-Reply-To: <bug-13696-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13696


Bernardo Dal Seno <dibbex@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |DUPLICATE




--- Comment #2 from Bernardo Dal Seno <dibbex@gmail.com>  2009-07-03 12:09:49 ---
Yes, the patch solves the problem.  Thank you.

Sorry for the duplicate; probably when I searched for existing bug reports I
thought that a bug found in 2.6.30-rc1 was fixed in 2.6.30 and I didn't check
the date.

Best regards,
Bernardo

*** This bug has been marked as a duplicate of bug 13399 ***

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
