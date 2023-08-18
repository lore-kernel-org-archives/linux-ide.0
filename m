Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF4EE49A1
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 23:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbjHRXtc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbjHRXtM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 19:49:12 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D73AA3;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a812843f0fso928532b6e.2;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692402549; x=1693007349;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1VpnhCuusO+sAhM5Kw3Tczs95L4YAJFEm2T5Kv4jlo=;
        b=KIZk5cc6xCFICEh3ROMEN94AphUbX2S2LV4GHnqgN3W0rEKR0SbZhFU5nRnYN1EYZT
         RsraF62RmxGIstAk2dRHIe6N70QKQiBFT/X685h05v/eK711brrzbIbOL8nG7872MLap
         KMZyhg6mjps6Sv/K57c46HG/AEF4VeMwwQWar74YJUj1cPNX/6DryYWMo2rQErDEOQwq
         qqYFDMEj3NQWody1TbgxJ+y6WO5r0egVrxSctw+dKvlxIv2lddKUd20q587DWmzMjzGQ
         uZzvteQ251gmvxUX0Azk6cbJ2ztx9lw/WXO/4ub6WfTRB8mC5zqL0Nh/ilNvVzBryfmI
         84OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692402549; x=1693007349;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1VpnhCuusO+sAhM5Kw3Tczs95L4YAJFEm2T5Kv4jlo=;
        b=kkD3Q9gzzBRB0KdsJEjat+5M2KJlW1jnYpRkyqvXrco4HQ8EKlTrb5CoMV7QOWKsOO
         8b2vByr5q88W9BDkQBdab1pQ7318PJ6viBmcEv8YagXw7CHXTs9Et/0/QBnCn5OabzaL
         +xzYVujWk7PM/Yh1oyqlGMXG2nAI0cXEe3RiQ96HMLIs9zOdYMkfi0oGKD17LGmm14KP
         w6uqcYuKAq6OZWOrECfeMeQ+m14utDLeJLtAaYKuOTAiQO69jULU8j6Mx5e0FdDP2Ewz
         XvE8zQo8hm8g9MrugZ7CG1DovjGRte0QsSSD0t+o73B2VpOI1ZAcFG64L3q1ZvEjHjLX
         uMLg==
X-Gm-Message-State: AOJu0YzoAL1WTqBRDZTvdJsXbo0UAOSqAH1rr36dzZ/qEwgu/MGfTpgt
        V0k9UDap61mGegIUw3v17sS2moujIzo=
X-Google-Smtp-Source: AGHT+IFHV4HFhpHjnCaftVUUBerqShkiBxOnZ09gsUinknjKAtozE5hS/uVjE5483rodM/BtT/vjGA==
X-Received: by 2002:a05:6808:dc1:b0:3a7:5c52:5e88 with SMTP id g1-20020a0568080dc100b003a75c525e88mr764187oic.16.1692402548995;
        Fri, 18 Aug 2023 16:49:08 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id n10-20020a17090a670a00b0025c1cfdb93esm2060089pjj.13.2023.08.18.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:49:08 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id F3E71360332; Sat, 19 Aug 2023 11:49:04 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH v3 0/2] Q40 IDE fixes
Date:   Sat, 19 Aug 2023 11:49:01 +1200
Message-Id: <20230818234903.9226-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Comments by Finn and Geert have been addressed. Tested-by tag added
for both patches.

Patch 3 would have caused user space visible changes, so has been
dropped after changes to patch 2 make it handle negative pdev->id
correctly.

Cheers,

   Michael


