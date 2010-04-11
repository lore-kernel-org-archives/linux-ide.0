From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 20:22:31 GMT
Message-ID: <201004112022.o3BKMVtg021065@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41390 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab0DKUWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 16:22:51 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BKMd2n021114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 20:22:39 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #15 from Borislav Petkov <bbpetkov@yahoo.de>  2010-04-11 20:21:56 ---
(In reply to comment #14)
> There is no way to reduce the amount of debugging messages, is there? The
> server with the remote syslog only has a small /var/log partition..

You could try changing /etc/syslog.conf settings like so:

change:

*.*;auth,authpriv.none        -/var/log/syslog

to

auth,authpriv.none        -/var/log/syslog

and comment out all lines which have the kern.* facility:

kern.*                -/var/log/kern.log

(at least this is what I have here). netconsole logging should still work
though.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
