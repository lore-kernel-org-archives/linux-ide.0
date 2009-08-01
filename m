From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] Suspend to disk no longer works in 2.6.30.2 with an EIDE
 drive
Date: Sat, 1 Aug 2009 19:12:55 GMT
Message-ID: <200908011912.n71JCtI8006087@demeter.kernel.org>
References: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35328 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZHATMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 15:12:55 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71JCt6h006088
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 19:12:55 GMT
In-Reply-To: <bug-13886-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886





--- Comment #5 from Rafael J. Wysocki <rjw@sisk.pl>  2009-08-01 19:12:54 ---
(In reply to comment #4)
> The fix mentioned above (commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a) does
> not address the problem I am encountering (which is present in 2.6.30.2).
> 

Bart's point is that the problem introduced by commit
295f00042aaf6b553b5f37348f89bab463d4a469 was fixed by commit
2ea5521022ac8f4f528dcbae02668e02a3501a5a, so if you have a bisection point
between the two commits, the bisection may lead to commit
295f00042aaf6b553b5f37348f89bab463d4a469 instead of the real culprit.

> There is no e100 hardware present here.

How is e100 relevant here?

> I am more than willing to help with the debugging process from this end.
> 
> Might we test by reverting his commit on 2.6.30.2?

That might be difficult, because I guess commit
295f00042aaf6b553b5f37348f89bab463d4a469 doesn't revert cleanly.

Could you instead test the kernel where commit
2ea5521022ac8f4f528dcbae02668e02a3501a5a is the head and see if the problem is
present there?

[Bart, I know you're not maintaining IDE any more, but your commit was pointed
out by the bisection.  Thanks for the information that it was a false
positive.]

First-Bad-Commit: unknown

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
