From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 13:27:25 -0700 (PDT)
Message-ID: <20080313202725.2DE9910806A@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50042 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbYCMU1y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 16:27:54 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2DKSHEd003058
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 13:28:18 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|bzolnier@gmail.com          |




------- Comment #2 from bzolnier@gmail.com  2008-03-13 13:27 -------
Thanks, the drive survives the probe (is identified correctly) but fails when
there is a first attempt to use it with ide-cd.

Could you also send a dmesg from 2.6.23 (so we can compare these two)?

| Steps to reproduce:
| plug a plextor DVDR PX-740A as primary ide master.
| boot a kernel >= 2.6.24-rc1
|
| NB: if the plextor is on primary ide slave, there's no error.
| (the jumpers are ok).

Please confirm that I get this correctly - if the drive is plugged as master
and configured by _jumpers_ as master it also fails?

[ Also: is the drive connected to the "other" cable end (_not_ in the middle)
  when used as master? ]

PS I'm cc:ed on all IDE bugs anyway so I've removed myself from cc:


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
