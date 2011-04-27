From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33412] 2.6.39-rc3 udevadm settle timeout, many hdb events,
 interrupt storm
Date: Wed, 27 Apr 2011 21:07:42 GMT
Message-ID: <201104272107.p3RL7gLl027089@demeter1.kernel.org>
References: <bug-33412-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:59630 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1D0VHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Apr 2011 17:07:43 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3RL7gb9027090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 27 Apr 2011 21:07:43 GMT
In-Reply-To: <bug-33412-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33412


Tim Shepard <shep@alum.mit.edu> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |shep@alum.mit.edu




--- Comment #2 from Tim Shepard <shep@alum.mit.edu>  2011-04-27 21:07:32 ---
I just tried 2.6.39-rc5 and I see none of these problems.   (The problems still
existed in 2.6.39-rc4, so this got fixed between 2.6.39-rc4 and 2.6.39-rc5.)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
