From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Fri, 16 Apr 2010 17:19:21 GMT
Message-ID: <201004161719.o3GHJLkg024864@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50623 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0DPRTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Apr 2010 13:19:22 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3GHJLpK024870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 16 Apr 2010 17:19:21 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #23 from Marc H. Thoben <kernelbug@develz.org>  2010-04-16 17:19:08 ---
Hello Borislav,

Thank you for that hint to finally start figuring out how to switch
from IDE to LIBATA. It took me a while but it was worth it.

No kernel panics anymore using libata & pata_it8213 & sr_mod! :)

> No, tainted kernel doesn't help. The only info I get from this is that
> it might be that the proprietary crap interferes with the cdrom. How do
> I know it doesn't?
> 
> Well, I don't because I can't look at the source code. So the reason
> I'm asking you to retry without the nvidia driver is so that we can be
> really sure whether there's a bug.

Well, I would have thought that showing the same kernel panic with the
call traces showing the oops in the same functions over and over again,
no matter whether the kernel is tainted or not, had made it obvious
that the tainted status doesn't matter. Pity I couldn't get Nouveau
working with 2.6.34. But running a single monitor setup for days just to
wait for the randomly occurring crash wasn't an option. But yeah -
I wish I didn't have to use the closed-source nvidia driver either.

Anyways.. Thank you very much again for taking time to look into this.
I hope you'll find the cause. Let me know if anything comes up that you
would like me to test or try out.

Cheers,
Marc

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
