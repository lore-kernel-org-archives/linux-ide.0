Return-Path: <SRS0=eeaJ=4K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D959C35671
	for <linux-ide@archiver.kernel.org>; Sat, 22 Feb 2020 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC0206EF
	for <linux-ide@archiver.kernel.org>; Sat, 22 Feb 2020 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq6bKHlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBVPvp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 22 Feb 2020 10:51:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33073 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVPvo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Feb 2020 10:51:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so2627333pgk.0
        for <linux-ide@vger.kernel.org>; Sat, 22 Feb 2020 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/dFIX7JpghOy5p2V8HH1laMs8deAcd8gQNu7/tngB4k=;
        b=Jq6bKHlmx0VAoY1hYsRt73l6S02vKTUNPCzF3fERzS3o5KEf8ja4RAmZhhsE1zNRza
         LjPJ0k9nUcHmsVqm9UEpJ4lkeAUbNaiYajoKMljwrviNC2W3dTGMIBBtjZcIDXPJ2dXv
         ZTgBhBIOCiVRuzzQXbzHDXkW9JPwblMZ0y8Maz83z0YNvfdl9xLGbhHkRjdPVETA43dv
         qju4GTMJ/lPXjaoyPHxaPmL4wvuP6FtqQ+tOacBE1JrOZdwwpwmf+dAIPY5m/Gfpar+A
         zhxd+ffANHyAOiJkdZeQ0f2vweZSf9WtPgiQ1xvw1V3W9uBb9+w2Cu891/WE08fGFdjS
         M+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/dFIX7JpghOy5p2V8HH1laMs8deAcd8gQNu7/tngB4k=;
        b=CGm9YyioYutcfu5Rxhc3ejgWqzZSPku0DxrxglJFq5d5EHuSBqVYITv+gEjUe2dEbI
         prO4FDjPCeWkuYNi10aPnRH2JeHbuqYTg/p1x1iHQJ/r/t6RFunrnJn7FimKulBwja+c
         PL4Bl11DyD7v2ErD4dLOcYJC4cGLF4MMmNH66gCzonGZYr9fkBPhLgaNKbgeWZ6BC65t
         mwjSPbJm/HP5zIdVNGhWw9982uQ097Kq1vfAFOI98s3d12wGdaPukpijQCmFcQDoL0vT
         QRFOn1BghTgq0ogR/nTPTiJKWCPCC4TEkLDDCB/mSepwzbGaMoulB8bbBkj/MD3whSHt
         DhJA==
X-Gm-Message-State: APjAAAUvS67PVvyEhP/lzwtcFXD/DXqVr8knIvgYQjQ0zJPIC4F6NSFI
        qatM3cDI3liR5C/sp5VA2HM=
X-Google-Smtp-Source: APXvYqyqV+c/pYXSgszoI7gGazFm0QQjdd3wqyjImP5R/o5sSPaNqjhcBJhT/PLIJBagGXjIMKKKmg==
X-Received: by 2002:a62:446:: with SMTP id 67mr41293556pfe.109.1582386704226;
        Sat, 22 Feb 2020 07:51:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s124sm7040753pfc.57.2020.02.22.07.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 07:51:43 -0800 (PST)
Subject: Re: [PATCH v2] libata: Assign OF node to the SCSI device
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200222112057.31476-1-linus.walleij@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6ea324b8-7831-b95e-d042-28d05442321a@roeck-us.net>
Date:   Sat, 22 Feb 2020 07:51:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222112057.31476-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/22/20 3:20 AM, Linus Walleij wrote:
> When we spawn a SCSI device from an ATA device in libata-scsi
> the SCSI device had no relation to the device tree.
> 
> The DT binding allows us to define port nodes under a
> PATA (IDE) or SATA host controller, so we can have proper device
> nodes for these devices.
> 
> If OF is enabled, walk the children of the host controller node
> to see if there is a valid device tree node to assign. The reg
> is used to match to ID 0 for the master device and ID 1 for the
> slave device.
> 
> The corresponding device tree bindings have been accepted by
> the device tree maintainers.
> 
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> ChangeLog v1->v2:
> - Use dev_dbg() for the debug print
> - return immediately after finding a matching OF node
> ---
>   drivers/ata/libata-scsi.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index eb2eb599e602..9b2bd080f4e4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -36,6 +36,7 @@
>   #include <linux/suspend.h>
>   #include <asm/unaligned.h>
>   #include <linux/ioprio.h>
> +#include <linux/of.h>
>   
>   #include "libata.h"
>   #include "libata-transport.h"
> @@ -4582,6 +4583,34 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
>   	return rc;
>   }
>   
> +#ifdef CONFIG_OF
> +static void ata_scsi_assign_ofnode(struct ata_device *dev, struct ata_port *ap)
> +{
> +	struct scsi_device *sdev = dev->sdev;
> +	struct device *d = ap->host->dev;
> +	struct device_node *np = d->of_node;
> +	struct device_node *child;
> +
> +	for_each_available_child_of_node(np, child) {
> +		int ret;
> +		u32 val;
> +
> +		ret = of_property_read_u32(child, "reg", &val);
> +		if (ret)
> +			continue;
> +		if (val == dev->devno) {
> +			dev_dbg(d, "found matching device node\n");
> +			sdev->sdev_gendev.of_node = child;
> +			return;
> +		}
> +	}
> +}
> +#else
> +static void ata_scsi_assign_ofnode(struct ata_device *dev, struct ata_port *ap)
> +{
> +}
> +#endif
> +
>   void ata_scsi_scan_host(struct ata_port *ap, int sync)
>   {
>   	int tries = 5;
> @@ -4607,6 +4636,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>   						 NULL);
>   			if (!IS_ERR(sdev)) {
>   				dev->sdev = sdev;
> +				ata_scsi_assign_ofnode(dev, ap);
>   				scsi_device_put(sdev);
>   			} else {
>   				dev->sdev = NULL;
> 

