Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A16C25B67
	for <linux-ide@archiver.kernel.org>; Fri, 27 Oct 2023 07:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjJ0Hbj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Oct 2023 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbjJ0HbZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2023 03:31:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDEE1705
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2023 00:31:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD7C433C7;
        Fri, 27 Oct 2023 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698391877;
        bh=83Npn6lP//bZWIRXGC9KUviMtipSYP51x3/4c9RWfuo=;
        h=From:To:Subject:Date:From;
        b=Rsnd+rovorrk539wUrBO8+d9eYTN27lcEhotmFVyY6hBA+VaRgxBezJIfTOj9ojMo
         8LoqMYmV0exbgIqJciVP9g88IJQYHatS+wAb+0Gr1kBXzqpLZgauul19/MerYsv4mr
         0EdO67FDkVmb4lPJfHa60rawx9TcwDy5vFlko1s2TZLSPwqdKJm89kVP+y3lGiYz3b
         nrWwfS9bfIVg7VOlD3F+u6tnouCNOF64/uNcB6H490NZ6YK3Q2jLLkNn603nLZ6URo
         5EiNT+awTesL65M0dblut1VhtiMZlV8ye/GokswdYi2CWigC+9LGsjonFVVVvDWEjm
         QQi2DCGpvln+g==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.6-final
Date:   Fri, 27 Oct 2023 16:31:15 +0900
Message-ID: <20231027073115.170201-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 626b13f015e080e434b1dee9a0c116ddbf4fb695:

  scsi: Do not rescan devices with a suspended queue (2023-10-10 14:42:22 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-final

for you to fetch changes up to 24eca2dce0f8d19db808c972b0281298d0bafe99:

  scsi: sd: Introduce manage_shutdown device flag (2023-10-27 10:00:19 +0900)

----------------------------------------------------------------
ATA fixes for 6.6-final

A single patch to fix a regression introduced by the recent
suspend/resume fixes. The regression is that ATA disks are not stopped
on system shutdown, which is not recommended and increases the disks
SMART counters for unclean power off events. This patch fixes this by
refining the recent rework of the scsi device manage_xxx flags.

----------------------------------------------------------------
Damien Le Moal (1):
      scsi: sd: Introduce manage_shutdown device flag

 drivers/ata/libata-scsi.c  |  5 +++--
 drivers/firewire/sbp2.c    |  1 +
 drivers/scsi/sd.c          | 39 ++++++++++++++++++++++++++++++++++++---
 include/scsi/scsi_device.h | 20 ++++++++++++++++++--
 4 files changed, 58 insertions(+), 7 deletions(-)
