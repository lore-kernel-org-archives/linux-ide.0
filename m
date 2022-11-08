Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B945C4167D
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 13:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiKHNll (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiKHNl1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 08:41:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B953EDB
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 05:41:24 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N68Pz0BwRzmVk4;
        Tue,  8 Nov 2022 21:41:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:41:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 21:41:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <yangyingliang@huawei.com>
Subject: [PATCH v3 0/4] ata: libata-transport: fix some error handlings
Date:   Tue, 8 Nov 2022 21:40:00 +0800
Message-ID: <20221108134004.1079981-1-yangyingliang@huawei.com>
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

patch #1 fix a null-ptr-deref problem that caused by double put refcount.

patch #2 ~ #4 handle error case of transport_add_device(), if it's
ignored, it will lead kernel crash because of trying to delete not
added device in transport_remove_device().

v2 -> v3:
  Update commit message of patch #2 ~ #4 to more clear.

v1 -> v2:
  Update commit message that suggested by Damien.

Yang Yingliang (4):
  ata: libata-transport: fix double ata_host_put() in ata_tport_add()
  ata: libata-transport: fix error handling in ata_tport_add()
  ata: libata-transport: fix error handling in ata_tlink_add()
  ata: libata-transport: fix error handling in ata_tdev_add()

 drivers/ata/libata-transport.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.25.1

