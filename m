Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78544C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 21 Jan 2022 09:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiAUJio (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Jan 2022 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiAUJin (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2022 04:38:43 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18EFC06173F
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2022 01:38:43 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v186so25969531ybg.1
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2022 01:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JekWhR8CMAxMCtnFBApW6vamUlJTaekkAKvbq4p6qw8=;
        b=Mu93tn/1YAjVBeQULNJalS9X6HhXvdWuyJXmfAqYbyxtxM0dtvMRc+raEPKdaKvd1j
         W8jW7wwFnUYqcxvwlY4G9B0sR9xprDxdAKdd0JyJVIAgSzP1Vg36C/ZZqPTTMQVeQKlk
         SB/QuNjdCsYqzTCpkkZ76PVrvOBoNAiR5+qeeYz+B++Ax0BLwt7s6J+GZE4wEO1Ju2aR
         Dr1e04+a6xS3r5LKxcnKAgOstzSLyEfXClE/U0xMM/BWLLZ8pSHvYlj3Y/C3mUpkO+gS
         Ap3JYFS/dUwYBdBnGvyFqeEfUmllZvIoJyVvlsiHvrpEwZY5WOtx/o5APydHInZdx/kX
         IW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JekWhR8CMAxMCtnFBApW6vamUlJTaekkAKvbq4p6qw8=;
        b=HlVz3ah3i05iO+cSSEmqJlZym9Li+mVfeDhDKMw78X/jK183l6T0+Rl8vyrhAZywsd
         m3Tiz2Pu2UwfcbbF6CcyhWZJQCQz0v4TgLLq1u1CG1n6CDfWWCwa6bZBx2VFe+5xmx58
         yYDwHQdtAVUjqty+4ta48PLqGxPFcZ9SadW/nor5FKdQG/DOZ7sj1nGKqHL9MlGNhtoc
         PK3xK+v3BP4cwvmjqgcUdDRgJ3A4Me7ClXu5gUfjw0hD85gB9Zn0HZupF9wun8MIR5LQ
         U+acnsPzfY2L6HsvOA9hAhD+/R5OokrqcsdZ99rd4xfDXf+Zkk89QRjKSgEK+n5ktfCz
         AZiw==
X-Gm-Message-State: AOAM532bxBtrnUBIbWbHY6NeQz5KMN0lGgMBRZVi4St6HS0w8fV6wYEO
        adWhKzs70o9YKCkUjk7IDrZdM9hFhkwL+cvNg4aT+Q==
X-Google-Smtp-Source: ABdhPJxwPwDcVZlwqlEbNURijL+6MLGocOVUhJTkp4UaAqzb1wi8hvxpYQGzCNUitvJcHn3KXKIEEW0s6ye7Cf9nlng=
X-Received: by 2002:a25:c04c:: with SMTP id c73mr4847013ybf.553.1642757922889;
 Fri, 21 Jan 2022 01:38:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtq0wzSeG8YG-a+=KrbdWqHJMXk1hvq0FKeAvj9sZAK2g@mail.gmail.com>
 <6249735f-e6b7-1331-eb2b-361bb17d6115@opensource.wdc.com> <CA+G9fYu__OOvk-ESXoOqbd-Lk+CmO8CSQ8chEFf3MyeTjKtp9g@mail.gmail.com>
 <350720e8-9b78-bd24-5c60-602076610bf4@opensource.wdc.com>
In-Reply-To: <350720e8-9b78-bd24-5c60-602076610bf4@opensource.wdc.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jan 2022 15:08:31 +0530
Message-ID: <CA+G9fYuMc9qjQE+XoKUzwhMP4O5QE5FbCEhJEmrd_Q8LaC4nFw@mail.gmail.com>
Subject: Re: [next] mips: cavium_octeon_defconfig: pata_octeon_cf.c:598:23:
 error: passing argument 1 of 'trace_ata_bmdma_stop' from incompatible pointer type
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 21 Jan 2022 at 14:47, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2022/01/21 17:58, Naresh Kamboju wrote:
> >> I just posted a fix. As I do not have the environment to compile test
> >> mips, could someone test please ? I will send the fix to Linus asap
> >> after confirmation that it is OK.
> >
> > Please share your patch / patch link. I will test it with tuxmake.
>
> I posted on linux-ide and CC-ed linux-mips:
>
> https://marc.info/?l=linux-ide&m=164275458614058&w=2

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

- Naresh
