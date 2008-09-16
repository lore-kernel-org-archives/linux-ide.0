From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11576] compactflash TRANSCEND at ide adapter failed to IDENTIFY
Date: Tue, 16 Sep 2008 08:42:19 -0700 (PDT)
Message-ID: <20080916154219.8C45A108047@picon.linux-foundation.org>
References: <bug-11576-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57716 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755719AbYIPPmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Sep 2008 11:42:52 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8GFgJZt014624
	for <linux-ide@vger.kernel.org>; Tue, 16 Sep 2008 08:42:20 -0700
In-Reply-To: <bug-11576-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11576





------- Comment #5 from alan@lxorguk.ukuu.org.uk  2008-09-16 08:42 -------
No immediate ideas but the traces look like they have everything needed for
further work on this. There are some CF related changes in 2.6.26 to handle
devices which didn't implement all of the expected indentify/setup sequences
but this seems different.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
