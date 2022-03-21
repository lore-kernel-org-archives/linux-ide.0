Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A613C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 14:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349717AbiCUO6e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiCUO6b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 10:58:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC107628A
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 07:57:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0FC5C210F1;
        Mon, 21 Mar 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647874624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=26s5nW/mETOfrOgbfuL2FL4lSIGRiv0Bt+IGeZRSg7g=;
        b=Z2NMlMOtkhmC+G+qI1bkqLbotWx9WajJaNNzH6W24/soE859Bfe+ewZ7KF5ZTgoQ0Q0Srb
        PNYkRO3Gu11FJeotJ7pu2GQ47+f+I/J7zLH2X/q3omkFucPXzNHlm/AmLexTeGrEMr/Sq+
        THu3w3ckt3WRjAVhztWmX8MZ80olVkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647874624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=26s5nW/mETOfrOgbfuL2FL4lSIGRiv0Bt+IGeZRSg7g=;
        b=AbRrK7a5v8UfnOAxfWYO1gXUKlJDnge67cyCMyFhW59zvzLIm1Fu5gLvu3LiGh+sWtFH7W
        tnex4YwoXRfh2xAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CE2B7A3B87;
        Mon, 21 Mar 2022 14:57:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BAD90519382E; Mon, 21 Mar 2022 15:57:03 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] libata: sysfs naming
Date:   Mon, 21 Mar 2022 15:56:56 +0100
Message-Id: <20220321145659.97150-1-hare@suse.de>
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
to 'port'. To provide backwards compability I've added an additional
class object for the ata_port with the name of 'ata'.
This additional object can be disabled with the config option
ATA_SYSFS_COMPAT.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  libata: sysfs naming option
  libata: CONFIG_ATA_SYSFS_COMPAT
  libata: sanitize PMP link naming

 drivers/ata/Kconfig            | 10 +++++++
 drivers/ata/libata-transport.c | 55 ++++++++++++++++++++++++++++++----
 include/linux/libata.h         | 54 ++++++++++-----------------------
 3 files changed, 76 insertions(+), 43 deletions(-)

-- 
2.29.2

