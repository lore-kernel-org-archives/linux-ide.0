Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327F6C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 23 Nov 2021 01:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhKWBcv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:32:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26348 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhKWBcv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2021 20:32:51 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hymdl01GYzbj2m;
        Tue, 23 Nov 2021 09:24:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 23 Nov
 2021 09:29:42 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtylyov@gmail.com>, <yebin10@huawei.com>,
        <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next V4 0/2] fix two bugs when trying rmmod sata_fsl
Date:   Tue, 23 Nov 2021 09:41:57 +0800
Message-ID: <20211123014159.3442998-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

V1->V2:
	Fixed the check on the return value of platform_get_irq().
	And propagate errors up to sata_fsl_probe()'s callers.
V2->V3:
	Add fixed and CC stable and modified the patch description.
V3->V4:
	Use a single structure.

Baokun Li (2):
  sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
  sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

 drivers/ata/sata_fsl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.31.1

