Return-Path: <SRS0=h62M=YT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D1AC47E49
	for <linux-ide@archiver.kernel.org>; Sat, 26 Oct 2019 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D2E21655
	for <linux-ide@archiver.kernel.org>; Sat, 26 Oct 2019 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJZSRo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:17:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42077 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfJZSRo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Oct 2019 14:17:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id i185so3655929oif.9;
        Sat, 26 Oct 2019 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEdAFZBZ5NUS+Fh7ssVzDmGSUoLPSmlnubte9uHFVAc=;
        b=RcKHU3S0MaE7nQMW8inYfAopovvwZ50iKsGU+HXsKHNzTqpEnHr0cZU0kVRaZZ07+p
         mgpUcCNDnOm3tNo1cC/nTdFRbjDjj5Z6RTZdSfZsbJ9eIQGAGQx8S7D3AXeoUnupGl9N
         WfVrwrLy5JUcvUlTt214UnWSxMYkw5SDH0uK7AM32VMppjaE8TCvgLWx/iZO3AltFf6k
         fVQbUmS2MNOktjZJGrVK8DdWxIS28Q77RXewDXlqiBJ+uG7Ik4k4TcKvB2L5UQ+fhlX3
         V6p7sNEByqiCuEciruhwAZYNS8tyYwnp7IMWvzeQY4PNDxL2iu0ydOgtHkjXOw3DtmSQ
         BVyg==
X-Gm-Message-State: APjAAAXCrYU51s28DAOdkdmdttlB2Vexfm6opwviacrW/ZXR89pJCTS5
        wd7D3ZS1onA2dqwFxywiv+N5BQzWR8Q3cyij1Hc=
X-Google-Smtp-Source: APXvYqyR4U7mhyMxGgIjP7SyS9+jPq8Fvs6iNNQ4OXbCJQb4LVsJcddLjDglds+YJFYrZ+Y77Cola0gRxO5ZKq6d6mU=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr7672689oie.131.1572113862818;
 Sat, 26 Oct 2019 11:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com> <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
In-Reply-To: <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 26 Oct 2019 20:17:31 +0200
Message-ID: <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform device
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Oct 25, 2019 at 10:33 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 9/25/19 9:54 PM, Michael Schmitz wrote:
> > [Resend because linux-m68k was dropped from the recipient list ...]
> >
> > As suggested by Geert, at least one of the drivers available for the Falcon
> > IDE interface should be converted to a platform device driver (to enable
> > module autoloading by the Debian installer).
> >
> > Add platform device for Falcon IDE (patch 1), and rewrite the present
> > libata driver to make use of that device (patch 2).
> >
> > Changes from v1:
> >
> > Incorporated review comments by Geert; corrected silly mismatch between
> > platform device name and platform driver name that caused loading driver
> > to fail locating the related resource; check return code of platform device
> > register call.
> >
> > Tested on ARAnyM with only the pata_falcon driver builtin.
>
> Who's going to pick this one up? I can do it, but it'd be nice to have
> m68k on patch 1 first.

Sorry for the late reply.  I'll have a closer look after ELC-E, and will apply
to the m68k tree if it passes.

BTW, I believe v1 of both patches has been acked by Bartlomiej?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
