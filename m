From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 62351] Marvell PCIe SSD controller 0x9183 suspend/resume
 problem
Date: Mon, 30 Sep 2013 21:38:20 +0000
Message-ID: <bug-62351-11633-LYfPeg0KpM@https.bugzilla.kernel.org/>
References: <bug-62351-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44407 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab3I3ViX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Sep 2013 17:38:23 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A54C72024F
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 21:38:22 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 4297520212
	for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 21:38:21 +0000 (UTC)
In-Reply-To: <bug-62351-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=62351

--- Comment #3 from Patrik Jakobsson <patrik.r.jakobsson@gmail.com> ---
Hi Tejun

Success!

Setting min_power before suspend makes the error go away. Sadly pm-utils sets
max_performance so it needs to be configured and for some reason it doesn't
take my /etc/pm/config.d/sata_alpm into account. I ended up copying
/usr/lib/pm-utils/power.d/sata_alpm to /etc/pm/power.d and forcing it to
min_power. Also added a link to it in /etc/pm/sleep.d/ so it sets min_power
before suspend.

Strangely the SATA device randomly appears on /sys/class/scsi_host/host0 and
../host1 but I just set them both (the other is USB) and that works fine.

Thanks
Patrik

-- 
You are receiving this mail because:
You are on the CC list for the bug.
