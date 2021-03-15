Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18432C43619
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 11:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38E564EBD
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 11:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCOL3y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:29:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13537 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCOL3m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2021 07:29:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzYzn4CgBzNnCN;
        Mon, 15 Mar 2021 19:27:17 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Mon, 15 Mar 2021
 19:29:31 +0800
Subject: Re: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <john.garry@huawei.com>,
        <yangxingui@huawei.com>
References: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
 <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <06094d83-2083-09ad-5948-718cfbe4579b@huawei.com>
Date:   Mon, 15 Mar 2021 19:29:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2021/3/12 22:27, Jens Axboe wrote:
> Is this controller arm exclusive?


Yes, our SoC is base on ARM64 only.


Thanks

Jiaxing


