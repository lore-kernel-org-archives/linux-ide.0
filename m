From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Fri, 17 Dec 2010 08:47:52 GMT
Message-ID: <201012170847.oBH8lqdU018121@demeter1.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:55602 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab0LQIrx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2010 03:47:53 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oBH8lqQj018123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2010 08:47:52 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702





--- Comment #4 from software+linux-kernel@kd6lvw.ampr.org  2010-12-17 08:47:49 ---
This report is consistent with the problem I initially experienced.  I did
upgrade my binutils to a 2.21 (from 2.20) version.

   http://sourceware.org/bugzilla/show_bug.cgi?id=12327

When I rolled back to a 2.6.36.1 kernel (which I'm running now), I note that I
did turn the relocation option OFF.  However, it was originally on.

I also note this fix to binutils.  I have not installed it to confirm the fix.

  http://gcc.gnu.org/ml/gcc/2010-12/msg00397.html

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
