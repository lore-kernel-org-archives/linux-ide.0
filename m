From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon, 29 Dec 2008 12:16:51 -0800 (PST)
Message-ID: <20081229201651.52A7810800E@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33733 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399AbYL2UQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 15:16:54 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBTKGpln029871
	for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 12:16:52 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #8 from bzolnier@gmail.com  2008-12-29 12:16 -------
It is the same problem as:

http://bugzilla.kernel.org/show_bug.cgi?id=11732

[ also http://marc.info/?l=linux-ide&m=122865770510761&w=2 ]

Hmm... with additional debug data it all starts to make sense now! :)

Borislav, it seems that ide_map_sg() need to check for REQ_TYPE_ATA_PC now that
DMA is allowed for such requests (so it can use sg_init_one() path for them
instead of the usual blk_rq_map_sg() one)?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
