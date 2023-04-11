Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C9C7619A
	for <linux-ide@archiver.kernel.org>; Tue, 11 Apr 2023 07:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDKHOt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDKHOs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2023 03:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215B2E7C
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2023 00:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3EC6147C
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2023 07:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC54C433D2;
        Tue, 11 Apr 2023 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681197287;
        bh=szDG3tU2VG3p1VLOokKq6nwoDQWYwW9SXJ1O14rFFbU=;
        h=From:To:Subject:Date:From;
        b=DG0In0nlVtULC2hC26yXNBrNJdzRAu9DCU4eKKgwcW40oCHX05tmopLB6YwS7ZUko
         aUEL4mykoUxrfBrHFtrJaRzQEWjalWywIc/zBT1CNOGkeXii5mnOEDxqMGKj99uH/1
         APtHev9cFHhTZLak8ZvdIcIaWl204yFbPxLHeoDNERzbWxAxYXDn8ov7oMYowRFI4s
         ZzFLGIGTvCuCA+8VyxMZv8ojO6TDigkvnkbOUVYnsGxqwo/tVjTx5Tnm9qmxrtqYtR
         IlI+XivKtq1KFW52WWBhqj95w6xk7cldxfTsQxI3VvMvFxUQ9EfqNzfT7I1ApJEiV+
         FnO0WQPV+Mvrg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.3-rc7
Date:   Tue, 11 Apr 2023 16:14:44 +0900
Message-Id: <20230411071444.8357-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 5bc9e2d43f86105a95f86fa096fb4e517bb0ce73:

  ata: pata_parport: fix memory leaks (2023-03-16 16:54:38 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc7

for you to fetch changes up to 2096134b5a00bf0bd15745d3a492039e801e84c0:

  MAINTAINERS: Change ata maintainer email addresses (2023-04-11 16:10:10 +0900)

----------------------------------------------------------------
ata changes for 6.3-rc7

 * Update my email address in the MAINTAINERS file.

----------------------------------------------------------------
Damien Le Moal (1):
      MAINTAINERS: Change ata maintainer email addresses

 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
