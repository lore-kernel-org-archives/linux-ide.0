From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 19:59:21 GMT
Message-ID: <201004111959.o3BJxLdS015954@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36101 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab0DKT70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 15:59:26 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BJxMT3015956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 19:59:22 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #14 from Marc H. Thoben <kernelbug@develz.org>  2010-04-11 19:59:13 ---
Yes, you are right. But I was talking about previous tests. This computer is
crashing for 6 weeks already. At the moment it's tainted. But 6 weeks is a long
time and I tried a lot scenarios, also without the Nvidia driver even being
installed (not just not loaded into the kernel or unloaded). Too bad I didn't
know about netconsole at the beginning.

Most of the other crash traces start at cpu_idle() calls, without mentioning
any _nv0* things.

I'll reproduce without again. It'll take a while though, because without the
Nvidia driver the panic is a bit harder to reproduce.

There is no way to reduce the amount of debugging messages, is there? The
server with the remote syslog only has a small /var/log partition..

Thanks,
Marc.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
