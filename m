Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097BC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 22 Apr 2022 00:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382345AbiDVAcX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVAcW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 20:32:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C12182B
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 17:29:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so6917506wma.3
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VVXlpLZ+Fq+rGdj3zWntBmgAH60/fMUJiGhk005mR0=;
        b=GYjODota80O9coFk0PbNQluugFkcv7KR+cdU00z7BsUX6Cwn5YJdYnXQol4SC9IvLW
         IKs+Jadjf6xxL5/znWPiFOQUnbNinPGrAUtdUe/kkPJvNDb6xwOhKE2muFX+bOgHyyqW
         KUuqxJDNe9u6PGikEvYCR/2wV2UmIWE0I65Oqg5+BOyvOfT8rfkFShqkytSzAaLpAg0K
         mswRvwk6RcsEmgfqSkv6OSV9GlhshnhXRomfX/v6/NdlheR9HtjN+R0+J+RQPuMcyp8c
         2uPPUPw9xDFQjD//5nUwV7NXuYaQBjXeSsoUsrIrz5TxCNbxL39tLftq7cffu9IOSORy
         hfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VVXlpLZ+Fq+rGdj3zWntBmgAH60/fMUJiGhk005mR0=;
        b=yrPX25tGSg3aMuLRg1bfomojDOaKvBufBFEuby7f3u1SWw2iyl0Dm3iVvTuvTFzZKm
         MzTctulsKA0+iac85LKYm3dP1iEIapsZwMgT8TA7BNhjvZ0bxcTF3BEsnP6GrtyG3qrV
         +HIV+KwxysJfvpfCfZJQe3k/6nqBrLA+GKjarSvM6Cvxj7YWQvFLtRC2mE+SBNI6NSA4
         Asob03NFixHpBIooz/GHai2Kww2MWmpOKqNrRoFP0MgTQuhNX+9U8LaXldTa5rEv22P7
         IJpA5GAApltcQSl+1N8gSVWIKlT0p1nNKWwYRmV903VXfKyAb/tf5gjspnd4wEvY1KiX
         dx2g==
X-Gm-Message-State: AOAM532JNvYUIZ8hmx+GqM4UocYb8iQ4+Zdjb/44cenU7w1JsM8jkRTP
        9kQKPauclQDCoxZ5Mb5baPQlyB5d6/16dT2aeeBYGyTgaAA=
X-Google-Smtp-Source: ABdhPJybURvwAWfcAC8/nLqribFxUx6aV3cRy1ViGa1gak5qPA3Ec/BDo1sqrk2+hLakkk+jj4caEFcAsvX/4NOU6cs=
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id
 c4-20020a7bc844000000b0038e7c92a9e3mr1554080wml.140.1650587369581; Thu, 21
 Apr 2022 17:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220421045423.17821-1-diego.viola@gmail.com> <b2850508-5f61-0688-74df-930a1447df0c@opensource.wdc.com>
In-Reply-To: <b2850508-5f61-0688-74df-930a1447df0c@opensource.wdc.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 21 Apr 2022 21:29:18 -0300
Message-ID: <CA+ToGPHmeXj_wYkRt8G6fNSofeR=JyWSA=TZpDbs=5Mq-1mXOA@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: replace "its" with "it is"
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Apr 21, 2022 at 8:41 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 4/21/22 13:54, Diego Viola wrote:
> > and "isn't" with "is not". The former fixes the typo while the latter
> > just uses the same formal language.
> >
> > Signed-off-by: Diego Viola <diego.viola@gmail.com>
>
> Applied to for-5.19. Thanks !

Thank you, I really appreciate it.

>
> --
> Damien Le Moal
> Western Digital Research

Diego
