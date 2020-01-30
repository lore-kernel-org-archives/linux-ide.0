Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA69C35240
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78182206D5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgA3KHQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:07:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52648 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3KHQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:07:16 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3136315AB16A5;
        Thu, 30 Jan 2020 02:07:15 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:07:13 +0100 (CET)
Message-Id: <20200130.110713.2121058244629085751.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jan 2020 02:07:16 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


1) Fix mem region name in tx4949ide driver, from Christophe JAILLET.

2) Make drive->dn read only, it should not be changeable by users.
   From Dan Carpenter.

3) Several cast fixups from Krzysztof Kozlowski.

There is also going to be a removal of a now unused IDE driver, but
that will come via the MIPS tree.

Please pull, thanks a lot!

The following changes since commit 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721:

  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-07-22 09:30:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 2fd3c5c617937cde5aafa48db4f4056e1f705987:

  ide: make drive->dn read only (2020-01-30 11:03:24 +0100)

----------------------------------------------------------------
Christophe JAILLET (1):
      ide: tx4939ide: Fix the name used in a 'devm_request_mem_region()' call

Chuhong Yuan (1):
      ide: Use dev_get_drvdata where possible

Dan Carpenter (3):
      cmd64x: potential buffer overflow in cmd64x_program_timings()
      ide: serverworks: potential overflow in svwks_set_pio_mode()
      ide: make drive->dn read only

Guoqing Jiang (1):
      ide: remove unnecessary touch_softlockup_watchdog

Krzysztof Kozlowski (2):
      ide: ht6560b: Fix cast to pointer from integer of different size
      ide: qd65xx: Fix cast to pointer from integer of different size

Masahiro Yamada (1):
      ide: remove unneeded header include path to drivers/ide

Wang Hai (1):
      ide: remove set but not used variable 'hwif'

 drivers/ide/Makefile      | 2 --
 drivers/ide/cmd64x.c      | 3 +++
 drivers/ide/ht6560b.c     | 2 +-
 drivers/ide/ide-iops.c    | 1 -
 drivers/ide/ide-proc.c    | 2 +-
 drivers/ide/pmac.c        | 3 +--
 drivers/ide/qd65xx.c      | 2 +-
 drivers/ide/serverworks.c | 6 ++++++
 drivers/ide/siimage.c     | 3 +--
 drivers/ide/tx4939ide.c   | 2 +-
 drivers/ide/via82cxxx.c   | 3 +--
 include/linux/ide.h       | 4 ++++
 12 files changed, 20 insertions(+), 13 deletions(-)
