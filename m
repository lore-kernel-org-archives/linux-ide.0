From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 05:36:56 -0700 (PDT)
Message-ID: <20081016123656.AB2DD108042@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42099 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755253AbYJPMg7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 08:36:59 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GCaude001077
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 05:36:57 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #16 from stan.cunningham@yahoo.com  2008-10-16 05:36 -------
Valerio,

I'm afraid you've stumbled on an ongoing dispute among developers regarding
which drivers to use and improve. The "piix" driver is part of the old "ide"
framework that is being replaced. The ata_piix driver is part of the new
"libata" framework that is close to doing everything that "ide" does, plus a
lot more.

Some developers like Borislav are sadly willing to spend their time on the old
"ide" framework, which will be removed from the kernel soon. That would be
fine, if it weren't for the fact that they are also wasting the users' (read:
your) time debugging and git-bisecting a dead horse. You can read some
background on the problem at
http://marc.info/?l=linux-ide&m=122392751706811&w=2 .

If ata_piix works for you, just use that. Please attach the boot time errors
you mentioned in Comment #14 so that they can be fixed in libata/ata_piix.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
