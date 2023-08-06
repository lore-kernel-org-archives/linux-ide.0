Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6EEB64DD
	for <linux-ide@archiver.kernel.org>; Sun,  6 Aug 2023 02:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHFCzu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Aug 2023 22:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHFCzt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Aug 2023 22:55:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E6130
        for <linux-ide@vger.kernel.org>; Sat,  5 Aug 2023 19:55:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso4588555a12.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Aug 2023 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691290546; x=1691895346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJZMDTGTfD9nGe6xDLgICYFfqzyDS4Q+NODuPfnfQFw=;
        b=JA7OZsvbVYXuL/KvZ5FuFGiPFz0SPNSOmCYGvXU6a+D9CTWHH1biP4lGY0t/6DKxMB
         IvNeNf1uKy7EcprMPPiegTluzmgr3t5Ek1tRJFpkM3qlGBHm21isS1wULTCezW8UrF34
         R73dU+YI8k4pIuDlsxqNq8Hg5jBXV+X8jLFfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691290546; x=1691895346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJZMDTGTfD9nGe6xDLgICYFfqzyDS4Q+NODuPfnfQFw=;
        b=hxdIDwjTqM+7Bx18xpr0X4h81wWzd/7AaHKesgzt993/wXDDp12DzLwZlCW61W9QOu
         LJu0jKrzteJFlkHT4E3NTdfx0KepY4Iu6/PP68g9IKOdyZEnjUxocsxeKwG6e+3usRJg
         QIkqg89wYkR0mmGDOIkluwdPvlrVyUhJFPytsR3/a5myl0anhoJOcorYWOtYpD+0UmPA
         Ov+ezKSqzAdoga7upeX7M3JylkmG/R9rFMOFbO5CQqo+hxX3f4NM+eIDC4nrxL357Yy7
         bRL4fhrOkJX2T7L+g0JQ32QX8s5FhfCfK2JgQkjmu7AiHYp67fyJVUxY82nxNV2kAsGA
         39aw==
X-Gm-Message-State: AOJu0YxcHVvDdsib4uTQCcuyl3JgBfYAVrAT9g3yYpid1RzT8dAN/dks
        xcdfdWUOtv4OSw3VkqZoi3Qi7T9LYlwCt9yvCUd7z+HZ
X-Google-Smtp-Source: AGHT+IEyBFyq84DjlRiHQdIlYiJTs0Q+zIIg9IkEZKvUOVEDVKi3DuQyjhNjaD4eDx9H69fwOejSXg==
X-Received: by 2002:a17:907:1dc3:b0:98d:63c5:d147 with SMTP id og3-20020a1709071dc300b0098d63c5d147mr5096156ejc.47.1691290546454;
        Sat, 05 Aug 2023 19:55:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b0099bc5e5742asm3401800ejg.70.2023.08.05.19.55.45
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 19:55:45 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso4588535a12.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Aug 2023 19:55:45 -0700 (PDT)
X-Received: by 2002:a05:6402:413:b0:522:57d9:6553 with SMTP id
 q19-20020a056402041300b0052257d96553mr5953101edv.1.1691290545417; Sat, 05 Aug
 2023 19:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230806012901.250817-1-dlemoal@kernel.org> <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjkDNZeE1ounYLv-BDy9Y-Wz6H=nbe4itqqrpsdeHSSHQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Aug 2023 19:55:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9cRUcAY1b-NvjVwysGadMPJ2W+UiTzXxzEKk==WdHxg@mail.gmail.com>
Message-ID: <CAHk-=wi9cRUcAY1b-NvjVwysGadMPJ2W+UiTzXxzEKk==WdHxg@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.5-rc5
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 5 Aug 2023 at 19:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (a) split manage_start_stop into three bits for the three actual
> cases it deals with: (stop_on_suspend, stop_on_shutdown,
> start_on_resume).
>
>  (b) then not set the "start_on_resume" bit

Side note: the ATA layer already has

 - ATA_FLAG_NO_POWEROFF_SPINDOWN

which seems to basically be very close to "don't send stop on shutdown"

And in fact, it looks like

 - ATA_FLAG_NO_HIBERNATE_SPINDOWN

is in turn very close to "don't send stop on suspend". So if that
manage_start_stop had been just split into those three actions, it
sounds like those ATA_FLAG flags we have would basically have
translated to setting those bits too.

And the whole "start" seems to be translated to "ATA_CMD_VERIFY for
the first sector", which would seem to be literally just a random
command intentionally chosen to not return any actual data.

The *only* effect of doing that 'start' is to cause extra disk IO
early that is then ignored. Logically it doesn't actually do anything
useful, and it would seem like it might actually be an actively bad
thing (ie spinning up a disk on a laptop for potentially no actual
good reason, and waiting for this all to happen).

End result: it really smells like ATA fundamentally doesn't want the
whole 'manage_start_stop' noise AT ALL.

You just removed the nasty early start with that 'no_start_on_resume'
bit, and the spindown seems to be questionable on at least some
machines too.

So I wonder: did somebody test just removing the setting of that flag entirely?

I guess ATA is legacy enough these days that people want to make
minimal changes, although that 'no_start_on_resume' really doesn't
smell all that much more minimal to me than not sending spindown
commands.

        Linus
