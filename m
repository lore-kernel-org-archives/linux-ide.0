From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Tue, 14 Jul 2009 21:01:07 GMT
Message-ID: <200907142101.n6EL17dk005766@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:45495 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbZGNVBI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2009 17:01:08 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6EL17Wf005767
	for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2009 21:01:07 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #28 from Mark de Wever <koraq@xs4all.nl>  2009-07-14 21:01:06 ---
I tried to get the OOPS but the system hung and I wasn't able to capture it.

I just tested with 2.6.31-rc3 which didn't OOPS, but files written to the
streamer were truncated when read. I hope to find some more time this
weekend to do some more testing and see whether there's a pattern in the
truncating. Just wanted to let you know to see whether it rings a bell.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
