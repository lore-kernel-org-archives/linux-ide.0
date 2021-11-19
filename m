Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC52C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE1F61051
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKSECL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:02:11 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27146 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSECJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2021 23:02:09 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HwNBx2pGzz1DJYH;
        Fri, 19 Nov 2021 11:56:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 11:59:06 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>, <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next 0/2] fix two bugs when trying rmmod sata_fsl
Date:   Fri, 19 Nov 2021 12:11:26 +0800
Message-ID: <20211119041128.2436889-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Baokun Li (2):
  sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
  sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

 drivers/ata/sata_fsl.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.31.1

