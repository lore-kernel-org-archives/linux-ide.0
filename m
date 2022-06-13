Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C2CCA47B
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jun 2022 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiFMUZT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349230AbiFMUMx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2022 16:12:53 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1554122
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 11:47:54 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.127) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 13 Jun
 2022 21:47:46 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <226fc2b1-ecb9-19d9-d7f0-2c6bc0fc8edf@omp.ru>
Date:   Mon, 13 Jun 2022 21:47:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.127]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/13/2022 18:34:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171077 [Jun 13 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.127 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;178.176.74.127:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.127
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/13/2022 18:36:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/13/2022 4:53:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
milliseconds. Then follow the suit with ata_exec_internal(), its only
caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
caller  that explicitly passes *unsigned long* variable for timeout...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-core.c |    6 +++---
 drivers/ata/libata.h      |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -1472,7 +1472,7 @@ static void ata_qc_complete_internal(str
 unsigned ata_exec_internal_sg(struct ata_device *dev,
 			      struct ata_taskfile *tf, const u8 *cdb,
 			      int dma_dir, struct scatterlist *sgl,
-			      unsigned int n_elem, unsigned long timeout)
+			      unsigned int n_elem, unsigned int timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -1647,7 +1647,7 @@ unsigned ata_exec_internal_sg(struct ata
 unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen,
-			   unsigned long timeout)
+			   unsigned int timeout)
 {
 	struct scatterlist *psg = NULL, sg;
 	unsigned int n_elem = 0;
@@ -4339,7 +4339,7 @@ unsigned int ata_dev_set_feature(struct
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	unsigned long timeout = 0;
+	unsigned int timeout = 0;
 
 	/* set up set-features taskfile */
 	ata_dev_dbg(dev, "set features - SATA features\n");
Index: libata/drivers/ata/libata.h
===================================================================
--- libata.orig/drivers/ata/libata.h
+++ libata/drivers/ata/libata.h
@@ -52,11 +52,11 @@ extern u64 ata_tf_read_block(const struc
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
-				  unsigned long timeout);
+				  unsigned int timeout);
 extern unsigned ata_exec_internal_sg(struct ata_device *dev,
 				     struct ata_taskfile *tf, const u8 *cdb,
 				     int dma_dir, struct scatterlist *sg,
-				     unsigned int n_elem, unsigned long timeout);
+				     unsigned int n_elem, unsigned int timeout);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
