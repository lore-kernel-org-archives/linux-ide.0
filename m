From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Sun,  2 Mar 2008 07:24:57 -0800 (PST)
Message-ID: <20080302152457.47F5F108065@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51630 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbYCBPZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 10:25:27 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m22FP0Mn023202
	for <linux-ide@vger.kernel.org>; Sun, 2 Mar 2008 07:25:02 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #5 from qrees@poczta.fm  2008-03-02 07:24 -------
Because I have vt8233 chipset and this module is responsible for DMA support on
this chipset (at least I think so). When I turn off DMA system is stable. This
might be some other module, but it's definitely something with DMA on vt8233
chipset.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
