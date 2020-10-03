Return-Path: <SRS0=uTHP=DK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A264FC4727E
	for <linux-ide@archiver.kernel.org>; Sat,  3 Oct 2020 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6768320738
	for <linux-ide@archiver.kernel.org>; Sat,  3 Oct 2020 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601752510;
	bh=IVlwNptL1F7Lo+dBbkxM2rDH6zbhyDsY0nEC6TgBSSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ofoPsRvG0X0RhzP0ZmmPc+EwWUq7pUUfhGVFtT866kcjC+fT5y23LGs6drfaqB3Ts
	 fR0iD0RO24u7uY6sOfS0pSKq1Y9EsY6EIK+uwn5Z6ngIBq1c3qvPBpsNZUikLsfa4o
	 t5juu3Cs+z5n3ksMRs/xeIosdyQGJGYG/EXBiCE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJCTPI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJCTPH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 3 Oct 2020 15:15:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB4C0613D0
        for <linux-ide@vger.kernel.org>; Sat,  3 Oct 2020 12:15:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so7185870qkj.7
        for <linux-ide@vger.kernel.org>; Sat, 03 Oct 2020 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XDd6ahIT6gLYMAruH7ju3Kkp37FW6zZiiBzXKCROhVM=;
        b=BSsJMiNovC7ylJtGVK8Pu6lbRNONMCIf6IKbC00u5s1boHBtCnTHfJa/Q5VQbBE7QD
         V4bS1NjUh5BbbOIsGpNZvopY7M6czs5rDiFGIqVWOTcL/cuAcI2C4+QBDfXFlYfMA/pD
         daW0tThIPF0WuvSn4othGKNjDJ5j6h9bkvbes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XDd6ahIT6gLYMAruH7ju3Kkp37FW6zZiiBzXKCROhVM=;
        b=OqjlpJAJsuPYyOxxW8mt3dCQdv9M9iyj09wsMGJSyPnn+zABCkmgLABqbN5JGyDUfC
         Db7Tz23evtaBk6IR3UyXqeKglIw8qChoX+WmJpc2bazjYePCZseHVJkOCFG3cx/EIHGV
         B4gpFDGhPITC8CtFxIrPlj2If/0jeW6RBJXSxaF7O32emm5n31jCarLoOAcRTJSfU9Bj
         GSj3hvFK/z2kQU+agZ3Z4SWURo9Xy9ymgF8EUnHb1TJbsaQgLs2Cjl6uE6xls5zyPBCt
         jADSHebs+auva5DbSVGzM0S2nkovNlySB7FY37RQq8PKZX3MHO3y9kF+TYtIinpXlj6r
         Z8xw==
X-Gm-Message-State: AOAM533I6WeE1SCI7nJzzaTcDTGMhXMU8MGbZB10UllYU4wDmRy3SLlm
        WrWACXHb2ANKNFbiXZTPHrCJ+g==
X-Google-Smtp-Source: ABdhPJyMY8qIL4KEm7vcRUWiReW42vytsh13A1Usl//XvmLKcZ1mWKVKCTveyFrYEAH8SB+YYGag4g==
X-Received: by 2002:a37:7844:: with SMTP id t65mr7450404qkc.136.1601752505009;
        Sat, 03 Oct 2020 12:15:05 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k22sm3882799qkk.13.2020.10.03.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 12:15:04 -0700 (PDT)
Date:   Sat, 3 Oct 2020 15:15:01 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Mark Brown <broonie@kernel.org>, tools@linux.kernel.org,
        linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-acpi@vger.kernel.org, David Lechner <david@lechnology.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        openipmi-developer@lists.sourceforge.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
Message-ID: <20201003191501.o56tqq63d2buq5ox@chatter.i7.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Mark Brown <broonie@kernel.org>, tools@linux.kernel.org,
        linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>, linux-acpi@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        openipmi-developer@lists.sourceforge.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
 <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
 <20200929113745.GB4799@sirena.org.uk>
 <db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
 <20201001110150.GA6715@sirena.org.uk>
 <f44d19ad596f261c0287c9ab18c45161003efb43.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f44d19ad596f261c0287c9ab18c45161003efb43.camel@perches.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Oct 03, 2020 at 11:40:48AM -0700, Joe Perches wrote:
> (Adding tools and Konstantin Ryabitsev)
> 
> There seems to be some mismatch between b4's use of the
> cover letter to a patch series and what maintainers that
> apply a subset of the patches in the patch series.
> 
> The merge description shows the entire patch series as
> applied, but the actual merge is only a subset of the
> series.
> 
> Can this be improved in b4?

So, the following logic should be applied:

- if the entire series was applied, reply to 0/n
- if a subset only is applied, reply to each n/n of the patch that was 
  cherry-picked out of the series

Is that an accurate summary?

-K
