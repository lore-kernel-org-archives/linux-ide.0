Return-Path: <SRS0=C1w+=A2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D15C433DF
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5720663
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDyhtwgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGORhg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGORhf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2020 13:37:35 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0893C061755;
        Wed, 15 Jul 2020 10:37:35 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c7so900933uap.0;
        Wed, 15 Jul 2020 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhW8t1MHdrxQztXKi30mBa7dx42Iv336zQjUMRVbNW4=;
        b=UDyhtwgWCHILCK7g1nuQJQ2moHB76sniPWrU1cxiqCgaW6EG32K1mtl9yJOc0QBn3s
         n0CidgEWy9usOSSeX0j9U7yrL0ZEXC252AtWKwZUgJ0EAlM8G+HgVPiOr6cGPzewqKZ4
         4999bHCK8PN1UQ9BvzBpEu97ZODZ4MvKnWodt+e/iRWgnSQ0VPZUcYElgj3L3ZrVMigE
         5D4tDEG7idrxtSFR0rmNr+FLbbh9ZsaR73t8Po27sG1uhMVEPGBw+ESJw7zXHY+NsCcZ
         T8/4z7QBZrHXWMeSP5Jb0zt6dZvH4SPLNjiGWCs9+gTpB5YXeLBsVgEVzp3P3PSj24/N
         YUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhW8t1MHdrxQztXKi30mBa7dx42Iv336zQjUMRVbNW4=;
        b=JjtTpvFGJeelpTk67NBp+NQht0Vb3haw2DKSqmObLEv887yQ34JaoXhdoX+Yk2M8Ot
         Zrm4s9Yhrrvf6zz9pXi1edGLmPokAGoWku/yf3TIDWv0Rh55DKxQ47Gait37va2MRLEc
         9Mme3S2XaH5USIaGR3RGLYkla3zKwi8G1nwn08HaCW7ocJX4l/kO9tCsF+w59XAsA6ri
         lV2iA5RqEyEVU7Xb/sl9u+ofAK4q7SjvX1LjETscM4H5gGvmStKoqJMCHbMudfKqBk+J
         nDqbTeDagnKGlaLI3SuNXwOLi9wPYMD4yqPVcc4P/9kn5KgUdKXmnsk3BJp4M7g35Tzx
         EIbA==
X-Gm-Message-State: AOAM531HwXWmsXCxywGWXj/WlcgZqiJJp4B24mSsDhiwNK2RrP0GOZCn
        uHhgJLMBqMedQF3LWLR9xaxNLdt9CzDSJCgeJkE=
X-Google-Smtp-Source: ABdhPJyjIUHyusFG66XD1xnNw7EnAyakpvIShBADAzUne1f+v4qVvqB6GbOyAAWrXGaOohn+PPyRzuCscgejYWxcVvE=
X-Received: by 2002:ab0:6510:: with SMTP id w16mr431695uam.97.1594834654617;
 Wed, 15 Jul 2020 10:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
In-Reply-To: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Thu, 16 Jul 2020 02:37:22 +0900
Message-ID: <CAD14+f0CVzRCJUJBBM=+jQ=UtOhxVJu9naQ9SpgqMqbbaeamiQ@mail.gmail.com>
Subject: Re: [PATCH] ata: Disable queued TRIM for Samsung 860 SSDs
To:     Simon Arlott <simon@octiron.net>, linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Simon,

On Wed, Jul 15, 2020 at 8:13 PM Simon Arlott <simon@octiron.net> wrote:
> the original justification for
> enabling appears to be based on marketing material with no explanation
> of what has been changed to make the 860 work properly when the earlier
> 840 and 850 both have the same issue.

Yes, this was why I sent out the patch.

With that said though, I've tested 860 EVO at that time(on i5-6200U,
so it's an Intel SATA controller) for a few weeks both with
asynchronous trim via f2fs and manual synchronous trim via fstrim.
(Since I was also using TLP, the SATA controller and the SSD was
constantly switching between LPM mode and non-LPM.)
My unit did not have any problem whereas both my previous 850 PRO and
850 EVO suffered from issues.

My 860 EVO was just fine with no problem for about 1.5 year until
later I switched to NVMe.

Given how late the bug reports were made after my patch went into
mainline, I wonder if this is firmware-specific.

Thanks.

>
> Signed-off-by: Simon Arlott <simon@octiron.net>
> Cc: Park Ju Hyung <qkrwngud825@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: ca6bfcb2f6d9 ("libata: Enable queued TRIM for Samsung SSD 860")
> ---
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b1cd4d97bc2a..02e861aac5ec 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3951,6 +3951,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>                                                 ATA_HORKAGE_ZERO_AFTER_TRIM, },
>         { "Samsung SSD 850*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>                                                 ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +       { "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> +                                               ATA_HORKAGE_ZERO_AFTER_TRIM, },
>         { "FCCT*M500*",                 NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>                                                 ATA_HORKAGE_ZERO_AFTER_TRIM, },
>
> --
> 2.17.1
>
> --
> Simon Arlott
