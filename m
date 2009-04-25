From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13120] BUG: using rootfstype=ext4 causes oops
Date: Sat, 25 Apr 2009 21:00:50 GMT
Message-ID: <200904252100.n3PL0o7q028123@demeter.kernel.org>
References: <bug-13120-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:45797 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZDYVAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2009 17:00:50 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3PL0oVp028124
	for <linux-ide@vger.kernel.org>; Sat, 25 Apr 2009 21:00:50 GMT
In-Reply-To: <bug-13120-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13120


Rafael J. Wysocki <rjw@sisk.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |CODE_FIX
             Status|RESOLVED                    |CLOSED




--- Comment #2 from Rafael J. Wysocki <rjw@sisk.pl>  2009-04-25 20:58:44 ---
Fixed by commit f505d49ffd25ed062e76ffd17568d3937fcd338c .

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
