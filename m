From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Mon, 12 Apr 2010 18:21:46 GMT
Message-ID: <201004121821.o3CILkhC020394@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33679 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0DLSVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Apr 2010 14:21:47 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3CILkCx020401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 12 Apr 2010 18:21:46 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #17 from Dario Ernst <kernelbugs@nebuk.de>  2010-04-12 18:21:40 ---
Same here, tried 1.5 days (and night) without loaded nvidia (and without GUI
running) ... had one of the crashes (ide-cd compiled in kernel, not as module)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
