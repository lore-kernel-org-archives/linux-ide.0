Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BBCC77B7A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjEPNGv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjEPNGe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BF83DE
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C293C639DE
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEBEC433EF;
        Tue, 16 May 2023 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242373;
        bh=jfGLy19gavibVuA17mYMp0mYR3/uhLiDg5tNHov7OsU=;
        h=From:To:Cc:Subject:Date:From;
        b=HD6SiAFQwkbFdea6cyJ5yFn70eIDJnK9ziOcIvkLj8GeOiIh6BScRWa+pupF0b086
         +8PvmlWKdIPyxlgjNxtvrDwzsAQfzKsZjy+2FXj7rlCSI7rYYgr4/V29bEl4u+iGpW
         PmQ5LezMQEKtw3CyITynKwQ78Lw4w/6XJA8w6IPrwzqBb2lu/nWy6BUIHOZSMfIRwC
         BQZoOihVlSTsAIlGpgOrMOGyidSRUsoLQX3Ppulrg3dqZI7UqzW3GkjJPfrtZoXDbG
         5WpbG4Qk66SNXSHGt9kFgrNuYXOquAKTqLrApHeVrXiIgJUEJlsymifM5pwNP0WKVv
         NO5ef3/45lfxg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 00/13] Cleanup pata_parport protocol drivers
Date:   Tue, 16 May 2023 22:05:58 +0900
Message-Id: <20230516130611.109932-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Cleanup the code of the pata_parport protocol drivers to avoid warnings
from smatch and other static code checkers. No functional changes are
introduced.

Damien Le Moal (13):
  ata: pata_parport: Fix aten module code indentation and style
  ata: pata_parport: Fix bpck6 module code indentation and style
  ata: pata_parport: Fix comm module code indentation and style
  ata: pata_parport: Fix dstr module code indentation and style
  ata: pata_parport: Fix epat module code indentation and style
  ata: pata_parport: Fix epia module code indentation and style
  ata: pata_parport: Fix fit2 module code indentation and style
  ata: pata_parport: Fix fit3 module code indentation and style
  ata: pata_parport: Fix friq module code indentation and style
  ata: pata_parport: Fix kbic module code indentation and style
  ata: pata_parport: Fix ktti module code indentation and style
  ata: pata_parport: Fix on20 module code indentation and style
  ata: pata_parport: Fix on26 module code indentation and style

 drivers/ata/pata_parport/aten.c  | 103 +++----
 drivers/ata/pata_parport/bpck6.c |  67 ++---
 drivers/ata/pata_parport/comm.c  | 238 +++++++++--------
 drivers/ata/pata_parport/dstr.c  | 285 +++++++++++---------
 drivers/ata/pata_parport/epat.c  | 320 ++++++++++++----------
 drivers/ata/pata_parport/epia.c  | 442 ++++++++++++++++---------------
 drivers/ata/pata_parport/fit2.c  | 131 +++++----
 drivers/ata/pata_parport/fit3.c  | 206 +++++++-------
 drivers/ata/pata_parport/friq.c  | 292 ++++++++++----------
 drivers/ata/pata_parport/kbic.c  | 314 +++++++++++-----------
 drivers/ata/pata_parport/ktti.c  |  85 +++---
 drivers/ata/pata_parport/on20.c  | 149 ++++++-----
 drivers/ata/pata_parport/on26.c  | 414 +++++++++++++++--------------
 13 files changed, 1591 insertions(+), 1455 deletions(-)

-- 
2.40.1

