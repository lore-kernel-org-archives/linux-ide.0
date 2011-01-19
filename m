From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15941] Thinkpad T61 after suspend to ram ide cdrom doesn't work
Date: Wed, 19 Jan 2011 00:13:27 GMT
Message-ID: <201101190013.p0J0DR4m010850@demeter1.kernel.org>
References: <bug-15941-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:34031 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1ASAN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 19:13:29 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p0J0DS1a010851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 19 Jan 2011 00:13:28 GMT
In-Reply-To: <bug-15941-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15941


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #16 from Robert Hancock <hancockrwd@gmail.com>  2011-01-19 00:13:21 ---
(In reply to comment #14)
> It could be fine with me, but AFAIR the libsata driver had pretty
> fragile error handling on sense errors. When using 'safecopy' program
> the kernel or device often get stuck in some weird state. Could you
> take a look at it? I can try to reproduce it, but I'm not sure what
> information will be useful for a bug report...

If you see problems in current kernels, please open a new bug report and
include the full dmesg log.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
