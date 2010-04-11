From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 15:52:49 GMT
Message-ID: <201004111552.o3BFqnvs014470@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37388 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0DKPxY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 11:53:24 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BFqoBj014471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 15:52:50 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #9 from Borislav Petkov <bbpetkov@yahoo.de>  2010-04-11 15:52:01 ---
Hi Dario and Marc,

the fact that you guys both are running into this and that you both
run the closed source nvidia driver (not the nouveau thing that just
went upstream, right?) is suspicious and since closed source drivers
are known to break the kernel, I'd suggest you both give a kernel a try
without those closed source drivers, before doing anything else.

When testing this, please make sure the nvidia kernel module is removed
so that it doesn't get loaded at all and not simply blacklisting it.

Thanks,
Boris.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
