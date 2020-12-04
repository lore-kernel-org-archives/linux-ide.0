Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4DC4167B
	for <linux-ide@archiver.kernel.org>; Fri,  4 Dec 2020 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5183922B3B
	for <linux-ide@archiver.kernel.org>; Fri,  4 Dec 2020 17:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgLDRFd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbgLDRFc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2020 12:05:32 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5DC061A55;
        Fri,  4 Dec 2020 09:04:36 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFb5jkbz8sj2;
        Fri,  4 Dec 2020 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101475;
        bh=1nrU4kv3OysW0fIN8YAPdRnA0Y6QA6l/x40Yu9FDh5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYZ27PSO1nSOrpMLK69P2QVW18jG+Onjt1lGQHRl4ybs0lTXKjc2OM+fLiTeQroqb
         ONLcY6lsaiLiRxp5wgz17GD3f7uPmUXGxZqFmzdyw3jqt7F5mQUMCY3iSgNV+fzdXG
         AqxLzqc+RtQ2A7kRhg02MUR+BbO+BeuwrftbHR6o=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFb2HRxz8sfb;
        Fri,  4 Dec 2020 17:04:35 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 08/12] ide: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:14 +0100
Message-Id: <20201204170319.20383-9-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/ide/ide-floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index f5a2870aaf54..c0b1080e458d 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -495,7 +495,7 @@ static void ide_floppy_setup(ide_drive_t *drive)
 	 * it. It should be fixed as of version 1.9, but to be on the safe side
 	 * we'll leave the limitation below for the 2.2.x tree.
 	 */
-	if (strstarts((char *)&id[ATA_ID_PROD], "IOMEGA ZIP 100 ATAPI")) {
+	if (str_has_prefix((char *)&id[ATA_ID_PROD], "IOMEGA ZIP 100 ATAPI")) {
 		drive->atapi_flags |= IDE_AFLAG_ZIP_DRIVE;
 		/* This value will be visible in the /proc/ide/hdx/settings */
 		drive->pc_delay = IDEFLOPPY_PC_DELAY;
@@ -506,7 +506,7 @@ static void ide_floppy_setup(ide_drive_t *drive)
 	 * Guess what? The IOMEGA Clik! drive also needs the above fix. It makes
 	 * nasty clicking noises without it, so please don't remove this.
 	 */
-	if (strstarts((char *)&id[ATA_ID_PROD], "IOMEGA Clik!")) {
+	if (str_has_prefix((char *)&id[ATA_ID_PROD], "IOMEGA Clik!")) {
 		blk_queue_max_hw_sectors(drive->queue, 64);
 		drive->atapi_flags |= IDE_AFLAG_CLIK_DRIVE;
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
-- 
2.20.1

