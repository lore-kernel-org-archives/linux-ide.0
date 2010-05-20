From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 16:56:55 GMT
Message-ID: <201005201656.o4KGutvk001601@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36779 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0ETQ4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 12:56:55 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KGut0B001602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 16:56:55 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #28 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-20 16:56:48 ---
> Load is the average number of threads which are running or willing to run.  It
> doesn't have much to do with actual cpu usage.  Load average can and does go
> way above the number of processors.  It doesn't mean the kernel is creating
> virtual cpus for you.

I haven't said anything about creation of virtual CPUs, but I've always thought
that one can estimate real system load (it maybe above 100%) by diving load
average by number of CPUs and for "normal" tasks like mathematical calculations
this principle holds true. E.g. :

`cat < /dev/urandom > /dev/null` on all Unixes will result in 1.0 load average.
That means that one CPU or CPU core is 100% busy. Run this task twice and
you'll get 2.0 load average or for 4 cores system that means half of the CPUs
are busy churning random numbers.

Why this principle doesn't hold true for tasks which are bound by IO operations
is beyond my understanding. Why IO wait time is even included in load average
statistics is also beyond my understanding.

So, on behalf of almost all Linux users I have to ask this hard question: how
one is supposed to understand/interpret top/htop/whatever_else_utility numbers
when IDLE time is shown as _0%_ for _all_ IO intensive operations? In OS,
everyone hates but most people still use, IO wait time is shown as kernel time
but otherwise CPU is mostly _idle_ (90% of more, depending on chipset, IO
drivers, etc) - in Linux CPU is _100% busy_ - and it makes no sense, e.g.

`cat /dev/sda > /dev/null`

will result in top showing:

Cpu(s):  4.3%us,  4.0%sy,  0.0%ni, 75.4%id, 15.8%wa,  0.0%hi,  0.5%si,  0.0%st

As you can clearly see my 4 CPUs system is approximately 25% busy, i.e. one CPU
is 100% busy doing something.

So, _please_, fix the kernel, fix top/htop/load_average, fix whatever you want,
but, please, stop confusing people with numbers that make no sense.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
