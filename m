From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 07:49:00 -0700 (PDT)
Message-ID: <20081016144900.19354108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52675 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753906AbYJPOtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 10:49:03 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GEn0mH010211
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 07:49:01 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #18 from bzolnier@gmail.com  2008-10-16 07:48 -------
> Some developers like Borislav are sadly willing to spend their time on the old
> "ide" framework, which will be removed from the kernel soon. That would be

I hear this since 2005...

Nobody is going to remove "old" framework anytime soon.  It is still a
preferred solution on the embedded front (we've just support for another
controller recently) and many non-x86 platforms.

There is a lot of non-ISA/VLB & non-x86 hardware that is not supported by
libata.  Please check up your facts.

> fine, if it weren't for the fact that they are also wasting the users' (read:
> your) time debugging and git-bisecting a dead horse. You can read some

Nobody is forcing anybody here to do anything.  People are free to use or
develop whatever driver or framework they want.

Please keep the discussion technical == free of unfounded speculations and your
personal preferences.  If you want to show your support for libata the best way
to do it is to go work on it instead of forcing other people to do it.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
