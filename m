Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9BFC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA38961040
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 12:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhITMqo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhITMqn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2021 08:46:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A16C061574
        for <linux-ide@vger.kernel.org>; Mon, 20 Sep 2021 05:45:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so41018338lfu.13
        for <linux-ide@vger.kernel.org>; Mon, 20 Sep 2021 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwUX+Uyred0HTEGQWL9JhHRlrkwmUhERwhYxYKonkhk=;
        b=WmFcxwGgg4zy6KAkKfyGkYMonCTzwSi8SXcAnewI68odgEIUiGV+vJwYS7wBfPLXBq
         rXTiXgL51e3EAbw7chGUMqNa9iyR2fEQ1v8Q0AHi1r+Xb0qa0JP+LWrgjkva7vUbLmuD
         6XngXmiLcaqx4BVbSzlc3idGBn949tbt/+kapaUibR8tTSpS/BwgeEYhrVtBCIry94+g
         uJN2bDk4LvvgLom+wrvMz+RJ6gwgVgKFLzAeDgD7HrKLzbWNnaZLYNGC5NVHzjgodf3b
         91mv5T5iZW+yCmHJCKMw1APy2GqdJDzh9j1yNTndpSXQeiEie1G+m4cgOuU/gWSdEsOk
         W0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwUX+Uyred0HTEGQWL9JhHRlrkwmUhERwhYxYKonkhk=;
        b=A37s2qHh8bW+93O5GBw8tCcqTVKO512yKTFnAlLyeDjNhq5iBMdY8vejeLFH2TRHRc
         vatv2i7oGdQe22xtoV2ekOMWZOmgD+YI4yGIkbAB4H7pnRRhkb0QezSE90y7NK1hul3F
         h39NhwbVVB1pskG4cVEk0EcuC2g5ERjodEDRX3FqiOyNQfrMVN3NEuEFn6VyyYyLfCwA
         oqFF+ybBU3JeUaR0lHW5/3mW+dUIbfafhvBAj9DTSDyNAISHDdb1xwk9ld/sSaT/ddfk
         fkKAZqNhzv87dcP4wdQc0m9izY93bd5dHcOTJ6sj8a67GtUZt4hixJaVv26HO87WF7hb
         eJLw==
X-Gm-Message-State: AOAM532hcpIfbnvsJcbyMvIEVSZUMfoRwhY332sj5AMzR52ULM40m3Jf
        XBgd61anj1mv5cP4FDbwtZl8dkb9JqqOOM0KC6Q=
X-Google-Smtp-Source: ABdhPJxS30HNPGmp2pgNzoPNm4MQjWJVcz7RLd04w/rtRYfkSjXSSXTpVU77p+nJRKUDafJy1fGSPnVRgxe8gFJseN8=
X-Received: by 2002:a2e:a485:: with SMTP id h5mr23739576lji.345.1632141914800;
 Mon, 20 Sep 2021 05:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <d9aa4052-f3d1-6595-65d5-0b0bfc489047@omprussia.ru> <CAOMZO5DM5dpqtO2_kg+n0xi2eBoURH+OSDdUfHwocE_jKpw47w@mail.gmail.com>
 <f6e3bb64-4715-01b1-5149-745507ffa7d4@omp.ru>
In-Reply-To: <f6e3bb64-4715-01b1-5149-745507ffa7d4@omp.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Sep 2021 09:45:03 -0300
Message-ID: <CAOMZO5A3NiOOg8Zv1+mXh_VixuQ3=KLFPG-7CphQt-S997XV5A@mail.gmail.com>
Subject: Re: [PATCH 4/4] pata_imx: deny IRQ0
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Sergey,

On Sat, Sep 18, 2021 at 5:49 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> > IMHO the current code is correct as-is.
>
>    Not quite... I don't want to leave a bad example for the future driver authors. What should
> I change in the patch description for the patch to become acceptable for you?

Please see how the PCI subsystem has converted the handling of
platform_get_irq():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc2&id=0584bff09629666eea97c7ac428e55b00df211f5

Why does drivers/ata/ need to handle platform_get_irq() differently?

I still don't see the need for changing drivers/ata/pata_imx.c in this aspect.
