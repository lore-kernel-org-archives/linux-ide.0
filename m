From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 12 Nov 2009 20:11:17 GMT
Message-ID: <200911122011.nACKBHmE006225@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50820 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZKLULM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Nov 2009 15:11:12 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nACKBIeC006238
	for <linux-ide@vger.kernel.org>; Thu, 12 Nov 2009 20:11:18 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #11 from Tejun Heo <tj@kernel.org>  2009-11-12 20:11:02 ---
It looks like the device is buggy and fails from time to time without raising
interrupt.  libata waits till the timeout comes whenever that happens and thus
the 30sec long stutters.  This is basically caused by crappy hardware.  The
only workaround is to poll for the failure as irqpoll does.  For now, I think
you'll have to live with irqpoll.  In the long run, we'll probably need to add
automatic polling execution for the hardare.  Can you please attach the output
of "hdparm -I /dev/sda"?

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
