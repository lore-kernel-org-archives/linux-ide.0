Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80AFC352A5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF22082F
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CE+ZkFIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgBJN31 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:29:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgBJN30 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:29:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210132925euoutp01fd01f859f9367b53644c3a2335be4c11~yDZfqWKxQ2436724367euoutp01g
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210132925euoutp01fd01f859f9367b53644c3a2335be4c11~yDZfqWKxQ2436724367euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581341365;
        bh=aaz7JhG3ExkFVvKZbCME/mfiWbdAntb1qBrK/VUR8/I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CE+ZkFIseX/0S4Zb53uJUt8o46OgzkvXxFV4BTF9E9LkT9vaGH/D+nEkV0rhb9rHb
         6LAB/CwS6zqyJJ78qIqvx5S/0vCpltNOxXUqS1p+DCITlhjFFAbRhyAx6QVt9ymEpy
         iKgSz9fvMNvq8ze3NgphOtnkcyJQ8aQOutD/6GEw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210132925eucas1p2512a338863b22f75a821469f4737e02e~yDZfiipD42144821448eucas1p2l;
        Mon, 10 Feb 2020 13:29:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.8E.60698.5BA514E5; Mon, 10
        Feb 2020 13:29:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210132924eucas1p1748588bf66e10b38553b5e125b3a45c1~yDZfSODWT1984619846eucas1p1r;
        Mon, 10 Feb 2020 13:29:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210132924eusmtrp2809c07a1c2d1118930976fb67dfb05e3~yDZfRrt8e2043520435eusmtrp2k;
        Mon, 10 Feb 2020 13:29:24 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-93-5e415ab587cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.49.07950.4BA514E5; Mon, 10
        Feb 2020 13:29:24 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210132923eusmtip2edb4b56969c900463c2b02dc052318f0~yDZeG3IOG2370423704eusmtip2H;
        Mon, 10 Feb 2020 13:29:23 +0000 (GMT)
Subject: Re: [PATCH 12/46] sata_sx4: move DPRINTK to VPRINTK
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bc423c22-cfbd-8c86-e5c4-79473f5c48af@samsung.com>
Date:   Mon, 10 Feb 2020 14:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-13-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7pboxzjDN6/Y7dYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Ma+dvsRcs
        4qz4+Ua/gfEkexcjJ4eEgInEtAO/WLsYuTiEBFYwSmxctpkJwvnCKPH15FU2COczo8TLuUsZ
        YVouTV7MBmILCSxnlNh+og6i6C2jxN9LJ5hBEsICNhI37t0HKxIRUJL42H4IbB+zQJxE05W7
        YDabgJXExPZVYEN5Bewk7n/vAOtlEVCVuLJ6G1hcVCBC4tODw6wQNYISJ2c+YQGxOYGO+NnY
        zwoxU1zi1pP5TBC2vMT2t3OYQQ6SEOhml5h/ZgkbxNUuEhNXT4B6Wlji1fEtULaMxP+d85kg
        GtYBfdDxAqp7O6PE8sn/oLqtJe6c+wVkcwCt0JRYv0sfIuwosXPFKUaQsIQAn8SNt4IQR/BJ
        TNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5N
        Ty02zkst1ytOzC0uzUvXS87P3cQITCun/x3/uoNx35+kQ4wCHIxKPLwXgh3jhFgTy4orcw8x
        SnAwK4nwWkoDhXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCU
        amCcMUn62BcHoWjZhC3bH/xJmz1H5lCO7jGJO3bC9pYTr03mKy5hlF46ce/CZ3+aVoQefuF8
        unl6kOGzxomH7Y9WJjTfFi4UW3vTOWOlzspdZ76Lxf0r6DRfnysSGKn98Pn9uZ+ahbIiriVs
        O1aXVpOYKpW+dkXz9nXHrDJVbndd1NDPW9jcosCrxFKckWioxVxUnAgA5tm7pycDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7pbohzjDKZONbFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Ma+dvsRcs4qz4+Ua/gfEkexcjJ4eEgInE
        pcmL2boYuTiEBJYyStx7do+xi5EDKCEjcXx9GUSNsMSfa11QNa8ZJVYtus4EkhAWsJG4ce8+
        G4gtIqAk8bH9ENhQZoE4iX99u5kgGjYwSmzt2sAMkmATsJKY2L6KEcTmFbCTuP+9AyzOIqAq
        cWX1NrC4qECExOEds6BqBCVOznzCAmJzAl36s7GfFWKBusSfeZeYIWxxiVtP5jNB2PIS29/O
        YZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmAcbTv2c8sO
        xq53wYcYBTgYlXh4LwQ7xgmxJpYVV+YeYpTgYFYS4bWUBgrxpiRWVqUW5ccXleakFh9iNAV6
        biKzlGhyPjDG80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MCp6
        Oe589MGPj9lhNkNj0sHUSbIdZpGH/BwkbB60Fs/c9OOFD0O8v/2hO8XR/htDZXsnyLg/OX7N
        9+1bs7tmSWWSBYY7TT9MujjtD6tR3oqIJOn7y2YLFr9tcuvac6Hwe1R2rpzRNccDtlnrQkqO
        5q6W45w/n8l5oXC3Sr5SzUGL44XHnmR4KLEUZyQaajEXFScCAB0krFC5AgAA
X-CMS-MailID: 20200210132924eucas1p1748588bf66e10b38553b5e125b3a45c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165613eucas1p25b43c623f09c0ba01c9fd51c04d18814
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165613eucas1p25b43c623f09c0ba01c9fd51c04d18814
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165613eucas1p25b43c623f09c0ba01c9fd51c04d18814@eucas1p2.samsung.com>
        <20200204165547.115220-13-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> All other logging instances in this functions are with VPRINTK,
> so follow suit.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Please fix From: and S-o-B: to match (some other patches also
have this issue).

With that resolved:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_sx4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 2c7b30c5ea3d..e99d9f5139f9 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -755,7 +755,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
>  	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
>  
>  		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
> -		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
> +		VPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
>  		qc->err_mask |= ac_err_mask(status);
>  		ata_qc_complete(qc);
>  		handled = 1;
> 
