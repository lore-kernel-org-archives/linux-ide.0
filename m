From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v5 0/2] Add support for SCT Write Same
Date: Tue,  9 Aug 2016 20:00:27 -0500
Message-ID: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp78.mediacombb.net ([68.66.77.78]:58546 "EHLO
	dsmdc-mail-smtp.mcomdc.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751119AbcHJBAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 21:00:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

At some point the method of issuing Write Same for ATA drives changed.
Currently write same is commonly available via SCT so expose the SCT
capabilities and use SCT Write Same when it is available.

This is useful for zoned based media that prefers to support discard
with lbprz set, aka discard zeroes data by mapping discard operations to
reset write pointer operations. Conventional zones that do not support
reset write pointer can still honor the discard zeroes data by issuing
a write same over the zone.

It may also be nice to know if various controllers that currently
disable WRITE SAME will work with the SCT Write Same code path:
  aacraid, arcmsr, megaraid, 3w-9xxx, 3w-sas, 3w-xxxx, gdth, hpsa, ips,
  megaraid, pmcraid, storvsc_drv

This patch against v4.8-rc1 is also at 

https://github.com/stancheff/linux/tree/v4.8-rc1+ws.v5

git@github.com:stancheff/linux.git v4.8-rc1+ws.v5

Shaun Tancheff (2):
  Use kmap_atomic when rewriting attached page
  Add support for SCT Write Same

 drivers/ata/libata-scsi.c | 240 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/ata.h       |  69 ++++++++-----
 2 files changed, 252 insertions(+), 57 deletions(-)

-- 
2.8.1

