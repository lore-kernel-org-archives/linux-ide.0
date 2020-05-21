Return-Path: <SRS0=/FW4=7D=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42468C433E0
	for <linux-ide@archiver.kernel.org>; Thu, 21 May 2020 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2C20738
	for <linux-ide@archiver.kernel.org>; Thu, 21 May 2020 08:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgEUIR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 May 2020 04:17:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728473AbgEUIR6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 21 May 2020 04:17:58 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C35B84EE43A5A79F9888;
        Thu, 21 May 2020 09:17:56 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.132) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 21 May
 2020 09:17:56 +0100
Subject: Re: [PATCH v2] libata: Use per port sync for detach
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, <axboe@kernel.dk>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200521043007.23215-1-kai.heng.feng@canonical.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ecd1b0a6-8cdf-1895-a0e8-1bbd98a37887@huawei.com>
Date:   Thu, 21 May 2020 09:16:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200521043007.23215-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.132]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 21/05/2020 05:30, Kai-Heng Feng wrote:
> Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
> detach") may cause system freeze during suspend.
> 
> Using async_synchronize_full() in PM callbacks is wrong, since async
> callbacks that are already scheduled may wait for not-yet-scheduled
> callbacks, causes a circular dependency.
> 
> Instead of using big hammer like async_synchronize_full(), use async
> cookie to make sure port probe are synced, without affecting other
> scheduled PM callbacks.
> 

Apart from nit, it looks ok.

Cheers,
John

> Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
> BugLink: https://bugs.launchpad.net/bugs/1867983
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   - Sync up to cookie + 1.
>   - Squash the synchronization into the same loop.
> 
>   drivers/ata/libata-core.c | 9 ++++-----
>   include/linux/libata.h    | 3 +++
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index beca5f91bb4c..b6be84f2cecb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -42,7 +42,6 @@
>   #include <linux/workqueue.h>
>   #include <linux/scatterlist.h>
>   #include <linux/io.h>
> -#include <linux/async.h>
>   #include <linux/log2.h>
>   #include <linux/slab.h>
>   #include <linux/glob.h>
> @@ -5778,7 +5777,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>   	/* perform each probe asynchronously */
>   	for (i = 0; i < host->n_ports; i++) {
>   		struct ata_port *ap = host->ports[i];
> -		async_schedule(async_port_probe, ap);
> +		ap->cookie = async_schedule(async_port_probe, ap);
>   	}
>   
>   	return 0;
> @@ -5921,10 +5920,10 @@ void ata_host_detach(struct ata_host *host)
>   	int i;
>   
>   	/* Ensure ata_port probe has completed */

nit: maybe we can relocate this comment

> -	async_synchronize_full();
> -
> -	for (i = 0; i < host->n_ports; i++)
> +	for (i = 0; i < host->n_ports; i++) {
> +		async_synchronize_cookie(host->ports[i]->cookie + 1);
>   		ata_port_detach(host->ports[i]);
> +	}
>   
>   	/* the host is dead now, dissociate ACPI */
>   	ata_acpi_dissociate(host);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cffa4714bfa8..ae6dfc107ea8 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -22,6 +22,7 @@
>   #include <linux/acpi.h>
>   #include <linux/cdrom.h>
>   #include <linux/sched.h>
> +#include <linux/async.h>
>   
>   /*
>    * Define if arch has non-standard setup.  This is a _PCI_ standard
> @@ -872,6 +873,8 @@ struct ata_port {
>   	struct timer_list	fastdrain_timer;
>   	unsigned long		fastdrain_cnt;
>   
> +	async_cookie_t		cookie;
> +
>   	int			em_message_type;
>   	void			*private_data;
>   
> 

