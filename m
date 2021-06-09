Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09DC48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786161351
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhFIHjJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFIHjF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 03:39:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C3C061574;
        Wed,  9 Jun 2021 00:37:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y11so10585066pgp.11;
        Wed, 09 Jun 2021 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y+Kn1AiXqJGdat+y6ke7MG9G8WljLOiMDyi/oOH9jMo=;
        b=dwXZdzu1MW1C2kls1mNA2a8AxIaMj3oFrd1QuqznJ1zmdtS7YIzzrir8LYxLMH2vsw
         8MgLZPfK1P5AqQWwupWniODxMOjtIMqlsGkc3logZphDNKkWiYGu3EirGQ0NtHbGlrOj
         QfFx7f3xEbkV1X6hJF64mhowtn7EFBY+BCLSSQ4/1hILde6O1XlyiaOVglue2oWKwfVg
         waO6ZNj5tZ1+XLKmL38M2W/gMhIxVs1fD0LkVLgoFDWQARNkyo+eOI4XQcr3NR29QHYa
         LKsDc9hoY9uBzQiQ/+2zi3XIJHUCI7LApUO4UNDDe8vhxNduzOSJ/tKaIPVMXBhOcmaT
         nizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y+Kn1AiXqJGdat+y6ke7MG9G8WljLOiMDyi/oOH9jMo=;
        b=l+5A5NWpN3nL51B0a02UuLNH5P8lrF17xUr7cFOdUGzmyYV4Dr45XsOgC4ySJtGCwf
         C5vUS8zmVx/taHdL8s1uDpJzvIXJo+1h9n3TrZ6u5scTdGzGvARp6iMYVTA3qTu6oEdy
         4d8eHjJctccrmtVuSsyOqEZv2UlYsDhfqzpSprqpy9tQ69kjezDFt2dCMPw95oUnaVnM
         9PuXHt67lJ6NOkJUSpA1CtfdHuIOwUAPIXE/L87cpZXS+YZX5G0TyfSgG/JbFuvZWc+f
         0bcR8Rfta5hC6zFzpvaj2hS2WFewU1Y1y2J7lBmjpsez3JNlf0OOV8geF7N+MSzGElpf
         jx/Q==
X-Gm-Message-State: AOAM532qAAIsMuaTJ68SqiZ21uWXUk6ncHLQ4JnRbgLYO4hiTsNYN9Ig
        SyZpSO0Ic1i6OiMA+TYFfQxEfI5JdwE=
X-Google-Smtp-Source: ABdhPJx/bCVkS2L3ClfbbUoA3WUypB39f8ruUkeePFl0YVR4zu+MnDbdz0tD+4wiYnpN5JN+kAEmDA==
X-Received: by 2002:a63:af02:: with SMTP id w2mr2512468pge.350.1623224221834;
        Wed, 09 Jun 2021 00:37:01 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id w63sm12871314pfw.153.2021.06.09.00.37.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:37:01 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 1284D3603D8; Wed,  9 Jun 2021 19:36:57 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
Subject: [PATCH v1 0/2] Add APNE PCMCIA 100 Mbit support
Date:   Wed,  9 Jun 2021 19:36:52 +1200
Message-Id: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Now that we've sanitzed io_mm.h, revisit support for the 100 Mbit APNE
PCMCIA card variants that didn't find favour with the netdev folks three
years ago.

Add another ISA type for these cards, and switch to that type from the
APNE probe code in response to a module parameter. 

I've addressed review comments received so far, to the best of my ability.

Compile tested only - hopefully someone will be encouraged to give this
a try before I submit the apne.c patch to netdev. 

Cheers,

   Michael

