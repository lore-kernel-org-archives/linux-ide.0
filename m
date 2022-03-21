Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDACC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 14:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiCUO6g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiCUO6b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 10:58:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9676286
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 07:57:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09E371F37C;
        Mon, 21 Mar 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647874624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7tYLUG1kSpDFuVRn8P4IVyf6MB9nYWUCUPB9m0pP6Q=;
        b=rQUdOP2TNNT+dbehEPVkBuNnI7nUSeQWb3qmL35eR8iNVFOjiaJ8vcG3x1wtXdyqqDccEN
        PqDZH6XrO6wE/IH+ld2aG5Pehu+GSpuM8PFf9Dp6mHQaZiGsB2FsoNNvl8U5RDt3xqiq9Y
        mP1/3CDpcYL+iB0jf+6/E9vBSnrSuUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647874624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7tYLUG1kSpDFuVRn8P4IVyf6MB9nYWUCUPB9m0pP6Q=;
        b=mvBty78HQfkBujKH4cdiVTyxUatAjU3rBuvWFR31E0CMHKbb99YZzt0ICg/vAD6PXen5/n
        ARnyMcnASMNzDqBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id DA516A3B89;
        Mon, 21 Mar 2022 14:57:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C3F9B5193833; Mon, 21 Mar 2022 15:57:03 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] libata: sanitize PMP link naming
Date:   Mon, 21 Mar 2022 15:56:59 +0100
Message-Id: <20220321145659.97150-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220321145659.97150-1-hare@suse.de>
References: <20220321145659.97150-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Do not set the ata_link name to 'link<port>.<pmp>.0' as we only have
one device attached, rather use the simpler 'link<port>.<pmp>' to
avoid having the only three-level naming in libata.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index efca41039d1e..ee4aaf67234f 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -738,7 +738,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
 	else
-		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
+		dev_set_name(dev, "dev%d.%d", ap->print_id, link->pmp);
 
 	transport_setup_device(dev);
 	ata_acpi_bind_dev(ata_dev);
-- 
2.29.2

