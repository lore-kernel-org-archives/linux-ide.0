From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] ata: enhance the definition of SET MAX feature field value
Date: Mon, 08 Jan 2018 22:16:55 -0500
Message-ID: <yq17esroh5k.fsf@oracle.com>
References: <1514456447-213928-1-git-send-email-chenxiang66@hisilicon.com>
        <1514456447-213928-2-git-send-email-chenxiang66@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbeAIDRU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2018 22:17:20 -0500
In-Reply-To: <1514456447-213928-2-git-send-email-chenxiang66@hisilicon.com>
        (chenxiang's message of "Thu, 28 Dec 2017 18:20:46 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: martin.petersen@oracle.com, chenxiang <chenxiang66@hisilicon.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>


Tejun,

Are you OK with me pulling this change through the SCSI tree?

> There are two other values for SET MAX feature field according to ata
> protocol. So definite them.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/linux/ata.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index c7a3538..40d150a 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -448,6 +448,8 @@ enum {
>  	ATA_SET_MAX_LOCK	= 0x02,
>  	ATA_SET_MAX_UNLOCK	= 0x03,
>  	ATA_SET_MAX_FREEZE_LOCK	= 0x04,
> +	ATA_SET_MAX_PASSWD_DMA	= 0x05,
> +	ATA_SET_MAX_UNLOCK_DMA	= 0x06,
>  
>  	/* feature values for DEVICE CONFIGURATION OVERLAY */
>  	ATA_DCO_RESTORE		= 0xC0,

-- 
Martin K. Petersen	Oracle Linux Engineering
