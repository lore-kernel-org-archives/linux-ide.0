From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sun, 27 Sep 2009 16:19:31 GMT
Message-ID: <200909271619.n8RGJVuB014769@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34488 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbZI0QT1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Sep 2009 12:19:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8RGJVNk014771
	for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2009 16:19:31 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #58 from Borislav Petkov <bbpetkov@yahoo.de>  2009-09-27 16:19:26 ---
Ok, my fix addresses at least the sense handling case, however, your
drive is still unresponsive and fails almost every command. I'm assuming
the drive has been functional at one point in time; if so, can you
please bisect the kernel - it might give us more insight into the failure.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
