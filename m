From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 3072] ATAPI Zip drive doesn't work properly
Date: Thu, 28 Feb 2008 18:31:03 -0800 (PST)
Message-ID: <20080229023103.D5D4C11D10C@picon.linux-foundation.org>
References: <bug-3072-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:52615 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844AbYB2Cbg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 21:31:36 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1T2V35N028499
	for <linux-ide@vger.kernel.org>; Thu, 28 Feb 2008 18:31:06 -0800
In-Reply-To: <bug-3072-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3072





------- Comment #9 from dave@flaterco.com  2008-02-28 18:31 -------
With 2.6.24.3 I determined that if the "stable" IDE drivers under
ATA/ATAPI/MFM/RLL support are disabled, the Zip drive works great with the
"experimental" PATA drivers in libata.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
