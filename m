From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Sat,  2 Aug 2008 22:00:02 -0700 (PDT)
Message-ID: <20080803050002.D9F9A11D10B@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50309 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939AbYHCFAe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 01:00:34 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m735021o001360
	for <linux-ide@vger.kernel.org>; Sat, 2 Aug 2008 22:00:03 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #16 from tj@kernel.org  2008-08-02 22:00 -------
Eh... devices_kset list is corrupt?  Strange.  It's added through
drivers/base/core.c::device_add() -> lib/kobject.c:kobject_add() ->
kobject_add_vargs() -> kobject_add_internal() -> kobj_kset_join() ->
include/linux/list.h::list_add_tail().

So, it seems loading ahci as module breaks the list.  Strange.  The list is
manipulated only through device_add() and device_del().  Can you please put
some tracing code there and see what's going on?  (ie. printk to print out
what's happening followed by infinite loop check)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
