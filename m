From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Tue, 9 Jun 2009 21:04:07 GMT
Message-ID: <200906092104.n59L47JU013492@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52676 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704AbZFIVEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2009 17:04:06 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n59L47x7013493
	for <linux-ide@vger.kernel.org>; Tue, 9 Jun 2009 21:04:07 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345


Ethan Grammatikidis <eekee57@fastmail.fm> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |eekee57@fastmail.fm




--- Comment #14 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-09 21:04:05 ---
Hullo. I ran into this the other day, & can report the bug is still present in
2.6.30-rc8.

I tried to capture the console output on panic but:
FATAL: Error inserting netconsole
(/lib/modules/2.6.30-rc8/kernel/drivers/net/netconsole.ko): Operation not
permitted

(Yes, I was root.)

I tried 2 drives, only one triggered the bug. This is a Lite-On SOHD-16P9S28C
made in January 2005.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
