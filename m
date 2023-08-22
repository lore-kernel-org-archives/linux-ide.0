Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC3BEE49B1
	for <linux-ide@archiver.kernel.org>; Tue, 22 Aug 2023 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHVWOJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 18:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjHVWOI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 18:14:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1ACD2;
        Tue, 22 Aug 2023 15:14:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdf4752c3cso30027145ad.2;
        Tue, 22 Aug 2023 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692742446; x=1693347246;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhrVf6seEAierk/yi9slekoheI/hQpejB3kp7KTu7Sk=;
        b=nv7pfo/KYBY1sl411NcqE96i8r+CmR99/EeBwszDABnmvfGfcTGmvm9tMVPL6d9QJk
         hOHJKc63IvBZbD3NMBdXlx3Ydm3n3kh3Xr2Y4jI1u/6Gu71eUNHlfW2HhmuYCTpAN8P/
         SIKXWi2rbr/Sy/S4uN0RIyGKYpS8XXL3yH7bdWaeBy5y2V+zNVbzh9r1aYkXGYKnyuCm
         XhUJUBADNlIRcSf6dhwRIQTaJmswNnVtgySFnUvoqsPjdYmd91+yopf3La53atv4y43l
         1uoGnZQr+G9LdSwUmAdaTjkyKHFWtSFlg4xo2/FDx1OGa7rIE1m/ByC4fbaqEs6Kxg+P
         hMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692742446; x=1693347246;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhrVf6seEAierk/yi9slekoheI/hQpejB3kp7KTu7Sk=;
        b=krhNnWNgTZ8lGPiMP1emZ8BE/McoI6cRTQCuSMLpaPVfh+dd1unkZ7qpt4Zw34Vx1e
         +m8HP2JfGHf+BGXlhv1Z3XW7w2aNY1pHPajhwuZWqKgZcfvi+SjUy5TiFzT383dVvPNL
         XUlbkb8tf7FClm3wyEZZmeI6F+6cV4k6RBNhrLis/S+bOQdwgAnBdl9Q4UV8+RgjLODE
         aP+/tv1ErWpPUHp9D4vbsppMNc47MOmmuE0Czk8xZPIPvRRI/5NLdxUooyXJsd/lvPOy
         z468a1C+1fAvdl2kTbFy/NlHNeFvLUqDHCKJPE08QfJoqbw8fm0JVhlWFeUNmdohsdxX
         1FCA==
X-Gm-Message-State: AOJu0Yxp33HjpnCr/e6zlQpu2xoav/D03IN4V0RdilkU8yjjBNVNMHcl
        V8chlaxl686qI4GFH/bvUUw=
X-Google-Smtp-Source: AGHT+IFHfaWpGXpO8BGc+OhFQjLxrekCfk6fvJFi85+6l4ZH+SJnOpxlSQfsuAXxkuD6/xLyDrYy4Q==
X-Received: by 2002:a17:902:da82:b0:1bd:d446:6676 with SMTP id j2-20020a170902da8200b001bdd4466676mr9545217plx.31.1692742446478;
        Tue, 22 Aug 2023 15:14:06 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001b9de4fb749sm9468348plb.20.2023.08.22.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 15:14:05 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 85D72360324; Wed, 23 Aug 2023 10:14:01 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH v4 0/2] Q40 IDE fixes
Date:   Wed, 23 Aug 2023 10:13:57 +1200
Message-Id: <20230822221359.31024-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Version 4 of the pata_falcon bugfix patch for Q40 support.

Changes to patch 1 only - now uses register shift instead of
register step (or gap, or scale ...). Most drivers appear to
use shift these days where platform integration differences
have to be reconciled. ata_port_desc() will now report the
MMIO address used by the data transfer function (which differs
from command and control base address in the Q40 case).

Cheers,

   Michael


