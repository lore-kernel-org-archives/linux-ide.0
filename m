From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sat, 1 Aug 2009 21:30:27 GMT
Message-ID: <200908012130.n71LURC3026649@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39050 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZHAVa1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 17:30:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71LURRB026650
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 21:30:27 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #15 from Alan <alan@lxorguk.ukuu.org.uk>  2009-08-01 21:30:26 ---
I have complete documentation for them. They are set by the BIOS to indicate
whether the cable is 40 or 80 wire. We cannot do drive side detect as there is
no guarantee the boards support it.

If the system supports ACPI we also check the ACPI data. There isn't much else
we can do and unfortunately the ACPI tells us "80 wire or dunno" not 80/40 so I
don't see a good way to use that for both.


The other bits in that register pertain to mode/timing stuff.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
