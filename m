Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F8EB64DD
	for <linux-ide@archiver.kernel.org>; Sun,  6 Aug 2023 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjHFC02 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Aug 2023 22:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFC01 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Aug 2023 22:26:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77C1FEB
        for <linux-ide@vger.kernel.org>; Sat,  5 Aug 2023 19:26:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so4269218a12.0
        for <linux-ide@vger.kernel.org>; Sat, 05 Aug 2023 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691288784; x=1691893584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Krzj2pWw9PZcYdBsa8yT8L9y4x2jm40P25UZN01dDtk=;
        b=MrtgTC2u7Cr1p0ZS3Poh7H0vvBc3n/mvs6HrGTf82vAHrMY2PlgTq6XJ0xGZUBGKzU
         Yuy+OkROQkoatpjN6lt5lIrsL7xdNnIFIAS/Mli2Sn6GM07R+gwRq1VI+V7Psg8HD/M+
         ID+dYPgkNE0upMnR2hphWBGlkkIavLvHHIykk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691288784; x=1691893584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krzj2pWw9PZcYdBsa8yT8L9y4x2jm40P25UZN01dDtk=;
        b=RhoP57lU/lhoV5GKkf4Tz/3gY7dfLBoc7OtlLCqfMZCSl3z9OfFdfGiqwfgzHwPUGV
         cxq6a7CAbbEMOhujsArTr1xqd30S9Z5MUAl7xDe5Hm98lTDQw9RDBYRT9zq1Zc5DZ0V1
         cZVJijM+E+UGv8Lw9QaelUkvmtmb7V+qPNYvZstCnQ+H4/wVgRQJhdoeRzxkS/h/uhUj
         ahQO64AfreTIFgvltM2N0nTExfsYO6kdz10bNqAfjYHoD9rXSTmc1p5If50z3Vlyd6O0
         7vyfIg5IASpnJ8VS7VzR3oK1gbSm74jcKwO1wWqaT/vOL8B7yuyXOZB8lgZVlACRRRGT
         ASKQ==
X-Gm-Message-State: AOJu0YzCRzfGLZse5bedRyDCnFPuboAcZaz4qgayNsBg5RzgEIxqHdFx
        9pAdpjZuryl0guADzD9QXgRdZONop/B2j4wZ7GEX62Rb
X-Google-Smtp-Source: AGHT+IGoQ4dVPS6eM3/Qe1ZqYk0ooq2HxVJZaiFHyEH5V7KjDbrmh0hvXcEbhELGdWgd9VPo70i9tA==
X-Received: by 2002:aa7:c50b:0:b0:523:35df:af89 with SMTP id o11-20020aa7c50b000000b0052335dfaf89mr287811edq.15.1691288784117;
        Sat, 05 Aug 2023 19:26:24 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id b20-20020a056402139400b00522d53bff56sm3264714edv.65.2023.08.05.19.26.23
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 19:26:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-522c9d388d2so4239633a12.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Aug 2023 19:26:23 -0700 (PDT)
X-Received: by 2002:aa7:c0d5:0:b0:521:d770:4753 with SMTP id
 j21-20020aa7c0d5000000b00521d7704753mr4641968edp.13.1691288782839; Sat, 05
 Aug 2023 19:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230806012901.250817-1-dlemoal@kernel.org>
In-Reply-To: <20230806012901.250817-1-dlemoal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Aug 2023 19:26:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
Message-ID: <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.5-rc5
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 5 Aug 2023 at 18:29, Damien Le Moal <dlemoal@kernel.org> wrote:
>
>  - Prevent the scsi disk driver from issuing a START STOP UNIT command
>    for ATA devices during system resume as this causes various issues
>    reported by multiple users.

Honestly, this seems pretty broken.

I mean, there are literally just three things that manage_start_stop
does, and you just disabled one of those cases.

And it's quite illogical, since one of the two remaining cases is for
the suspend side (the final one is shutdown).

The deeper issue seems to be that ATA is just doing something that
other SCSI devices aren't doing (the whole set
'sdev->manage_start_stop' thing), and while there is one other user in
the sbp2 firewire code, clearly the SCSI people don't really care for
this bit, and the SCSI changes then cause problems.

I agree that the new "don't ask sd.c to send a start command" is the
right thing to do, but I feel it was done in a particularly ugly and
illogical manner.

I think it would have been better if maybe the approach would have been to

 (a) split manage_start_stop into three bits for the three actual
cases it deals with: (stop_on_suspend, stop_on_shutdown,
start_on_resume).

 (b) then not set the "start_on_resume" bit

instead of the current crazy model of first saying "please manage
start/stop for me" and then following up with "oh, but don't do it for
this case".

See what I'm saying? Don't mix "please do X, but don't do subset Y"
bits. It's a completely messy thing and makes it really hard to figure
out what you actually want for no good reason.

I've pulled this, but it really smells like a maintenance disaster to
me. Particularly since the SCSI people really don't care about ATA
anyway.

               Linus
