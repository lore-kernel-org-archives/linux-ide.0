From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Fri, 11 Apr 2008 04:32:49 -0700 (PDT)
Message-ID: <20080411113249.0872D11D109@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759703AbYDKLdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 07:33:49 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3BBXGOG020587
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 04:33:17 -0700
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #8 from jan.fikar@psi.ch  2008-04-11 04:32 -------
I'll try...

I'm not sure about APIC error, as some kernels before (till 22 or 23 if I
remember well) the log was full of those APIC errors. They were produced at a
speed of two or three per hour. And I thought they are harmless. Anyway at that
time there were no problems with atiixp.

Then with the 22 or 23 upgrade they do no come so often. Maybe once per day or
so and I still ignored them. In fact I'm not sure it was corrected or only
silenced. There were still no atiixp problems. The atiixp timeouts started in
24.

I think I can check your hypothesis, maybe you are right. I remember that at
least in the 2.6.25-rc6 case with the single DMA timeout the APIC error was in
the log just before. However I'm not sure how long before. I think I can switch
on the timestamps.

And if it really is an IRQ routing problem, shouldn't I try to disable it by
noapic kernel parameter or something like that?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
