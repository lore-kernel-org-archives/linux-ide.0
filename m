From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 15:49:42 GMT
Message-ID: <201005201549.o4KFngro010990@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39316 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0ETPto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 11:49:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KFnhvB010991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 15:49:43 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #26 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-20 15:49:11 ---
(In reply to comment #25)
> Artem, if some tool is showing iowait as cpu time consumed, that tool needs to
> be fixed.  The kernel is simply exporting what it's doing.  The presentation is
> upto system monitoring tools.  I recall lots of tools which kind of gave the
> wrong signals years ago but these days I don't recall seeing such things too
> often.  There always is a problem with people who are fixated on weird stuff
> but I don't think it's possible to satisfy everyone.  We can't show cached as
> free memory for people who claim the kernel is wasting all memory, right? 
> That's a very bad solution for a virtually non-existing problem.
> 

Are you aware of any other tools except htop and top (from procps package)?
They both show IO wait as CPU load.

What about kernel itself? load average to my knowledge is statistical data
exported by kernel itself and according to your words this data can be trusted,
or I am missing something here?  Why do we have this kind of situation (I need
to quote myself here):

(In reply to comment #21)
> 
> `cat /dev/sda > /dev/null` results in load average rapidly climbing to 1.32 and
> counting on my PC, that's just insane and wrong.

I've just rerun this test for 10 minutes and load average climbed to 2.14 on my
4 cores SMP system (2 real cores, 2 HT's). That means that intensive I/O
operations consume a mind boggling 50% of my CPU power and mind that I have a
really fast CPU (3.4GHz Intel Core i5).

On this issue there are two almost identical bugs filed by me, bug 14531 and
bug 14648 but it seems like no one cares.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
