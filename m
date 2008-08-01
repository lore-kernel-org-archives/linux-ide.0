From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri,  1 Aug 2008 13:00:02 -0700 (PDT)
Message-ID: <20080801200002.9F0D8108038@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53720 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754070AbYHAUAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 16:00:30 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71K02aL030420
	for <linux-ide@vger.kernel.org>; Fri, 1 Aug 2008 13:00:03 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #15 from gfpadovan@gmail.com  2008-08-01 13:00 -------
The dev->kobj.entry.prev and dev->kobj.entry.next point to same place. But I
noted that it isn't the one. This happens with other devices too.

So I tried whit this:

list_for_each_entry(dev, &devices_kset->list, kobj.entry) {
                dev_emerg(dev, " dev=%p prev=%p next=%p\n", dev->kobj.entry,
                dev->kobj.entry.prev, dev->kobj.entry.next)

And the unique dev that dev->kobj.entry, dev->kobj.entry.prev and
dev->kobj.entry.next point to same place. So we take an infinite loop.

Where is the function that include the device on the list? Is 
device_initialize()?

If my English is bad, ask me to rewrite this.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
