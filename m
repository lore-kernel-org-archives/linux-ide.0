Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8882CC77B7C
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjEJWwl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjEJWwi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692B6584
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E62B821994;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hhKG1SWAsYDpesy8a3ANtfAeY1phfj1XOe5FeuvGzQ=;
        b=ERGHhbjRdGRk5to0vzJgvWFaJxNsoOrL3KS1be+SupUqGsu0lScA9wWEtfoFp+nTlplGdX
        4EIxeZAwoy3uh2vL61Pvt1C8cNs/DNxl6Ug3e9SUx5Jjin6Ai4fqM4A0GVne2UpKenk8MH
        ohu0vkHTkVaOMU3+83TwmL3oDPEAEng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hhKG1SWAsYDpesy8a3ANtfAeY1phfj1XOe5FeuvGzQ=;
        b=6X2p/ajDaQDXP4YZrpQu0u4lOozPXu/G7YHkVV+UOBqajrdiQvufQ0ygIKx/BSWwpw2MMT
        gpOlXdlwYBcGiZBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id DC4252C149;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D5F1351C34E7; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] ata: remove ata_sas_sync_probe()
Date:   Thu, 11 May 2023 00:52:09 +0200
Message-Id: <20230510225211.111113-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c | 7 -------
 include/linux/libata.h    | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 70da34a35c54..1580d5c880aa 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1136,13 +1136,6 @@ void ata_sas_async_probe(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_sas_async_probe);
 
-int ata_sas_sync_probe(struct ata_port *ap)
-{
-	return ata_port_probe(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_sync_probe);
-
-
 /**
  *	ata_sas_port_init - Initialize a SATA device
  *	@ap: SATA port to initialize
diff --git a/include/linux/libata.h b/include/linux/libata.h
index dbd3df0fb69d..ad5535ee61aa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1225,7 +1225,6 @@ extern int ata_slave_link_init(struct ata_port *ap);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
 extern void ata_sas_async_probe(struct ata_port *ap);
-extern int ata_sas_sync_probe(struct ata_port *ap);
 extern int ata_sas_port_init(struct ata_port *);
 extern int ata_sas_tport_add(struct device *parent, struct ata_port *ap);
 extern void ata_sas_tport_delete(struct ata_port *ap);
-- 
2.35.3

