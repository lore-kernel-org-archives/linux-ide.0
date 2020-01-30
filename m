Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDEC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2382082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HCEQlsxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgA3Lwh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:52:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45998 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3Lwh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:52:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130115235euoutp017264548afb61bdcbf49c3e7cd2091246~up_zvLtIg1871418714euoutp01S
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:52:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130115235euoutp017264548afb61bdcbf49c3e7cd2091246~up_zvLtIg1871418714euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385155;
        bh=JnL2qJFgCSDI9Ha7UXY/8ke5U06BorsUjW0aQQd4U9A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HCEQlsxXUfhuPInz6DaV7k7P1RmDExy8dCWjiUO+gIKNdbO8DNHBMj1Blrr+JcaEI
         PYZYPrhReIVUU9p8nGNDEtAJrfeo/22lFCbUOConzFykp5UxEfduOGBOisP+Eicmcy
         xgb9xdE6p9tyclMI8M9caWg1kHf/Pd3f8iBlM2bU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130115235eucas1p27640ecf819de592f43ad0e26922d7588~up_zlggYc0104901049eucas1p2c;
        Thu, 30 Jan 2020 11:52:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FD.62.61286.383C23E5; Thu, 30
        Jan 2020 11:52:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130115234eucas1p1bc251b3567317bf9c29944210ce6c53d~up_zK2u2-0849308493eucas1p10;
        Thu, 30 Jan 2020 11:52:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130115234eusmtrp18a5f9153828368f16848a57f94d0d8e3~up_zKTLs-2079120791eusmtrp1P;
        Thu, 30 Jan 2020 11:52:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-08-5e32c383f800
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.B7.08375.283C23E5; Thu, 30
        Jan 2020 11:52:34 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130115234eusmtip10ec12244fbb6b58b6afa1527bdf08402~up_y4H0aB2175721757eusmtip1u;
        Thu, 30 Jan 2020 11:52:34 +0000 (GMT)
Subject: Re: [PATCH 19/24] libata: Use ata_port_printk() in ata_dump_id()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <2e54cd29-6d42-a942-5503-3528239923ed@samsung.com>
Date:   Thu, 30 Jan 2020 12:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-31-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87rNh43iDFpesFisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGy8krWQqe
        8lfs/tPK1MC4i6eLkZNDQsBEoqV5DzuILSSwglHi0mypLkYuIPsLo8TGtavZIZzPjBJ7n89k
        h+n4Pec8I0RiOaPEqt5ZLBDOW0aJHS++soBUCQt4Shx4tAasQ0RASeJj+yEwm1kgTqLpyl0w
        m03ASmJi+ypGEJtXwE6i4/4fsDiLgKrE9lsz2EBsUYEIiU8PDrNC1AhKnJz5BGw+p4CxxNZN
        E1ggZopL3HoynwnClpfY/nYOM8hBEgL97BItX5ayQJztInG/5wErhC0s8er4Fqh3ZCROT+5h
        gWhYxyjxt+MFVPd2Ronlk/+xQVRZS9w59wvI5gBaoSmxfpc+RNhR4u+SHmaQsIQAn8SNt4IQ
        R/BJTNo2HSrMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LVZSN6ZheSdWQh7FzCyrGIUTy0t
        zk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMLKf/Hf+0g/HrpaRDjAIcjEo8vBobjOKEWBPLiitz
        DzFKcDArifCKuhrGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbL
        xMEp1cDIkTbzYcmqNVkzj7kdKry2tWWb0Z7mj0nHw/X6VvzjtmZk+8M636rv43ZhmcUztW6n
        uhy+/G31XRXZjD9heyu/GK+6G9C5WV341IZ33jIJ13jYntvdqs+x0Tu3K4GPe2ZleYHGFlWe
        90J6XKvUV17kXlx/9HCF2L/maI638sb+vn0uwuKNCUFKLMUZiYZazEXFiQCL1wdLKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pNh43iDD7OUbVYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Ml5NXshQ85a/Y/aeVqYFxF08XIyeHhICJ
        xO855xlBbCGBpYwSuzZmdzFyAMVlJI6vL4MoEZb4c62LrYuRC6jkNaPE9bMn2EASwgKeEgce
        rWEHsUUElCQ+th8Cs5kF4iT+9e1mgmhYxygxY8k2sAY2ASuJie2rwJbxCthJdNz/A9bAIqAq
        sf3WDLAaUYEIicM7ZkHVCEqcnPmEBcTmFDCW2LppAgvEAnWJP/MuMUPY4hK3nsxngrDlJba/
        ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAONp27Ofm
        HYyXNgYfYhTgYFTi4dXYYBQnxJpYVlyZe4hRgoNZSYRX1NUwTog3JbGyKrUoP76oNCe1+BCj
        KdBzE5mlRJPzgTGeVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB
        seUu86ZHiVxViucbjs16NHl+O+u2+t83dTwu29rsyxF9WSJ6pOdK0anqDcvOLQuUli9Y3eHO
        aFgeI91r9uS5+gTP/7UdJQoFmgn9lz8vKYkLuJZRcXud4AXBnknTnvo/2tczwdi9MU38Tubl
        eRPu1TScTN20XmODQvaHJ87Tz8b5llerpu8rV2Ipzkg01GIuKk4EAFRwCPi5AgAA
X-CMS-MailID: 20200130115234eucas1p1bc251b3567317bf9c29944210ce6c53d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7@epcas1p1.samsung.com>
        <20181213104716.31930-31-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Use ata_port_printk() in ata_dump_id(), dropping DPRINTK usage there.

Wouldn't it be better to pass and use 'dev' instead of 'ap'
(the function prints device's id block)?

Why does it convert DPRINTK() to ata_port_printk() and not dev_dbg()?

Also please preserve __func__ printing in the conversion.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libata-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a36f24de399b..914520254215 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1438,9 +1438,10 @@ static int ata_hpa_resize(struct ata_device *dev)
>   *	caller.
>   */
>  
> -static inline void ata_dump_id(const u16 *id)
> +static inline void ata_dump_id(struct ata_port *ap, const u16 *id)
>  {
> -	DPRINTK("49==0x%04x  "
> +	ata_port_printk(ap, KERN_DEBUG,
> +		"49==0x%04x  "
>  		"53==0x%04x  "
>  		"63==0x%04x  "
>  		"64==0x%04x  "
> @@ -1450,7 +1451,8 @@ static inline void ata_dump_id(const u16 *id)
>  		id[63],
>  		id[64],
>  		id[75]);
> -	DPRINTK("80==0x%04x  "
> +	ata_port_printk(ap, KERN_DEBUG,
> +		"80==0x%04x  "
>  		"81==0x%04x  "
>  		"82==0x%04x  "
>  		"83==0x%04x  "
> @@ -1460,7 +1462,8 @@ static inline void ata_dump_id(const u16 *id)
>  		id[82],
>  		id[83],
>  		id[84]);
> -	DPRINTK("88==0x%04x  "
> +	ata_port_printk(ap, KERN_DEBUG,
> +		"88==0x%04x  "
>  		"93==0x%04x\n",
>  		id[88],
>  		id[93]);
> @@ -2542,7 +2545,7 @@ int ata_dev_configure(struct ata_device *dev)
>  	xfer_mask = ata_id_xfermask(id);
>  
>  	if (ata_msg_probe(ap))
> -		ata_dump_id(id);
> +		ata_dump_id(ap, id);
>  
>  	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
>  	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
