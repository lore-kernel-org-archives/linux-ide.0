From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Thu, 23 Dec 2010 02:39:03 GMT
Message-ID: <201012230239.oBN2d3O3019044@demeter1.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:60114 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0LWCjE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2010 21:39:04 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oBN2d3aw019045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2010 02:39:03 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702


software+linux-kernel@kd6lvw.ampr.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |DOCUMENTED




--- Comment #7 from software+linux-kernel@kd6lvw.ampr.org  2010-12-23 02:38:59 ---
Due to other reasons, I had to reboot the server that had the problem which
caused this thread.  It is now working.

Resolution:  I set it to "Documented" because "Moved" is not an available
choice, despite this web site saying so in its help page
("page.cgi?id=fields.html#status"):

"MOVED 
"The problem was specific to a related product whose bugs are tracked in
another bug database. The bug has been moved to that database."

The related product is binutils.  The bug has been fixed over there.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
