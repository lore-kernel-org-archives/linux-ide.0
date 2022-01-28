Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22579C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiA1Qei (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350068AbiA1Qeg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 11:34:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72056C061747
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 08:34:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ah7so17780359ejc.4
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CPTp/menBO6UQqnwwqQqUCiR3PFFyaI2dQ9F0EuRW8=;
        b=KaYioSIoYKLfQIKe+XdiLeZgcY3pk28UmXSyRoo+3r3VkNuZEBkdDCpwmoEduq4+hn
         9Kl7qZpp51pp3+f7fb+iGGxceJiqbPquZa7B4EF9/kwy45OtrrEc1RPYLpUzci1H/73O
         8WNInMfG+0fjYDSDrfSDcVlDwjqfULzbTlNg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CPTp/menBO6UQqnwwqQqUCiR3PFFyaI2dQ9F0EuRW8=;
        b=WSSQJu8x3eFwiN81EMAD8QtARtKZrrZrgXgkOazJSmggAEtOa7W1B9NNBYdPAWAw1t
         RJUTswjiS1qOjgRPTjWLiV99qWB2DRszp4MtLDOxYd8s9n5qa4F1Jr6thhDs+yTpySQ0
         Gq8VPnrXXY/nE07m/Yz02ph6D7zv3+fxJcITctYJ3gB+SL1e6pbfMcNOZ/DXJgT/QSkX
         8HDbdcgJz1pL0ZXAkZotNl63o7OX7fmqWRSML7U1SQAw6g+rWb0X+TDn+v2sG31JgoF7
         I7FzCbxMV8cl4W5IVhIufOQDX4wIsyV4cjv0TRsTLPaesMvPOSjHkXM5vFzfPQjht67B
         LdOQ==
X-Gm-Message-State: AOAM532Zt67FJH2I+vJjewczX6pue5VuUa9VBcIzrIc2RBEeqZE8VBoU
        Sxb7QhLiyZUtiNwpjvspY2TJKr2qHMQBnCfX
X-Google-Smtp-Source: ABdhPJyi9vNiD6DAdJGUKze+LwR8wFiCsuF2uKA1cUHrfOhVG2Nxna06IvCut7WxcLbyi0bLupoHMA==
X-Received: by 2002:a17:906:d0d4:: with SMTP id bq20mr7276196ejb.230.1643387674689;
        Fri, 28 Jan 2022 08:34:34 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id cr8sm13106506edb.47.2022.01.28.08.34.33
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:34:33 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso8590523wma.1
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 08:34:33 -0800 (PST)
X-Received: by 2002:a05:600c:1509:: with SMTP id b9mr8031785wmg.144.1643387673610;
 Fri, 28 Jan 2022 08:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 18:34:16 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
Message-ID: <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jan 28, 2022 at 2:10 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> I forgot about the umn.edu situation and accepted a patch, which was the single
> fix in my earlier pull request. This pull request reverts the patch. My
> apologies for the noise.

Gaah. The patch looks valid, so I think reverting it just for the umn
situation is not only noise, but a bit unnecessary.

I'm adding Greg to the cc, since he was the one most involved with
that whole thing and maybe he feels otherwise, but I'll drop this
revert for now on the assumption that it's fine.

               Linus
