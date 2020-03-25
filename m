Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE687C54FCF
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CC420772
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EytQXqNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYPP2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:15:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39671 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYPP2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 11:15:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200325151526euoutp027b30f680a38270cc692d6401604f016c~-lOoIz59P3106831068euoutp02x
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 15:15:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200325151526euoutp027b30f680a38270cc692d6401604f016c~-lOoIz59P3106831068euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585149326;
        bh=UKSj4K2GRfPwmVUCm/p0A8iPa1ZecKW5xBjfL1rPVhY=;
        h=To:Cc:From:Subject:Date:References:From;
        b=EytQXqNTFnJ4Ibai7lfUd/r5bpP09j41mH+jZUR0W8SNZj51dlgapEccB+o/XybW/
         uddeBQMXl/RP1MlvjIs2mg2r5gY+xjhxUPC36ebHg+PUbd2kQu41nXZFkAppA9e7Kx
         MbzIqZV04qZ8kK8pM6i9AyCbL90WomX6flA/+MwM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200325151526eucas1p243aef070c861e477497dfca3c6724e6e~-lOniea_J2502925029eucas1p2b;
        Wed, 25 Mar 2020 15:15:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.05.60679.D857B7E5; Wed, 25
        Mar 2020 15:15:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81~-lOnPDdIv1637316373eucas1p1v;
        Wed, 25 Mar 2020 15:15:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200325151525eusmtrp23652d9b1b6ac83fe232ac54974695db9~-lOnOetP02382823828eusmtrp2t;
        Wed, 25 Mar 2020 15:15:25 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-8d-5e7b758d35b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.4D.08375.D857B7E5; Wed, 25
        Mar 2020 15:15:25 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200325151525eusmtip2fc321312b0ad422106e3f2a0f6071f51~-lOm7DZI42571925719eusmtip2X;
        Wed, 25 Mar 2020 15:15:25 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        b.zolnierkie@samsung.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] sata_fsl: build fix
Message-ID: <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
Date:   Wed, 25 Mar 2020 16:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7p9pdVxBncSLFbf7Wez2DhjPavF
        nkWTmCyO7XjEZPFk4Rkmi1/LjzI6sHlcPlvqsWlVJ5vHzu8N7B59W1Yxemw+Xe3xeZNcAFsU
        l01Kak5mWWqRvl0CV8aPm2sYC45wVMy4/YyxgXEpexcjJ4eEgInEx+WzWbsYuTiEBFYwSjxb
        fRbK+cIoMffJJBYI5zOjxMzZk5lhWu5tnMAOkVjOKLFlzw1GCOctUP/iRjaQKhEBBYme3yvZ
        QBLMArMYJU4cXQCWYBOwkpjYvgqog4NDWEBF4ta+LJAwr4CdxMFtU1hBbBYBVYmeJa/BDhQV
        iJD49OAwK0SNoMTJmU9YQGxmAXGJW0/mM0HY8hLb386Bum4eu8Tv9SEQtovEwisHoeLCEq+O
        b4F6Wkbi/06QXi4gex2jxN+OF8wQznZGieWT/7FBVFlL3Dn3iw3kUGYBTYn1u/Qhwo4SS7cd
        ZwcJSwjwSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJdQ5HhJdSy4zTmBUnIXk
        s1lIPpuF5LNZCDcsYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZh+Tv87/mUH464/
        SYcYBTgYlXh4N1hWxwmxJpYVV+YeYpTgYFYS4d2cWhEnxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA+OUK7Xbhf/8uMhw88/bGUvv7uQstLrVp/HxCsuB
        N8GWS810n4amrt4aKXGp4v+OhFMu+UwnnwZ1+auFh/fEffxqwfbdecWnzSUfYlYGOP3gq5uS
        vrXxXUS0zK/zltp3jqzwWV62t6jpocrXw1G3z1iX/c98yiWbZmzNxaZcEfhEN0osbuEKJz4l
        luKMREMt5qLiRACWocTyOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7q9pdVxBn/36FqsvtvPZrFxxnpW
        iz2LJjFZHNvxiMniycIzTBa/lh9ldGDzuHy21GPTqk42j53fG9g9+rasYvTYfLra4/MmuQC2
        KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MHzfX
        MBYc4aiYcfsZYwPjUvYuRk4OCQETiXsbJwDZXBxCAksZJY60P2LpYuQASshIHF9fBlEjLPHn
        WhcbRM1rRonlq7+zgiREBBQken6vBEswC8xilLjx5QEzSIJNwEpiYvsqRpBBwgIqErf2ZYGE
        eQXsJA5umwLWyyKgKtGz5DXYEaICERKHd8xihKgRlDg58wkLiM0soC7xZ94lZghbXOLWk/lM
        ELa8xPa3c5gnMAItRWiZhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM
        n23Hfm7ewXhpY/AhRgEORiUe3g2W1XFCrIllxZW5hxglOJiVRHg3p1bECfGmJFZWpRblxxeV
        5qQWH2I0BXpoIrOUaHI+MLbzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0
        MXFwSjUwVtVMOD33+Pzmp4keR0Sklp/vVNoevOKs7tRf+7bvc7M6/CTG9cZTQd0zVpHfOzZw
        //9w8k7kas789OtchtN3pU+v2DjBZdaPsLX/F8rm2ExTXmo99f7BiEsT391aY7Tqauq6Mz87
        b8u1bDAqKkpJ/nuYeQffEefq6l/2q6K/Wmz/2rfzypTaQz+VWIozEg21mIuKEwHUFsVitQIA
        AA==
X-CMS-MailID: 20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81
References: <CGME20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix incorrect DPRINTK() conversion in sata_fsl_init_controller()
(dev_dbg() should be used instead of ata_port_dbg()).

Fixes: b3f062310706 ("sata_fsl: move DPRINTK to ata debugging")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_fsl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/sata_fsl.c
===================================================================
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1362,7 +1362,7 @@ static int sata_fsl_init_controller(stru
 	iowrite32((temp & ~0x3F), hcr_base + HCONTROL);
 
 	/* Disable interrupt coalescing control(icc), for the moment */
-	ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
+	dev_dbg(host->dev, "icc = 0x%x\n", ioread32(hcr_base + ICC));
 	iowrite32(0x01000000, hcr_base + ICC);
 
 	/* clear error registers, SError is cleared by libATA  */
