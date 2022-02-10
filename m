Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E703C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 19:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiBJTWX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:22:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBJTWW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 14:22:22 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A809243
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 11:22:18 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 8840B205CF17
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 0/3] Disable the fast interrupts in the prereset() methods of HighPoint HPT36x/37x drivers
Date:   Thu, 10 Feb 2022 22:22:11 +0300
Message-ID: <20220210192214.14205-1-s.shtylyov@omp.ru>
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

Here are 3 patches against the 'for-next' branch of Damien Le Moal's
'libata.git' repo. Disable the so called fast interrupts in the prereset()
methods of the HighPoint HPT36x/37x/3x2N drivers -- that will allow to
de-duplicate the PIO/DMA mode setting in the HPT37x driver...

Sergey Shtylyov (3):
  ata: pata_hpt366: disable fast interrupts in prereset() method
  ata: pata_hpt37x: disable fast interrupts in prereset() method
  ata: pata_hpt3x2n: disable fast interrupts in prereset() method

 drivers/ata/pata_hpt366.c  | 13 ++++++-----
 drivers/ata/pata_hpt37x.c  | 48 +++++++++++++++++---------------------
 drivers/ata/pata_hpt3x2n.c | 23 ++++++++----------
 3 files changed, 39 insertions(+), 45 deletions(-)

-- 
2.26.3

