Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE3C433B4
	for <linux-ide@archiver.kernel.org>; Fri, 14 May 2021 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258D661460
	for <linux-ide@archiver.kernel.org>; Fri, 14 May 2021 14:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhENODH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 May 2021 10:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhENODG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 May 2021 10:03:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA67E61454;
        Fri, 14 May 2021 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621000915;
        bh=qFqN2dj2rmGsfozT6zbjm9HVwa2c3P8b01rM7/x/thE=;
        h=From:To:Cc:Subject:Date:From;
        b=D3/yKLkkR4n90s7WHDWVvC37Glxy6qktMrdxUW6rOPwsN+y7YaBspszCk88aNq81h
         jdFnzWFlyDGZJSctssi6ZW3PW1qhnTxRkyzTW0ppmoSsqHNe8z+b1hAjzfn3unKI+m
         P83usl1NPZoqvHJ1IRlf293lz4G5Eo5/Z/bQSZKOm+WdtGK84QFh57OJISFjg2cvvP
         +Ib8upl/n8cqmu0ssAqLuch2uiqfHklqNHJmFep/OB0WyjNQdEEiHptp5/h+qJ8drJ
         XvRw3XA4vr5i1c0qZX8lmmJhD+5eay7zsHLfBkRxkUKyIVQ24QV5peE7CIU591i27+
         7XqPOYstA/M7w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sata: nv: fix debug format string mismatch
Date:   Fri, 14 May 2021 16:01:01 +0200
Message-Id: <20210514140105.3080580-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Turning on debugging in this this driver reveals a type mismatch:

In file included from include/linux/kernel.h:17,
                 from drivers/ata/sata_nv.c:23:
drivers/ata/sata_nv.c: In function 'nv_swncq_sdbfis':
drivers/ata/sata_nv.c:2121:10: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
 2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
 2124 |   ap->print_id, ap->qc_active, pp->qc_active,
      |                 ~~~~~~~~~~~~~
      |                   |
      |                   u64 {aka long long unsigned int}
include/linux/printk.h:142:10: note: in definition of macro 'no_printk'
  142 |   printk(fmt, ##__VA_ARGS__);  \
      |          ^~~
drivers/ata/sata_nv.c:2121:2: note: in expansion of macro 'DPRINTK'
 2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
      |  ^~~~~~~
drivers/ata/sata_nv.c:2121:36: note: format string is defined here
 2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
      |                                   ~^
      |                                    |
      |                                    unsigned int
      |                                   %llx

Use the correct format string for the u64 type.

Fixes: e3ed89396441 ("libata: bump ->qc_active to a 64-bit type")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/sata_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 20190f66ced9..de4504556669 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2118,7 +2118,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		 */
 		lack_dhfis = 1;
 
-	DPRINTK("id 0x%x QC: qc_active 0x%x,"
+	DPRINTK("id 0x%x QC: qc_active 0x%llx,"
 		"SWNCQ:qc_active 0x%X defer_bits %X "
 		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
 		ap->print_id, ap->qc_active, pp->qc_active,
-- 
2.29.2

