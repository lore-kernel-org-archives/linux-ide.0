From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Fri, 10 Apr 2009 12:48:31 GMT
Message-ID: <200904101248.n3ACmVkA020649@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33303 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936713AbZDJMsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 08:48:32 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3ACmVpZ020650
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 12:48:31 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874


Sergei Shtylyov <sshtylyov@ru.mvista.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sshtylyov@ru.mvista.com




--- Comment #24 from Sergei Shtylyov <sshtylyov@ru.mvista.com>  2009-04-10 12:48:29 ---
(In reply to comment #20)
> Hmm, seems like the buffer is quite botched or the drive replies with some mode
> parameter headers I cannot correlate.

If you mean this line:

[   42.272638] caps:  70 0 6 0 0 0 0 a 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0


this is the extended sense data with its characteristic 1st byte of 0x70,
8-byte header with sense key UNIT ATTENTION, 10 bytes of additinal length and
ASC of 0x29 meaning "reset hs occured".

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
