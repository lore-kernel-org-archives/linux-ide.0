From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Fri, 14 Mar 2008 01:30:29 -0700 (PDT)
Message-ID: <20080314083029.B0C52108064@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50454 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751641AbYCNIac (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2008 04:30:32 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E8VNjU026300
	for <linux-ide@vger.kernel.org>; Fri, 14 Mar 2008 01:31:25 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239





------- Comment #4 from richard.genoud@gmail.com  2008-03-14 01:30 -------
> Please confirm that I get this correctly - if the drive is plugged as master
> and configured by _jumpers_ as master it also fails?
> [ Also: is the drive connected to the "other" cable end (_not_ in the middle)
>   when used as master? ]
yep!

doesn't work:
IDE drive configured by jumper as master AND connected to the end of the cable.

does work:
IDE drive configured by jumper as slave AND connected to the middle of the
cable.

By the way, the presence of another drive on the cable doesn't seem to change
anything.

[I didn't try:
IDE drive configured by jumper as master AND connected to the middle of the
cable.
IDE drive configured by jumper as slave AND connected to the end of the cable.
but I can try if you want]

And the calbe I use is a 80 connector.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
