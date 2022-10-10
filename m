Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1FFC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Oct 2022 11:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJJLW6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Oct 2022 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiJJLW5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2022 07:22:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734B6E2D5
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 04:22:55 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmGh12TzBz67y8Y;
        Mon, 10 Oct 2022 19:21:21 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 13:22:52 +0200
Received: from [10.195.245.13] (10.195.245.13) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 12:22:52 +0100
Message-ID: <071c9e57-1ec3-30cd-87fe-d694249f8b83@huawei.com>
Date:   Mon, 10 Oct 2022 12:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] ata: add ata_port_is_frozen() helper
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-2-niklas.cassel@wdc.com>
 <2d3253f5-c14a-67b2-0ce3-68ba1e332664@huawei.com>
 <Y0PxS6OGiipR3OqO@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y0PxS6OGiipR3OqO@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.13]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/10/2022 11:17, Niklas Cassel wrote:

Hi Niklas,

> Well, right now there is no consistency:)
> 
> $ git grep "static inline" include/linux/libata.h | grep "(const struct"
> include/linux/libata.h:static inline bool ata_port_is_frozen(const struct ata_port *ap)
> include/linux/libata.h:static inline int ata_acpi_stm(const struct ata_port *ap,
> include/linux/libata.h:static inline int ata_acpi_gtm(const struct ata_port *ap,
> include/linux/libata.h:static inline bool ata_is_host_link(const struct ata_link *link)
> include/linux/libata.h:static inline bool ata_is_host_link(const struct ata_link *link)
> include/linux/libata.h:static inline unsigned int ata_dev_enabled(const struct ata_device *dev)
> include/linux/libata.h:static inline unsigned int ata_dev_disabled(const struct ata_device *dev)
> include/linux/libata.h:static inline unsigned int ata_dev_absent(const struct ata_device *dev)
> include/linux/libata.h:static inline int ata_link_max_devices(const struct ata_link *link)
> include/linux/libata.h:static inline int ata_try_flush_cache(const struct ata_device *dev)
> 
> There are 10 uses (9 without my addition) that uses a const struct pointer.

I was just checking *ata_port, and based my judgement on that one.

> 
> So since both are used in libata, I chose the one that seemed most correct.
> 
>> Indeed, this is not const data which you're pointing at, so maybe it's
>> better to be honest with the compiler. And since this is inlined, could the
>> compiler optimise out multiple reads on ap->flags in a caller function since
>> we tell it it's const?
> "This is not const data which you're pointing at"
> 
> Well, according to 6.7.6.1 Pointer declarators in
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
> 
> A "const struct *ptr" means that the contents of any object pointed to
> cannot be modified through that pointer.
> 

sure

> 
> "And since this is inlined, could the compiler optimise out multiple reads
> on ap->flags in a caller function since we tell it it's const?"
> 
> I'm far from a compiler expert, but because an optimising compiler is free
> to inline whatever function it wants, not just functions marked inline,
> I would assume that the compiler would "do the right thing" regardless if
> a function is marked as inline or not.
> 
> Doing a:
> git grep "static inline" include/ | grep "(const struct" | wc -l
> 2055
> 
> Makes me quite confident that this should be fine.
> Sure, the data it points to might never change.
> 
> But seeing e.g.:
> $ git grep "static inline" include/ | grep "empty(const struct"
> 
> Especially used in tcp and qdisc makes me even more confident that this
> will work fine.

yeah, I think it should be fine, as the compiler should treat 
ata_port_is_frozen() as self-contained and thus make no judgement 
optimizing out such reads when inlining.

> 
> Looking at e.g. __dev_xmit_skb():
> https://elixir.bootlin.com/linux/v6.0/source/net/core/dev.c#L3803
> we can see that it uses nolock_qdisc_is_empty() multiple times within
> the same function. So now I'm very confident that this will be fine:)

I'm still not inclined to add const specifier, but I'll leave that to 
Damien and you.

I think generally we could add const a lot more in the kernel codebase. 
But we don't, as if we need to change how we treat the data we point to, 
i.e. stop writing or start writing, then we need to start changing APIs, 
and that is not so welcome, and so generally omit it. The same goes for 
non-ptr functions args. And then programmers are often a bit lazy and 
over-confident too (to not bother using it) :).

Thanks,
John

