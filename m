From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Thu, 18 Jun 2009 18:02:55 GMT
Message-ID: <200906181802.n5II2tfa021564@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40338 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbZFRSCw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 14:02:52 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5II2tZL021565
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 18:02:55 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #26 from Mark de Wever <koraq@xs4all.nl>  2009-06-18 18:02:54 ---
Hi Boris,

I didn't test before since I thought the fixes would be in 2.6.31-rc1.
I just tested 2.6.30 and the drive still causes an OOPS.
I'll test again after 2.6.31-rc1 is released and if it still crashes
I'll post a full dmesg and OOPS report.

Regards,
Mark

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
