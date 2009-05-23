From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13297] kernel panic -  not syncing : fatel exception in
 interupt
Date: Sat, 23 May 2009 00:02:46 GMT
Message-ID: <200905230002.n4N02kuZ010732@demeter.kernel.org>
References: <bug-13297-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53483 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646AbZEWACp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 20:02:45 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4N02kTT010733
	for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 00:02:46 GMT
In-Reply-To: <bug-13297-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13297


Rafael J. Wysocki <rjw@sisk.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |CODE_FIX




--- Comment #1 from Rafael J. Wysocki <rjw@sisk.pl>  2009-05-23 00:02:46 ---
Fixed by commit e3b29f05124b07303088795396ff858811d2acb8 .

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
