Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD33C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 13:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKGNBq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiKGNBp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 08:01:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8D1C411
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 05:01:44 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5WZh3bbMz15MQ7;
        Mon,  7 Nov 2022 21:01:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 21:01:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 21:01:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <yangyingliang@huawei.com>
Subject: [PATCH 0/3] ata: libata-transport: fix some error handing
Date:   Mon, 7 Nov 2022 20:59:39 +0800
Message-ID: <20221107125942.143769-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patchset handle error case of transport_add_device(), if it's
ignored, it will lead kernel crash because of trying to delete not
added device in transport_remove_device()

Yang Yingliang (3):
  ata: libata-transport: fix error handling in ata_tport_add()
  ata: libata-transport: fix error handling in ata_tlink_add()
  ata: libata-transport: fix error handling in ata_tdev_add()

 drivers/ata/libata-transport.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.25.1

