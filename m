Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D725AC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 14 Jan 2022 13:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiANNzM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 08:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiANNzM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 08:55:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C3C061574
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 05:55:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c71so35255594edf.6
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcEwauH45+rhC/MbgC+4dlTLC3087h+2leLmqCoIr/4=;
        b=hjLSxKkQyyF30FWYahgCPlpuIr3TU6MvCOfa7/LXP9/JMo5bC5316pLWpVJndU/4Xi
         yebtO6RVDBdMX7OgKB2tk0AjXRPhxrmEEGBAdqhZRCPeMjllObb4jtkJlXFUqfCskY7F
         KiD76oc/prWAFGgTY1/qsFdjOsoJj0uBDOKtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcEwauH45+rhC/MbgC+4dlTLC3087h+2leLmqCoIr/4=;
        b=gP3qIh7Q57Zvb70cTmRMhD2R4i1ToMxMKSAKsOan4hT6zgRZcIXFtEnadbR0U9Efsk
         hHKWybzhTfbpVdX47Qvmh2O8lgI9XgGSWETJxX6yCIKcp1sf1/xv6H/4dc2Yr4iUIxJa
         wfu7gdoT01eiLB1QQycNUGNoE4plJrGUe9Z8baGKSYaGBaCC/rOgNFUAaraLDd+ZmStn
         wsIvXz4qsmL872P43JZUcNlXaMWAvLhluDdVmpb424arri64t8xRaQqe2yNJDge7zpkl
         0b5W2NoYmrdkXws97LcH4wgF7tQcFw+c/SrHXssjwmlyGkwbF06X6aWVHGmtt3V9MwR6
         nWRQ==
X-Gm-Message-State: AOAM530dO+TluVbPth9j2v/YTl3XbFvF5wM7Ansg18UC+tHHi34k90N9
        IwClG+1iEzK298V+s/cf+Y5T9hsPtmNBumhB
X-Google-Smtp-Source: ABdhPJwAkG3iBOjPyh592lxfknMf2m7TUjOW5fh7c31e9ME+THyvE3/BFxk2GJpkbz56V6gXbSTaTw==
X-Received: by 2002:a17:907:6290:: with SMTP id nd16mr7162256ejc.244.1642168509663;
        Fri, 14 Jan 2022 05:55:09 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id f20sm1852760ejf.162.2022.01.14.05.55.08
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 05:55:08 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so3483122wms.0
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 05:55:08 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr15575509wmq.152.1642168508614;
 Fri, 14 Jan 2022 05:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jan 2022 14:54:52 +0100
X-Gmail-Original-Message-ID: <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
Message-ID: <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jan 14, 2022 at 7:59 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> ATA changes for 5.17-rc1

A number of these commits are not in linux-next. Why?

It looks like you have rebased things very recently (and looks like
you did it a week ago too). Or maybe some patch-queue system, or
whatever. Why? If it hasn't been in linux-next, you should explain
what's up.

As it is, I'm traveling, and I'm just throwing this away because I
don't want things that haven't seen the build testing that linux-next
does, since on my laptop I cannot do as much build testing as I
normally do.

                    Linus
