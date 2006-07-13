From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/6] AHCI suspend/resume support --take5
Date: Thu, 13 Jul 2006 13:38:07 +0800
Message-ID: <1152769087.7132.326.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8494 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751485AbWGMFwD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Jul 2006 01:52:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Hi, all

This is the take 5 of AHCI suspend/resume patches.
The patch is against libata #upstream.

For this version, I split the patches in correct way -- each individual
patch, when applied in succession, creates a compilable, usable
driver :)

Thanks,
Forrest
