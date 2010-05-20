From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 16:14:50 GMT
Message-ID: <201005201614.o4KGEo3J019658@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58123 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0ETQOu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 12:14:50 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KGEoSq019659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 16:14:50 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #27 from Tejun Heo <tj@kernel.org>  2010-05-20 16:14:28 ---
(In reply to comment #26)
> Are you aware of any other tools except htop and top (from procps package)?
> They both show IO wait as CPU load.

No, they don't.  They clearly distinguish between sys, user, idle and iowait. 
You're confusing cpu usage and load average.

> What about kernel itself? load average to my knowledge is statistical data
> exported by kernel itself and according to your words this data can be trusted,
> or I am missing something here?  Why do we have this kind of situation (I need
> to quote myself here):

It just seems that you're misunderstanding what 'load' means.

> I've just rerun this test for 10 minutes and load average climbed to 2.14 on my
> 4 cores SMP system (2 real cores, 2 HT's). That means that intensive I/O
> operations consume a mind boggling 50% of my CPU power and mind that I have a
> really fast CPU (3.4GHz Intel Core i5).

Load is the average number of threads which are running or willing to run.  It
doesn't have much to do with actual cpu usage.  Load average can and does go
way above the number of processors.  It doesn't mean the kernel is creating
virtual cpus for you.

> On this issue there are two almost identical bugs filed by me, bug 14531 and
> bug 14648 but it seems like no one cares.

If you don't clearly understand the issue technically (which is expected for
anyone who's not working on the specific area), it usually is a much better
idea to report what problem you're experiencing as a user.  Sure, your
conjecture or gut feeling can be helpful and it's a good idea to present them
but please always keep in mind the possibility of them being completely wrong
and/or irrelevant.

Good: While a large file is being copied, the system is very sluggish.  I can't
hardly move mouse pointer and simple command like ls takes minutes to complete.
 While this is happening, the load avg is such and such and I suspect this
might have something to do with the sluggishness.  My system information is
such and such...

Bad: While a large file is being copied, 150% of my cpu is being used
(misinterpreting load avg as cpu usage), please fix.

So, what actual problem are you seeing other than the expected high load avg?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
