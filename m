From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13921] No CD-ROM ATAPI driver on kernels higher than 2.6.24.x
Date: Thu, 6 Aug 2009 10:21:04 GMT
Message-ID: <200908061021.n76AL4Re023335@demeter.kernel.org>
References: <bug-13921-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55967 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbZHFKVE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 06:21:04 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n76AL48c023336
	for <linux-ide@vger.kernel.org>; Thu, 6 Aug 2009 10:21:04 GMT
In-Reply-To: <bug-13921-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13921





--- Comment #7 from Krystian Juskowiak <jusko@tlen.pl>  2009-08-06 10:21:03 ---
I'm afraid i can't, because installers stop responding or they don't see
cd-drive and can't install without it. Many installers don't have shell option.
I have this problem on every distro with kernel higher than 2.6.24.x (it's only
one problem, because i've submitted two other bugs). I can't use any Ubuntu
higher than 8.10 (because i have BusyBox), but i can upgrade 8.04 to newer
version. On 8.10 - i don't have cd-rom drive and card reader (but i've
submitted this bug). I can upgrade and get dmesg from Ubuntu 8.10.


p.s : sorry for terrible english - it's not my native language.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
