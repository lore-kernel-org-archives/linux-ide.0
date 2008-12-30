From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Tue, 30 Dec 2008 01:25:13 -0800 (PST)
Message-ID: <20081230092513.CDFE210800E@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbYL3JZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 04:25:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBU9PDdX029932
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 01:25:15 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #9 from bbpetkov@yahoo.de  2008-12-30 01:25 -------
(In reply to comment #8)
> It is the same problem as:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=11732
> 
> [ also http://marc.info/?l=linux-ide&m=122865770510761&w=2 ]
> 
> Hmm... with additional debug data it all starts to make sense now! :)
> 
> Borislav, it seems that ide_map_sg() need to check for REQ_TYPE_ATA_PC now that
> DMA is allowed for such requests (so it can use sg_init_one() path for them
> instead of the usual blk_rq_map_sg() one)?

Hmm,

shouldn't we do that for all rq's which aren't bio-backed? As a means to handle
the more general case?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
