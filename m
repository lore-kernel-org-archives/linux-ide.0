Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A6FC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jan 2022 07:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiA2HHe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiA2HHd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2022 02:07:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843FC061714
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 23:07:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so23800269ejx.2
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 23:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2Ho8dLumCd4fFnXA+EscLp32NM/bpPpYSbd6knxPwE=;
        b=bGcymcHvryNUyIO4cX68UVaO5+myilq6KtZ30pcO/OFaY3lg06ueq0ye3xyX1PJb0W
         oP7DKC+Al+hU+QUgUQlzuZiF7VPBdHGsfV7qGwcY4c60Vuy0dVXKLAYo6M7SQUiR+2AQ
         V7qfI+QL2kSSNPkdp2dRmhdjp21EW+OK5myoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2Ho8dLumCd4fFnXA+EscLp32NM/bpPpYSbd6knxPwE=;
        b=yVxA26MZYgMZPDYvxc0BWN1ojVHlyQnMSdn++AQDOVYYdbePGzqG67gSJLjYF+f/xe
         5I+Lg4Sy6y52JpwSfEqV4rfL5rvN5IY3c9Ivsvl8vsnwA/OWB3NX40UIqj6nmbZmtxMu
         4rELFKAw4uuAiBv0OPx+DH84LqeUhw1EffrRuLj9ZTYDqSLMyVpWK5fhJuHRakuAtn/U
         lrxhOFva5SakStlalPMOlHQA4WZ6/DHDw70pCcGajvRJWOoDxTqvEM0oq2iLM2DC40hg
         tVS5n6FLH+9adUIgrPXeDhcNnT/6XWjs58aIx8iPrIWcWOYgGut9XbdtBkiBbWz75N82
         9WwA==
X-Gm-Message-State: AOAM531oyUvVNb26gDRMGsbZPtnceF760eopWfwfLi8DcxJYM11pGpZl
        7WRyesXqtps08jHRYrOoJhKEo2aMNZGYXzxE
X-Google-Smtp-Source: ABdhPJwErgaZah1jG1dIU1iIREEADnLNx/+i3ZwhdYx3RzPod9aOzvemSMmhfRX3giH/Ucbbnoa5PQ==
X-Received: by 2002:a17:906:25cb:: with SMTP id n11mr9642618ejb.419.1643440051199;
        Fri, 28 Jan 2022 23:07:31 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id fn3sm10732306ejc.47.2022.01.28.23.07.30
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 23:07:30 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id k18so15022169wrg.11
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 23:07:30 -0800 (PST)
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr9338887wrq.281.1643440050487;
 Fri, 28 Jan 2022 23:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com> <YfTluSca/ye+lmrn@kroah.com>
In-Reply-To: <YfTluSca/ye+lmrn@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Jan 2022 09:07:14 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjAajZDJoqy93DVLQ+ZJQ+w1ScCxsnS-ELdL12kqYM_Gg@mail.gmail.com>
Message-ID: <CAHk-=wjAajZDJoqy93DVLQ+ZJQ+w1ScCxsnS-ELdL12kqYM_Gg@mail.gmail.com>
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jan 29, 2022 at 8:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It's up to you all, if you think the patch is correct, keep it for now.

In the fixed form (ie with Damien's fix for the wrong test polarity),
it's certainly not wrong, and matches a lot of our standard patterns -
including our documentation in

    Documentation/driver-api/driver-model/design-patterns.rst

I did a quick visual grep, and all the cases of
devm_kzalloc(..GFP_KERNEL) I grepped for did indeed have that "if
(!..)" error handling pattern for the return value, including other
cases in the ATA subsystem.

That was very much a "quick visual grep" though, so no guarantees, and
I stopped looking after it was so obvious. IOW, it was just a

   git grep -1 devm_kzalloc.*GFP_KERNEL

and then looking at the output and saying "yup, they all seem to do
that allocation failure test".

At the same time it's certainly also true that a small devm_kzalloc()
using GFP_KERNEL should never actually fail, so the patch - while
looking very correct to me - almost certainly makes no difference in
practice.

So I think the only problem with the patch is the original (fixed)
bug, and the source it came from.

              Linus
