Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87462C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Dec 2021 09:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbhLWJtN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Dec 2021 04:49:13 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:50384 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347545AbhLWJtM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Dec 2021 04:49:12 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 9C4D622F2817
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <4fd38f6e-b804-1356-9a13-d35f9ddfa660@omp.ru>
Date:   Thu, 23 Dec 2021 12:48:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 43/68] libata: drop ata_msg_info()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-44-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211221072131.46673-44-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 21.12.2021 10:21, Hannes Reinecke wrote:

> Convert the sole caller to ata_dev_deb() and remove the definition.

    ata_dev_info() actually (as follows from the patch)?

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/libata-core.c | 10 +++-------
>   include/linux/libata.h    |  2 --
>   2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index dcb3278471fb..81ea8241fdba 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2530,8 +2530,8 @@ int ata_dev_configure(struct ata_device *dev)
>   	char modelbuf[ATA_ID_PROD_LEN+1];
>   	int rc;
>   
> -	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
> -		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
> +	if (!ata_dev_enabled(dev)) {
> +		ata_dev_dbg(dev, "no device\n");
>   		return 0;
>   	}
>   
> @@ -5333,11 +5333,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>   
>   #if defined(ATA_VERBOSE_DEBUG)
>   	/* turn on all debugging levels */
> -	ap->msg_enable = 0x0003;
> -#elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
> -#else
> -	ap->msg_enable = ATA_MSG_DRV;
> +	ap->msg_enable = 0x0001;
>   #endif
>   
>   	mutex_init(&ap->scsi_scan_mutex);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index bce3b50112c0..9895414492cb 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -73,11 +73,9 @@
>   
>   enum {
>   	ATA_MSG_DRV	= 0x0001,
> -	ATA_MSG_INFO	= 0x0002,
>   };
>   
>   #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
> -#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
>   
>   static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
>   {

MBR, Sergey
