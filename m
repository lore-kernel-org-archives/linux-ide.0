From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Sat, 24 Oct 2009 13:39:49 GMT
Message-ID: <200910241339.n9ODdnGQ009671@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52913 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbZJXNjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 09:39:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9ODdn99009672
	for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2009 13:39:49 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310


Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bzolnier@gmail.com




--- Comment #5 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-10-24 13:39:48 ---
Jiri, please try the patch from

http://bugzilla.kernel.org/attachment.cgi?id=23513

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
