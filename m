From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: question on hotplug on ICH8M
Date: Tue, 29 Aug 2006 10:10:39 -0700
Message-ID: <20060829101039.8a1ec81e.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61536 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965171AbWH2RVN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 13:21:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,
I have a CD/DVD rom device on an ICH8M that and the ahci driver that
I am trying to hot remove with kernel 2.6.18-rc4-git.  It seems that
hotplug for this device should be supported.  Do I need to do anything
special to hot remove this device (such as write to some sysfs file),
or can I just "pull the plug" so to speak?

Thanks,
Kristen
