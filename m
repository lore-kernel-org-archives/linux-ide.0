Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0192CEB64D7
	for <linux-ide@archiver.kernel.org>; Sun, 18 Jun 2023 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjFRQzM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 18 Jun 2023 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFRQzK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jun 2023 12:55:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550CE71
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 09:55:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5187aa18410so2782591a12.0
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687107303; x=1689699303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GhurBNTJAuTY8NoGxhLi2KlPXGGnP481hrRLm4bjVfE=;
        b=JA9TzTgxW+Kq/ELHQeTtPzlWX9z293UiXDWOJWvtae9uPSiPR/WGxGAyA4Lti6J+nQ
         CALFT1M8yuo9vLvXFURNXZFI2WiFtvNthgCtwU7u2LEdWTNInhEOFMh834ipd+kJ7dah
         1UfAGGJCMMMM2YdPEGG+FmqhZtrqd9VD4XPfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687107303; x=1689699303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhurBNTJAuTY8NoGxhLi2KlPXGGnP481hrRLm4bjVfE=;
        b=YafiicdJJkuqq9/+FjJ4VhaaADBXGo4O7j4o9jx8IUoZIU4657JY7RGeNLgy/2Tn8k
         Chxxq1peKvbkmqm2UuHHNth8XqQCIlX1JeZBjfgSqY/w/ivboH49gzqrNYZqacZSJFpU
         b16VLarTQAuk9xUifPFD4qzS7BiO1C4xcBdNo44/GYbtOmbqQKlg7jBZcaSrCeLapqkg
         88diA5OCmBEkgYQee/IXf1zZ3SJJfcMcxg/yeV+Om1/B/XfI6uM3nBEpcasrqaSR6oor
         T3BUFVht8erh0wGDSOZ5xa3DkiTiom0UQY/Z2RW7ZeGFBSxfizWudcheQR/ZiL//CnVy
         nvAA==
X-Gm-Message-State: AC+VfDz+D0BvFaXgWiRKU9OOXxQBnn6S8cV2vX6PGAP6sxnTxrYXk5KG
        rcm6QrnaWxb6/ZmPg1zjzb7dlDdkZd3t545aciHsDNlo
X-Google-Smtp-Source: ACHHUZ63809cJC1vmjUen0kOE/AKa9Qp9AjheNej4Lt/cFFZFpTCCki3aF5xzbOl/PmtfEWtdi3oPA==
X-Received: by 2002:a50:ec84:0:b0:51a:46e1:541c with SMTP id e4-20020a50ec84000000b0051a46e1541cmr2625238edr.8.1687107303478;
        Sun, 18 Jun 2023 09:55:03 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b00514a97b6b80sm12130874edo.78.2023.06.18.09.55.02
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 09:55:02 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so25093335e9.3
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 09:55:02 -0700 (PDT)
X-Received: by 2002:adf:fdc5:0:b0:30a:e87b:515b with SMTP id
 i5-20020adffdc5000000b0030ae87b515bmr6668842wrs.20.1687107302213; Sun, 18 Jun
 2023 09:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230618025811.292922-1-dlemoal@kernel.org> <fa363e94-6fba-5199-d02d-8bce1d219007@kernel.org>
In-Reply-To: <fa363e94-6fba-5199-d02d-8bce1d219007@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Jun 2023 09:54:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whh9uYfu9Qk+Q+oE7Gge64d=v=MYRy8nh-yTOs_sAMB5Q@mail.gmail.com>
Message-ID: <CAHk-=whh9uYfu9Qk+Q+oE7Gge64d=v=MYRy8nh-yTOs_sAMB5Q@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.4-rc7
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 17 Jun 2023 at 20:02, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> Please ignore (my apologies for the noise). Resending this.

Hmm. Was the only difference with the resend adding a 'Reviewed-by'?

Probably not worth the rebase and double pull request if so, but whatever...

              Linus
