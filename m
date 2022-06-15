Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C94CCA47F
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbiFOTik (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiFOTi2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 15:38:28 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244F5469F
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 12:38:24 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 8D23120CB7AA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v2 0/2] Fix sloppy 'timeout' parameter type in libata-core.c
Date:   Wed, 15 Jun 2022 22:38:19 +0300
Message-ID: <20220615193821.9235-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1902.lancloud.ru (fd00:f066::72)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The libata code too often uses the *unsigned long* type for the millisecond
timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
take *unsigned int* parameters for those. Start fixing the timeout types from
ata_exec_internal[_sg]() that triggered the SVACE static analyzer; there's
going to be a large continuation series somewhat later...

Sergey Shtylyov (2):
  ata: libata-core: make ata_exec_internal_sg() *static*
  ata: libata-core: fix sloppy parameter type in ata_exec_internal[_sg]()

 drivers/ata/libata-core.c | 12 ++++++------
 drivers/ata/libata.h      |  6 +-----
 2 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.26.3
