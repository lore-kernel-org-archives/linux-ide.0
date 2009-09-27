From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sun, 27 Sep 2009 16:52:55 GMT
Message-ID: <200909271652.n8RGqtKb018203@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33211 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbZI0Qwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Sep 2009 12:52:51 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8RGqtbk018204
	for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2009 16:52:55 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #59 from David Woodhouse <dwmw2@infradead.org>  2009-09-27 16:52:53 ---
To be honest, I don't know that it ever worked. I've always used libata on this
machine and using drivers/ide for my test build of 2.6.31 wasn't intentional.
When I get home next week, I'll attempt to find a good kernel and then bisect.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
