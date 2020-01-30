Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12B3C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA8A206D5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GKQmjoAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgA3KYd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:24:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40562 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgA3KYd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:24:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130102431euoutp01386772f84e404c86469672c25e806844~uox6zQiuT0846508465euoutp01K
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:24:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130102431euoutp01386772f84e404c86469672c25e806844~uox6zQiuT0846508465euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580379871;
        bh=M/zmK5txIXJcBTX1YQGWKdsxu1zyqsRRXnW3tgDCFx0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GKQmjoAcVUbdS4CXaqm66H+gYzmKw1SND510vd2ZCYigUbEoQfxNtFO5I2bWPqIBn
         ZtnfCXnRFSWOL4Z4PyE7ZKFj8YQ6BKuwfwaZYlN/V//FGcK2At8lMNCHOR8FqES33P
         oTCNc2kypJ/kpmQwAT7c1r/7ywOGMUHcBD0yRJ/4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130102431eucas1p2c4f48d4a3bebe987c6b955c493f65f29~uox6YJQmy2096920969eucas1p2l;
        Thu, 30 Jan 2020 10:24:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1E.A9.60679.EDEA23E5; Thu, 30
        Jan 2020 10:24:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130102430eucas1p153e21a42e8b9abb56bee58e41e25d8bf~uox6H69wY1836418364eucas1p1n;
        Thu, 30 Jan 2020 10:24:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130102430eusmtrp20eec4051f61f7ce068bc9735772f7da0~uox6HM0Mu0552205522eusmtrp2o;
        Thu, 30 Jan 2020 10:24:30 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-0a-5e32aedeabb3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.AA.08375.EDEA23E5; Thu, 30
        Jan 2020 10:24:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130102430eusmtip12b90053fae441f54bdc54a38252e8ad5~uox53VoEO3019030190eusmtip1x;
        Thu, 30 Jan 2020 10:24:30 +0000 (GMT)
Subject: Re: [PATCH 00/24] ata: move DPRINTK to dynamic debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <055a2421-a59a-29a5-152b-fde54ff55aea@samsung.com>
Date:   Thu, 30 Jan 2020 11:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-1-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned3764ziDOYcY7RYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKO4bFJSczLLUov07RK4MiY9O8JW8FqiYuXsmgbG30Jd
        jJwcEgImEm9bj7F1MXJxCAmsYJQ4efQQK4TzhVFi3oV1jBDOZ0aJr99bmGBaft7uZYdILGeU
        OH+5nwnCecsoMXnxb1aQKmEBR4nj106wgNgiAkoSH9sPsYPYzALWErMXrwebxCZgJTGxfRUj
        iM0rYCex9t0VsF4WAVWJ2Q/XgPWKCkRIfHpwmBWiRlDi5MwnYHFOASOJh4v2MkPMFJe49WQ+
        E4QtL7H97RxmkIMkBJrZJa7f+c8GcbaLxNW5jcwQtrDEq+Nb2CFsGYn/O+czQTSsY5T42/EC
        qns7o8Tyyf+guq0l7pz7BWRzAK3QlFi/Sx8i7CjRuXwbK0hYQoBP4sZbQYgj+CQmbZvODBHm
        lehogwa2msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212CgvtVyv
        ODG3uDQvXS85P3cTIzCJnP53/MsOxl1/kg4xCnAwKvHwXlhrFCfEmlhWXJl7iFGCg1lJhFfU
        1TBOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBsaNS3zu
        pj9e2eutKvZjToTPmTdfk5qs7hyKdCjZpMrxPc3ZOKbLfM8+y0wRyV2ioiXLw1a6JN1d+WYq
        e4umfX+LyvfS2YESWck91TsuCniKK6+rWDPzxEv1upA4T4XIDbtMnWfvvtH+5/EG1VqfXfM+
        z637cq2eVffIV1bXln5p4x2rbrGcX6rEUpyRaKjFXFScCAB+mJ6iHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7r31hnFGVxdoW2x+m4/m8WeRZOY
        LI7teMTkwOxx+Wypx+bT1R6fN8kFMEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZUx6doSt4LVExcrZNQ2Mv4W6GDk5JARMJH7e7mXvYuTiEBJY
        yijxdeEOxi5GDqCEjMTx9WUQNcISf651sUHUvGaUuHfuEStIQljAUeL4tRMsILaIgJLEx/ZD
        7CA2s4C1xOzF65kgGloZJVb/fM0GkmATsJKY2L6KEcTmFbCTWPvuCtggFgFVidkP14ANEhWI
        kDi8YxZUjaDEyZlPwOKcAkYSDxftZYZYoC7xZ94lKFtc4taT+UwQtrzE9rdzmCcwCs1C0j4L
        ScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgz24793LyD8dLG4EOMAhyM
        Sjy8F9YaxQmxJpYVV+YeYpTgYFYS4RV1NYwT4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5Hxg
        POeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamAsM+1Ynclm9aNn
        wZrdckpquzn68zkev+Z67u+rfUuSraAn69XiG3wPuhhijX/FSs2pMeZz+HuCpf+LT+gCw86I
        30tYdxensby1Ks8J/JrxSkJ7yZ+Zyx5M92my6Vg8/dPe/7Ebrux6FiMgEfR7Ivu846Yz2H7N
        CGgu/+zdz/Qjl/U14yPe1hYlluKMREMt5qLiRADASeDmrwIAAA==
X-CMS-MailID: 20200130102430eucas1p153e21a42e8b9abb56bee58e41e25d8bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104740epcas3p419fa4d0d7bbd5a5004ba3f3c632ba7bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104740epcas3p419fa4d0d7bbd5a5004ba3f3c632ba7bd
References: <CGME20181213104740epcas3p419fa4d0d7bbd5a5004ba3f3c632ba7bd@epcas3p4.samsung.com>
        <20181213104716.31930-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Hi all,

Hi,

> I got tired of always having to recompile the ATA drivers with ATA_DEBUG
> set so here's now a patchset of move every user of DPRINTK over to
> dynamic debugging, and drop ATA_DEBUG completely.
> 
> As usual, comments and reviews are welcome.

This patchset somehow slipped through the cracks which is
a shame because it seems to be a valuable contribution.

I agree with the general approach but have some comments to
the individual patches (please see my other replies).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Hannes Reinecke (24):
>   libata: move ata_{port,link,dev}_dbg to dynamic debugging
>   sata_nv: move DPRINTK to ata debugging
>   sata_sx4: move DPRINTK to ata debugging
>   sata_sil24: move DPRINTK to ata debugging
>   sata_rcar: move DPRINTK to ata debugging
>   sata_qstor: move DPRINTK to ata debugging
>   pdc_adma: move DPRINTK to ata debugging
>   ahci: move DPRINTK to ata debugging
>   ahci_qorig: move DPRINTK to ata debugging
>   pata_octeon_cf: move DPRINTK to ata debugging
>   pata_sil680: move DPRINTK to ata debugging
>   ata_piix: Remove DPRINTK usage
>   libahci: move DPRINTK to ata debugging
>   libata: move DPRINTK to ata debugging
>   pata_pdc2027x: Replace PDPRINTK() with dynamic debugging
>   sata_fsl: move DPRINTK to ata debugging
>   sata_mv: replace DPRINTK with 'pci_dump' module parameter
>   libata: add 'link' argument to ata_dev_classify()
>   libata: Use ata_port_printk() in ata_dump_id()
>   pata_pdc202xx_old: move DPRINTK to ata debugging
>   libata: remove DPRINTK() macro
>   ata: Remove remaining references to ATA_DEBUG
>   libata: drop BPRINTK()
>   libata.h: Whitespace cleanup
> 
>  drivers/ata/ahci.c              | 10 ++---
>  drivers/ata/ahci.h              |  2 +-
>  drivers/ata/ahci_qoriq.c        |  4 +-
>  drivers/ata/ata_piix.c          |  5 +--
>  drivers/ata/libahci.c           | 25 ++++++-----
>  drivers/ata/libata-core.c       | 76 ++++++++++++++++++---------------
>  drivers/ata/libata-eh.c         | 26 ++++++------
>  drivers/ata/libata-pmp.c        | 12 +++---
>  drivers/ata/libata-scsi.c       | 26 ++++++------
>  drivers/ata/libata-sff.c        | 44 +++++++++----------
>  drivers/ata/pata_octeon_cf.c    | 13 +++---
>  drivers/ata/pata_pdc2027x.c     | 72 +++++++++++++------------------
>  drivers/ata/pata_pdc202xx_old.c |  2 +-
>  drivers/ata/pata_sil680.c       |  2 +-
>  drivers/ata/pdc_adma.c          |  4 +-
>  drivers/ata/sata_fsl.c          | 94 ++++++++++++++++++++++-------------------
>  drivers/ata/sata_inic162x.c     |  2 +-
>  drivers/ata/sata_mv.c           | 71 ++++++++++++++++---------------
>  drivers/ata/sata_nv.c           | 22 +++++-----
>  drivers/ata/sata_qstor.c        |  5 ++-
>  drivers/ata/sata_rcar.c         | 10 ++---
>  drivers/ata/sata_sil24.c        |  6 +--
>  drivers/ata/sata_sx4.c          |  2 +-
>  drivers/scsi/libsas/sas_ata.c   |  3 +-
>  include/linux/libata.h          | 34 ++++++---------
>  25 files changed, 282 insertions(+), 290 deletions(-)
