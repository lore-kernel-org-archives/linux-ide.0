Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A50C47093
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B078B61246
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFBFW6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFBFW5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 01:22:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B9C061574;
        Tue,  1 Jun 2021 22:21:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c12so1300752pfl.3;
        Tue, 01 Jun 2021 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zQVqAHkqvIMBffK2LGT/eyQqVks9T9bdv5WPmUDipYo=;
        b=Mv35t54o0QfCTvBav7mzneQ5nMe2kJJS7En7XATvnA0XJ87Fuisu1Rj8Yp+CGWOJf/
         Bu3ZJeq3nEPUkfj50pKtnIWhSs3Kh0WGo9PuXnoCrXwkrIEDkCoPEPN3d0x+yC3/ZHih
         mmioni2LuEsMC1yKSdlQkHWkR5lrN0CIo61xnxM/RMHc+2sRPcThr7OW4JzI0MuzjFgf
         TqNfLCwmr7Z0JdbmwxeMA9Mqw4Xb8M+P0cZWwdWgBSyhJlhwA1kOF4SenEVSdTXdJAzU
         NRskf+gTIfDBDU8occKhoT7+JjKSQYoNbX7/P7odjy9YJTzJT2F3xtc+j0Rk5mjk6Ys8
         Ktjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zQVqAHkqvIMBffK2LGT/eyQqVks9T9bdv5WPmUDipYo=;
        b=psr7Fd1CaKd4Wlz7ZI9J6r3pcqfQW/I/J8O/YuOELO2zrsjfcfuQHQxrYk8RGbHtPg
         HvkH9acJBQAv2xq0AhR2jacLZWMbS/ScRCgzdWNRiIsWDE1wzXJ3aBENFTw5Fxczwqua
         DocH4X6Xin8LXvwWvLycchnt60fQ/lmUiNNINyD4xXQBJL5RgTAzEK5ygHkQJrYa3zO6
         nA3ddxoUeK2q+7am/ygtRdQZXrzPJye66nXt7Juanpymjwq4BCcjz5GvpnupkVT276+O
         kwebVPQPRpkNjh4/IA8JZ0qBN3BIChfCP5wN5ktnf7HqYRLgziVhjM/t0YesgsRZEOVZ
         3WnQ==
X-Gm-Message-State: AOAM530/Ojw2gDzKIw7LPlN2/Dq8Zlh7IDde7m5Dr9Lrergl7V8kxtFA
        XJkDNT2nFJN0ZAX9j8EIeSBmkys/c+w=
X-Google-Smtp-Source: ABdhPJzpavpy0w9+XOUj8z/H2IYcAwxvLi0KR/R4DkDhqurVyH6ILpYKC7Jkn+lS6n4GM1lz8oTCEg==
X-Received: by 2002:a05:6a00:248e:b029:28e:bca9:5985 with SMTP id c14-20020a056a00248eb029028ebca95985mr26054194pfv.10.1622611274633;
        Tue, 01 Jun 2021 22:21:14 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id n9sm14754251pfd.4.2021.06.01.22.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 22:21:14 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id EBE8D36040F; Wed,  2 Jun 2021 17:21:09 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org
Subject: [PATCH RFC 0/2] Fix m68k multiplatform ISA support
Date:   Wed,  2 Jun 2021 17:21:05 +1200
Message-Id: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Finn Thain found out that our multiplatform support is broken when
attempting to build a kernel with support for both Q40 and Atari (when
setting CONFIG_ISA through CONFIG_Q40, but not CONFIG_ATARI_ROM_ISA).

Inspection of the code in io_mm.h reveals that in that case, ISA I/O
accessors with address translation are used for the Atari IDE driver, where
MMIO accessors with no address translation would have been appropriate.

Setting CONFIG_ATARI_ROM_ISA will fix the issue for Atari, but then force the
use of I/O accessors without address translation for Q40. The code in
io_mm.h is fundamentally broken for kernels that have both Q40 and Atari
support. 

Address this by adding a check for address < 1024 to the Atari address
translation case, changing the default address translation to return the
untranslated address, and changing the CONFIG_ATARI_ROM_ISA section to use
ISA I/O accessors for addresses > 1024 (i.e., those not intended to map to
the ROM port).

Tested on ARAnyM with all combinations of CONFIG_ATARI_ROM_ISA and
CONFIG_ISA. Earlier versions tested on my Falcon hardware, all using
pata_falcon. 

A thorough review in particular in regard to ramifications for Q40 and Amiga
would be welcome. If there is a better way to implement these changes, I'd
appreciate a hint. This is all academic as long as support for Q40 and Atari
in the same kernel image is not needed, of course. 

I suspect patch 2 may not be needed, since the isa_sex variable should always 
be zero? 

Cheers,

   Michael
