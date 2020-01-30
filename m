Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB461C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9476A206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="axuPeFsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3Kz1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:55:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53102 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3Kz1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:55:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105524euoutp015a029b4728547a75489d112ce5aaec6a~upM48-Mse0390003900euoutp01M
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:55:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130105524euoutp015a029b4728547a75489d112ce5aaec6a~upM48-Mse0390003900euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381724;
        bh=b3LVbGdYtX0S/SRzwGgycZsAJVIraQN9AHvsMCpbYyo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=axuPeFsJWkwwWufHFXhZH5y00CtVb640v4GupbvuV8AWYiuIMa6b7oZCRaq/JVKt+
         uX3Z1sIdyBplaEJDf6M24j2qx+qYERO2g9K/qqg5Xv/5LIbku7bVmJeMsV6Nhfxvns
         A/UEBsOFmAAbM1maqPOLLSSv0icErLqM5xPGXScs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130105524eucas1p16b26e2836e403c6407ee707b5498107a~upM4xRmpS1561115611eucas1p15;
        Thu, 30 Jan 2020 10:55:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 38.E9.61286.C16B23E5; Thu, 30
        Jan 2020 10:55:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105524eucas1p15636a07aec843386d6bb3b5b7ad9ebd4~upM4fAWYL0213602136eucas1p10;
        Thu, 30 Jan 2020 10:55:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130105524eusmtrp2117d0474473b9b597835ec9ebda16338~upM4ebK3K2525425254eusmtrp20;
        Thu, 30 Jan 2020 10:55:24 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ea-5e32b61ce16a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.CE.07950.C16B23E5; Thu, 30
        Jan 2020 10:55:24 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130105524eusmtip2d365c53bbc31e8af1ffeda1d412bfaeb~upM4FUQZP0788007880eusmtip2f;
        Thu, 30 Jan 2020 10:55:23 +0000 (GMT)
Subject: Re: [PATCH 13/24] libahci: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a56fc42d-187c-67b7-181c-6f2a4626f8ea@samsung.com>
Date:   Thu, 30 Jan 2020 11:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-25-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7oy24ziDB5t0bJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mp1PvMhVs
        EqtY9EuogfGDYBcjJ4eEgInE0S3b2EFsIYEVjBKXun26GLmA7C+MEttPfWGDcD4zSsx/MJsR
        puPJ3d/MEInljBL/Tj9jgnDeMkrs2ncYrEpYwFHixKRNTCC2iICSxMf2Q2A7mAXiJJqu3AWz
        2QSsJCa2rwKr5xWwk5i78QMbiM0ioCqxccdyVhBbVCBC4tODw6wQNYISJ2c+YQGxOQWMJaa1
        TmGDmCkucevJfCYIW15i+9s5YNdJCPSzSzz9eZIF4mwXiYstm5khbGGJV8e3sEPYMhL/d85n
        gmhYxyjxt+MFVPd2Ronlk/+xQVRZS9w59wvI5gBaoSmxfpc+RNhR4tj/vWBhCQE+iRtvBSGO
        4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpa
        nJueWmyYl1quV5yYW1yal66XnJ+7iRGYVk7/O/5pB+PXS0mHGAU4GJV4eDU2GMUJsSaWFVfm
        HmKU4GBWEuEVdTWME+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyW
        iYNTqoExKfTywoeNmx8fk919R5PjfZTbBqV3KQLKbFFd158YRJpa/mqTKlr8o+qo546u31u/
        LArXWlM9vcDowqfZWQtzrJrq2mwcrwfy/DsUn7NxoWL1a7ZZYkcfn/9mPOtcZuXZJ3PeZ4tK
        3P0xRbv+w1P1BLc7d1bP3/1hS02H952Ay8XnN065qDDxsxJLcUaioRZzUXEiAM7UXVYnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oy24ziDP6sErdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mp1PvMhVsEqtY9EuogfGDYBcjJ4eEgInE
        k7u/mbsYuTiEBJYySvz5cg/I4QBKyEgcX18GUSMs8edaFxtEzWtGiXPbf7KDJIQFHCVOTNrE
        BGKLCChJfGw/BBZnFoiT+Ne3mwmiYR2jxK2dcxlBEmwCVhIT21eB2bwCdhJzN35gA7FZBFQl
        Nu5YzgpiiwpESBzeMQuqRlDi5MwnLCA2p4CxxLTWKWwQC9Ql/sy7xAxhi0vcejKfCcKWl9j+
        dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC42jbsZ9b
        djB2vQs+xCjAwajEw6uxwShOiDWxrLgy9xCjBAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFG
        U6DnJjJLiSbnA2M8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        49qfy//nuy3cK8P96LTYx6gttZve7z39onP1ykczuN5XBC5d+7HvO+f14+kWPSY8f/xsD/rm
        pzDekZC+17GtJLzVXYhvll/xk8K06YHuh2PaHh2xvjSduWpaBofzm4sf4tfG7XDqLROpc8l8
        +W1SGsM+9XfnRKe/qHqyo6Tu1fMzct/YylwrK5VYijMSDbWYi4oTAdAPK5K5AgAA
X-CMS-MailID: 20200130105524eucas1p15636a07aec843386d6bb3b5b7ad9ebd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104745epcas2p448f3dcac7e01735ab3cded7c52d94ae9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104745epcas2p448f3dcac7e01735ab3cded7c52d94ae9
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104745epcas2p448f3dcac7e01735ab3cded7c52d94ae9@epcas2p4.samsung.com>
        <20181213104716.31930-25-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libahci.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index b5f57c69c487..d6c93ce83504 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1408,7 +1408,8 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	bool fbs_disabled = false;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER, class %u pmp %d\n",
> +		     __func__, *class, pmp);

Please document enhancements in the patch description.

>  	/* prepare for SRST (AHCI-1.1 10.4.1) */
>  	rc = ahci_kick_engine(ap);
> @@ -1469,7 +1470,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	if (fbs_disabled)
>  		ahci_enable_fbs(ap);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
> +	ata_link_dbg(link, "%s: EXIT, class=%u\n", __func__, *class);
>  	return 0;
>  
>   fail:
> @@ -1491,7 +1492,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
>  {
>  	int pmp = sata_srst_pmp(link);
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER, pmp %d\n", __func__, pmp);

ditto

>  	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
>  }
> @@ -1522,7 +1523,7 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	u32 irq_sts;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER, class %u\n", __func__, *class);

ditto

>  	rc = ahci_do_softreset(link, class, pmp, deadline,
>  			       ahci_bad_pmp_check_ready);
> @@ -1557,7 +1558,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	struct ata_taskfile tf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER, class %u %sline\n",
> +		     __func__, *class, *online ? "on" : "off");

ditto

>  	hpriv->stop_engine(ap);
>  
> @@ -1574,7 +1576,7 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	if (*online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> +	ata_link_dbg(link, "%s: EXIT, rc=%d, class=%u\n", __func__, rc, *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(ahci_do_hardreset);
> @@ -1686,7 +1688,7 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
>  	u32 fbs = readl(port_mmio + PORT_FBS);
>  	int retries = 3;
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  	BUG_ON(!pp->fbs_enabled);
>  
>  	/* time to wait for DEC is not specified by AHCI spec,

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
