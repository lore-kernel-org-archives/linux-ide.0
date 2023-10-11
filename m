Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808ECD6E43
	for <linux-ide@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJKItq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJKItp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Oct 2023 04:49:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8C3C9
        for <linux-ide@vger.kernel.org>; Wed, 11 Oct 2023 01:49:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7315CC433C8;
        Wed, 11 Oct 2023 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697014183;
        bh=KNlB19eJxeH4yTlBaEX+eZzg0q2TzYRHrOYYUPVUTII=;
        h=From:To:Subject:Date:From;
        b=JKHo5KfZRrmvGHD2Auu0rZnff4PW1XFrTSmVq6sEe8UPAQSiiqq0Eg+eHW+9jLEgO
         XMwzPCVDoiR2f3unbJqfSYRm1qlKpHd6xm2AM2YGYXRrYuPMHfYmkUa73d+ehWDGwm
         xbykXlr9t6C3Q+xiBPZfe/UwOCBkldtfBYxQ4NKBz91K+99gaM03bzZ+IGVTVwBJHt
         uoO7YVa6wV6zhNech8E7/fISPuyJJ322ni+NO10sm48HFU7Wc+ij6mvak8Iu4MIBAz
         z1/sYY1Xj96JmBYn9O42Fmk15Gq//gM1kAm7JUkztVhpT33RVd26Ox22O5it1SXQDk
         rmssWzrEDWY8Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.6-rc6
Date:   Wed, 11 Oct 2023 17:49:42 +0900
Message-ID: <20231011084942.22372-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc6

for you to fetch changes up to 626b13f015e080e434b1dee9a0c116ddbf4fb695:

  scsi: Do not rescan devices with a suspended queue (2023-10-10 14:42:22 +0900)

----------------------------------------------------------------
ata fixes for 6.6.0-rc6

 - Three fixes for the pata_parport driver to address a typo in the code,
   a missing operation implementation and port reset handling in the
   presence of slave devices (From Ondrej).

 - Fix handling of ATAPI devices reset with the fit3 protocol driver of
   the pata_parport driver (From Ondrej).

 - A follow up fix for the recent suspend/resume corrections to avoid
   attempting rescanning on resume the scsi device associated with an
   ata disk when the request queue of the scsi device is still suspended
   (in addition to not doing the rescan if the scsi device itself is
   still suspended) (from me).

----------------------------------------------------------------
Damien Le Moal (1):
      scsi: Do not rescan devices with a suspended queue

Ondrej Zary (4):
      ata: pata_parport: fix pata_parport_devchk
      ata: pata_parport: implement set_devctl
      ata: pata_parport: add custom version of wait_after_reset
      ata: pata_parport: fit3: implement IDE command set registers

 drivers/ata/pata_parport/fit3.c         | 14 +-----
 drivers/ata/pata_parport/pata_parport.c | 78 ++++++++++++++++++++++++++++++++-
 drivers/scsi/scsi_scan.c                | 11 ++---
 3 files changed, 84 insertions(+), 19 deletions(-)
