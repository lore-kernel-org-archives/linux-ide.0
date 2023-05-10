Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D0C7EE22
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEJWwf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEJWwe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8A61A4
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D697C2198E;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7I6gEUsPDPLHJG5F6lFv3u01NDEKoye1kqcNxdWAgG4=;
        b=zvMdbZXErsOMeaVon5GpDSEVRI+FHK0IXwXHVxS7caqNJwl0Z4fWU8CZBNvC1K6hSb99M7
        UAfxR70VMpb1bVp5SKDNXst2BcyMoJ4Hz+EsQ7w5TUyFQ+yx4dOjYfLXljQdHOlY8tN3ie
        kceHVYPhTY0Nk5Z3wMtONL5L+jkti1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7I6gEUsPDPLHJG5F6lFv3u01NDEKoye1kqcNxdWAgG4=;
        b=lCHwhdCS3+VLZ9QZqghgIwSBeR0LRVNvZRPCaumLqV3zb2fKNYfPnUFDMoMJZbJhVKrl0L
        fJlGzCoJqsOXkXCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C9D952C143;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BA51051C34DF; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] libata: remove references to 'old' error handler
Date:   Thu, 11 May 2023 00:52:05 +0200
Message-Id: <20230510225211.111113-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

now that the ipr driver has been modified to not hook into libata
all drivers now use the 'new' error handler, so we can remove any
references to it. And do a general cleanup to remove callbacks
which are no longer needed.

Hannes Reinecke (6):
  ata: remove reference to non-existing error_handler()
  ata,scsi: remove ata_sas_port_{start,stop} callbacks
  ata,scsi: remove ata_sas_port_destroy()
  ata: remove ata_sas_sync_probe()
  ata: inline ata_port_probe()
  ata,scsi: cleanup ata_port_probe()

 drivers/ata/libata-core.c          | 166 +++++++++++------------------
 drivers/ata/libata-eh.c            | 148 +++++++++++--------------
 drivers/ata/libata-sata.c          |  77 -------------
 drivers/ata/libata-scsi.c          |  21 +---
 drivers/ata/libata-sff.c           |  32 +++---
 drivers/ata/libata.h               |   2 -
 drivers/scsi/libsas/sas_ata.c      |   6 +-
 drivers/scsi/libsas/sas_discover.c |   2 +-
 include/linux/libata.h             |   6 +-
 9 files changed, 143 insertions(+), 317 deletions(-)

-- 
2.35.3

