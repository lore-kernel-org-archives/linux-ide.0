From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11498] Teac DV28EV stops working with ide-cd
Date: Wed,  8 Oct 2008 01:03:39 -0700 (PDT)
Message-ID: <20081008080339.C4597108057@picon.linux-foundation.org>
References: <bug-11498-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41102 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021AbYJHIDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 04:03:41 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9883dH3019123
	for <linux-ide@vger.kernel.org>; Wed, 8 Oct 2008 01:03:40 -0700
In-Reply-To: <bug-11498-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11498


dcl@hppine99.gbr.hp.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dcl@hppine99.gbr.hp.com




------- Comment #5 from dcl@hppine99.gbr.hp.com  2008-10-08 01:03 -------
I started to investigate this problem when it was also reported to me. The
issue seems to pertain to the TEAC DV*28* family of devices only.  The HAL
'hald-addon-storage' polling daemon seemed to be the process that perturbed the
problem, as a result I extracted the relevant syscalls from an strace and was
able to develop a simple stand-alone reproducer script and C-program.

Here are the results of a test run, showing the problem:

[root@gtr01 tests]# ./tryme
Problem seen 14 times in 500000 iterations


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
