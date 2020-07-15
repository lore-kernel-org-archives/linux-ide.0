Return-Path: <SRS0=C1w+=A2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55660C433E4
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FF0206F4
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o45vpIlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGOWD6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGOWD4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2020 18:03:56 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D6C061755;
        Wed, 15 Jul 2020 15:03:55 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id h190so846213vkh.6;
        Wed, 15 Jul 2020 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI9Mde07pxk4goJz9fnrbNuMJ5Nwi3EajcG9yYLG+m4=;
        b=o45vpIlbigNauT/xzIHQ1p7d1Blxc0cUFIEu5F4vCfolJeRszhwNqo1DLkfIjSxMaB
         yrv7Wj8Jyp6ew+il2xDyqaB0hbB/opH/UCycK6qecxKpDN34G3YDxis5atxFLDOe2QVD
         CZ10+gSLvOmAlqnqlu0qHhQ9iyaHRz+M9zKGLQ84I3BfupbM9gr1slhno5rvZmyUcmUJ
         5WviwD7Rzf6gyPHZVQBcjMChMTjrd59MIUTrkBbk1Y9R6LZyHr/Zabh4h3NYZJ49fR+3
         7Xpelf2nXEC86SuOEBrCp2SFFrUY1BPBGU7T2+OHBLF7fpYly6emsos71DruFRQ4J8Ez
         AqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI9Mde07pxk4goJz9fnrbNuMJ5Nwi3EajcG9yYLG+m4=;
        b=E2wQhijmvt1oLLco2yGvc3T1fZ9/gI3nO6kJ3iT6MpE/sr0b0BUAuKRCa5W7Mx98kb
         I4BiF0XhtKZ8D8EJYisg7cTfZryT5xDy9X1tsgw9yeosXHxm99fYi+CjdzQlU21Q9ZCA
         skONYxfTRFJBMCfy10+lb6FKXfAhzvDPK7vHRyXGU43tXuAt1f6ZiMaJjkHN2OESipuL
         cIjNUp9gcAaTA/em4KRIIjBKzx9jDHk2E1qtpavVv9gFkTydHARAYrivLvO9PsuCTvhG
         C5EIUGSEv7ph2O3o8txujykf0PiM9Wyon0XY74t6SyVHs7IktkJ+0iUiDmcZBgkl7Tw2
         qxAA==
X-Gm-Message-State: AOAM530SvLNXvqpeKEGM7Dann0boEp1Tl0LFwRLfujiRHeZYPckj/HIJ
        7HHcAyUWS8NFSrPFUBYcugaUaxwxCQHYDiSWdA4=
X-Google-Smtp-Source: ABdhPJw/P79FzpGlgS3RQuq3c7IwTh9oXZtHQJTWKgvTacZzW+jF/Ju7r2S4vvudBnzdz44PBQmy8DWIUbWEiN93rLU=
X-Received: by 2002:a1f:eec8:: with SMTP id m191mr999635vkh.47.1594850634903;
 Wed, 15 Jul 2020 15:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
 <yq1blkgo6y0.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1blkgo6y0.fsf@ca-mkp.ca.oracle.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Thu, 16 Jul 2020 07:03:43 +0900
Message-ID: <CAD14+f1BjqmzGXnt_ha04gD-WpSu7spq93hVMDqnoO60MX3zEg@mail.gmail.com>
Subject: Re: [PATCH] ata: Disable queued TRIM for Samsung 860 SSDs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Simon Arlott <simon@octiron.net>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Martin,

On Thu, Jul 16, 2020 at 5:53 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> I really wish we had some more data to work with :(
>
> Lacking a proper heuristic I guess we don't have any choice to disable
> the feature. But that's sad news for the people who currently don't have
> problems since their performance will inevitably suffer.

It seems like the latest 860 EVO's firmware, RVT24B6Q, is fairly recent.
The earliest reference that I could find on Google is this from Jan,
2020: https://smarthdd.com/database/Samsung-SSD-860-EVO-M.2-500GB/RVT24B6Q/
and an Amazon review.

Earlier reports seem to be related to ASMedia's chipsets and NCQ quirks.

AFAIK, no reports were made in 2018.
IIRC the last time we went through this with the 850 series, a bunch
of people reported data corruptions, sometimes even filesystem's
superblock.
Surely, we would have gotten reports of it pretty soon if the drives
were indeed faulty.

Maybe the latest firmware is to blame?

Also, I don't think queued trim is all that crucial to performance
imho, at least in the context of Linux.

In my experience, regular R/W I/Os were still severely blocked when
fstrim is undergoing even with queued trim was in use(which, to my
understanding, is exactly what queued trim tried to resolve in the
first place?). Probably file-system's implementation is at partial
fault too with it sending ERASE commands with too big granularity. I
believe f2fs' default discard_granularity of 4KB is what tries to
mitigate this.

Linux distros are not using the "discard" mount flag by default and
defers to periodic fstrim on idle.
Android has been doing this since 4.3(2013), and doesn't even use SATA.
f2fs avoids this problem entirely by sending ERASE commands only when
the drive is idle.

All in all, I don't think we should pull out hairs trying to figure
out how to do this properly.
I'm yet to be convinced that queued trim solves practical performance issues.

If we can't figure this out quickly, I agree on blacklisting 860s again.

Thanks.
