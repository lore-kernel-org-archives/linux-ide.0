From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Mon, 13 Dec 2010 14:13:18 GMT
Message-ID: <201012131413.oBDEDIoC011675@demeter2.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:38389 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab0LMONT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Dec 2010 09:13:19 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id oBDEDJ6k011676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2010 14:13:19 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702





--- Comment #3 from Borislav Petkov <bp@alien8.de>  2010-12-13 14:13:11 ---
Ok,

just wanted to make sure, thanks.

Well, I'm looking through the 290 .36.2 commits and
can't find a strong candidate for this regression. Maybe
3dc40311eaf91cde40f29d799f430dc6a00c2a7c but I can't see how... Can you
try reverting it and see if it fixes the issue, per chance?

If that doesn't help, you could still bisect the 290 commits between
36.1 and 36.2.

Feel free to ask in case you need any help.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
