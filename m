From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] Suspend to disk no longer works in 2.6.30.2 with an EIDE
 drive
Date: Sat, 1 Aug 2009 10:52:08 GMT
Message-ID: <200908011052.n71Aq80d019769@demeter.kernel.org>
References: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49390 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZHAKwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 06:52:07 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71Aq8FY019770
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 10:52:08 GMT
In-Reply-To: <bug-13886-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886





--- Comment #2 from Rafael J. Wysocki <rjw@sisk.pl>  2009-08-01 10:52:07 ---
Caused by:

commit 295f00042aaf6b553b5f37348f89bab463d4a469
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Jan 2 16:12:48 2009 +0100

    ide: don't execute the next queued command from the hard-IRQ context (v2)

First-Bad-Commit : 295f00042aaf6b553b5f37348f89bab463d4a469

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
