Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0914BC83F0E
	for <linux-ide@archiver.kernel.org>; Sat, 26 Aug 2023 00:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHZApX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Aug 2023 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjHZAoy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Aug 2023 20:44:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F32119;
        Fri, 25 Aug 2023 17:44:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a41035828so1192233b3a.1;
        Fri, 25 Aug 2023 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693010691; x=1693615491;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPOMYxzU8vZZeKPscxcFLSdrOO7V+ZYl2duFOimfGac=;
        b=oGWXmOwKDwk+d/Lf2YJ3z+dGGMwkyUGqw8D7fZ/i/Lu8I9unNf+LjytAZdH9KFAWfV
         R79WcMncUlQCSdw95KtMi1TgNckiNzNEyI+ot1Ba3YY3f4KFMrVsqDBRryIOF+X+7Z+/
         b1eG4lJwS4ATQ6ntKNrar/ZSP6IfEQHSWtiV9JV0i7fzByZHC1KAba/hFxOB9XD65o9J
         4CD1GzaHqCf61nYzPadGyU0rKmf6CRc3xoll0p8mu3NYuFwWx0D8/cIZLFOc5QUa+Ldn
         l+xlwss4qhDlxu/70qM5KTKuvWRFfIhpGkwhfRrYdeKhXNq1SIb7Auyt1wIant8pQdac
         rnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693010691; x=1693615491;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mPOMYxzU8vZZeKPscxcFLSdrOO7V+ZYl2duFOimfGac=;
        b=GHsCVxnoKgylJINVvZkSQRHQCkbgDaz1fOnKH7UARXIKEvue5ta2iZ1U1JkIaL2Vcz
         kPAsPJ1AmqMJMlcPNUWDCVO7vjx7LFuGVh/RoZGCdlo+swNY/Ui1ZO09nX+bP85EfeZ/
         uXFZdWkWKb68bPV3To6dW+/Mqote/PMfRnh1HO3J2L9KlrcJ5sK9Zymo/Vbsd5cLbFOn
         Fk6dQJZmVaVxlzmv7oHB9+tREl0q+nANuJgbuvKZbwD2x3AWQKZkOWrcJ+VkeOVi/66D
         sYWGtfm0GpnCSjoOPwZLCTJwMK0d1JGMEGUllmovoU8zIzmxHRruplREcfUeiVM8zLAI
         K7ug==
X-Gm-Message-State: AOJu0YxU9h/yUPwkp667GTVjsYE1pNX1a5elF1KrvuQAScZ1GeVCU6j6
        VkB+H8CYhDv+dsbqGjmr1NM=
X-Google-Smtp-Source: AGHT+IHKGpicetbdPVmBuT1CKi6iRtMi30MrnwZ8UsgHHTtFj+mta7z7JJJqd+Be4km0zD3KS0cImw==
X-Received: by 2002:a05:6a00:1a88:b0:67a:9208:87a with SMTP id e8-20020a056a001a8800b0067a9208087amr18834818pfv.23.1693010690973;
        Fri, 25 Aug 2023 17:44:50 -0700 (PDT)
Received: from Schmitz-MacBook-Pro.local (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.googlemail.com with ESMTPSA id q10-20020a63bc0a000000b00563ff7d9c4bsm2307909pge.73.2023.08.25.17.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 17:44:50 -0700 (PDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230825011335.25808-1-schmitzmic@gmail.com>
 <20230825011335.25808-3-schmitzmic@gmail.com>
 <CAMuHMdUhw-mvGXRRimfp1SAMaRzOfQuO=k81LaZbXuNPV0igQQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v5 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
Message-ID: <f02aeddc-eb6e-9de3-5c92-959271b1b6c5@gmail.com>
Date:   Sat, 26 Aug 2023 12:44:44 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUhw-mvGXRRimfp1SAMaRzOfQuO=k81LaZbXuNPV0igQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 25.08.23 um 19:46 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Fri, Aug 25, 2023 at 3:13=E2=80=AFAM Michael Schmitz <schmitzmic@gma=
il.com> wrote:
>> Some users of pata_falcon on Q40 have IDE disks in default
>> IDE little endian byte order, whereas legacy disks use
>> host-native big-endian byte order as on the Atari Falcon.
>>
>> Add module parameter 'data_swab' to allow connecting drives
>> with non-native data byte order. Drives selected by the
>> data_swap bit mask will have their user data byte-swapped to
>> host byte order, i.e. 'pata_falcon.data_swab=3D2' will byte-swap
>> all user data on drive B, leaving data on drive A in native
>> byte order. On Q40, drives on a second IDE interface may be
>> added to the bit mask as bits 2 and 3.
>>
>> Default setting is no byte swapping, i.e. compatibility with
>> the native Falcon or Q40 operating system disk format.
>>
>> Cc: William R Sowerbutts <will@sowerbutts.com>
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Tested-by: William R Sowerbutts <will@sowerbutts.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> ---
>>
>> Changes since v4:
>>
>> Damien Le Moal:
>> - spell out bitmask shift calculation
> Thanks for the update!
>
> Sorry to bother you again...
>
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -124,7 +129,7 @@ static int __init pata_falcon_init_one(struct plat=
form_device *pdev)
>>         struct ata_host *host;
>>         struct ata_port *ap;
>>         void __iomem *base, *ctl_base;
>> -       int irq =3D 0, io_offset =3D 1, reg_shift =3D 2; /* Falcon def=
aults */
>> +       int irq =3D 0, io_offset =3D 1, reg_shift =3D 2, mask_shift; /=
* Falcon defaults */
> The comment does not apply to the mask_shift variable, unless you
> pre-initialize it to 0...

It does not apply to mask_shift even then - '0' is the default for the
first Q40 ISA adapter also, not just for Falcon.

I'll move mask_shift to its own line so the comment can be correct.

>
>>         dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller=
\n");
>>
>> @@ -194,6 +199,12 @@ static int __init pata_falcon_init_one(struct pla=
tform_device *pdev)
>>         ata_port_desc(ap, "cmd %px ctl %px data %px",
>>                       base, ctl_base, ap->ioaddr.data_addr);
>>
>> +       if (pdev->id > 0)
>> +               mask_shift =3D 2;
>> +       else
>> +               mask_shift =3D 0;
> ... and drop the else.

Damien did seem quite partial to that one, so I'll leave it.

Cheers,

=C2=A0=C2=A0=C2=A0 Michael

>
>> +       ap->private_data =3D (void *)(uintptr_t)(pata_falcon_swap_mask=
 >> mask_shift);
>> +
>>         irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>         if (irq_res && irq_res->start > 0) {
>>                 irq =3D irq_res->start;
> Gr{oetje,eeting}s,
>
>                         Geert
>

