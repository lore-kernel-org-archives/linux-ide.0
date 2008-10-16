From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 09:33:49 -0700 (PDT)
Message-ID: <20081016163349.9AC88108040@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41447 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495AbYJPQdv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 12:33:51 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GGXnq9016801
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 09:33:50 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #21 from valerio.p@libero.it  2008-10-16 09:33 -------
Thank Boris and Stan for you replies.

Stan said:
>If ata_piix works for you, just use that. Please attach the boot time errors
>you mentioned in Comment #14 so that they can be fixed in libata/ata_piix.

Don't worry, it was "my" mistake. In the procedure I've found to blacklist piix
it was not mentioned to "depmod -ae" before creating an initrd image. Anyhow,
now that I have fixed it, there is no more any warning at boot time :).
It's time to be happy, relax and take a coffee ;)


>You could bisect search for the commit which is causing that regression -
>this'll be of great help. Here's a good tutorial on that:
Ok, it seems not easy, but sadly now I've a lot of free time and I think that
spending it on helping in fixing this bug is not that bad... at least until you
have both frameworks in the kernel. I don't want to mess in the discussion, I'm
not a developer, just an user. But I have a practical approach to almost
everything and IMO until we have both, we should have them working and avoid
problems to other users. I consider this as a service to the community. That's
all


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
