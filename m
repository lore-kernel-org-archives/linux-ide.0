From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Thu,  4 Dec 2008 06:40:24 -0800 (PST)
Message-ID: <20081204144024.C10E0108041@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45097 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528AbYLDOk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 09:40:26 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB4EeOLo008137
	for <linux-ide@vger.kernel.org>; Thu, 4 Dec 2008 06:40:25 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




------- Comment #4 from bbpetkov@yahoo.de  2008-12-04 06:40 -------
Hi,

here's what you could do for now:

1. Try a kernel without the proprietary nvidia module. I want to rule out the
distant possibility of it interfering
2. Try a recent kernel since a lot changed in ide-cd in the 2.6.26..2.6.27
timeframe

also what does 

cat /proc/sys/dev/cdrom/info

say?

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
