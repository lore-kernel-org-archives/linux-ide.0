From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13663] suspend to ram regression (IDE related)
Date: Tue, 7 Jul 2009 20:32:02 GMT
Message-ID: <200907072032.n67KW2ZF017693@demeter.kernel.org>
References: <bug-13663-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49864 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZGGUcE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jul 2009 16:32:04 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n67KW2fu017694
	for <linux-ide@vger.kernel.org>; Tue, 7 Jul 2009 20:32:02 GMT
In-Reply-To: <bug-13663-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13663


Rafael J. Wysocki <rjw@sisk.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED
         Resolution|PATCH_ALREADY_AVAILABLE     |CODE_FIX




--- Comment #2 from Rafael J. Wysocki <rjw@sisk.pl>  2009-07-07 20:32:02 ---
Fixed by commit 2bf427b25b79eb7cea27963a66c3d4684cae0e0c .

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
