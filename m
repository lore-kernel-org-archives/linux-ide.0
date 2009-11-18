From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 18 Nov 2009 05:24:12 GMT
Message-ID: <200911180524.nAI5OCdR005170@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51750 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbZKRFYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 00:24:07 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAI5OCr8005171
	for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2009 05:24:12 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




--- Comment #14 from Tejun Heo <tj@kernel.org>  2009-11-18 05:24:08 ---
Hmmm... I can't think of any reason why 2.6.31 would behave worse than 2.6.28. 
Are you sure that the error doesn't happen with 2.6.28?  Can you please check
one more time (no need to install whole distro, just installing the old kernel
should be enough)?

Cc'ing Alan.  Alan, a CF device is failing without triggering IRQ thus causing
timeouts.  Reportedly, this behavior doesn't happen with 2.6.28 but does with
2.6.31.  Any ideas?

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
