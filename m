Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC47C27C40
	for <linux-ide@archiver.kernel.org>; Thu, 24 Aug 2023 08:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHXIaF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Aug 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbjHXI3m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2023 04:29:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683701980
        for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2023 01:29:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d73c595b558so6291884276.2
        for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2023 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865771; x=1693470571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W23dUDoYPVM+Albz/fV7buPvXshVz7q37yEa393WS6U=;
        b=rNNdxiH5IkcE2W6izEaA/RjXtQay2euQ4SKKZgVceqhfRBVMZBby5WhB8m+2ycLzb9
         cucGeYwuHkIuKrzMMM1U1RHHjMryrJa+s4Si8A3NpWULQBJ8HMv9Nnfeo1bZqd9v4YbU
         D2tgpb0uuaoQgrLdywDnObbtTddD3GTObZiTjYRnxazBI6NvAVbjnC84Xv+GbmuXrCmK
         g63+PNm8kXkAw8RU54nWRPcSgqnD5i2tFjbOrS9+BoWmuGmUftW5ks7ssgvUTC9W5uyn
         sv1sfpR7io/LMVwUMmasruvrPZtZavhZPXK9IwqYmqFwjCahVXrOP0JnHmnIl/eOTi4S
         RnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865771; x=1693470571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W23dUDoYPVM+Albz/fV7buPvXshVz7q37yEa393WS6U=;
        b=f1NNc9m+aoG4LP+MQw7/EKorbeiO7wcWwGWLcmYG749aeH72kjf6Q2HOnz8a/5lU3V
         4QVqUWm8M4sVS0Nb3Zw3a3n43i5CWiK9iS10G9fnlOgSMzH2Cunt6goBB2ak/T2omgin
         SaR8ZYTORd7w1Xl1DcYGF8zONPzvEZpNm971YRkpTDrDxHq1fpuxiVSRs/M/MZj56HMJ
         +K3loSwC5GA0hgye4C+3CGdFRdxKVrsNBNwXNlzhdfG2AiSJ4JgMzIs6V7v3lvTO+Ky0
         LA2xmdSAVX/LBLTjfYbkkwcAZg10YS32RVFI3Tz+4Hnm+LbeRA/ZmJAxIu7W9zoHshpm
         KdHQ==
X-Gm-Message-State: AOJu0Yz/FUKFWj32YFYqy/CKS+KDjVIgHiMHLdTX+n4nGz5Xi7xPOJZP
        +uTO+xK0+SGIXIcNPLgmbxtRDg7hwP7N2IgDWRW1aFdWNqbgzKPM
X-Google-Smtp-Source: AGHT+IEl4L2FUHZquf36cH0eKeiAqrKkzoBDEQmxyTV1nygM0st6nbzsX8cOpP5PeXx3gdS01tXwYrnbVJZwAhEn8RE=
X-Received: by 2002:a25:804f:0:b0:d77:de72:592b with SMTP id
 a15-20020a25804f000000b00d77de72592bmr3070562ybn.48.1692865771594; Thu, 24
 Aug 2023 01:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230823225234.36354-1-dlemoal@kernel.org>
In-Reply-To: <20230823225234.36354-1-dlemoal@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Aug 2023 10:29:20 +0200
Message-ID: <CACRpkdY8S_03a9RyJRK6uAh3aFC2K76+_M+rmwEX=sOwr04mkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix compilation warnings
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Aug 24, 2023 at 12:52=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:

> Add missing MODULE_DESCRIPTION to avoid warnings when compiling
> with W=3D1.
>
> Damien Le Moal (2):
>   ata: pata_ftide010: Add missing MODULE_DESCRIPTION
>   ata: sata_gemini: Add missing MODULE_DESCRIPTION

For both:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this Damien!

Yours,
Linus Walleij
