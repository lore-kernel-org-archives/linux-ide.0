From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 12 Nov 2009 05:03:59 GMT
Message-ID: <200911120503.nAC53x68010024@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34343 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZKLFDx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Nov 2009 00:03:53 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAC53xV0010025
	for <linux-ide@vger.kernel.org>; Thu, 12 Nov 2009 05:03:59 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #10 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-12 05:03:58 ---
>But the system doesn't stall for 30secs, does it?

Umm, yes, you're right on that.  I also tried a 'torture test' of gparted and
whereas previously it would be tied up in knots for a long time, it did work
promptly (with the same errors in the log).

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
