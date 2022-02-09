Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A1C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 20:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiBIUx5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:53:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiBIUxy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 15:53:54 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E1C014F2A
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 12:53:55 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru D1F4E20A43EC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 0/2] Drop unused declarations from HPT3x2N PATA driver
Date:   Wed, 9 Feb 2022 23:53:49 +0300
Message-ID: <20220209205351.10912-1-s.shtylyov@omp.ru>
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

Here are 2 patches against the 'for-next' branch of Damien Le Moal's
'libata.git' repo. The HPT3x2Nd PATA driver has some declarations from
the time it was first merged that have never been actually used...

Sergey Shtylyov (2):
  ata: pata_hpt3x2n: drop unused HPT_PCI_FAST
  ata: pata_hpt3x2n: drop unused 'struct hpt_chip'

 drivers/ata/pata_hpt3x2n.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.26.3

