Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78473C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 20:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiBIUZl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:25:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBIUZk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 15:25:40 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB2E011166
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 12:25:40 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru EC31520A2D59
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v5 0/2] Use *switch*es instead of *if*s in the Artop PATA driver
Date:   Wed, 9 Feb 2022 23:25:33 +0300
Message-ID: <20220209202535.7679-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Here are 3 patches against the 'for-next' branch of Damien Le Moal's
'libata.git' repo. The driver abuses the strings of the *if* statements
where a *switch* statements would fit better...


Sergey Shtylyov (2):
  ata: pata_artop: use *switch* in artop_init_one()
  ata: pata_artop: use *switch* in atp8xx_fixup()

 drivers/ata/pata_artop.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.26.3

