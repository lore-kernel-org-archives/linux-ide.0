From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 26 Nov 2009 04:23:59 GMT
Message-ID: <200911260423.nAQ4NxL9017536@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42623 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbZKZEXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 23:23:52 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAQ4Nxfj017537
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2009 04:23:59 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #20 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-26 04:23:55 ---
The comment on SSD device speed being part of the bug is interesting:

1. Looking through the bug reports on Ubuntu, most of the problems are with the
supposedly 'faster' devices.  The slower devices - such as older factory fitted
devices - don't seem to figure.

2. I have an early Aspire One that is factory fitted with an Intel 8Gb SSD. 
This is not a fast SSD unit, and I believe that Acer later discontinued using
the Intel in favour of faster SSD units.  This machine has been 2.6.31 (Ubuntu
9.10) since the Beta, and without any problems.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
