From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Fri, 11 Sep 2009 05:49:30 GMT
Message-ID: <200909110549.n8B5nUI7000917@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43931 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZIKFt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2009 01:49:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8B5nUDq000918
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 05:49:30 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #52 from Borislav Petkov <bbpetkov@yahoo.de>  2009-09-11 05:49:29 ---
Hi David,

dang, seems we haven't fixed it properly,
39c58f37a10198054c656c28202fb1e6d22fd505 was supposed to do that.

Can you please apply http://bugzilla.kernel.org/attachment.cgi?id=23062 and get
me the whole dmesg.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
