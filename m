Return-Path: <SRS0=sCUz=ZK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5201C432C3
	for <linux-ide@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1B220748
	for <linux-ide@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKRJU7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:20:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45362 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJU6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Nov 2019 04:20:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id r24so13869706otk.12;
        Mon, 18 Nov 2019 01:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtAKsWPBlYnhv+xK55aiSn/N1rFNErdKd7pO8efpmpA=;
        b=iAF5HFsv9JXdeRg/Q9QbPlWoozmK3MVflMSwxhqq/LacsKgKwgYhABDyWs2hQHl166
         ah/mX9FrlWTJ3LvSIS7vpZUlyChbOMVV9fm5wRTqqdBwV+t2eOCh6cRTiUm8ERaZPxcI
         T2xlYE3pJYi4+0W92PQ9ndrXezOUNqPXR8uMemHuAnQWMtm/piw3XENPfgZ2Z4uuSiGm
         Kpmqw905Idp7q6L4OtxPZw+tnPNyHmhsTQzcNImxdA/NI1cv/8PqRYLZzdbIND9M//c1
         nwbdlC8J91JPFOZiLPc8TCVZwDlUjv8bqAfaGTKz3dke5bypIDsdRPw9GOdAOZTcIsRc
         uvMQ==
X-Gm-Message-State: APjAAAV6fOpgOxt4kOPOxpm73GzLKdiuZMx6oIskMh2ErQ9oSM0IbYLN
        pwfmy+3O+/XKs+mwrfz1jeBYFbaNJsUCqlzNF9wTwD6O
X-Google-Smtp-Source: APXvYqyvWtR9apLRYit6Bnvfc+ieSGeODh9jXLMv+77Lpop91UHEppp5TOf9eieGeZgEG2xUWfn0n3eejy/S7qG4/9Q=
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr21120807otj.250.1574068857754;
 Mon, 18 Nov 2019 01:20:57 -0800 (PST)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com> <1573008449-8226-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1573008449-8226-1-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Nov 2019 10:20:46 +0100
Message-ID: <CAMuHMdU0QvQELB27tZ4LG-X5sAGD1aAoqRHQ310PYO9FCDnUUw@mail.gmail.com>
Subject: Re: [PATCH v3] m68k/atari: convert legacy Falcon IDE driver to
 platform driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-ide@vger.kernel.org,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Nov 6, 2019 at 3:47 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Autoloading of Falcon IDE driver modules requires converting these
> drivers to platform drivers.
>
> Add platform device for Falcon IDE interface in Atari platform setup
> code. Use this in the pata_falcon driver in place of the simple
> platform device set up on the fly.
>
> Convert falconide driver to use the same platform device that is used
> by pata_falcon also. (With the introduction of a platform device for
> the Atari Falcon IDE interface, the old Falcon IDE driver no longer
> loads (resource already claimed by the platform device)).
>
> Tested (as built-in driver) on my Atari Falcon.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied as "m68k/atari: Convert Falcon IDE drivers to platform
drivers", and queued for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
