Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B3C43219
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhLUHW7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbhLUHWq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2CB021F3C4;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juQxGrBuQSDY+nHKvca8xG0A60mcAh6NWwb39qmQKE0=;
        b=ZrCkF44WZ9WQS+IufpVIK0WItTmFe/O+qkkr/9Iw/hqK7ksUJ6RkgeuQ9JevzVMzmwvFkP
        6x5w+kZickkOg7nzpzB5G8bB18TRB7j40md3G8x51jJZoBCyHYGrtZWZLXY6O4YFO4RA+A
        S5OURnNttGE7mamSpEG0v9pxfBsA7L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juQxGrBuQSDY+nHKvca8xG0A60mcAh6NWwb39qmQKE0=;
        b=2j12yeK91iNnCTzI8Hyjh4EJNcC3yUDcdA9kwTUodZgGjzeRVvaOAObtpleonVJw+nPM8V
        285FdZwaqLhhn8Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2804DA3BA2;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2650351923B0; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 31/68] sata_inic162x: Drop pointless VPRINTK() calls
Date:   Tue, 21 Dec 2021 08:20:54 +0100
Message-Id: <20211221072131.46673-32-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
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

