Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A0C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735920838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ue6xR//h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBGOY2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:24:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48455 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGOY1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:24:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142426euoutp02065d18ec688b1d508928fdbd8cf0ae4d~xJNrlFjNa2418224182euoutp02q
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:24:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142426euoutp02065d18ec688b1d508928fdbd8cf0ae4d~xJNrlFjNa2418224182euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085466;
        bh=uQNpOFk2kaFpJkgOwJvlbIcD6BDo24bLhJkJZXwaWp0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ue6xR//haOzxEP1EcJB3hLHuTMI1sLJ1C0BPkqXl6W5Ut3g47a9EIgEKht7/qhBD+
         viLk9Q687N6Oui5lrXFkJYgGalVKcpPrbM1WkWf8beuuXYb14Pd3Vl1y7ajJ5JvJXP
         kYYR6ILaf69UHSq1WpCStMaOa8fbJO8hB6pvTzk8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142426eucas1p10e4a2574effed3af86941bf464eea2ea~xJNrZczid1983019830eucas1p1S;
        Fri,  7 Feb 2020 14:24:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.68.60698.A137D3E5; Fri,  7
        Feb 2020 14:24:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142426eucas1p21f131acdc849396696d84f259a0f7811~xJNrKHDUA1916819168eucas1p24;
        Fri,  7 Feb 2020 14:24:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142426eusmtrp17e1b66677e337e6934e36e5fb4ad9355~xJNrJg3FS0309203092eusmtrp1O;
        Fri,  7 Feb 2020 14:24:26 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-90-5e3d731a6d56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.75.07950.A137D3E5; Fri,  7
        Feb 2020 14:24:26 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142425eusmtip150cad317f97473707264fae8a8655194~xJNq1_x-c0117501175eusmtip1C;
        Fri,  7 Feb 2020 14:24:25 +0000 (GMT)
Subject: Re: [PATCH 15/28] ata: move sata_print_link_status() to
 libata-core-sata.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e6de4572-5707-75b9-118e-926245120b6e@samsung.com>
Date:   Fri, 7 Feb 2020 15:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129173045.GK12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7pSxbZxBjPvyFusvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANYrLJiU1
        J7MstUjfLoErY9amB0wF91gqvs27xdbA+I65i5GTQ0LARGLHt5+MXYxcHEICKxglHnxsZYFw
        vjBKrJr+lA3C+cwoceTuU3aYln/T/jFDJJYzSrRNfg/V8pZRYtGiM6wgVcICoRIfJ68HWyIi
        oClxa3k7WAezwAZGic+TtjCCJNgErCQmtq8Cs3kF7CT2rPkK1swioCLR/XUVE4gtKhAh8enB
        YVaIGkGJkzOfsIDYnALGEle3vAGzmQXEJW49mc8EYctLbH87B2yZhMAydomZX14CJTiAHBeJ
        vY0+EC8IS7w6vgXqHRmJ05N7WCDq1zFK/O14AdW8nVFi+eR/bBBV1hJ3zv1iAxnEDPTO+l36
        EGFHiZnfT7NDzOeTuPFWEOIGPolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQfDYL
        yTezkHwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIGJ5/S/4193MO77k3SI
        UYCDUYmHN8HRJk6INbGsuDL3EKMEB7OSCG+fqm2cEG9KYmVValF+fFFpTmrxIUZpDhYlcV7j
        RS9jhQTSE0tSs1NTC1KLYLJMHJxSDYx1c64s71KxmFfB9fl/24k7FszCRxi3HOSbv3LjCdEe
        /4Sgrbd3feI5ebi3SzOf23fljT9q1kG/XMKe1ujlLVwx/+LBiacCrzC6enctuumxjfO14syy
        hw88+X4pPWm6ZsYSdykysYVbzGfuqop59T0hSs+8bt36dqCEacF9Rc2azOzgotQO/yQlluKM
        REMt5qLiRAA0Od4BOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pSxbZxBh1dAhar7/azWTy7tZfJ
        4vSERUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZffYvELL4/LZUo9DhzsYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmLXpAVPBPZaK
        b/NusTUwvmPuYuTkkBAwkfg37R+YLSSwlFHi9NuYLkYOoLiMxPH1ZRAlwhJ/rnWxdTFyAZW8
        ZpS4uv8JWL2wQKjEx8nrwWwRAU2JW8vbwWxmgQ2MEte/CELMfM8o8WuLDYjNJmAlMbF9FSOI
        zStgJ7FnzVdWEJtFQEWi++sqJhBbVCBC4vCOWVA1ghInZz5hAbE5BYwlrm55wwIxX13iz7xL
        ULvEJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIExtu3Yzy07GLveBR9iFOBgVOLhTXC0iRNiTSwrrsw9xCjBwawkwtunahsnxJuS
        WFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA+M8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cAoubV6XVzi1uC2OcfXfzeV0bgbdfts/7LJHGYfM3Nkwji8U6/65fzc
        mGMs8mROVrNx6MMJrYnLrUtfLMlRebP13sc7hjcX1Mj41oZ65yb0PSy13cm1Zo+X3LqS2T6r
        uRfeyrh79K6RusVz+ZmHJ4ffSvCY5zozTmpyU08T22uXt5t6Pof2n7irxFKckWioxVxUnAgA
        8qpwiscCAAA=
X-CMS-MailID: 20200207142426eucas1p21f131acdc849396696d84f259a0f7811
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f@eucas1p1.samsung.com>
        <20200128133343.29905-16-b.zolnierkie@samsung.com>
        <20200129173045.GK12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:30 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2020 at 02:33:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * move sata_print_link_status() to libata-core-sata.c
>>
>> * add static inline for CONFIG_SATA_HOST=n case
> 
> With the IS_ENABLED() in sata_scr_read the compile should be able to
> just do this by itself - maybe with an inline thrown in for
> sata_print_link_status if the compiler behaves stupidly.

I've reworked the code to use this approach in v2 of the patchset.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
