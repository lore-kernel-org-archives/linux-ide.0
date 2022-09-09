Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1599ECAAD3
	for <linux-ide@archiver.kernel.org>; Fri,  9 Sep 2022 09:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIIJni (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Sep 2022 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiIIJnf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2022 05:43:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B5CCE13;
        Fri,  9 Sep 2022 02:43:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3378303138bso12506307b3.9;
        Fri, 09 Sep 2022 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7ZB/vFj1LBEvoFTPtCpwJzQSMMS3bz1eErTDvpmrofs=;
        b=BWmld3ITX+giHZRWkJWwbcDCiOUpMOxQyqf6WsoI7BqlMauyRaz/ygBKpHYYcBNO+X
         tUxzbx0oJP2PdXRc4UssH4YzjbKa/tcZH7uuybjb+cmvR5GjcY7cZ/Xsbyy+i1O+eVY/
         5/eT+SZULnxNPSVsQc5sDf7lQCC7IoTjd1fArydNSxtxWzw2iE/Fln6qxNRm4kefwf37
         4M6EC6OUSjfjZqTc+UWWlYsyNA3Oed/L+1/CNdtZ3ENyEEc/cmVDMI1zpmkJNfkxuGYp
         yxVvAV/1WQPtYBsUTCvuAEcN+S8yvFEBQZDSt5Fkb86VT+ZJwOTRpUJOP8tNS5jFDDd2
         qt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7ZB/vFj1LBEvoFTPtCpwJzQSMMS3bz1eErTDvpmrofs=;
        b=Pw3GAMaBKs8XttQ1mpLxwYUl+0BjVsADW018DmKvnTBzhD2OyZNBnuKvhg95aQIYQ1
         /wXL3uOkxIdlFeK8GBMRw73AmJVwIGDnq1mjWUGeSa6I9Rp0t6d2Fr2X/xqRVJ7b2xdH
         DYn1ynT2Keemknx+7eAMo89GDC5ejBQHCckdRYBc623a/wdOe1ojbQ9a2vRcxWbx/siB
         2cD9CxhGvk8zcSApIKBSOJEBuHTSz88wrJCh//TXtu+gJdLyTFEf+G7kgxX1kKEjPpvJ
         7tL/Axb6eV/7rskcL/Ttqb5ktsPS2UznXOUwyJxBTrjEsEcD6e6dU6GcXxnChBsqTpH4
         luEA==
X-Gm-Message-State: ACgBeo2twCqoTjlb9k2U+EE6ssPWD8aTMO1ZwxFHHClemIkU/Sk16jN4
        6NA2cybVDX2cjmeHNdyUpEJMHXq3nQUXYn0tvxA=
X-Google-Smtp-Source: AA6agR5jda4a3EcM5GDvNbwnprqfr/4CFDLarXT4mFEldLG0qPusFNe2TD+NpCjCIUQz5j77+wo6CNsqhSjzPuzhyYc=
X-Received: by 2002:a81:7702:0:b0:328:297a:fdcb with SMTP id
 s2-20020a817702000000b00328297afdcbmr11117970ywc.335.1662716613820; Fri, 09
 Sep 2022 02:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com> <20220909090343.21886-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20220909090343.21886-2-lukas.bulwahn@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 9 Sep 2022 11:43:23 +0200
Message-ID: <CAKXUXMyDON2ys_bxNi07h_BOYkjd1Gidi6qTHXQ-=L5Vsu9kxA@mail.gmail.com>
Subject: Re: [PATCH] ppc: select HAVE_PATA_PLATFORM in PPC instead of creating
 a PPC dependency
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Sep 9, 2022 at 11:04 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
> PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
> that all architectures simply select this config when the architecture
> supports using the PATA_PLATFORM driver.
>
> This is properly implemented already for all architectures except for the
> powerpc architecture. Implement this for powerpc now.
>
> Adjust the config of the powerpc architecture to use the config
> HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
> any specific architecture anymore.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Please ignore this patch and pick:

https://lore.kernel.org/linuxppc-dev/20220909090343.21886-1-lukas.bulwahn@gmail.com/

Lukas

> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/ata/Kconfig  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 39d71d7701bd..2575e21b6e6b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -237,6 +237,7 @@ config PPC
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI                         if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
>         select HAVE_OPTPROBES
> +       select HAVE_PATA_PLATFORM
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_EVENTS_NMI             if PPC64
>         select HAVE_PERF_REGS
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 1c9f4fb2595d..ed3547165528 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1103,7 +1103,7 @@ config PATA_PCMCIA
>
>  config PATA_PLATFORM
>         tristate "Generic platform device PATA support"
> -       depends on EXPERT || PPC || HAVE_PATA_PLATFORM
> +       depends on EXPERT || HAVE_PATA_PLATFORM
>         help
>           This option enables support for generic directly connected ATA
>           devices commonly found on embedded systems.
> --
> 2.17.1
>
