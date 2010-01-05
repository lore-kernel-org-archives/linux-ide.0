From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 8567] DMA: Wrong device is disabled
Date: Tue, 5 Jan 2010 17:50:06 GMT
Message-ID: <201001051750.o05Ho6xb022817@demeter.kernel.org>
References: <bug-8567-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57416 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab0AERuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 12:50:07 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id o05Ho68Z022818
	for <linux-ide@vger.kernel.org>; Tue, 5 Jan 2010 17:50:06 GMT
In-Reply-To: <bug-8567-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=8567





--- Comment #8 from dark_sylinc@yahoo.com.ar  2010-01-05 17:48:57 ---
I'm afraid that PC has now more serious HW problems (bad caps, replaced them
but still doesn't work right) which makes it difficult to test. I can hardly
keep it up running for long without a complete freeze right now. I use it as a
DVD player plugged to my TV until it completely dies...

The PC had serious HW problems that's for sure; the actual bug in the kernel
was that hdb (a CD-RW drive) DMA was being disabled when the conflicting device
was the Hard Drive at hda (an 40GB HDD).
Note the linux kernel correctly identified the malfunctioning HDD drive, it
just disabled the wrong device.

If I am able to update the latest kernel to that machine, I'll post it here

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
