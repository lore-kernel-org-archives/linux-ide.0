From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13696] Reading a DVD crashes the kernel
Date: Thu, 2 Jul 2009 20:07:52 GMT
Message-ID: <200907022007.n62K7qPR031713@demeter.kernel.org>
References: <bug-13696-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53378 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020AbZGBUHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 16:07:49 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n62K7q23031714
	for <linux-ide@vger.kernel.org>; Thu, 2 Jul 2009 20:07:52 GMT
In-Reply-To: <bug-13696-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13696


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #1 from Borislav Petkov <bbpetkov@yahoo.de>  2009-07-02 20:07:51 ---
Looks like a duplicate of Bug 13399. You can try the patch at
http://bugzilla.kernel.org/attachment.cgi?id=22042

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
