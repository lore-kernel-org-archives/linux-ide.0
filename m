Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C24C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769C0206C3
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 08:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCImI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:42:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgFCImI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Jun 2020 04:42:08 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6809DE24A9B570BF8335;
        Wed,  3 Jun 2020 09:42:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Jun 2020
 09:42:05 +0100
Subject: Re: [PATCH v3] libata: Use per port sync for detach
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, <axboe@kernel.dk>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603074819.21639-1-kai.heng.feng@canonical.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b13888c3-d1f9-7e6e-d25e-0287b3d7ba9b@huawei.com>
Date:   Wed, 3 Jun 2020 09:40:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200603074819.21639-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.59]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 03/06/2020 08:48, Kai-Heng Feng wrote:
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
> Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
> BugLink: https://bugs.launchpad.net/bugs/1867983
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

thanks,
Tested-by: John Garry <john.garry@huawei.com>

> ---
> v3:
>   - Move the comment to properly align with the code.
> 
> v2:
>   - Sync up to cookie + 1.
>   - Squash the synchronization into the same loop.
> 
>   drivers/ata/libata-core.c | 11 +++++------
>   include/linux/libata.h    |  3 +++
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 69361ec43db5..b1cd4d97bc2a 100644
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
> @@ -5920,11 +5919,11 @@ void ata_host_detach(struct ata_host *host)
>   {
>   	int i;
>   
> -	/* Ensure ata_port probe has completed */
> -	async_synchronize_full();
> -
> -	for (i = 0; i < host->n_ports; i++)
> +	for (i = 0; i < host->n_ports; i++) {
> +		/* Ensure ata_port probe has completed */
> +		async_synchronize_cookie(host->ports[i]->cookie + 1);
>   		ata_port_detach(host->ports[i]);
> +	}
>   
>   	/* the host is dead now, dissociate ACPI */
>   	ata_acpi_dissociate(host);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index af832852e620..8a4843704d28 100644
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

