From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/6] AHCI suspend/resume support --take4
Date: Mon, 10 Jul 2006 11:33:58 +0800
Message-ID: <1152502438.7132.265.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13450 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161324AbWGJDre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 23:47:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Hi, all

This is the take 4 of AHCI suspend/resume patches.
The patch is against libata #upstream.


Compared with last version, all the changes are in [PATCH 6/6]. In
particular, I made changes to the sixth patch to integrate it with
Tejun's PM patch.

Thanks,
Forrest
