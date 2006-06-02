From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/6] AHCI suspend/resume support
Date: Fri, 02 Jun 2006 15:39:33 +0800
Message-ID: <1149233973.13451.51.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9550 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751294AbWFBHvQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:51:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Hello, all

I ported the AHCI suspend/resume patch at
http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch to
libata-dev #upstream [ef2824073fba9def3cf122e89cc485f66dd71f70].

This series of patches provide the support for AHCI suspend/resume. The
patch works very well on Napa SDV in our lab.

The original author of the patch contact me, please. We can add you to
Signed-off-by.

Your comments and bug report are welcome.

Thanks,
Forrest
