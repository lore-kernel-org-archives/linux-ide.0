From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Wed, 15 Oct 2008 17:36:26 -0700 (PDT)
Message-ID: <20081016003626.39D33108040@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60819 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754191AbYJPAg7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 20:36:59 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9G0aQRd024720
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 17:36:27 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #8 from bumble.bee@xs4all.nl  2008-10-15 17:36 -------
Holy smokes, I had no idea you guys served a la carte! I remeber seeing a mail
from Mark Lord saying that he had no further interest in delkin_cb, thanks for
maintaining it Bart.
I applied your patch to Linus' git, it seems to resume just fine. It doesn't
hang in a wait state, and I/O that I start before resuming completes after it.

Seeing this in dmesg:
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: PCI INT A disabled
ACPI handle has no context!

Then, later:
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: enabling device (0000 -> 0003)
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: PCI INT A -> Link[LNKD] -> GSI 11
(level, low) -> IRQ 11
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: restoring config space at offset
0xf (was 0x4040100, writing 0x404010b)
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: restoring config space at offset
0x5 (was 0x0, writing 0x90000000)
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: restoring config space at offset
0x4 (was 0x1, writing 0xe001)
Delkin-ASKA-Workbit Cardbus IDE 0000:02:00.0: setting latency timer to 64

I'm awaiting Alan's general patch to see if it will help with libata.
It'd be great if it could be made to perform at >PIO0 speeds (but surprisingly
even as-is it's not that bad as a system drive).

Thanks!


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
