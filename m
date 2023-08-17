Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED7C71131
	for <linux-ide@archiver.kernel.org>; Thu, 17 Aug 2023 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355673AbjHQWNc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355701AbjHQWNJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2023 18:13:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC53A8C;
        Thu, 17 Aug 2023 15:12:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdc8081147so10237395ad.1;
        Thu, 17 Aug 2023 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310362; x=1692915162;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OsNAOjMPs6W5o5PXzHV9cWMtIz8YuQ5vDN9CHwvmKIo=;
        b=HgeSwgUo65xA4w/INkpZTKzj6d+o0ybjLjPcQcb1pdODFuDaXFocxPgPQapw9WLw0C
         cn4Yw5zvvMOCtU9h4wMMkrdTyqv/EOQbpkIbit4qc9R3z0kGsqKfNdi5GOp7Ee7yUarv
         YRFYfCmHjlWs+mBqd7RiEIuoe2sWiBzFjCIZXuipLAIAE7reEiOttStxbMVE3O3ZYn/o
         Oh0ml9GLNZJhTwMHs9FYktqhS39PI+VmnV4p26L1QiNI+lrtiugoSUl7c0gCjNdWmoSM
         OCx4LJ+XeShiBcXPt0AvGeJjR6QeeU8hGeMrD3t83K1T2slXA7jDEKhIjBm5tdo/eK0N
         w6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310362; x=1692915162;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsNAOjMPs6W5o5PXzHV9cWMtIz8YuQ5vDN9CHwvmKIo=;
        b=b93ixfImX75AObD3pSFzZr/wNR/En53ZT7PvBYrf+hn1galW3BlDHpsfO2CCYNpxXi
         jhUN6bjHHSmm+VML3uIN4+X6ylhHq70xDxj9LEbOlc1tm9JxF7z6XqfqseNxSVW3hz71
         rI50onw51Kh5ASU5Oog6WTODudHdGLXyotrw7PO8ii6NZnA9f3OPqZRmmlB7KLYjecaW
         IjtYumQkAFSIBICx4eAIKlzvcSoJusvrJ3oypkPWsLZmnTzeY7G1+WITKA2BQ5Ou3nnW
         x8jQHBCIuSZsq95r15yvLfZTonpIP1zc0dXGpXveRt29glfw8N/FR3siqqmAQM7UwEjq
         FKig==
X-Gm-Message-State: AOJu0Yx7T3k7qca++xlHrcDCELYNho3w0J7NQEe1jd8PP4v8+1urW7Fu
        TOV0U66a6q4CcC9HS0Edjk4=
X-Google-Smtp-Source: AGHT+IF7GPczl/mRkYNd2uVG+rP+fxCo/jn13ra2QWtGJN+73DZU1j/StaL7m1nUxua1meO7Be98OQ==
X-Received: by 2002:a17:902:d50d:b0:1bb:55be:e198 with SMTP id b13-20020a170902d50d00b001bb55bee198mr879086plg.0.1692310361800;
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001b51b3e84cesm251863plg.166.2023.08.17.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 0EB5236043C; Fri, 18 Aug 2023 10:12:38 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 3/3] m68k/atari: change Falcon IDE platform device to id 0
Date:   Fri, 18 Aug 2023 10:12:32 +1200
Message-Id: <20230817221232.22035-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817221232.22035-1-schmitzmic@gmail.com>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pata_falcon data byte swapping patch relies on pdev->id
being 0 or 1. Q40 uses these IDs, but Atari used -1. Change
pdev->id to 0 for Atari Falcon IDE platform device so
selection of drive to byte-swap through pata_falcon.data_swab
can be used on Falcon as well.
Tested on ARAnyM so far.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/atari/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 38a7c0578105..e3e437cd0f84 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -925,7 +925,7 @@ int __init atari_platform_init(void)
 #endif
 
 	if (ATARIHW_PRESENT(IDE)) {
-		pdev = platform_device_register_simple("atari-falcon-ide", -1,
+		pdev = platform_device_register_simple("atari-falcon-ide", 0,
 			atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
 		if (IS_ERR(pdev))
 			rv = PTR_ERR(pdev);
-- 
2.17.1

