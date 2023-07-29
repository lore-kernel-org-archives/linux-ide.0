Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E65C0015E
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jul 2023 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjG2USJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2USI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jul 2023 16:18:08 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8BE11C
        for <linux-ide@vger.kernel.org>; Sat, 29 Jul 2023 13:18:06 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.102) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 29 Jul
 2023 23:17:59 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH v2 0/8] Fix the remaining sloppy timeout typing in libata
Date:   Sat, 29 Jul 2023 23:17:45 +0300
Message-ID: <20230729201753.37600-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.75.102]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/29/2023 19:54:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178952 [Jul 29 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.102 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;178.176.75.102:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.102
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/29/2023 19:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/29/2023 4:55:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Here are 8 patches against the 'for-next' branch of Damien's 'libata.git' repo.

The libata code still often uses the 'unsigned long' type for the millisecond
timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
take 'unsigned int' parameters for those. I've started fixing the timeout types
from ata_exec_internal[_sg]() that tripped the Svace static analyzer and posted
couple patches, promising to post a large continuation series somewhat later...
in my worst nightmare I couldn't imagine that this would take a whole year! :-(

Sergey Shtylyov (8):
  ata: libata: fix parameter type of ata_deadline()
  ata: libata-core: fix parameter types of ata_wait_register()
  ata: libata-eh: fix reset timeout type
  ata: fix debounce timings type
  ata: libata-scsi: fix timeout type in ata_scsi_park_store()
  ata: libahci: fix parameter type of ahci_exec_polled_cmd()
  ata: ahci_xgene: fix parameter types of xgene_ahci_poll_reg_val()
  ata: sata_sil24: fix parameter type of sil24_exec_polled_cmd()

 drivers/ata/ahci.c          |  2 +-
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  7 +++----
 drivers/ata/libahci.c       |  7 ++++---
 drivers/ata/libata-core.c   |  6 +++---
 drivers/ata/libata-eh.c     |  6 +++---
 drivers/ata/libata-sata.c   | 16 ++++++++--------
 drivers/ata/libata-scsi.c   |  4 ++--
 drivers/ata/libata-sff.c    |  2 +-
 drivers/ata/sata_highbank.c |  2 +-
 drivers/ata/sata_inic162x.c |  2 +-
 drivers/ata/sata_mv.c       |  2 +-
 drivers/ata/sata_nv.c       |  2 +-
 drivers/ata/sata_sil24.c    |  4 ++--
 include/linux/libata.h      | 24 ++++++++++++------------
 15 files changed, 44 insertions(+), 44 deletions(-)

-- 
2.26.3
