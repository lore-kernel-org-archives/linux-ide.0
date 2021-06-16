Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87EC48BE8
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D2461042
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 21:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhFPVNo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVNn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 17:13:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3CFC061574
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 14:11:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z12so1007413edc.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kazik.de; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xLkZERxRt4v4GXzLzwipaQjjjWRDIAdZv/suj3Yer0=;
        b=JRPsgvv/XQLYxaZpMe0uUUHWhkdu32pyA/OBgkJASwWUTI7LGZuSsj/EeEOlcxUh86
         f9oW3uf8Yyam3H1IR2R6JSm8DBLTTrluwDjn71f1Qpsom7pamCQs9bOz11sWy3N3b1q/
         A6RYwUqLidM0WRqvIYMYpL8GB3udAW5ZfAU3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xLkZERxRt4v4GXzLzwipaQjjjWRDIAdZv/suj3Yer0=;
        b=m9bHfAJbi3154qZbhAuRARVrXUR+EHwgOQbwzbGf5q0dwnqq+Dj1d9rF2N8K/tv3+Y
         V8/H5sqNTaWndBgFuKkPybJLo/hvp9KzusudjhkQCHOqXYEI6Y0NT3npNBLAC5QJmrvD
         yd/ZTLdyDw6FBTk+FS6lZ44nk3JhXLIRtY09MGqkkwpPaNTOKCO+vAeMAraeKr5NajvH
         af3iZqgB7/B8Uz4ucK2aXRKTGpl9kLoAnAtqFj3Eyf6a6i373HbyKPufnqOPOwJN5JET
         SOu+rHv0KdOJ/7T3v0pCEUzrTNdBPBRbO+4JDey9ccTJmSLM6rbrJBFgaH3VQ1IKTBJF
         F6Aw==
X-Gm-Message-State: AOAM533c4SOJfI7S9rCSYH9Wl95accZh5hHVnCCeXYW6uOQdYZIxcuXs
        /KNsSUsqMmOFHkzKvB62+5f6cr0O3iGLKxk+qdoQQQ==
X-Google-Smtp-Source: ABdhPJxEip3zVVu8KtoWRaaE7nEAhYe99Sx6rXXsL1C9hrdZ9cY3gxng+KpretTC1dRxXN6scmr4Wtkd/WlsDUoEzkg=
X-Received: by 2002:a05:6402:5256:: with SMTP id t22mr2167872edd.54.1623877895573;
 Wed, 16 Jun 2021 14:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com> <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
From:   ALeX Kazik <alex@kazik.de>
Date:   Wed, 16 Jun 2021 23:11:24 +0200
Message-ID: <CAFFuhJpT+2h+4O_q15VjE_77iCQaxwLJC11siSFrr5GbjQ-pFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add APNE PCMCIA 100 Mbit support
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

I've tested the patches and they work.

At first I got it only to work with the following line removed/commented out:
  if (apne_100_mbit)
And thus enabling the following line always.

I've changed, with the help of Michael, the parameters to:

  static u32 apne_100_mbit = 0;
  module_param_named(100_mbit, apne_100_mbit, uint, 0644);
  MODULE_PARM_DESC(100_mbit, "Enable 100 Mbit support");

And was able to enable it with the kernel option "apne.100_mbit=1".

It's also available as /sys/module/apne/parameters/100_mbit

The 0644 is the permission (root can change it), If it shouldn't be
changed at runtime 0444 or 0 would be used.

(I think there is also a bool option instead of the uint, but I'm glad
it works like this.)

Alex.
