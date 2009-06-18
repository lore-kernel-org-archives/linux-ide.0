From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 18 Jun 2009 13:36:38 GMT
Message-ID: <200906181336.n5IDac0i011320@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47416 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZFRNgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 09:36:36 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5IDacgU011321
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 13:36:38 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #33 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-18 13:36:37 ---
(In reply to comment #32)
> I am also experiencing system lockups whenever I insert a formated dvd
> or cd into my "hdd" ro drive. A blank dics doesn't cause the system to
> freeze. This happens when running X windows & running just init 3 on
> Mandriva-2009.1 with the EXT4 filesystem & kernel-2.6.30.

Is that a vanilla kernel or a distro-patched one? Please supply the
whole boot log of the machine. Also, can you catch any oopses over
serial console or netconsole, that'll help us a lot.

> I have another dvd combo rw drive labeled "hdc" in this same "ASUS" box  & it
> works ok. Here is the only error output I was able to see when accessing drive
> hdd:
> 
>   "kernel panic not syncing Fatal inception interrupt"
>   "pid 1289 comm: modprobe tainted: G   D  2.6.30 #1"

If you've copied the line correctly, the D shows that this is part of a
follow-up OOPS. However, the first one is actually the interesting one.
Alternatively to the serial or netconsole methods above, you could try
to make a photo of your screen with any camera and send me that. Please
try to catch the whole OOPS, though.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
