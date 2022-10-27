Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4144C67871
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiJ0JnZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0JnY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 05:43:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D3DEEC
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:43:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a15so1527933ljb.7
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9jc/ixHxMQXTNaF95PsyQEA61wcheV2RJS6Z5LtrjM=;
        b=HF2fgSI0Z5sg37+lE955k9NPuuo3772ijxhWuYFJ4ttAUO0kNekBnNWytOuV3QIfxK
         0mc0BsBIvjSFYeeUbIUpRanavKC0PEylZNgWwq8gVj7TLO33OuTjJIzR5r2ydltulx3F
         sa+hYuPiB3h09ent1FcMVnuA7ymAOxY6Z5GWpN6J/ni4sxpgU24wUl55piIJHou9cdoD
         RZ6nU7qDJPbeIGdwhsD7fboeJuf3Ts5Es2cci2uNzI/7A+kmbVKu0hfxw+d7NomPq5IP
         LHrH4OAba2puNHPnNN/TgA/ug50c4m5EodyAt9GF4XkdqmEbC4DpB3TiglCcfl8CXC39
         DXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9jc/ixHxMQXTNaF95PsyQEA61wcheV2RJS6Z5LtrjM=;
        b=w/iP3gE3uryXDcq2+IKDiGloKIvF5RlYNFT6emuCd7KH722QbSg5rmbX0qSr27C3NR
         vZFtR5rC9rUWqlSp1PIGdZtZKduFLxm1A7cMbih4hGkhWWsuoJA7KYjfRtyTbIs4CDyn
         7O6Wr+NkjPbHWYA406T2pzf7pfauHTqrz5h1C3rYPhJaFZdXo9iF8DecHJf1fOGujO6v
         6gejhuNIwl1gbvm8lfpgu8A9SbLW3B2FLZTr1npUgggj26jo9lGySEWafe7PSR2hfAQ0
         pqV7bQDaYvsLyi2sKNR1ImLfmIQYd/zMyfpNmB3cPzJWvwIb0XFAjEUxsdb2txA0uXkz
         2I2A==
X-Gm-Message-State: ACrzQf1Vtw0FWNjHZH3Nh+Qe7r0jHm+zhLVQ02J9jsVrTl11aL2nf/nT
        u/dJmg+n0FhywY8cAUI9WkbXqqYfTm4=
X-Google-Smtp-Source: AMsMyM7Eu/7dv01gSRimOl46SsXuxOvH38hn5Yk1UnKRaccI4alAyDjLPu9Ege3lHnCuJhJtGFUSkQ==
X-Received: by 2002:a05:651c:c88:b0:26d:fea6:36b1 with SMTP id bz8-20020a05651c0c8800b0026dfea636b1mr18967721ljb.433.1666863801408;
        Thu, 27 Oct 2022 02:43:21 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.73.120])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056512168900b0048a934168c0sm123156lfb.35.2022.10.27.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 02:43:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-3-damien.lemoal@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ec971154-47c5-2e93-23e5-40090d29d2ff@gmail.com>
Date:   Thu, 27 Oct 2022 12:43:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221027075026.240017-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 10/27/22 10:50 AM, Damien Le Moal wrote:

> Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
> reflect the fact that this function sets a task file command and
> protocol. The arguments order is also reversed and the function return
> type changed to a bool to indicate if the command and protocol were set
> corretly (instead of returning a completely arbitrary "-1" value.

   Correctly. :-)

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..56ddcbaa0c6f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] = {
>  };
>  
>  /**
> - *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
> + *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
> + *	@dev: target device for the tf

   s/tf/taskfile/?

>   *	@tf: command to examine and configure
> - *	@dev: device tf belongs to
[...]

MBR, Sergey
