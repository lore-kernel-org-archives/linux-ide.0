From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Tue, 3 Nov 2009 06:21:06 GMT
Message-ID: <200911030621.nA36L6Xj007335@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:46769 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZKCGVD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2009 01:21:03 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nA36L6sY007336
	for <linux-ide@vger.kernel.org>; Tue, 3 Nov 2009 06:21:06 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515


Andrew Simpson <andrewnz.simpson@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andrewnz.simpson@gmail.com




--- Comment #4 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-03 06:21:05 ---
Ubuntu bug #445852

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/445852

Reporting as affecting Acer Aspire One, Asus EEE and Dell Mini 9 (All SSD
models).  More prevalent with SSD's that have been upgraded by the user to
newer models, but also reported on the stock 8Gb SSD on the AA1.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
