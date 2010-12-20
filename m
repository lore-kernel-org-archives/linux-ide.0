From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Mon, 20 Dec 2010 21:11:17 GMT
Message-ID: <201012202111.oBKLBHVn000357@demeter2.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:46939 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223Ab0LTVLS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2010 16:11:18 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id oBKLBHAn000358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 20 Dec 2010 21:11:17 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702





--- Comment #6 from software+linux-kernel@kd6lvw.ampr.org  2010-12-20 21:11:15 ---
I installed the new binutils.  All the "relocation warnings" have disappeared.

I have not tested the resulting kernel as I have done the upgrades only on my
production server and have not rebooted it.  I may try this on a spare machine
at home, but later (unless someone else can confirm this has disappeared).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
