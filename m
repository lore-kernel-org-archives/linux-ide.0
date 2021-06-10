Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC3C48BCF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92706613B3
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFJCL1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJCL0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 22:11:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12C0C061574;
        Wed,  9 Jun 2021 19:09:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so2786723pjz.3;
        Wed, 09 Jun 2021 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANxpNQcXZBl5iTHRpObdrJPEIhlgvCETwvAPeecwlFo=;
        b=p7BPpeCZJ8CQTwBYywX4YcmzzpHXAwUDmvc8MSXt85qpE/0ji9sMNOgNynP31N0U2o
         F8EEdbADPyMmEi3H3Ul2xb9d6LHD1cTPVZEpJVx18TaI3ZFAa+t67BfO0tdKX7Q36gJU
         aVSfD6UcPbCfh+r5Qezf7/74bhLOae2nmffC9o+RR3tsWGLSv20lcqsjAnAlcp1jvPby
         060YyXlzCASu7MwtM6kwWt9bvWBZ0qQGjITp6RYKNgOtjOET3XCVpTBrL7nTPfQGX13+
         Q9vVZD+GLSwYLKfVtUUL/Cr4Bi8EDsojDhVr7k9xYaOJu0DtCMexFifKlo52AX4pk2dm
         Yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANxpNQcXZBl5iTHRpObdrJPEIhlgvCETwvAPeecwlFo=;
        b=dfHaEM0808WQPl2UWzRu7gdMJzEuOp2EghlTPEFx2oGY+GisNmI3JLXHAZ+QjbEpB3
         RJldS30FQISCXSnbcQHOVs+0T5zV/ukSvNV9EzW3EZmUMg1Txcf9Pn1TMuhotcKfHZHV
         omW4zGOyQQDA683uJaSiTK+5MvMiF2wFXuaM3MyOsMhqScJN0BWip1osibat4V2EIl47
         x+eqwXWqFqpGjDutLOuw9C2U7BkIoVlfE8BxjGO5kWdJLh3GhkvDTtdguUzt4iBzu2kR
         LPAdUHs3BGJ3sQiROxZMYq3gdYge5VXcPgSpLi0I7MGTXIJGX1qU/vGs8RaVtZvOMHro
         b4YQ==
X-Gm-Message-State: AOAM531GCfhtokzWAm49DToWwapiGDTw2rcp8+lZ7wE0gLp5VTcAiqV0
        vMDpCB/+W5jcZVF3EQLy8MjJwEc6OS5efA==
X-Google-Smtp-Source: ABdhPJyLzW3ePHJGl2opoKmoBzwApEmakdNUn5Rm+7K/pJ3f1Dl+IScNkfmsJuiY+25mBCU346pp8w==
X-Received: by 2002:a17:902:7244:b029:f5:2ffd:37f9 with SMTP id c4-20020a1709027244b02900f52ffd37f9mr2680041pll.26.1623290959306;
        Wed, 09 Jun 2021 19:09:19 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id o24sm880050pgl.55.2021.06.09.19.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 19:09:18 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 190963603D8; Thu, 10 Jun 2021 14:09:15 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
Subject: [PATCH v2 0/2] Add APNE PCMCIA 100 Mbit support
Date:   Thu, 10 Jun 2021 14:09:11 +1200
Message-Id: <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
References: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Now that we've sanitzed io_mm.h, revisit support for the 100 Mbit APNE
PCMCIA card variants that didn't find favour with the netdev folks three
years ago.

Add another ISA type for these cards, and switch to that type from the
APNE probe code in response to a module parameter. 

I've addressed review comments received so far, to the best of my ability.
Patch 2 not changed in v2, only comments on patch 1 by Andreas Schwab were
addressed.

Compile tested only - hopefully someone will be encouraged to give this
a try before I submit the apne.c patch to netdev. 

Cheers,

   Michael

