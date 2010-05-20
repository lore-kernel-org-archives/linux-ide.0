From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 09:09:09 GMT
Message-ID: <201005200909.o4K9999s001489@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55855 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0ETJJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 05:09:11 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4K99A6Z001491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 09:09:10 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094


Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tj@kernel.org




--- Comment #25 from Tejun Heo <tj@kernel.org>  2010-05-20 09:08:51 ---
Artem, if some tool is showing iowait as cpu time consumed, that tool needs to
be fixed.  The kernel is simply exporting what it's doing.  The presentation is
upto system monitoring tools.  I recall lots of tools which kind of gave the
wrong signals years ago but these days I don't recall seeing such things too
often.  There always is a problem with people who are fixated on weird stuff
but I don't think it's possible to satisfy everyone.  We can't show cached as
free memory for people who claim the kernel is wasting all memory, right? 
That's a very bad solution for a virtually non-existing problem.

Zenith88, if Linux grinds your gears that much and makes you angry, go ahead
and use or do something else.  Life is short.  Do something you like and, well,
more importantly to me, don't get in the way of other people at the very least.
 If you wanna actually delve into solving a technical issue, please stay
technical from this point on.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
