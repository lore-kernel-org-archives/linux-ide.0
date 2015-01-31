From: Yann Droneaud <ydroneaud@opteya.com>
Subject: linux-next: libahci_platform has undefined symbol on sparc
Date: Sat, 31 Jan 2015 14:14:10 +0100
Message-ID: <1422710050.3030.17.camel@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ou.quest-ce.net ([195.154.187.82]:45830 "EHLO ou.quest-ce.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbbAaNcE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2015 08:32:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>
Cc: linux-next@vger.kernel.org, linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, Yann Droneaud <ydroneaud@opteya.com>

Hi,

I've seen another issue regarding commit c7d7ddee7e24eedde6149eefbcfbfbc7125b9ff0
("ata: libahci: Allow using multiple regulators") from linux-next:
This commit modify ahci_platform_get_resources to use of_platform_device_create().

Unfortunately, it seems that of_platform_device_create() is not
available on sparc (see CONFIG_OF_ADDRESS), so when built for sparc,
the module libahci_platform.ko is rejected by modpost:

  ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
  ../scripts/Makefile.modpost:91: recipe for target '__modpost' failed
  make[2]: *** [__modpost] Error 1
  src/linux/Makefile:1120: recipe for target 'modules' failed

Regards.

-- 
Yann Droneaud
OPTEYA


