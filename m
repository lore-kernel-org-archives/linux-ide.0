Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C91C27C47
	for <linux-ide@archiver.kernel.org>; Fri, 27 Oct 2023 23:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJ0Xnf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Oct 2023 19:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJ0Xnf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2023 19:43:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE71BB
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2023 16:43:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so412283666b.2
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2023 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698450211; x=1699055011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrD/T6NHT03FS51n6nd885uHXcqsMw/61/NkpnD0W6s=;
        b=cMSRAuMfJuPYSTMaiGU4cSzGCQWYnxfQZsn2/F3qBqie1cvkpnRFUggQsaS8CzBQum
         rZBTkVZVYMXaHnyUU/b3LyF4gAzoxyqPeWBq5X+kNAvpDtGujg1CzBsnmTt1ipajhi4R
         LZcKvWyJD4TP+7f5SSgEqMeA6FHEL8cpSmG6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698450211; x=1699055011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrD/T6NHT03FS51n6nd885uHXcqsMw/61/NkpnD0W6s=;
        b=jy8Ev9CbC5sC+t4yDLLQn4+MqvORmBJYxIeBfd0LK3MZKCL/VdxxHIQzO60nw9Prdm
         s7qOe+qnOqBWDw1AIIwEykJFiZMI0ukge+50H0SDQrMPRQB+btx2d9qlpZsUX7hDH/pF
         ns+t8/gE7vyAcdciQ6oSYXYLT/xsBPifSspsuQhGY0HvKo86aAQe+TZ8x/l+qS+8OYgU
         jhB3Fc/iJulOHyu0itkL78uIKZAoJCv59aAOKapiH66F6IQBqz5JdGoGYNCugpFFU5Jr
         SB8uH5XJQHOcovL/tTpRNo3IuWxamVSok0CwV+Xx8Y4PXFdNB/u/Fr+Z2EMHdnLcqqkc
         nBOg==
X-Gm-Message-State: AOJu0Yy3ZpH5BV//THODk6hxJkbvRG2b+y56D1nEP7xTJ5pf3Lf0ipsO
        NvRjtwlBM4Dj9yocz6eBi36396SsRHn/PfZoYcFLGQ==
X-Google-Smtp-Source: AGHT+IHqcpafRIoKvhp3yULNw8X8nbEcXiDAx766sc/Gp4GK9sUlcNavw2PadTOAfZnwhcAeQeKShQ==
X-Received: by 2002:a17:907:36c5:b0:9c7:5200:e4f4 with SMTP id bj5-20020a17090736c500b009c75200e4f4mr3381882ejc.41.1698450210794;
        Fri, 27 Oct 2023 16:43:30 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id lz23-20020a170906fb1700b009a5f1d1564dsm1855255ejb.126.2023.10.27.16.43.30
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:43:30 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so4066051a12.2
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2023 16:43:30 -0700 (PDT)
X-Received: by 2002:a05:6402:350:b0:53e:1825:be81 with SMTP id
 r16-20020a056402035000b0053e1825be81mr2962334edw.21.1698450209933; Fri, 27
 Oct 2023 16:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231027073115.170201-1-dlemoal@kernel.org>
In-Reply-To: <20231027073115.170201-1-dlemoal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Oct 2023 13:43:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wha0w0mOQ9w1OnPcadJK5anM5dM5kanDm3hFRqCu7QaFw@mail.gmail.com>
Message-ID: <CAHk-=wha0w0mOQ9w1OnPcadJK5anM5dM5kanDm3hFRqCu7QaFw@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.6-final
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 26 Oct 2023 at 21:31, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> A single patch to fix a regression introduced by the recent
> suspend/resume fixes. The regression is that ATA disks are not stopped
> on system shutdown, which is not recommended and increases the disks
> SMART counters for unclean power off events. This patch fixes this by
> refining the recent rework of the scsi device manage_xxx flags.

Side note: I think 'bool' ends up always using a whole byte in 'struct
scsi_device' (because you can't take an address of a single bit).

And while it might all end up being unnoticeable due to padding, those
bools are right next to bitfields.

Which just makes me go "those should all have been just 'unsigned:1' fields".

Of course, maybe they actually have their address taken, and it's all
very intentional.

              Linus
