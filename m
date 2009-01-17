From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12437] My DVD+\-RW ROM can not write any disc
Date: Sat, 17 Jan 2009 10:01:26 -0800 (PST)
Message-ID: <20090117180126.2670F108040@picon.linux-foundation.org>
References: <bug-12437-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50501 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756227AbZAQSBx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 13:01:53 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0HI1QRP021355
	for <linux-ide@vger.kernel.org>; Sat, 17 Jan 2009 10:01:27 -0800
In-Reply-To: <bug-12437-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12437





------- Comment #5 from bbpetkov@yahoo.de  2009-01-17 10:01 -------
Well,

I just tried burning a cd here with k3b and it worked just fine (2.6.29-rc1,
hardware: Optiarc DVD RW AD-7173A). The error log above is very strange, ide-cd
complains that the tray is open?? Also, what does "Latest working kernel
version: 2.27.9" mean, maybe 2.6.27.9? It could be a follow-up error after
fiddling with hdparm. Andrey, can you try burning after a fresh reboot without
setting anything with hdparm?

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
