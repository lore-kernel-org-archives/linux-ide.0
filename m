From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v6 0/4] SCT Write Same
Date: Sun, 21 Aug 2016 23:23:17 -0500
Message-ID: <20160822042321.24367-1-shaun@tancheff.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35874 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcHVEXh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 00:23:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

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

This patch against v4.8-rc2 is also at
    https://github.com/stancheff/linux/tree/v4.8-rc2%2Bbiof.v9

    git@github.com:stancheff/linux.git v4.8-rc2+biof.v9

v6:
 - Fix bisect bug reported by Tom Yan <tom.ty89@gmail.com>
 - Change to use sg_copy_from_buffer as per Christoph Hellwig <hch@lst.de>
 - Added support for a sector_size descriptor other than 512 bytes.
v5:
 - Addressed review comments
 - Report support for ZBC only for zoned devices.
 - kmap page during rewrite
 - Fix unmap set to require trim or error, if not unmap then sct write
   same or error.
v4:
 - Added partial MAINTENANCE_IN opcode simulation
 - Dropped all changes in drivers/scsi/*
 - Changed to honor the UNMAP flag -> TRIM, no UNMAP -> SCT.
v3:
 - Demux UNMAP/TRIM from WRITE SAME
v2:
 - Remove fugly ata hacking from sd.c

Shaun Tancheff (4):
  libata: Safely overwrite attached page in WRITE SAME xlat
  Add support for SCT Write Same
  SCT Write Same / DSM Trim
  SCT Write Same handle ATA_DFLAG_PIO

 drivers/ata/libata-scsi.c | 280 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/ata.h       |  69 +++++++-----
 2 files changed, 292 insertions(+), 57 deletions(-)

-- 
2.9.3

