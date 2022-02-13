Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D5C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 13 Feb 2022 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiBMPJn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Feb 2022 10:09:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiBMPJn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Feb 2022 10:09:43 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C765B3CF
        for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2022 07:09:34 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 460152314A78
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 0/2] Refactor the accessors for the ATA device control and alternate status registers
Date:   Sun, 13 Feb 2022 18:09:28 +0300
Message-ID: <20220213150930.4620-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Here are 2 patches against the 'for-next' branch of Damien Le Moal's
'libata.git' repo. Refactor the accessors for the device control and
alternate status registers moving the prerequeiste checks done now around
the calls into the functionas themselves and make them return a 'bool'
result indicating if a respective register exists or not...

Sergey Shtylyov (2):
  ata: libata-sff: refactor ata_sff_set_devctl()
  ata: libata-sff: refactor ata_sff_altstatus()

 drivers/ata/libata-sff.c | 86 +++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.26.3

