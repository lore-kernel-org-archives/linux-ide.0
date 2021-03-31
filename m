Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B4C433DB
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 10:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0623C61985
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 10:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhCaK04 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:26:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaK0v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Mar 2021 06:26:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9Mrf5lnYzlWjw;
        Wed, 31 Mar 2021 18:25:06 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 18:26:40 +0800
Subject: Re: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <john.garry@huawei.com>,
        <yangxingui@huawei.com>
References: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <75e0d609-0b4c-5ede-7421-1b49422f30cc@huawei.com>
Date:   Wed, 31 Mar 2021 18:26:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

kindly ping.


Hi, Jens,  are there any further comments from you?

Two weeks from your first comment now.


And it's a bugfix for our SoC, So the customer is asking whether this 
patch is merged or not.

They want to pull back.


Thanks

Jiaxing


On 2021/3/12 18:24, Luo Jiaxing wrote:
> From: Xingui Yang <yangxingui@huawei.com>
>
> On Hisilicon Kunpeng920, ESP is set to 1 by default for all ports of
> SATA controller. In some scenarios, some ports are not external SATA ports,
> and it cause disks connected to these ports to be identified as removable
> disks. So disable the SXS capability on the software side to prevent users
> from mistakenly considering non-removable disks as removable disks and
> performing related operations.
>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/ata/ahci.c    | 5 +++++
>   drivers/ata/ahci.h    | 1 +
>   drivers/ata/libahci.c | 5 +++++
>   3 files changed, 11 insertions(+)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 00ba8e5..33192a8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1772,6 +1772,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>   
>   #ifdef CONFIG_ARM64
> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
> +	    pdev->device == 0xa235 &&
> +	    pdev->revision < 0x30)
> +		hpriv->flags |= AHCI_HFLAG_NO_SXS;
> +
>   	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
>   		hpriv->irq_handler = ahci_thunderx_irq_handler;
>   #endif
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 98b8baa..d1f284f 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -242,6 +242,7 @@ enum {
>   							suspend/resume */
>   	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
>   							from phy_power_on() */
> +	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
>   
>   	/* ap->flags bits */
>   
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ea5bf5f..fec2e97 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -493,6 +493,11 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>   		cap |= HOST_CAP_ALPM;
>   	}
>   
> +	if ((cap & HOST_CAP_SXS) && (hpriv->flags & AHCI_HFLAG_NO_SXS)) {
> +		dev_info(dev, "controller does not support SXS, disabling CAP_SXS\n");
> +		cap &= ~HOST_CAP_SXS;
> +	}
> +
>   	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
>   		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>   			 port_map, hpriv->force_port_map);

