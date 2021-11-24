Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4CC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 24 Nov 2021 04:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKXEz3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 Nov 2021 23:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhKXEz3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Nov 2021 23:55:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE86C061574;
        Tue, 23 Nov 2021 20:52:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id o4so1439286pfp.13;
        Tue, 23 Nov 2021 20:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YCo7A+Vzp21Xzm6FNF5XCbTAVfXkpJNZHlPe+Xeivp8=;
        b=Q4GKIRZIDXau2T3nOWtCeqnxC0X1UWezCtBl0r2brCo/+qyKT9i5xnWPr9uUORZPuO
         MQTISveAgLvckQ0UseIWTxQTjsYHM3FlDgKZaCZUjiD02cKr2rEdH+My5qtpbT9A7cIW
         7uddZvG2VYPKdLb1beHgNqiLaVutUI4+qlubtQuB0mcX+uyXrQZZ/KNTxdjvZmDT4Gcx
         NCCX6Hcpd0XtY6qgN2oEPMoqeynus2DeejQaY7SRJdM4ZwQOpNxPNMEgd2JNApv4TpQU
         jf0zU3QNs1SamCMhDmXLVH1os/P3nBZfLLtlU52TCuG7LIL51xdXRp59wSTqokTy+G91
         TTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YCo7A+Vzp21Xzm6FNF5XCbTAVfXkpJNZHlPe+Xeivp8=;
        b=rIJIJUTVS9rN+4PLElgNBRF2FGfYI4UM6xaYCiBsh7IdMmIwvv11PYRU+LP2iYMTP2
         mSk0Gq1SMZfpp3wJ2/nbP3TwblDYfCu64VJvsuHKUYDU2u02wVGFzeHAF/clCDNwrN+D
         FBInuZEoXugs7/EnheIyCa10f31lDVWkMLH6MHmSGxGIXAMwwdpGNDZ5CsDl0fvwr1ig
         lqLoJNyMbtbNqra6dSB3PI7bfN+EL0UGPLuo0LTPomL5aSSOTVjqvFvVf5Qr/b7yF3+m
         3Ooa+Y6hv1Zlt3zS1m5UsftAXnYy8yI8JZ6qh79ujgXaN3Lcm6InAR8JDGvy2m0g7daX
         UFlw==
X-Gm-Message-State: AOAM533Z9+Fk1+8WPGmsOdEMn1HN5MR2jb197Kq1+pjkqGARgZYcIfId
        a/UPyX97eT4oVoU5jfWhV28jZmisCe48Kg==
X-Google-Smtp-Source: ABdhPJyg5eLjfLLcchqkhKaf3WMhlJ/DxdNC/7bucldHQvDLFv5/JIuz5qJBpS30GII4rjFUi70wQg==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr8035249pgb.88.1637729539560;
        Tue, 23 Nov 2021 20:52:19 -0800 (PST)
Received: from [10.1.1.26] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id ml24sm2834281pjb.16.2021.11.23.20.52.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 20:52:19 -0800 (PST)
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
To:     Finn Thain <fthain@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f420bff8-855a-aabe-924c-6d1b74f11001@gmail.com>
Date:   Wed, 24 Nov 2021 17:52:04 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

thanks for your patch!

On 24/11/21 17:25, Finn Thain wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
>
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
>
> The same thing shows up in 8 places, all told. Avoid this by use of
> __iomem type casts.

Seeing as data_addr was explicitly typed as __iomem, your fix is clearly 
correct. Bit embarrassing to have missed that (I remember adding __iomem 
annotations elsewhere at some stage).

If you think there's any need to test this change, say so.

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  drivers/ata/pata_falcon.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 121635aa8c00..e2a88edd9dbf 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  	/* Transfer multiple of 2 bytes */
>  	if (rw == READ) {
>  		if (swap)
> -			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
>  		else
> -			raw_insw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
>  	} else {
>  		if (swap)
> -			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
>  		else
> -			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> +			raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);
>  	}
>
>  	/* Transfer trailing byte, if any. */
> @@ -74,16 +74,16 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>
>  		if (rw == READ) {
>  			if (swap)
> -				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)pad, 1);
>  			else
> -				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_insw((u16 __iomem *)data_addr, (u16 *)pad, 1);
>  			*buf = pad[0];
>  		} else {
>  			pad[0] = *buf;
>  			if (swap)
> -				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)pad, 1);
>  			else
> -				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> +				raw_outsw((u16 __iomem *)data_addr, (u16 *)pad, 1);
>  		}
>  		words++;
>  	}
>
