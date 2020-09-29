Return-Path: <SRS0=lnsX=DG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A541C47423
	for <linux-ide@archiver.kernel.org>; Tue, 29 Sep 2020 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB562158C
	for <linux-ide@archiver.kernel.org>; Tue, 29 Sep 2020 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601377969;
	bh=jsNYaKVgFHpLC/ktuWsKIVg7iwR9LxHLmxcBHAgJsHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mq/bPDQCWcgLYyedzPq4kNW0M0uYJ9lhfYbopETkSdVOHdmpkswljkb/8FEYXUWP2
	 bTei7gBYNz2aAqaknOPPCxL0tbn3fmTmwcLuxt+tHyse0F2PzUcy5n6kIXbRJHwb5L
	 G9aBBdpd0HOBhv+JU21izjsE9PL86Fr4aQd4sKgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgI2LMr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Sep 2020 07:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgI2LMX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Sep 2020 07:12:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFFD21924;
        Tue, 29 Sep 2020 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601377943;
        bh=jsNYaKVgFHpLC/ktuWsKIVg7iwR9LxHLmxcBHAgJsHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1EbL+J/xOGZNZaTjf/INP6fzzt+Th8AASJXGgxSRAuuk1CKQFsdJhjLULoSYaCsu
         +u0sQtouuW4qtG70zZqnt1sq3bLACq4CwAvcP3PXJ/D+y38+mlGS/yEhf61lzFRAsj
         8aK4g4C34Ft08ei6rQLnREhqn2hybAoO9WSA0+5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 4.9 121/121] ata: sata_mv, avoid trigerrable BUG_ON
Date:   Tue, 29 Sep 2020 13:01:05 +0200
Message-Id: <20200929105936.175135632@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929105930.172747117@linuxfoundation.org>
References: <20200929105930.172747117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit e9f691d899188679746eeb96e6cb520459eda9b4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/sata_mv.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2111,12 +2111,10 @@ static enum ata_completion_errors mv_qc_
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


