From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Mon,  3 Nov 2008 04:52:54 -0800 (PST)
Message-ID: <20081103125254.735C7108047@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59024 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbYKCMw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Nov 2008 07:52:56 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3CqsBT024692
	for <linux-ide@vger.kernel.org>; Mon, 3 Nov 2008 04:52:55 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #2 from bzolnier@gmail.com  2008-11-03 04:52 -------
Could you try some newer kernel like 2.6.27 or 2.6.28-rc3?

Also did it work OK with some earlier kernel?

[ From the bugreport it seems that kernel from Live CD works OK? ]

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
