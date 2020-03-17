Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53597C10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB7206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgCQO5a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:57:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgCQO53 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:57:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HEv6wU121755;
        Tue, 17 Mar 2020 10:57:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ytb21j7js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 10:57:10 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02HEv89R121841;
        Tue, 17 Mar 2020 10:57:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ytb21j7ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 10:57:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02HEsKfH020816;
        Tue, 17 Mar 2020 14:56:00 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2yrpw68xw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 14:56:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HEu0SO48628190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 14:56:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43BF9112063;
        Tue, 17 Mar 2020 14:56:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21BA3112061;
        Tue, 17 Mar 2020 14:55:58 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.150.164])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 14:55:57 +0000 (GMT)
Message-ID: <1584456957.4545.7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/27] ata: make SATA_PMP option selectable only if
 any SATA host driver is enabled
From:   James Bottomley <jejb@linux.ibm.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Date:   Tue, 17 Mar 2020 07:55:57 -0700
In-Reply-To: <20200317144333.2904-4-b.zolnierkie@samsung.com>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
         <CGME20200317144342eucas1p2d73deadcdb4cee860dd610f9f8e26bda@eucas1p2.samsung.com>
         <20200317144333.2904-4-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170061
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 2020-03-17 at 15:43 +0100, Bartlomiej Zolnierkiewicz wrote:
> There is no reason to expose SATA_PMP config option when no SATA
> host drivers are enabled. To fix it add SATA_HOST config option,
> make all SATA host drivers select it and finally make SATA_PMP
> config options depend on it.
> 
> This also serves as preparation for the future changes which
> optimize libata core code size on PATA only setups.
> 
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # for
> SCSI bits
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/Kconfig         | 40
> +++++++++++++++++++++++++++++++++++++
>  drivers/scsi/Kconfig        |  1 +
>  drivers/scsi/libsas/Kconfig |  1 +
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index a6beb2c5a692..ad7760656f71 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -34,6 +34,9 @@ if ATA
>  config ATA_NONSTANDARD
>         bool
>  
> +config SATA_HOST
> +	bool
> +
>  config ATA_VERBOSE_ERROR
>  	bool "Verbose ATA error reporting"
>  	default y
> @@ -73,6 +76,7 @@ config SATA_ZPODD
>  
>  config SATA_PMP
>  	bool "SATA Port Multiplier support"
> +	depends on SATA_HOST
>  	default y
>  	help
>  	  This option adds support for SATA Port Multipliers
> @@ -85,6 +89,7 @@ comment "Controllers with non-SFF native interface"
>  config SATA_AHCI
>  	tristate "AHCI SATA support"
>  	depends on PCI
> +	select SATA_HOST
>  	help
>  	  This option enables support for AHCI Serial ATA.

This is a bit fragile and not the way Kconfig should be done.  The
fragility comes because anyone adding a new host has also to remember
to add the select, and there will be no real consequences for not doing
so.  The way to get rid of the fragility is to make SATA_HOST a
menuconfig option enclosing all the hosts, which makes the patch much
smaller as well.  The hint implies you want to separate out all the
PATA drivers, which also makes a menuconfig sound like the better
option.

I've also got to say that the problem doesn't seem to be one ... even
if some raving lunatic disables all SATA hosts and then enables PMP it
doesn't cause any problems does it?

James

