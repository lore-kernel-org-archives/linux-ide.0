Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544DDC001B0
	for <linux-ide@archiver.kernel.org>; Sun,  6 Aug 2023 17:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHFRiE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Aug 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHFRiD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Aug 2023 13:38:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B523107
        for <linux-ide@vger.kernel.org>; Sun,  6 Aug 2023 10:38:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so6229134e87.3
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2023 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691343481; x=1691948281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAcQC93rqO7hwJniSEja/eFfujqBNe5oILUJ36mqy84=;
        b=Ec7Vq84wX7JKGHtRuwV4yL3yv0kctHfuRI/uCGVF7LnaHw+fOkHr3EtAsbXrvLtnrY
         TUz5FybRbe4VvoOdeYQ6Zq4FMA1C8I3iVO3xhQDmB1FlSdgcUp07e2fnf74UACfeiKqs
         41aoDPcbIiMDIT3MHH5nZcvdrPaD+dWTze+zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691343481; x=1691948281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAcQC93rqO7hwJniSEja/eFfujqBNe5oILUJ36mqy84=;
        b=SLT4eV4sZ8JoHiu6OiZ9hlNos9glnObO9lkS0RtHjIrn5l8Hw7bigYSdtEw7F8CEKA
         SCmwk4s4hpEGrHfHSJG98EG46cvHQOVZS92YQlUe0VRp3yZazHEG3SbkqQF6SfAaAb4K
         WYveTWNjbD3o0kpmVHoH2vDcbqXZ8clUfitw+RrYCmR4M24ZSghqAFMOiBhIm1JZF+ER
         wAxNmeQTdi3v1EkLVlZ6QuQErN303gtoRZQmN/HviWGOi8NCJUos1lc0zq//qkcpm8Qf
         yVHPm1ae4pda46XoKAjLyXudenBNVDayct8Ymm2HV0GAOhBnilr6HiwoK6P11lYDfJ6A
         0UyQ==
X-Gm-Message-State: AOJu0Yy8mowgTRgJl8D+t0+zr0eyw1eK0n7oSG9O5BFo6SvlSe0AQ3mx
        JIf6jhyH2E0KBAha5ghWDSCKsE9BcaFA1mFm0nb4mZSS
X-Google-Smtp-Source: AGHT+IF/NR41auRR5usoMax+esuKv6b4H+trcA8M319iLGQM/eoHtAEGaMPVbJ6ZVRFzlcw095p/Xg==
X-Received: by 2002:a05:6512:401b:b0:4fe:1e69:c379 with SMTP id br27-20020a056512401b00b004fe1e69c379mr4829431lfb.13.1691343480884;
        Sun, 06 Aug 2023 10:38:00 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l17-20020ac24a91000000b004fdb913af80sm1186834lfp.209.2023.08.06.10.37.59
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 10:38:00 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9a828c920so57093961fa.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2023 10:37:59 -0700 (PDT)
X-Received: by 2002:a2e:9bd8:0:b0:2b5:89a6:c12b with SMTP id
 w24-20020a2e9bd8000000b002b589a6c12bmr5049959ljj.10.1691343479526; Sun, 06
 Aug 2023 10:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230806012901.250817-1-dlemoal@kernel.org> <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
 <CAHk-=wi9cRUcAY1b-NvjVwysGadMPJ2W+UiTzXxzEKk==WdHxg@mail.gmail.com> <e3357241-3cbe-4cc4-59a3-a97002443ba9@kernel.org>
In-Reply-To: <e3357241-3cbe-4cc4-59a3-a97002443ba9@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Aug 2023 10:37:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEP_mgNDs7tDtgD=+KMa=SiKYstDa4yyuQofwRGuVoqQ@mail.gmail.com>
Message-ID: <CAHk-=wgEP_mgNDs7tDtgD=+KMa=SiKYstDa4yyuQofwRGuVoqQ@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.5-rc5
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 6 Aug 2023 at 02:51, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> Hannes suggested doing all ATA start/stop processing solely relying on libata,
> that is, not using manage_start_stop at all. This is another option I am
> considering.

That definitely sounds like the best option to me, so if it is doable
that sounds worth pursuing.

            Linus
