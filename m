From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 0/5] libata: support the ata host which implements a queue depth less than 32
Date: Thu,  3 Jul 2014 20:09:37 +0800
Message-ID: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:46630 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaGCMKc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:32 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so118000pde.40
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:32 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Hi,

The fsl sata on mpc8315e is broken after the commit 8a4aeec8d2d6
("libata/ahci: accommodate tag ordered controllers"). This patch
serial tries to fix this problem. This is based on the next-20140702.
Boot test on the mpc8315rdb board.

Kevin Hao (5):
  libata: using ata_tag_internal() instead of open-coding
  libata: introduce ata_get_internal_tag()
  libata: add a 'struct ata_port *' argument for the ata tag help
    functions
  libata: support the ata host which implements a queue depth less than
    32
  sata_fsl: set the correct queue depth for the host controller

 drivers/ata/libata-core.c | 50 +++++++++++++++++++++++++++++++++++------------
 drivers/ata/libata-eh.c   | 32 ++++++++++++++++++------------
 drivers/ata/libata-scsi.c |  5 +++--
 drivers/ata/sata_fsl.c    | 22 +++++++++++++--------
 drivers/ata/sata_nv.c     |  9 +++++----
 drivers/ata/sata_sil24.c  | 10 +++++-----
 include/linux/libata.h    | 22 ++++++++++++++-------
 7 files changed, 100 insertions(+), 50 deletions(-)

-- 
1.9.3

