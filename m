Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF43C4321E
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhLJHdG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbhLJHdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DE48321129;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juQxGrBuQSDY+nHKvca8xG0A60mcAh6NWwb39qmQKE0=;
        b=i/e7o18VLkdFyUn54OaifeU3d1Rj7poIY+6aP40b4JHTMFXwVvxK5h5XP0G987cU8Yquqe
        KbuPIxX57Sf3VWlzMUI71AHtraIQC3Fuzte2H8dPlGwMnejySkMUgkS0aRpfdIR3qzhiNs
        REfw73uL+xoo57PRBVeefE8dJq21k+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juQxGrBuQSDY+nHKvca8xG0A60mcAh6NWwb39qmQKE0=;
        b=X9M9O1uncMo+XLL+t90Bj2vRaWg/+lCieuIy1pDFvNpi3Oap8hcJpmnYA6DSu8sHjTl3j8
        3+FrrvQpv4hgb6DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D935BA3BB4;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D62D7519205F; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 31/68] sata_inic162x: Drop pointless VPRINTK() calls
Date:   Fri, 10 Dec 2021 08:28:28 +0100
Message-Id: <20211210072905.15666-32-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_inic162x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index b6239dae524a..781901151d82 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -488,8 +488,6 @@ static enum ata_completion_errors inic_qc_prep(struct ata_queued_cmd *qc)
 	bool is_data = ata_is_data(qc->tf.protocol);
 	unsigned int cdb_len = 0;
 
-	VPRINTK("ENTER\n");
-
 	if (is_atapi)
 		cdb_len = qc->dev->cdb_len;
 
-- 
2.29.2

