Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A69CC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1723860F6B
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhITMyF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhITMyE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2021 08:54:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC72C061574
        for <linux-ide@vger.kernel.org>; Mon, 20 Sep 2021 05:52:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so65145019lfu.2
        for <linux-ide@vger.kernel.org>; Mon, 20 Sep 2021 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQ7i2scGcmG9OZhSR8ZJ1VYth2bzV/cPe4QmSweRP9k=;
        b=OezVhePJPTkBqqeJMkbleTtgmKQsVNs8o0qLVeDYNrqY6rbgHix0Vwdxer4NENbaOg
         9aLiuC6Ie8UUCMoaj7Wab22Ph+ZmyoYfy+vhkz67sXupPrnWLRNQg0XyqznPwWmerWIM
         djtQlLy2u7hwMaGtc+VqIADibwKSIurCmYlsLCedk/Xde2Wtqt2CTzp47YwhwwgxjUnQ
         dp/CoeAOs5Ch4YEOF+vEcWro1y2sFw1Y32+dy7XUd31Xb/YFiJou/y5Epq6+O40S0Jep
         XtRuWfHnicphhLr7Q6r26AdwEW7mdMQTMHSLTHfktdGFlSmn+3podChBaDx1x8d97Uk/
         kLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQ7i2scGcmG9OZhSR8ZJ1VYth2bzV/cPe4QmSweRP9k=;
        b=ITqXbY5qAvF2jdvB2KAl0S4RMBfjhGMCzuAcGwSXp0sCb2Qa+o5MUcpovrRvb6HQQH
         HQBrDrydzljfiNyD3J7oU6KDkpaVpPoQTnXYiSCso/gGWYh5kNMEmjUXaPXNEYqCss3j
         CnnRkEHCf6vi45/+txYM5EIT2cNJYcZ8gVavUs2O/jKgsAvuujbrLtAVctcHGO+JKI/7
         JHtKjTgVWsbnFjiOXEDpH9hCpR/NifUn7BO9Gvh+vPfAODnBwxH+3/NjF8007P8D4so0
         tyl1jR3aEmukYJ9S/iKD2CsiR9EFplpvdLxxIGrolWGSwhPmbp2ncYjBuzG6skdWlr+B
         3ZAQ==
X-Gm-Message-State: AOAM533Vk38w8oiJRmZCVl+tLUVIW/QBVjHwy8vuMahRFLJtEeIyv5nd
        fqZ0pQZTSJ2uEFMXasrxkPP4gX40BoJwe8Plt0M=
X-Google-Smtp-Source: ABdhPJxF7TPBPP3qkrH0O/T2bKoDx1GstKrtVx2SX3VDm7/L/F2C4u4LT6WPmctDw41Y+4ac4WP4rmjx3SsuPtCl4sc=
X-Received: by 2002:a2e:5815:: with SMTP id m21mr14891308ljb.95.1632142356294;
 Mon, 20 Sep 2021 05:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <d9aa4052-f3d1-6595-65d5-0b0bfc489047@omprussia.ru> <CAOMZO5DM5dpqtO2_kg+n0xi2eBoURH+OSDdUfHwocE_jKpw47w@mail.gmail.com>
 <f6e3bb64-4715-01b1-5149-745507ffa7d4@omp.ru> <CAOMZO5A3NiOOg8Zv1+mXh_VixuQ3=KLFPG-7CphQt-S997XV5A@mail.gmail.com>
In-Reply-To: <CAOMZO5A3NiOOg8Zv1+mXh_VixuQ3=KLFPG-7CphQt-S997XV5A@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Sep 2021 09:52:25 -0300
Message-ID: <CAOMZO5DprWvEzsWR5nXX1NHebA4Ro3oYr-8GprPHrsBqOTzroA@mail.gmail.com>
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

On Mon, Sep 20, 2021 at 9:45 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sergey,
>
> On Sat, Sep 18, 2021 at 5:49 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> > > IMHO the current code is correct as-is.
> >
> >    Not quite... I don't want to leave a bad example for the future driver authors. What should
> > I change in the patch description for the patch to become acceptable for you?
>
> Please see how the PCI subsystem has converted the handling of
> platform_get_irq():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc2&id=0584bff09629666eea97c7ac428e55b00df211f5
>
> Why does drivers/ata/ need to handle platform_get_irq() differently?
>
> I still don't see the need for changing drivers/ata/pata_imx.c in this aspect.

Also, please check this commit too:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc2&id=a85a6c86c25be2d2a5f9c31491f612ce0edc7869
