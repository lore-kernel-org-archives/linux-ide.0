From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH v3 0/2] Enabling ATA Command Priorities
Date: Tue, 11 Oct 2016 13:40:25 -0700
Message-ID: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39341 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbcJKUpk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2016 16:45:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@kernel.dk, tj@kernel.org
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org, Adam Manzanares <adam.manzanares@hgst.com>

This patch builds ATA commands with high priority if the iocontext
of a process is set to real time. The goal of the patch is to
improve tail latencies of workloads that use higher queue depths.

This patch has been tested with an Ultrastar HE8 HDD and cuts the 
the p99.99 tail latency of foreground IO from 2s down to 72ms when
using the deadline scheduler. This patch works independently of the
scheduler so it can be used with all of the currently available 
request based schedulers. 

Foreground IO, for the previously described results, is an async fio job 
submitting 4K read requests at a QD of 1 to the HDD. The foreground IO is set 
with the iopriority class of real time. The background workload is another fio
job submitting read requests at a QD of 32 to the same HDD with default 
iopriority.

This feature is enabled by setting a queue flag that is exposed as a sysfs
entry named rq_ioc_prio. If this feature is enabled, and the submission 
iocontext exists, and the bio_prio is not valid then the request ioprio is
set to the iocontext prio.

v3:
 - Removed null dereference issue in blk-core
 - Renamed queue sysfs entries for clarity
 - Added documentation for sysfs queue entry

v2:
 - Add queue flag to set iopriority going to the request
 - If queue flag set, send iopriority class to ata_build_rw_tf
 - Remove redundant code in ata_ncq_prio_enabled function.


Adam Manzanares (2):
  block: Add iocontext priority to request
  ata: Enabling ATA Command Priorities

 Documentation/block/queue-sysfs.txt | 12 ++++++++++++
 block/blk-core.c                    |  5 +++++
 block/blk-sysfs.c                   | 32 ++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c           | 35 ++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-scsi.c           | 10 +++++++++-
 drivers/ata/libata.h                |  2 +-
 include/linux/ata.h                 |  6 ++++++
 include/linux/blkdev.h              |  3 +++
 include/linux/libata.h              | 18 ++++++++++++++++++
 9 files changed, 120 insertions(+), 3 deletions(-)

-- 
2.1.4

