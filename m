From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Wed, 15 Oct 2008 04:22:02 -0700 (PDT)
Message-ID: <20081015112202.60C77108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44469 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501AbYJOLWE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 07:22:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FBM2VU015196
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 04:22:03 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #12 from valerio.p@libero.it  2008-10-15 04:22 -------
the previous dmesg that I've posted yesterday is referred to the non working
kernel 2.6.27.

> Can you give a shot at ata_piix and see whether it behaves any differently?

Do you mean to try with or without? As you can see from the above attached
lsmod belonging from 2.6.27 kernel, ata_piix is loaded as module automatically.
If you wanted me to disable it, please send me a kernel option I can give at
boot time to GRUB to override this default behaviour of the kernel.

See you


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
