From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13619] Inserting a video DVD causes a kernel panic
Date: Thu, 25 Jun 2009 08:26:34 GMT
Message-ID: <200906250826.n5P8QYvD019380@demeter.kernel.org>
References: <bug-13619-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50324 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZFYI0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 04:26:31 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5P8QYfK019381
	for <linux-ide@vger.kernel.org>; Thu, 25 Jun 2009 08:26:34 GMT
In-Reply-To: <bug-13619-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13619


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #2 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-25 08:26:34 ---
Can you try the patch at http://bugzilla.kernel.org/attachment.cgi?id=22042

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
