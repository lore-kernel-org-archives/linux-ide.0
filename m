From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/6] AHCI suspend/resume support --take3
Date: Thu, 29 Jun 2006 16:18:06 +0800
Message-ID: <1151569086.7132.220.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46176 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751799AbWF2IcX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 04:32:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Hi, all

This is the take 3 of AHCI suspend/resume patches.

The patch is against #upstream[
2154cfa6ba560401d25f6cc083fe3fb996cbb571] + Tejun's Power Management
patch(available at
http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=new-pm).

Although Tejun's PM patch may change as he mentioned in another mail,
such change is minor and will not impact the logic of AHCI suspend/
resume. So I re-send the patch in order to get test feedback and review
comments earlier.

Compared with last version, all the changes are in [PATCH 6/6]. In
particular, I made changes to the sixth patch to integrate it with
Tejun's PM patch.

Thanks,
Forrest
