Return-Path: <SRS0=E8D3=C3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F398C43464
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 02:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DF6238A0
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 02:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396181;
	bh=gFlss6PyCs3bnuohTwxiu4BoJJVf65zcD8wTeN2q2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzmRNqgPSNxr8z0QmzRTCTVspQqFBqPWcWTzQ6umjm9NmOiQJrLaE1FwwAJh50cor
	 gXilpO7slKyQcmocPC73V4994d8z8BYykcsnHicfuRpjn+NCqdjT0P1+6dLVn6jSdT
	 UDxh9AUl/DLEiHRz4U4lbGY68erF020xRUe+UPeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgIRC3j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgIRCPC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 17 Sep 2020 22:15:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C71623976;
        Fri, 18 Sep 2020 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395302;
        bh=gFlss6PyCs3bnuohTwxiu4BoJJVf65zcD8wTeN2q2ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S90D1fMRXmZl5oLpEmasKVSTvsJox7KTjRJhp9ewyg4KCZA2RzrnSphjZKvriWlX3
         spRxV6QRM9z7OkIuzqns8G9b3yJlIYflqkfit8Ed2lG4fT+Quzzt5q8bPjqGbMDMbZ
         R0nEBqbm38gQ2rEp0rpovKxLnDVIIBi1DuAj4vkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 05/90] ata: sata_mv, avoid trigerrable BUG_ON
Date:   Thu, 17 Sep 2020 22:13:30 -0400
Message-Id: <20200918021455.2067301-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021455.2067301-1-sashal@kernel.org>
References: <20200918021455.2067301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit e9f691d899188679746eeb96e6cb520459eda9b4 ]

There are several reports that the BUG_ON on unsupported command in
mv_qc_prep can be triggered under some circumstances:
https://bugzilla.suse.com/show_bug.cgi?id=1110252
https://serverfault.com/questions/888897/raid-problems-after-power-outage
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
https://bugs.centos.org/view.php?id=14998

Let sata_mv handle the failure gracefully: warn about that incl. the
failed command number and return an AC_ERR_INVALID error. We can do that
now thanks to the previous patch.

Remove also the long-standing FIXME.

[v2] use %.2x as commands are defined as hexa.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_mv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 2f32782cea6d9..2ec37a038eda8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2111,12 +2111,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
 		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
 		 * of which are defined/used by Linux.  If we get here, this
 		 * driver needs work.
-		 *
-		 * FIXME: modify libata to give qc_prep a return value and
-		 * return error here.
 		 */
-		BUG_ON(tf->command);
-		break;
+		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
+				tf->command);
+		return AC_ERR_INVALID;
 	}
 	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
 	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);
-- 
2.25.1

