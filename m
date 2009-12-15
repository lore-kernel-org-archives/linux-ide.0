From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 14:39:37 GMT
Message-ID: <200912151439.nBFEdbY9007818@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50214 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZLOOjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 09:39:37 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBFEdbIJ007819
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 14:39:37 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #38 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-12-15 14:39:35 ---
On Tuesday 15 December 2009 01:58:08 am bugzilla-daemon@bugzilla.kernel.org
wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14583
> 
> 
> Tejun Heo <tj@kernel.org> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |kay.sievers@vrfy.org
> 
> 
> 
> 
> --- Comment #36 from Tejun Heo <tj@kernel.org>  2009-12-15 00:58:06 ---
> cc'ing Kay Sievers as he knows one or two things about how these things are
> going.  Bartlomiej, yeah, it would have been nice if the code base were shared
> but well nobody did that and it's good to have desktop integration.  It's

After reading project's homepage it is clear that it was done in order
for desktop integration.  However I couldn't find any previous discussions
about the best way to solve the problem on the net and it just seems like
there wasn't even any attempt of involving smartmontools developers in the
loop (I didn't look very carefully though).

While this is not a lot of code it is a very sensitive area and bugs
involving S.M.A.R.T. support (or firmware issues in general) have been
always real hassle to debug and workaround/fix.

Sharing low-level code base with smartmontools will be great as it is not
Linux-only thing (which in this case helps a lot with additional testing
and verification on other platforms) and actually has a people with a lot
of needed ATA background/experience behind the project.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
