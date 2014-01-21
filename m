From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 0/1] libata: Get rid of ata_port::qc_allocated bitmask
Date: Tue, 21 Jan 2014 16:02:25 +0100
Message-ID: <cover.1390315528.git.agordeev@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbaAUPAq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jan 2014 10:00:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Nicholas A. Bellinger" <nab@linux-iscsi.org>

Hi Tejun,

This update is against "scsi-mq" branch in Nicholas tree:
git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git

A quick check with 'fio' tool's random reading indicates an
moderate improvement on a single drive, four threads and the
queue depth of 32:

  read : io=131072KB, bw=149785B/s, iops=36, runt=896066msec

vs

  read : io=131072KB, bw=166884B/s, iops=40, runt=804257msec

I have not measured cache line bouncing itself. I am kind of
limited in hardware configurations, but let me know if you
want to see more testing anyway.

Thanks!

Alexander Gordeev (1):
  libata: Get rid of ata_port::qc_allocated bitmask

 drivers/ata/libata-core.c |   82 +++++++++++++++++++++++++++++++-------------
 include/linux/libata.h    |    6 ++-
 2 files changed, 62 insertions(+), 26 deletions(-)

-- 
1.7.7.6

