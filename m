Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDBC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 20 Nov 2021 03:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhKTDZF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:25:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26338 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhKTDZE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 22:25:04 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HwzGl2wHrzbhrq;
        Sat, 20 Nov 2021 11:17:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sat, 20 Nov
 2021 11:22:00 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtylyov@gmail.com>, <yebin10@huawei.com>,
        <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH -next V2 0/2] fix two bugs when trying rmmod sata_fsl
Date:   Sat, 20 Nov 2021 11:34:18 +0800
Message-ID: <20211120033420.3762681-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

V1->V2:
	Fixed the check on the return value of platform_get_irq().
	And propagate errors up to sata_fsl_probe()'s callers.

Baokun Li (2):
  sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
  sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

 drivers/ata/sata_fsl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.31.1

