From: Tejun Heo <tj@kernel.org>
Subject: Please take a look at bug 11703
Date: Sun, 05 Oct 2008 09:01:01 +0900
Message-ID: <48E803BD.6050709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50690 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754622AbYJEACz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 20:02:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Holger Macht <hmacht@suse.de>, Shaohua Li <shaohua.li@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Holger, Shaohua.

There's libata dock related bug report.

 http://bugzilla.kernel.org/show_bug.cgi?id=11703

What seems to happen is that if the user unplugs the ultrabay drive
while the system is suspended, libata never gets notified of the change
and tries to access the port during resume resulting in deadlock.  Maybe
something needs to be done during resume hook?

Thanks.

-- 
tejun
