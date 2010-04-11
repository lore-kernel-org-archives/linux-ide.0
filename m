From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 12:13:02 GMT
Message-ID: <201004111213.o3BCD22R017565@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52280 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0DKMNF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 08:13:05 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BCD2Lw017572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 12:13:03 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #5 from Marc H. Thoben <kernelbug@develz.org>  2010-04-11 12:12:29 ---
Hello Borislav,

I'm happy you are willing to take a look at this. I'll attach the syslog
excerpt (which looks a bit messy due to netconsole, I believe) and the kernel
config now.

Admittedly I've been sinning for some years and have just returned to Linux
when I bought the new hardware... which means it'll take me a while to remember
how to compile the kernel myself. But I'll get there again :)

I can easily reproduce the crash by loading ide-cd_mod, activating composite
tweaks in xfce4 and running glxgears in a window. As soon as the terminal is
supposed to show the FPS I'll get the kernel panic.

Googling lead me to believe this is caused by the massive interrupt calls that
the closed-source nvidia driver is doing. I had the same crash, but not so
easily reproducable with the closed-source ati driver.. yes.. I switched
graphic cards on the hunt for these kernel panics. Until I found the netconsole
module and knew it's the ide/cdrom.

Sorry, I'm drifting off. I will post the debugging info as soon as possible.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
