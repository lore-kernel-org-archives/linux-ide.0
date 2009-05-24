From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13371] s2disk hangs with kernel 2.6.29 and later, SATA,
 Gigabyte EG45M-DS2H
Date: Sun, 24 May 2009 20:38:21 GMT
Message-ID: <200905242038.n4OKcLgr004854@demeter.kernel.org>
References: <bug-13371-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60079 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZEXUiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 16:38:19 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4OKcLov004855
	for <linux-ide@vger.kernel.org>; Sun, 24 May 2009 20:38:21 GMT
In-Reply-To: <bug-13371-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13371


Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bzolnier@gmail.com




--- Comment #1 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-24 20:38:20 ---
Please move this out from IDE:

It turned out later that issue also happens with *CONFIG_IDE=n* (the problem
was bisected to commit 295f00042aaf6b553b5f37348f89bab463d4a469 which was quite
soon fixed by commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a).

I was working with Richard on bisecting it further during past week but since
we are hitting a whole ton of unrelated kernel problems it takes a lot of
time...

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
