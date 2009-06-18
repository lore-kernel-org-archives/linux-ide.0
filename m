From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 18 Jun 2009 12:12:58 GMT
Message-ID: <200906181212.n5ICCwRc030351@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58906 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZFRMM4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 08:12:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5ICCwTw030352
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 12:12:58 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399


Stan Senuta Jr. <ssenuta@dialup.cc> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ssenuta@dialup.cc




--- Comment #32 from Stan Senuta Jr. <ssenuta@dialup.cc>  2009-06-18 12:12:57 ---
I am also experiencing system lockups whenever I insert a formated dvd or cd
into my "hdd" ro drive. A blank dics doesn't cause the system to freeze. This
happens when running X windows & running just init 3 on Mandriva-2009.1 with
the EXT4 filesystem & kernel-2.6.30. 

I have another dvd combo rw drive labeled "hdc" in this same "ASUS" box  & it
works ok. Here is the only error output I was able to see when accessing drive
hdd:

  "kernel panic not syncing Fatal inception interrupt"
  "pid 1289 comm: modprobe tainted: G   D  2.6.30 #1"

Also, I still have kernel-2.6.29 installed in this box & it handles both the
"hdc" & "hdd" cd drives without problem.

I hope this helps.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
