From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Thu,  4 Dec 2008 10:18:28 -0800 (PST)
Message-ID: <20081204181828.E7E4B108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38325 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754085AbYLDSS7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 13:18:59 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB4IITqr024674
	for <linux-ide@vger.kernel.org>; Thu, 4 Dec 2008 10:18:30 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #6 from bbpetkov@yahoo.de  2008-12-04 10:18 -------
... or you can simply try the attached patch against stock 2.6.27. I'm pretty
sure it'll fix your problem :).

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
