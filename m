From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 0/2] libata: support the ata host which implements a queue depth less than 32
Date: Sun,  6 Jul 2014 14:28:39 +0800
Message-ID: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38983 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaGFG3j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2014 02:29:39 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3776173pab.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 23:29:39 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Hi,

v2: Remove the changes for the ata tag helper functions.

v1:
The fsl sata on mpc8315e is broken after the commit 8a4aeec8d2d6
("libata/ahci: accommodate tag ordered controllers"). This patch
serial tries to fix this problem. This is based on the next-20140702.
Boot test on the mpc8315rdb board.

Kevin Hao (2):
  libata: introduce ata_host_set_queue_depth()
  sata_fsl: set the correct queue depth for the host controller

 drivers/ata/libata-core.c | 29 ++++++++++++++++++++++++++---
 drivers/ata/sata_fsl.c    |  3 +++
 include/linux/libata.h    |  3 +++
 3 files changed, 32 insertions(+), 3 deletions(-)

-- 
1.9.3

