From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Mon, 14 Dec 2009 18:38:49 GMT
Message-ID: <200912141838.nBEIcnWm020934@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41572 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZLNSiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 13:38:50 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBEIcnKd020935
	for <linux-ide@vger.kernel.org>; Mon, 14 Dec 2009 18:38:49 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Scott James Remnant <scott@netsplit.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |scott@netsplit.com




--- Comment #33 from Scott James Remnant <scott@netsplit.com>  2009-12-14 18:38:47 ---
I've been tracking a bug we've linked to this on Ubuntu, the most recent
replies received from affected users do indicate that it's the
devkit-disks-probe-ata-smart command that triggers the HSM Violations and death
of their SSD.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
