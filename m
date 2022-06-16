Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DDBC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiFPUwG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiFPUwF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2022 16:52:05 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0055FF06
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2022 13:52:00 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 17CC520EC994
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 0/2] Fix sloppy typing in the fast drain logic
Date:   Thu, 16 Jun 2022 23:51:47 +0300
Message-ID: <20220616205149.16157-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1902.lancloud.ru (fd00:f066::72)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Here are 2 patches against the 'for-next' branch of Damien Le Moal's
'libata.git' repo.
The libata's fast drain logic unfortunately boasts of some sloppy typing --
unify it by using *unsigned int* everyhere...

Sergey Shtylyov (2):
  ata: libata-eh: fix sloppy result type of ata_eh_nr_in_flight()
  ata: make ata_port::fastdrain_cnt *unsigned int*

 drivers/ata/libata-eh.c | 8 ++++----
 include/linux/libata.h  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.26.3
