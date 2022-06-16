Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0DC43334
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiFPUwF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFPUwF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2022 16:52:05 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3671D5FF07
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2022 13:52:00 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 35E7F20CC5BA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 1/2] ata: libata-eh: fix sloppy result type of ata_eh_nr_in_flight()
Date:   Thu, 16 Jun 2022 23:51:48 +0300
Message-ID: <20220616205149.16157-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616205149.16157-1-s.shtylyov@omp.ru>
References: <20220616205149.16157-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1902.lancloud.ru (fd00:f066::72)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_eh_nr_in_flight() counts the # of the active tagged commands and thus
cannot return a negative value but the result type is nevertheless *int*;
switching it to *unsigned int* (along with the local variables receiving
the function's result) helps avoiding the sign extension instructions when
comparing with or assigning to *unsigned long *ata_port::fastdrain_cnt and
thus results in a more compact 64-bit code...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-eh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3307ed45fe4d..25586e16692d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -802,11 +802,11 @@ void ata_port_wait_eh(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_port_wait_eh);
 
-static int ata_eh_nr_in_flight(struct ata_port *ap)
+static unsigned int ata_eh_nr_in_flight(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	unsigned int tag;
-	int nr = 0;
+	unsigned int nr = 0;
 
 	/* count only non-internal commands */
 	ata_qc_for_each(ap, qc, tag) {
@@ -821,7 +821,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
 {
 	struct ata_port *ap = from_timer(ap, t, fastdrain_timer);
 	unsigned long flags;
-	int cnt;
+	unsigned int cnt;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -870,7 +870,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  */
 static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 {
-	int cnt;
+	unsigned int cnt;
 
 	/* already scheduled? */
 	if (ap->pflags & ATA_PFLAG_EH_PENDING)
-- 
2.26.3
