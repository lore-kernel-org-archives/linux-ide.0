From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sun, 6 Feb 2011 15:45:31 GMT
Message-ID: <201102061545.p16FjVQL020146@demeter1.kernel.org>
References: <bug-13399-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:59396 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab1BFPpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2011 10:45:32 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p16FjV0H020147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 6 Feb 2011 15:45:31 GMT
In-Reply-To: <bug-13399-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=13399


Florian Mickler <florian@mickler.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|                            |CODE_FIX




--- Comment #63 from Florian Mickler <florian@mickler.org>  2011-02-06 15:45:13 ---
I'm closing this as fixed, as the problem of the original reporter and the
second problem of the next one both got fixed. 

If you come up with anything new just shout. 


merged in v2.6.31-rc1:
commit 39c58f37a10198054c656c28202fb1e6d22fd505
Author: Rainer Weikusat <rweikusat@mssgmbh.com>
Date:   Thu Jun 18 17:04:00 2009 +0200

    ide-cd: prevent null pointer deref via cdrom_newpc_intr


merged in v2.6.31-rc2:
commit 9c72ebef5aabf3532469d602a9d87beceea268b1
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Fri Jun 26 11:22:37 2009 -0700

    ide-cd: handle fragmented packet commands gracefully

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
