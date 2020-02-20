Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02CDC11D20
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B764C206F4
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 21:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKgZk5aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBTVmj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:42:39 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36630 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBTVmj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2020 16:42:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv17so52871pjb.1
        for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2020 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAgMHU+HJUZium/o7NIAR/mddC7Epr//ZO3mRhNiNjE=;
        b=sKgZk5aqjzotEPiMGqkwv0aRApKZUfpZt+qYZccoZqwXjJSsXcxXBBHyRkLpz7n5Um
         SVC2fRdcJN1XkBFlWNHGFZi+T64xdRb7yLOXFHMXNNmLKEbid6eszoUj1MP03axqQ6h6
         zhBb7oSH/DEBsSOWVjNs0MhZRx+ETZZVPTNwXjZD7K+CaeiPBa4qMm6RYTOSXqNLzSvw
         WFTto3niktNt1RcCVl73kfiE4SoxBkAnIouW0anrTkhS1hYXqcjiz8XnwKt0l4fnLuAi
         Mr72sFclg//o8FuvYC4wk4kGWkkZEZBruVTyLSqHHCsaG5tc6GsTzcerGqnaCPhzNXV9
         FJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAgMHU+HJUZium/o7NIAR/mddC7Epr//ZO3mRhNiNjE=;
        b=qYPKtfjjfzrDiLY7SM5HyPUQWPHKe7AT8v8Lo+uHIFQj9m2h5i+9kLTav2eaSXv+5r
         B6u5DaktZHb/gC1SbqIG1ogiS0WT6Z0pm0vZ5rC9Oc0TOcnO8NGPyjx7EDJEFkvvCVcX
         upPW2G6BNEYk3Kbzp0xSLKLT6Nte3/bDOnECF/kz7T3oOVM6QtjAllVdu2WCxBlkzNcW
         7T26FTMMTXOpPk8g9AFYn2XRlYmdQL/FNqzivQ5bvbsQ6qBle2nAMZaaAm2u0+GWYnui
         sVogV/owTTHtw1swpgE+0MUf58+ry+FZJCgT34N0C9fWpwjS479mhsggrXMprHXOlnZT
         aG1g==
X-Gm-Message-State: APjAAAUIRbJv5i17OXKeKLTtcvq4GleaHSLyH4u/Z8mj0u2ykNeHHeMa
        5xnTFVwbwW/nRb/EYM8KoBg=
X-Google-Smtp-Source: APXvYqyrLOPXakFBu1y8bt/rJYJuqxq2OaY3qQsmIcyr4Zb2iGmBUsriHyHQhCDUndIrouB/uo5B6g==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr6233955pjr.142.1582234958547;
        Thu, 20 Feb 2020 13:42:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm523880pfm.150.2020.02.20.13.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 13:42:37 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:42:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH RESEND] libata: Assign OF node to the SCSI device
Message-ID: <20200220214236.GA28771@roeck-us.net>
References: <20200220212935.2239-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220212935.2239-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Feb 20, 2020 at 10:29:35PM +0100, Linus Walleij wrote:
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
> ---
>  drivers/ata/libata-scsi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index eb2eb599e602..0610a3a86de3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -36,6 +36,7 @@
>  #include <linux/suspend.h>
>  #include <asm/unaligned.h>
>  #include <linux/ioprio.h>
> +#include <linux/of.h>
>  
>  #include "libata.h"
>  #include "libata-transport.h"
> @@ -4582,6 +4583,33 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
>  	return rc;
>  }
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
> +			dev_info(d, "found matching device node\n");

Does that add any value or should it be dev_dbg (if anything) ?

> +			sdev->sdev_gendev.of_node = child;

			of_node_put(child);
			break/return;

or is it on purpose to assign the last child if there are multiple matches ?

> +		}
> +	}
> +}
> +#else
> +static void ata_scsi_assign_ofnode(struct ata_device *dev, struct ata_port *ap)
> +{
> +}
> +#endif
> +
>  void ata_scsi_scan_host(struct ata_port *ap, int sync)
>  {
>  	int tries = 5;
> @@ -4607,6 +4635,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>  						 NULL);
>  			if (!IS_ERR(sdev)) {
>  				dev->sdev = sdev;
> +				ata_scsi_assign_ofnode(dev, ap);
>  				scsi_device_put(sdev);
>  			} else {
>  				dev->sdev = NULL;
> -- 
> 2.21.1
> 
