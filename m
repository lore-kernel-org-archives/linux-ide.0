From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9156] IDE DMA <-> CPU HLT <-> EHCI-HCD
Date: Mon, 22 Dec 2008 21:06:40 -0800 (PST)
Message-ID: <20081223050640.E604A10800D@picon.linux-foundation.org>
References: <bug-9156-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32967 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750773AbYLWFHN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Dec 2008 00:07:13 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBN56fcQ020127
	for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2008 21:06:42 -0800
In-Reply-To: <bug-9156-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9156





------- Comment #8 from hancockr@shaw.ca  2008-12-22 21:06 -------
This should really not be assigned to IDE subsystem, as what seems like is
needed is some kind of chipset-specific PCI quirk. Disabling halt only during
IDE transfers is likely no good solution since other DMA accesses can occur at
any time, often without prior kernel knowledge, and are likely also affected.
The chipset settings likely need to be fixed to not get into this busted state.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
