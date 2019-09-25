Return-Path: <SRS0=6af8=XU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379AC432C1
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 03:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D9E20665
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 03:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfPaFU3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405131AbfIYD7o (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:59:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36078 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404095AbfIYD7o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Sep 2019 23:59:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id t14so2009762pgs.3;
        Tue, 24 Sep 2019 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RN2qCxpcJvKDByVo/0WHJcrbI1KdB2Iw4qcIQ5ciAM0=;
        b=pfPaFU3cUHaUpczZY9qCt8cdQLwn/aSqMSZjqJm9ZdHUNqgSbuOiU5goi8omcsqChT
         Rd7Y2yVS/BrhrQ3ROkcPTIIPfb71pZUZP8R63V/om4zj1CGJ1i3CJmoKiHTIzRKBWQbi
         W8YlZwrJ5JUoq4tnyiYlnBg2P2RNw6hZrRLVJpdkqu+c8JbRTAMgqDBOiKZyoG7xRIzw
         slcl1AMC5uRQJg+W/SMazPE6GxYZmx+IcnFYGnYvPOP8JRCw99WGEq8jsittzj9/M4nT
         0EWrWznVb7cQxvpBke7Wu08sBq7C2PpwYhVCnYieltyhgQtWoYMIjZ7yJxrk7BPvNg0E
         mdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RN2qCxpcJvKDByVo/0WHJcrbI1KdB2Iw4qcIQ5ciAM0=;
        b=E0BJVgGTh6nmasiAn9uHkcjCkv8sB1qVbJOC6EteBSoX/3dZDCqlXrsmfnc/nhHWx2
         j/Eu0km4jVbYYJ0V23tiysXxR4SeQ6TwR9Jos0F0WvgguwGpU2THxYCUqsimr45KBwqf
         ukWW/zX70uFMdSMj5J0PxX1u2DlJv4q1V0s3VmQFyxKomKU6avldYNwOU+dBaWj8TgOl
         7x6UY8fMhuDCytspJdIDi/f2X6g6HELu6AJIkcvYU2KefSkIjQBH4zgRs3JTSJ9MOp7e
         xcrhNfFKSmdotG+c7bKt5HtuQwTaSLzmizYkpoInjRlypRqkLuLxtiL7fgcpMlJP+D6B
         WGRw==
X-Gm-Message-State: APjAAAU4kCHQo9t7Rt+Pq2qbUHzkyfvv/GIp1E0v/q3UvcwJTpS1nKnM
        fTPSm7KXLYjedl6pMfRWtECUuDXt
X-Google-Smtp-Source: APXvYqwNbrYUAsVMLtyrk8APJGXhOfZ7DhzC5DISMNBD10gEL66m5DnobT2WmZhZgVru8pjde50IkQ==
X-Received: by 2002:a62:168e:: with SMTP id 136mr7399316pfw.144.1569383983315;
        Tue, 24 Sep 2019 20:59:43 -0700 (PDT)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id g12sm5776511pfb.97.2019.09.24.20.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 20:59:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] drivers/ata: convert pata_falcon to arch platform
 device
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
 <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXeb2gUz92C-QqWmVLnpncArMkzgsJKNSz3F8J6ri89TQ@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <afe0f0bc-21fd-7e09-987b-4b13d2597f91@gmail.com>
Date:   Wed, 25 Sep 2019 15:59:23 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXeb2gUz92C-QqWmVLnpncArMkzgsJKNSz3F8J6ri89TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

thanks for your feedback!

Am 04.09.2019 um 00:44 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Tue, Jul 2, 2019 at 12:02 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> The Atari platform device setup now provides a platform device
>> for the Falcon IDE interface. Use this in place of the simple platform
>> device set up in the old pata_falcon probe code.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Thanks for your patch!
>
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -120,23 +120,21 @@ static int pata_falcon_set_mode(struct ata_link *link,
>>         .set_mode       = pata_falcon_set_mode,
>>  };
>>
>> -static int pata_falcon_init_one(void)
>> +static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  {
>> +       struct resource *res;
>>         struct ata_host *host;
>>         struct ata_port *ap;
>> -       struct platform_device *pdev;
>>         void __iomem *base;
>>
>> -       if (!MACH_IS_ATARI || !ATARIHW_PRESENT(IDE))
>> -               return -ENODEV;
>> -
>> -       pr_info(DRV_NAME ": Atari Falcon PATA controller\n");
>> +       dev_info(&pdev->dev, ": Atari Falcon PATA controller\n");
>>
>> -       pdev = platform_device_register_simple(DRV_NAME, 0, NULL, 0);
>> -       if (IS_ERR(pdev))
>> -               return PTR_ERR(pdev);
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res)
>> +               return -ENODEV;
>>
>> -       if (!devm_request_mem_region(&pdev->dev, ATA_HD_BASE, 0x40, DRV_NAME)) {
>
> ATA_HD_BASE is now unused, and can be removed.

Right - well spotted!
>
>> +       if (!devm_request_mem_region(&pdev->dev, res->start,
>> +                                    resource_size(res), DRV_NAME)) {
>>                 pr_err(DRV_NAME ": resources busy\n");
>
> dev_err(&pdev->dev, "resources busy\n");

I stole that from pata_gayle, Bartlomiej may want to fix it there as well?

>>                 return -EBUSY;
>>         }
>
>> @@ -174,9 +172,26 @@ static int pata_falcon_init_one(void)
>>         return ata_host_activate(host, 0, NULL, 0, &pata_falcon_sht);
>>  }
>>
>> -module_init(pata_falcon_init_one);
>> +static int __exit pata_falcon_remove_one(struct platform_device *pdev)
>> +{
>> +       struct ata_host *host = platform_get_drvdata(pdev);
>> +
>> +       ata_host_detach(host);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver pata_falcon_driver = {
>> +       .remove = __exit_p(pata_falcon_remove_one),
>> +       .driver   = {
>> +               .name   = "atari-falcon-ide",
>> +       },
>> +};
>> +
>> +module_platform_driver_probe(pata_falcon_driver, pata_falcon_init_one);
>
> This doesn't seem to work in the builtin case (e.g. atari_defconfig with
> ide replaced by ata): no hard drives are detected.

Due to a dumb naming mismatch between driver and platform code 
(shouldn't have rushed this right before going on leave). This would 
have made the driver fail in the modular case as well.

I'll fix that along with adding some error checking in the Atari 
platform init code.

Regarding the potential bisection issue with this series - that ought to 
be fixed as well by renaming the platform resource to match what the new 
driver expects. I'd rather leave the two patches separate so the Atari 
platform code one can go through your tree.

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
