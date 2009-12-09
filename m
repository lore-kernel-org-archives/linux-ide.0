From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 9 Dec 2009 02:40:51 GMT
Message-ID: <200912090240.nB92epHx008898@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41230 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480AbZLICkp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Dec 2009 21:40:45 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB92epnh008899
	for <linux-ide@vger.kernel.org>; Wed, 9 Dec 2009 02:40:51 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #25 from Robert Hancock <hancockrwd@gmail.com>  2009-12-09 02:40:49 ---
It looks like most of these bug reports indicate BMDMA status 0x04 or 0x64 when
the timeout occurs, indicating that the controller should be asserting an
interrupt and the BMDMA transfer is not or is no longer active. But the device
registers indicate DRQ is asserted, indicating the device wants to transfer
more data. It looks like this is why libata reports an HSM violation.

The amount of data drained indicates that no data was actually transferred (I
notice there's a bug that causes the amount of data reported as drained to be
half the actual amount, I'll submit a patch for that). I don't see a reason for
the device to generate an interrupt at this point. Thus I tend to suspect that
the cause is a bug in the device.

As far as why an interrupt is shown as generated but doesn't actually get
received, I'm not sure. Maybe the controller doesn't propagate the interrupt if
the state machine doesn't say it should be getting one? DRQ + interrupt
asserted certainly doesn't seem like a combination that should happen.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
