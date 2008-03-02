From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Sun,  2 Mar 2008 05:52:04 -0800 (PST)
Message-ID: <20080302135205.01992108063@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41786 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752231AbYCBNwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 08:52:07 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m22Dq8rY014538
	for <linux-ide@vger.kernel.org>; Sun, 2 Mar 2008 05:52:09 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #2 from qrees@poczta.fm  2008-03-02 05:52 -------
As I said, There is no log of the crash, because system just stops working. It
just freezes, I can't move mouse, change console... nothing. I can only press
reset button... I have tested many kernel versions, but this bug apears in 2.2,
2.4, 2.6 kernels.

Photo would be quite useless, because screen looks normal . There are no
additional messages on the screen. What's more it's quite difficult to show
that the screen (and anything else...) is frozen on photo ;).

PS: in 1st post should be vt8233 chipset, not via8233 chipset (which doesn't
exist ;) ).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
