From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Wed, 28 Apr 2010 21:40:25 GMT
Message-ID: <201004282140.o3SLePvr015342@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55880 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0D1Vkh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Apr 2010 17:40:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3SLeQOu015343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Apr 2010 21:40:26 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #24 from Dario Ernst <kernelbugs@nebuk.de>  2010-04-28 21:39:04 ---
Heho,

i've also tried again - with 2.6.34-rc4 and nouveau driver (propi one not even
installed). Crash happened after ~1h (used the cdrom in between - without
issues), netconsole truncated the output a bit, but the main portion looked
like the good old problem.

Thanks for all of your time looking into this! Hoping it'll work out somehow in
the future :P.

Thanks again
Reagards
- Dario

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
