Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A9FC71133
	for <linux-ide@archiver.kernel.org>; Thu, 17 Aug 2023 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355656AbjHQWNc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355644AbjHQWNE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2023 18:13:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03C35BF;
        Thu, 17 Aug 2023 15:12:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc83a96067so2559605ad.0;
        Thu, 17 Aug 2023 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310360; x=1692915160;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MopfytwMbhLxFvzM4qyCDRXu7obMAHHg9ZDiWMyOk4w=;
        b=eop6vqFubZ/IOTNrQaz2mkg2MUbelCekaa/yMHkh3L+aGFnGXj6SaSnH4EXU/duQp0
         UCHSWX4oB9I/5Wa5ZeCJjhd8gOgD6WENv81Ze/+Q0wZUGN0w3iro8KocsaKzfPBsY9Z3
         sReCNMfk56/C4/VnmD0kBxK2caae5HDMdrqQpOn+pLCY3OHyJw0UtB1JyMfnKBpzfC66
         GgS4Ax/5Z+xXU17LMGlDXkZ1UvO5K0Gwk9x3ra8KFkhNUJ7MNrOZwAw9zABz9+fKfwAb
         sVLOdQgtX4Xs/eUw8sLi/Ez/XYePg23UsYCMMuO9KWHS0rRUbmBqIHI+s7hw0S0a3TCh
         HYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310360; x=1692915160;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MopfytwMbhLxFvzM4qyCDRXu7obMAHHg9ZDiWMyOk4w=;
        b=lIRtyvJytLimU2ZD46mfiCFlLmMDydPApvbatrwniRq1AxDwK5Bp+KYrtv0uQrxIzA
         ZCzWVCCYkK9KddwVvaK/hTYp8zithiTsxNc31s7A8wK4a8TAkmf1k5WiKjj+kuP3Pr8J
         DoMNFRBEFkoLI51UZFaz+vNXYf2uARfJA1aCZfnqAoCWvhL3pzlVGgIf2p8jKnh8U65X
         1o1B7pueHZcP+qWm0/dRnmmhPl/c4Y0Z4IDs0oRya4BQ3lKieZV6YNiH65H+MOSFVIg9
         9KPYBSh+EgzUNjDrY8+C7ZDTbaaDHn8qVXMkjziKMQF3ZQOHJFWcOPpTOwHuAaHJFIQk
         SQiQ==
X-Gm-Message-State: AOJu0YyYVhqq209W79yFdIB0yvWo5fv90Eta1kIHS8h9mTeHQUW+moie
        N1d26gzzvIzN+m583VpF7sljrPL4Kvo=
X-Google-Smtp-Source: AGHT+IE65KhX1/S+o0LqB5aYWOhE3vHQYlM0AmjjEaJ5VKCyP3/E6gJISy0iUQ1QZSUI3xLKPp6MmQ==
X-Received: by 2002:a17:902:c14b:b0:1bf:13a7:d3ef with SMTP id 11-20020a170902c14b00b001bf13a7d3efmr652711plj.66.1692310359907;
        Thu, 17 Aug 2023 15:12:39 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001a6f7744a27sm266418plb.87.2023.08.17.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:12:39 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A7F00360334; Fri, 18 Aug 2023 10:12:35 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH 0/3] Q40 IDE fixes
Date:   Fri, 18 Aug 2023 10:12:29 +1200
Message-Id: <20230817221232.22035-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pata_falcon IDE driver for m68k Q40 has been broken since Q40
was converted to use pata_falcon in preparation for removal of the
legacy IDE core in v5.14. A bug has only recently been reported.

This patch series to fix the bug has seen some discussion and review
on linux-m68k in the past week. It's also been tested on both Q40
and Atari.

The bug reporter has since found that he can use pata_legacy for
his Q40, but that is solely due to his disk written in the default
IDE byte order. Other users of Q40 will have data on disk in
big-endian order, and will have to use the pata_falcon driver
which does not attempt byte swapping to host byte order in its
data_xfer() function.

Patch 1 fixes the bug introduced in v5.14. That one ought not
to be controversial (I hope).

Patch 2 adds a module parameter to select drives to have byte
swapping to host byte order applied (useful for connecting drives
in IDE default byte order to Q40 and Atari for interoperability).

Patch 3 changes the Atari Falcon IDE platform device to use a
device ID compatible with the byte swapping scheme. This patch
should go through the m68k tree, not IDE.

Feedback welcome!

Cheers,

   Michael
