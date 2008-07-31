From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Thu, 31 Jul 2008 03:14:30 -0700 (PDT)
Message-ID: <20080731101430.BFCE3108045@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48840 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252AbYGaKPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 06:15:03 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VAEUSD004360
	for <linux-ide@vger.kernel.org>; Thu, 31 Jul 2008 03:14:31 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #14 from tj@kernel.org  2008-07-31 03:14 -------
Gustavo, can you please add the following loop at the top of device_shutdown()
and report what the kernel says?

  printk("XXX head prev=%p next=%p\n", devices_kset->list.prev,
devices_kset->list.next);
  list_for_each_entry(dev, &devices_kset->list, kobj.entry)
      printk("XXX prev=%p next=%p\n", dev->kobj.entry.prev,
dev->kobj.entry.next);


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
