Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC5C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Oct 2022 07:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJJHA1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJJHAZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2022 03:00:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EF120B8
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 00:00:13 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mm8sw43Rjz67yhg;
        Mon, 10 Oct 2022 14:59:32 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 09:00:10 +0200
Received: from [10.195.245.13] (10.195.245.13) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 08:00:10 +0100
Message-ID: <2d3253f5-c14a-67b2-0ce3-68ba1e332664@huawei.com>
Date:   Mon, 10 Oct 2022 08:00:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] ata: add ata_port_is_frozen() helper
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-2-niklas.cassel@wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221007132342.1590367-2-niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.13]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 07/10/2022 14:23, Niklas Cassel wrote:
> At the request of the libata maintainer, introduce a ata_port_is_frozen()
> helper function.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   include/linux/libata.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index a505cfb92ab3..d5ac52654b42 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1043,6 +1043,11 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
>   	return ap->ops == &ata_dummy_port_ops;
>   }

Hi Niklas,

 >
 > +static inline bool ata_port_is_frozen(const struct ata_port *ap)

The majority of libata APIs don't use const in this way, so I think that 
consistency is better.

Indeed, this is not const data which you're pointing at, so maybe it's 
better to be honest with the compiler. And since this is inlined, could 
the compiler optimise out multiple reads on ap->flags in a caller 
function since we tell it it's const?

Thanks,
John

> +{
> +	return ap->pflags & ATA_PFLAG_FROZEN;
> +}
> +
>   extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
>   extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
>   				int (*check_ready)(struct ata_link *link));

