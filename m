From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 13:09:49 GMT
Message-ID: <201004111309.o3BD9nk6011992@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35648 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0DKNJv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 09:09:51 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BD9nL5011994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 13:09:49 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #8 from Dario Ernst <kernelbugs@nebuk.de>  2010-04-11 13:09:38 ---
Hi,

i just tried 2.6.33.2, still the same problem.
Nvidia driver problems could be as i'm also using them, haven't tried without
(as my kinda special dualhead setup doesn't work without).

I'll also try the patchlet with debugging enabeled as soon as i find some time.
Thanks to you too for contributing! :P

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
