From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] ata: pata_arasan: Staticize local symbols
Date: Fri, 09 Aug 2013 14:35:00 +0900
Message-ID: <000001ce94c2$30c95430$925bfc90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10561 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343Ab3HIFfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 01:35:02 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR900EEN0TM7530@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Fri, 09 Aug 2013 14:35:00 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Jingoo Han <jg1.han@samsung.com>

These local symbols are used only in this file.
Fix the following sparse warnings:

drivers/ata/pata_arasan_cf.c:657:6: warning: symbol 'arasan_cf_error_handler' was not declared. Should it be static?
drivers/ata/pata_arasan_cf.c:686:14: warning: symbol 'arasan_cf_qc_issue' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_arasan_cf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 848ed32..853f610 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -654,7 +654,7 @@ static void arasan_cf_freeze(struct ata_port *ap)
 	ata_sff_freeze(ap);
 }
 
-void arasan_cf_error_handler(struct ata_port *ap)
+static void arasan_cf_error_handler(struct ata_port *ap)
 {
 	struct arasan_cf_dev *acdev = ap->host->private_data;
 
@@ -683,7 +683,7 @@ static void arasan_cf_dma_start(struct arasan_cf_dev *acdev)
 	ata_sff_queue_work(&acdev->work);
 }
 
-unsigned int arasan_cf_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int arasan_cf_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct arasan_cf_dev *acdev = ap->host->private_data;
-- 
1.7.10.4


