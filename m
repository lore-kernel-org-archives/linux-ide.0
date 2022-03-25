Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB70C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiCYM6I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347741AbiCYM6D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 08:58:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9EAD0AB6
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 05:56:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3755921100;
        Fri, 25 Mar 2022 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648212987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BEzKunm2ECSD6cAIlFITJiuVJ3gIRDH0aI5vcdi+7k8=;
        b=JMXWbxWgI7jUi5BI0V7b4AmbwUve/+TWIQkPh6+bnuiSBhe9dSv9vnY7Nd3PPt+Xbg8hzC
        EORV//sjNbo7Syr1zfWp/76XLyCA6oR1ZXNcGLaLhk2Ub9bhJWiOIFXBzkF/pS6Nk8yyLp
        ZBYAUGlbdj6Gvijeg8kh8Bctxoo5TC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648212987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BEzKunm2ECSD6cAIlFITJiuVJ3gIRDH0aI5vcdi+7k8=;
        b=gkN+2UXKmYHyrEadZ9s8TYwb+ReCi0xCQ8YAuKSxWmv1cImzCwtpN33AcIDyUeAgwqob96
        eusu562LIL1JSICw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0A857A3B92;
        Fri, 25 Mar 2022 12:56:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id F21C75193927; Fri, 25 Mar 2022 13:56:26 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/2] libata: sysfs naming
Date:   Fri, 25 Mar 2022 13:56:22 +0100
Message-Id: <20220325125624.99929-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

here's my second attempt the align the libata object naming with sysfs.
Key point is to introduce an 'ata' bus, which serves to collect all
libata object (ata_port, ata_link, and ata_device).

To facilitate that the name of the 'ata_port' object changes from 'ata'
to 'port'. To provide backwards compatibility I've added config option
CONFIG_ATA_SYSFS_COMPAT to create a compat symlink in the PCI sysfs device
directory with the name of 'ata'.

As usual, comments and reviews are welcome.

Changes to v3:
- Included reviews from Damien

Changes to v2:
- Dropped patch to change PMP naming
- created compability symlink instead of full sysfs objects

Hannes Reinecke (2):
  libata: rework sysfs naming
  libata: CONFIG_ATA_SYSFS_COMPAT

 drivers/ata/Kconfig            | 10 ++++++
 drivers/ata/libata-transport.c | 62 ++++++++++++++++++++++++++++++++--
 include/linux/libata.h         | 53 ++++++++---------------------
 3 files changed, 84 insertions(+), 41 deletions(-)

-- 
2.29.2

