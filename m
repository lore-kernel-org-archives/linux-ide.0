From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH v2 0/2] Enabling ATA Command Priorities
Date: Wed, 5 Oct 2016 12:00:05 -0700
Message-ID: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: axboe@kernel.dk, tj@kernel.org
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org, Adam Manzanares <adam.manzanares@hgst.com>
List-Id: linux-ide@vger.kernel.org

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
entry named req_prio. If this feature is enabled the request ioprio comes
from the highest priority between the iocontext and the bio. 

v2:
 - Add queue flag to set iopriority going to the request
 - If queue flag set, send iopriority class to ata_build_rw_tf
 - Remove redundant code in ata_ncq_prio_enabled function.


Adam Manzanares (2):
  ata: Enabling ATA Command Priorities
  block: Add iocontext priority to request

 block/blk-core.c       |  8 +++++++-
 block/blk-sysfs.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.1.4

