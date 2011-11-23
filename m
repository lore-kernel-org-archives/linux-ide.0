From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v3 0/6] ata port runtime power management support
Date: Wed, 23 Nov 2011 15:01:20 +0800
Message-ID: <1322031686-28233-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8690 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab1KWHBc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2011 02:01:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Jeff Garzik <jgarzik@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, James Bottomley <JBottomley@parallels.com>, Tejun Heo <tj@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>

Hi all,

This is the v3 patches to add ata port runtime pm support.
Applied on top of v3.2-rc2.

v1:
https://lkml.org/lkml/2011/11/2/23

v2:
https://lkml.org/lkml/2011/11/10/71
Acked-by: Tejun Heo <tj@kernel.org>
Kay Sievers reviewed sysfs change

Changes in v3:
- runtime resume scsi device before system suspend (Alan Stern)
- check runtime status in sd_shutdown

Thanks for any comment,
Lin Ming
