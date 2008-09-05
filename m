From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11498] Teac DV28EV stops working with ide-cd
Date: Fri,  5 Sep 2008 07:32:56 -0700 (PDT)
Message-ID: <20080905143256.2821B108056@picon.linux-foundation.org>
References: <bug-11498-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33376 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179AbYIEOc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Sep 2008 10:32:58 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m85EWu30006228
	for <linux-ide@vger.kernel.org>; Fri, 5 Sep 2008 07:32:57 -0700
In-Reply-To: <bug-11498-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11498





------- Comment #1 from bhutchings@solarflare.com  2008-09-05 07:32 -------
The kernel config is based on the RHEL 5 PAE kernel config; I will attach the
config we used for 2.6.27-rc5. I'm not sure it's feasible to bisect this as the
error has only been seen after the machine has been running for several hours.

We saw the following kernel error messages:

hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command

The last three lines were repeated at 5-second intervals, apparently whenever
the device was opened.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
