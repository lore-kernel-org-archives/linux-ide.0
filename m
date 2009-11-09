From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Mon, 9 Nov 2009 14:47:15 GMT
Message-ID: <200911091447.nA9ElFw9012737@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:38954 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZKIOrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2009 09:47:11 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nA9ElFhk012738
	for <linux-ide@vger.kernel.org>; Mon, 9 Nov 2009 14:47:15 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515


Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tj@kernel.org




--- Comment #5 from Tejun Heo <tj@kernel.org>  2009-11-09 14:47:12 ---
This has nothing to do with the harddrive.  It's the optical drive choking up
on commands (TEST_UNIT_READY) used for polling for media presence events.  As
it's PATA and the hard drive shares bus with the optical drive, while the
optical drive is choking, the hard drive can't access the bus so hard drive
access also stalls.

Disabling media presence polling should work around the problem for now.  Long
term, I think we shouldn't use TUR for media presence polling.  Windows doesn't
use it and devices with crappy firmware which chokes on repeated TUR aren't too
rare.  That's in the pipeline but unfortunately I don't think it will be ready
for this release cycle.  It's gonna be a pretty pervasive change.  :-(

So, for now, "hal-disable-polling /dev/sr0" seems like the only solution.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
