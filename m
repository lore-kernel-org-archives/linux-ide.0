From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 17:45:38 GMT
Message-ID: <201004111745.o3BHjc9Q016911@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56058 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0DKRpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 13:45:39 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BHjcPl016912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 17:45:38 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #10 from Marc H. Thoben <kernelbug@develz.org>  2010-04-11 17:45:32 ---
Hi Borislav,

when I got the new hardware I bought it with an ATI card. For 2 weeks it kept
crashing - no matter if ran the closed-source driver or without. Blaming the
ATI driver I bought an Nvidia card and had the same problem. I ran Xorg with
the nvidia driver, with nv and with vesa. It happened for all of them (yes, I
made sure the kernel wasn't tainted by nvidia's driver).

I found out about the netconsole module later, so I can't guarantee the problem
now is the same problem as with the ATI card previously - but it for sure does
seem so to me. I still have the ATI card here and could give it a try again if
we need to know for sure.

In the meantime I have compiled the ide-cd_mod module with the changes you
suggested and got two nice & big dmesg to report. This time I loaded netconsole
before syslog is started, so you can see all kernel messages. I hope that's
what you meant with "whole dmesg" - otherwise I'm sorry for the spam in those
logs.

While doing tests I got one step further and I believe this is important: The
kernel panic only shows up if there is no CD in the cdrom!

For the first test I booted the full system, loaded the new ide-cd_mod driver,
made sure there is _no_ CD in the drive and then ran glxgears in a window with
composite extension enabled (as mentioned above, this is the quickest way I
found to reproduce the kernel panic). It crashes after a few seconds. It does
so every time. This is in the first log I will attach after writing this.

For the second test I booted the full system, loaded the new ide-cd_mod driver,
made sure there _is_ a CD in the drive, then ran glxgears for a bit, then
ejected the CD (check for "Remove CD from CDROM" which I wrote to syslog with
logger) and it crashed almost immediately. I haven't yet tried to reproduce
this, but I saw it happen twice to me before. This is in the second log
attached.

After these two tests I booted again as previously but this time kept the CD in
the drive and went for dinner. That's about 50 minutes ago now - glxgears is
still running without a kernel panic. I never before took care whether there is
a CD in the drive or not, but it seems to prevent the kernel panic from
happening.

Maybe my assumptions are all wrong - after all, I have no idea how to read
those debugging messages. Thank you very much again for looking into this.

Best regards,
Marc

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
