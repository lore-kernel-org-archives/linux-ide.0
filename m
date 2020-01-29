Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66371C33C9E
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 02:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393DC2071E
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 02:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwSQEdJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgA2Chg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:37:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgA2Chg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 21:37:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T2Y8hn111870;
        Wed, 29 Jan 2020 02:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=HfW61FK9uk+WkM9utdU/THqOxC9th3YYTgHs+EIQeWA=;
 b=HwSQEdJz8ERKqdgeKVO2dXoa9kMNvLpkEu6cdCurXG+LlvlafNLsMMATd2Kuwcq37qVx
 eaNayazE7jeMY0K6JMlB1KHdnpM9zbbndfltl1uLhUWvEfKYr4FGAEW+mbd/LXBXJ1g8
 b6MD7FoxiU3RTUl5OOEPIfPgQgmMQfMKeUEMJu2FkkM/aP/Mg8YRKMMdndS0M585wpvi
 SUaCCFymv/keIaXrAuYyf4m8RiKMdGKNmnoqiq3wQZ2HzQCWZrw9TE8/k+XGtyem2gua
 ZapSMoZ/skWIlVD+2Ss3zlfZIKhGU2sHKGrwwPZdSzHBQTT1k0IRzqhcbJQtJNA2P7t4 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xreara2ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 02:37:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T2Y3N5033622;
        Wed, 29 Jan 2020 02:35:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xth5j3de0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 02:35:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00T2ZMox032109;
        Wed, 29 Jan 2020 02:35:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 18:35:22 -0800
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 03/28] ata: make SATA_PMP option selectable only if any SATA host driver is enabled
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5@eucas1p1.samsung.com>
        <20200128133343.29905-4-b.zolnierkie@samsung.com>
Date:   Tue, 28 Jan 2020 21:35:19 -0500
In-Reply-To: <20200128133343.29905-4-b.zolnierkie@samsung.com> (Bartlomiej
        Zolnierkiewicz's message of "Tue, 28 Jan 2020 14:33:18 +0100")
Message-ID: <yq1zhe76lco.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=926
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=993 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290020
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Bartlomiej,

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index a7881f8eb05e..1b6eaf8da5fa 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -989,6 +989,7 @@ config SCSI_SYM53C8XX_MMIO
>  config SCSI_IPR
>  	tristate "IBM Power Linux RAID adapter support"
>  	depends on PCI && SCSI && ATA
> +	select SATA_HOST
>  	select FW_LOADER
>  	select IRQ_POLL
>  	select SGL_ALLOC
> diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
> index 5c6a5eff2f8e..052ee3a26f6e 100644
> --- a/drivers/scsi/libsas/Kconfig
> +++ b/drivers/scsi/libsas/Kconfig
> @@ -19,6 +19,7 @@ config SCSI_SAS_ATA
>  	bool "ATA support for libsas (requires libata)"
>  	depends on SCSI_SAS_LIBSAS
>  	depends on ATA = y || ATA = SCSI_SAS_LIBSAS
> +	select SATA_HOST
>  	help
>  		Builds in ATA support into libsas.  Will necessitate
>  		the loading of libata along with libsas.

SCSI bits look fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
