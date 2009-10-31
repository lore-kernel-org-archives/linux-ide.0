From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Sat, 31 Oct 2009 02:01:12 GMT
Message-ID: <200910310201.n9V21CSV031055@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37051 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608AbZJaCBH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2009 22:01:07 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9V21CVO031056
	for <linux-ide@vger.kernel.org>; Sat, 31 Oct 2009 02:01:12 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515


Barry Song <21cnbao@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |21cnbao@gmail.com




--- Comment #2 from Barry Song <21cnbao@gmail.com>  2009-10-31 02:01:11 ---
Yes. I've encountered the same problem "lost interrupt" with Lloyd Weehuizen
after upgrading kernel to 2.6.31. What I am using is HP laptop.
I think recent commits must have destroyed some ATA controllers.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
