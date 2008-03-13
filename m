From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 13:37:40 -0700 (PDT)
Message-ID: <20080313203740.D19D1108066@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36680 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754532AbYCMUhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 16:37:42 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2DKcWZh003784
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 13:38:34 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239





------- Comment #3 from bzolnier@gmail.com  2008-03-13 13:37 -------
| [ Also: is the drive connected to the "other" cable end (_not_ in the middle)
|   when used as master? ]

One more thing - please also verify that the cable is plugged correctly (not in
the reverse order) - the connector farer from the middle one (blue one) should
go to the controller.

[ Sorry for asking so many stupid questions but I would really like to exclude
  hardware configuration issue first. ]


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
