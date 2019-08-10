Return-Path: <SRS0=D4f6=WG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD595C41514
	for <linux-ide@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D18208C3
	for <linux-ide@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHJG7q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:59:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34010 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJG7q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 10 Aug 2019 02:59:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so141361086otk.1;
        Fri, 09 Aug 2019 23:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fp4hsWr8syuRKTwFPCpF0dTJtEb/wet/DLA0Rph5N4=;
        b=ImkDGR7dnfMHrXL1ARALnlFXB3jWIqQGxKxKRVzCJIq2lG9ePvdbaFllxcOANL/B83
         5S7DBpX3UE9SjTAdtG57y+Qjn2vT3fEPCKXiNlU9bMAt6C8cvsyRJORBlcBTLI3Wj9R/
         bGZNiwICKX7olJe6/5qPmAIDhTdvOr+FuQi27PY64p9mbcHh5yQZr4r23yLcBEx4jsk2
         5fHLL0LP+T6ZJORqztOqvbbDCNeIFgWF9MpQBB8HVGHHfKamV8l8dLpQMC153MmrI/QJ
         X/1W17RSTFlprer6gEgV6Vbx/tG3b2H24YHcDqsOEbNfdNp7KE922YJ052gBrX/tFcsI
         ildQ==
X-Gm-Message-State: APjAAAXD+LYGj0VExNFrnfEOdZ05AC7Nlcb80VqXlY2kfhs7Kd7OD1Pb
        LjwIaTKL3ej1H/C//7UXhtHm+/yvE2DMnmOd3w8=
X-Google-Smtp-Source: APXvYqwZqivSCVKiTybKuSYyqKw6SGkvI+q08qTetYUm3KXeOaa7QsJmq0t7hdRAs1gLZOSXjjl1xzJ2MUduMbuklWw=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr8786344otk.145.1565420385727;
 Fri, 09 Aug 2019 23:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190809215131.877-1-horms+renesas@verge.net.au>
In-Reply-To: <20190809215131.877-1-horms+renesas@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 10 Aug 2019 08:59:34 +0200
Message-ID: <CAMuHMdVi4LK-v_MbeM1T6OO3A7CtGZ3FcR55PcVdgB8rh6oA2Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: sata_rcar: Rename bindings
 documentation file
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Aug 9, 2019 at 11:52 PM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Rename the bindings documentation file for Renesas SATA controller
> from sata_rcar.txt to renesas,rcar-sata.txt
>
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
