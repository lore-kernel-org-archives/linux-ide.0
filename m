From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] IDE Probe fails to find CD drive
Date: Tue, 20 Oct 2009 11:45:16 GMT
Message-ID: <200910201145.n9KBjGZw029651@demeter.kernel.org>
References: <bug-14438-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33066 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZJTLpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Oct 2009 07:45:12 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9KBjG4o029652
	for <linux-ide@vger.kernel.org>; Tue, 20 Oct 2009 11:45:16 GMT
In-Reply-To: <bug-14438-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14438





--- Comment #6 from Borislav Petkov <bbpetkov@yahoo.de>  2009-10-20 11:45:15 ---
(In reply to comment #5)
> I play around a bit tonight to see if the change is fine -- my drives all have
> different names now...

You can always have stable device names with udev:
http://reactivated.net/writing_udev_rules.html

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
