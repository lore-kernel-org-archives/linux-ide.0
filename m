From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Wed, 15 Oct 2008 17:18:49 -0700 (PDT)
Message-ID: <20081016001849.EDDFB108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39821 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753800AbYJPATT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 20:19:19 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9G0IorD023765
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 17:18:51 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #13 from tj@kernel.org  2008-10-15 17:18 -------
ata_piix can drive the same controllers piix can but in your case piix is being
loaded before ata_piix thus grabbing the common controller.  So, to rephrase,
can you please retry without piix and with ata_piix?  How to inhibit or exclude
a module from initrd is distro specific, so you'll need to dig a bit there. 
Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
