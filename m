Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ABC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9D20708
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C2rcJupW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgBJMr1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33575 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgBJMr0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:47:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210124725euoutp0269f1515b56358935b85ff79ea6910b1b~yC01F-pKk0048300483euoutp02Z
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210124725euoutp0269f1515b56358935b85ff79ea6910b1b~yC01F-pKk0048300483euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581338845;
        bh=BCJmu9d9c5yX4ItLB+IWdDR3e2qEHxj63STpRl67fEY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C2rcJupWlMEdF2g3+/UdLCbi5mE66duwSQmWjC+zgtKeRzIRXufD0HS4TdQF4mGKl
         pSwskRB3IfNYvqCyY0CdtxXbFh1c51srP/TrewRBGwg04gViRvo3mOvPb+dCOinvzJ
         yVMER3sejtTING/b86oA9eCwnF0mDY9f3GJnrcbk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210124725eucas1p245b183cc1febfe48cdec8aeedcdb969a~yC007QrL60369903699eucas1p25;
        Mon, 10 Feb 2020 12:47:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.57.60698.DD0514E5; Mon, 10
        Feb 2020 12:47:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210124725eucas1p10fd6e07c83c89f4fe59d3a23d6df3b1e~yC00kC2K01801418014eucas1p1_;
        Mon, 10 Feb 2020 12:47:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210124725eusmtrp2a528f59d3376524162291d032478f14d~yC00jctsX2962729627eusmtrp2a;
        Mon, 10 Feb 2020 12:47:25 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-7f-5e4150ddfb41
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.A2.07950.DD0514E5; Mon, 10
        Feb 2020 12:47:25 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210124724eusmtip1e582cbc264402e1bd21897e48989a9b7~yC00Komwq0271802718eusmtip1U;
        Mon, 10 Feb 2020 12:47:24 +0000 (GMT)
Subject: Re: [PATCH 09/46] libata: move ata_dump_id() to dynamic debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <fef948b4-bff3-6cef-306e-b374435c3671@samsung.com>
Date:   Mon, 10 Feb 2020 13:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-10-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd27AY5xBtcuiFmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGbNm/mEp2C5QcefSU8YGxs88
        XYycHBICJhKXLm5l6WLk4hASWMEo0bFiHzOE84VR4vKraewQzmdGibVrNjHBtCy6/gCqZTmj
        RPPeNlYI5y2jxNdVM9lAqoQFvCTOTFnGDmKLCChJfGw/BGYzC1hLzF68HmwSm4CVxMT2VYwg
        Nq+AncSuqU/BbBYBVYkZ5yawgNiiAhESnx4cZoWoEZQ4OfMJWJwT6Irtd68wQswUl7j1ZD4T
        hC0vsf3tHLAfJASa2SUm7/3JCnG2i8Ts7U/YIWxhiVfHt0DZMhL/d4I0gzSsY5T42/ECqns7
        o8Tyyf/YIKqsJe6c+wVkcwCt0JRYv0sfIuwo8WV1LztIWEKAT+LGW0GII/gkJm2bzgwR5pXo
        aBOCqFaT2LBsAxvM2q6dK5knMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb56WW6xUn
        5haX5qXrJefnbmIEppHT/45/3cG470/SIUYBDkYlHt4Zjg5xQqyJZcWVuYcYJTiYlUR4LaUd
        44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpgXMzykuPT
        0kSHzutiEmLt5X83+ugsk927wKNy+jbTubc3HdpyKPzbjp9XC//2TbD4+cFqa8LUIM30WU67
        GyM8//OcSPjQt7FGqVD1RIDg76vzvPZJfb9mqLbbyKO5X61oU3HLT+Y37JXO6v4Tr6U8/T7r
        Rsfu14n/j6/+P2FVhKzHfnXZd31PBZRYijMSDbWYi4oTAWV3lWsfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7p3AxzjDJ4uYLFYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0MmbN/MNSsF2g4s6lp4wNjJ95uhg5OSQETCQWXX/A0sXIxSEk
        sJRRYtLt7WxdjBxACRmJ4+vLIGqEJf5c62KDqHnNKPFyxXl2kISwgJfEmSnLwGwRASWJj+2H
        wGxmAWuJ2YvXM0E0bGCUuN99lgkkwSZgJTGxfRUjiM0rYCexa+pTMJtFQFVixrkJLCC2qECE
        xOEds6BqBCVOznwCFucEunT73SuMEAvUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mch
        aZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNm27GfW3Ywdr0LPsQowMGo
        xMPrYO8QJ8SaWFZcmXuIUYKDWUmE11LaMU6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84ER
        nVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTGtyC0vsOTh17C7
        dzoiNwrWGii+mNN8+cYbhhUNdZdYPlRF3l1scvJk2n8t9zwRBdv973bvUom9vXjhnhnGd83n
        HrxQUPSxwi18U3j8afVJGVt4owxvPpPqyDdseOTfcXDhgU03LcoM1suHRJw6pua3Qd8lVG9y
        h0bcxmPCbPe7eZPmGJVaNimxFGckGmoxFxUnAgCz3RGisAIAAA==
X-CMS-MailID: 20200210124725eucas1p10fd6e07c83c89f4fe59d3a23d6df3b1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165613eucas1p28e04fbc0dadcde04c9ec5d0412a196c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165613eucas1p28e04fbc0dadcde04c9ec5d0412a196c8
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165613eucas1p28e04fbc0dadcde04c9ec5d0412a196c8@eucas1p2.samsung.com>
        <20200204165547.115220-10-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Use ata_port_dbg() to print out the information in ata_dump_id()
> and remove the ata_msg_probe() conditional.

Can't we use ata_dev_dbg() instead of ata_port_dbg()?

Otherwise it looks fine.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b2b96420a2f2..8a18047f9bcb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1449,32 +1449,14 @@ static int ata_hpa_resize(struct ata_device *dev)
>   *	caller.
>   */
>  
> -static inline void ata_dump_id(const u16 *id)
> -{
> -	DPRINTK("49==0x%04x  "
> -		"53==0x%04x  "
> -		"63==0x%04x  "
> -		"64==0x%04x  "
> -		"75==0x%04x  \n",
> -		id[49],
> -		id[53],
> -		id[63],
> -		id[64],
> -		id[75]);
> -	DPRINTK("80==0x%04x  "
> -		"81==0x%04x  "
> -		"82==0x%04x  "
> -		"83==0x%04x  "
> -		"84==0x%04x  \n",
> -		id[80],
> -		id[81],
> -		id[82],
> -		id[83],
> -		id[84]);
> -	DPRINTK("88==0x%04x  "
> -		"93==0x%04x\n",
> -		id[88],
> -		id[93]);
> +static inline void ata_dump_id(struct ata_port *ap, const u16 *id)
> +{
> +	ata_port_dbg(ap,
> +		"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
> +		"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
> +		"88==0x%04x  93==0x%04x\n",
> +		id[49], id[53], id[63], id[64], id[75], id[80],
> +		id[81], id[82], id[83], id[84], id[88], id[93]);
>  }
>  
>  /**
> @@ -2552,8 +2534,7 @@ int ata_dev_configure(struct ata_device *dev)
>  	/* find max transfer mode; for printk only */
>  	xfer_mask = ata_id_xfermask(id);
>  
> -	if (ata_msg_probe(ap))
> -		ata_dump_id(id);
> +	ata_dump_id(ap, id);
>  
>  	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
>  	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
> 

