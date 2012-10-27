From: Brian Norris <computersforpeace@gmail.com>
Subject: [RFC v2 0/3] ahci_platform: unbind/rmmod power down sequence
Date: Sat, 27 Oct 2012 13:09:33 -0700
Message-ID: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61645 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab2J0UKO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2012 16:10:14 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1806841dak.19
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2012 13:10:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>, Brian Norris <computersforpeace@gmail.com>

Hello,

This is a follow up on a previous questions and RFC series I sent. See here for
some context:

    http://article.gmane.org/gmane.linux.ide/53143
    http://article.gmane.org/gmane.linux.ide/52951

This series:

(1) Allows ahci_platform to unbind a device from the driver. This is useful for
    allowing total power-off of the device, for instance.
(2) Adds ahci_platform ata_port_operations.host_stop() hook, so that
    platform-device exit() can power down the device at the appropriate point
    in the removal sequence.

Thanks to Tejun for the comments, which suggested that ahci_platform (not
libata-core) was broken.

Brian

Brian Norris (3):
  ahci_platform: enable hotplug unbinding
  ahci_platform: convert to module_platform_driver
  ahci_platform: perform platform exit in host_stop() hook

 drivers/ata/ahci_platform.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
1.7.11.3

