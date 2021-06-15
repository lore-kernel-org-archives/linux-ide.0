Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDEC2B9F4
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 02:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1137C613FA
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 02:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFOCqa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:46:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4090 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhFOCq2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2021 22:46:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3rws1r8nzXfys;
        Tue, 15 Jun 2021 09:54:53 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:52 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:52 +0800
Subject: Re: [PATCH -next] ide-cd: fix warning: variable 'stat' set but not
 used
To:     <davem@davemloft.net>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210529061729.2824082-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <3832bef1-6181-4606-93f4-7432c92a5198@huawei.com>
Date:   Tue, 15 Jun 2021 09:59:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210529061729.2824082-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ping

在 2021/5/29 14:17, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/ide/ide-cd_ioctl.c: In function 'ide_cdrom_select_speed':
> drivers/ide/ide-cd_ioctl.c:212:6: warning:
>   variable ‘stat’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/ide/ide-cd_ioctl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
> index 011eab9c69b7..8d0a52123349 100644
> --- a/drivers/ide/ide-cd_ioctl.c
> +++ b/drivers/ide/ide-cd_ioctl.c
> @@ -231,6 +231,8 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
>   	}
>   
>   	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
> +	if (stat)
> +		return stat;
>   
>   	if (!ide_cdrom_get_capabilities(drive, buf)) {
>   		ide_cdrom_update_speed(drive, buf);
