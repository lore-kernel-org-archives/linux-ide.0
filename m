Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6375C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 12:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbiCXMdm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiCXMdl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 08:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE1A94E9
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 05:32:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A148421602;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648125128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B4lMmloBBmG3q7XtkmgHlDqDbvLflSp281lXks996Lg=;
        b=OGXLsZQNOvHHaWJGlWeuzK8uxBuLjUp/Q5am0fkiAuuG32MVZ3uzNIUyNH8V0H/W64vNdY
        ZflNj4zFIvHLbLm04Oul/CtdRjLbFRr20goL07Ry60Cd4SjIpeCSzpGdjg+ISAyxhmQnXu
        teQEhmkhwkyxmi1USQDTyyDfdTXzfk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648125128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B4lMmloBBmG3q7XtkmgHlDqDbvLflSp281lXks996Lg=;
        b=fBjbQVpNWt2j32u6vzeQfgwfEW9fVgV8s/IXDvPrUwUvGy1mqnyPe4mOgGOnm6W+KT61Ce
        56iq+ENNwHSQ2eBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 74200A3B88;
        Thu, 24 Mar 2022 12:32:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6854951938F9; Thu, 24 Mar 2022 13:32:08 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/2] libata: sysfs naming
Date:   Thu, 24 Mar 2022 13:32:02 +0100
Message-Id: <20220324123204.61534-1-hare@suse.de>
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
to 'port'. To provide backwards compability I've added config option
CONFIG_ATA_SYSFS_COMPAT to create a compat symlink in the PCI sysfs device
directory with the name of 'ata'.

As usual, comments and reviews are welcome.

Changes to v2:
- Dropped patch to change PMP naming
- created compability symlink instead of full sysfs objects

Hannes Reinecke (2):
  libata: rework sysfs naming
  libata: CONFIG_ATA_SYSFS_COMPAT

 drivers/ata/Kconfig            | 10 +++++++
 drivers/ata/libata-transport.c | 41 ++++++++++++++++++++++++--
 include/linux/libata.h         | 54 ++++++++++------------------------
 3 files changed, 64 insertions(+), 41 deletions(-)

-- 
2.29.2

