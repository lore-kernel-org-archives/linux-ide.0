Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82444C47096
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2FD6141D
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhFFF5n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:57:43 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45009 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFF5m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 01:57:42 -0400
Received: by mail-pl1-f180.google.com with SMTP id b12so882318plg.11;
        Sat, 05 Jun 2021 22:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1SMYS4qCp6YGBbnn+JnAitbUm8JxMB2inl/faYe5t0=;
        b=u2+iYv7LxCi2Tk1btIoBOhWncfG7TNXuVagvduLm/TI883dHsxbDGPao0bhGbmsPaY
         vSPsqNe3cBjN9MGUKf1nZj4Xz6ibNjGMdq9sjOXsWLl17PieVBkRKyQ1VR3rjUirWLCY
         2ZkGdiF99cZ0K27bnBI/GcSxmkU7lBYnPnuwykxaIbIBHzdj+KMsvl21eY1P56Lc00Tg
         C7LBcKzknELx6V/pWVI0wI1J1bwMhQoZMggO2KaCixFMKLfLMTB9RtfMUPNNAd++Y4+D
         q/FeMbbWhudTnlz4T3Vvo+9LAT0yAurRBgb8poH48mCFcbiSdUdVIlew4FB1JBbtF0Ff
         Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1SMYS4qCp6YGBbnn+JnAitbUm8JxMB2inl/faYe5t0=;
        b=uMfBYvxcBPfMj8qdnYl+oKGIF/sq/GIUUJteFCl3dOsBfvp8SLoRM1iUOXNanonZrn
         y1jIyXrC8sjDZ7YFNWpnkxHfcZCKTOOiSC2n2bBaRV5TtaV2Zi63QZDNb6+DjT5qoq6R
         ENIeuAHxjSwIyjvwf7jaaEyONxdvRl/40Kr7Hu2lYOwv73+9Ut7P8O2h4z5LeklBW+Ba
         SKqNita8p1/E/ct860ms3af4fNp4GderqVo2ZpPxbqr+WBrpVa5s6LEVV3+8qpUQIbSr
         Eql+rLd/wVI9BOx4OD7IIsNY8h2twCZ8JaYUH7Ez9CX0Lpwl+UxrB9OGw/0ujHZiUK83
         p52Q==
X-Gm-Message-State: AOAM533vi4F5qWCPtANXJq1YuIRWzfs0txmjO3uZFLJgqS7pkk+Xw4Wd
        M/CgI/HKV/ZDK6gQi4olzTgCcGZuQ/E=
X-Google-Smtp-Source: ABdhPJzM+SRNcywfIvjAVXE4J8UUMBn6X+dIFaVSVnkUtkF3k6MUqXUZEPzd3DqFmn1EX4V7gVu6Fg==
X-Received: by 2002:a17:90a:6002:: with SMTP id y2mr26370370pji.197.1622958884416;
        Sat, 05 Jun 2021 22:54:44 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id d3sm5244234pfn.141.2021.06.05.22.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 22:54:44 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 07D763603D8; Sun,  6 Jun 2021 17:54:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
Subject: [PATCH RFC 0/2] Add APNE PCMCIA 100 Mbit support
Date:   Sun,  6 Jun 2021 17:54:35 +1200
Message-Id: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210605060447.GA18461@allandria.com>
References: <20210605060447.GA18461@allandria.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Now that we've sanitzed io_mm.h, revisit support for the 100 Mbit APNE
PCMCIA card variants that didn't find favour with the netdev folks three
years ago.

Add another ISA type for these cards, and switch to that type from the
APNE probe code in response to a module parameter. 

Entirely untested, just for comment (and hopefully someone will give
this a spin). 

Cheers,

   Michael
