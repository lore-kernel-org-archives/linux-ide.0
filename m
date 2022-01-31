Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD0C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jan 2022 00:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357187AbiAaAc2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Jan 2022 19:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiAaAc1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jan 2022 19:32:27 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC4AC06173D
        for <linux-ide@vger.kernel.org>; Sun, 30 Jan 2022 16:32:27 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j2so22379226ybu.0
        for <linux-ide@vger.kernel.org>; Sun, 30 Jan 2022 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ids2P9zdNRZ0i8dcrt76jILnjHIJTXIWEZONpz4utdg=;
        b=MF+8Mj+YUU1xTY3VkpGuAwciEZNBJadB6L7lfLpH0h/EDUCspIV4gJL5vC/HtbvI2w
         c69XZLAc8unI3PNck/RJDavlF8zzWLjnCr01JyCfky2HlG3O5gt+V+38df7d1SZIP1sk
         dGNe8TIHgmfMwjcp5c8MIL1f5Cy2R1no+gsa8Ueb0gIrJtRDtK51hBsA3Q8vMahUigGu
         cYbp49iacZ0wekkZ8kBRKwWi2ZPaLmL1MSg4SiijrvKAHkqYdxWtJ9ed6T1aaRSMz2vQ
         n/iLRAfQJKIaw8cWmaP7duCI7qwwztr9FlMblEIEg8eXFwZ8L+iFcnwmi6UDMWX1Ooxm
         pHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ids2P9zdNRZ0i8dcrt76jILnjHIJTXIWEZONpz4utdg=;
        b=nesmY3Cv7/XaStdHf97Mtz4DmfuWvH1X07cmzGhlAgYIWFWCVTux9S+8gLHu4ps+kO
         gr9+7oiJb56OFGxS831f+JACB0zURhpgdh0x12+R12D5XJrX3lbGjWORy4238WSSgzHT
         IJk07AJHu/C3/KDLyDS57IbcYe7RP69MigIJRcrqFjg01rSVjzCCEKCrSmIaaE9KRMcz
         aGG0tw2mXmzjuythnt5eqr7fimvC3OmxT/qoNz+5dpzvfCxouN4Kd0tOp0HUdMPMYC4b
         WmV8qiMOXvvjlDnvsliSWQDJ9JbP/TkfHF8KrdODEER4QDLH+ioC/DzyrPXL6Kgb9xEF
         CTVw==
X-Gm-Message-State: AOAM5338A2kApGPQH9Kb/NLrWE8BKHxtv7mh6qavj55TV+bTmLM65TWL
        LZWUImQd5+Xk02LsMqJXL+3g24zaotdfY7MnhEeZ5w==
X-Google-Smtp-Source: ABdhPJwo2QNY3IDvE9KFTcTr268nBBKnNiLEJJMMR1jfg1SUwEVAWR8tYNcUicd7x2P6m3dZ70a9gDetUAJ/mLXhIIU=
X-Received: by 2002:a25:8011:: with SMTP id m17mr26212682ybk.284.1643589146392;
 Sun, 30 Jan 2022 16:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20220129204004.1009571-1-clabbe@baylibre.com> <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
 <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
In-Reply-To: <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 01:32:15 +0100
Message-ID: <CACRpkdbJ2c0X4Oh8-Daw9O4Qk3ZWJQSkN171Ox7K9DnGbVhp3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jan 31, 2022 at 12:56 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 2022/01/30 9:26, Linus Walleij wrote:
> > Thanks for doing this Corentin!
> >
> > On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> >> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> >>
> >> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
> > this patch when he feels it looks good.
>
> What do you mean ? I am doing my best here to maintain ata !

I am referring to the situation before
commit 5ac749a57e0ebb334b1b2c3d28d4d5b1ef85f8ed
I am happy that this is now solved!

Sorry for not being up-to-date.

Yours,
Linus Walleij
