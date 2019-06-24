Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB6C43613
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE020657
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561393976;
	bh=Kt0T+dY3iljzRaPT++FbeHmexddgyZCJXMDJJnEofOc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NLFRKGMYcdaLub7piWUYDo+bVpFYTP7CGCEzFzwCfuFt69uNWIJFqGg0woRi1cpxS
	 zsVF0wPmLq832SyvxX/zTyRAGk/7fvfAaoq9u46al4bBJXnSqM/xcTk3qsQRECDzCL
	 va4t7BrdKb0w1YhDg0qBo7C8RUJ9YpokO9k8iGY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfFXQcz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:32:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45661 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfFXQcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 12:32:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so15112632qtr.12
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2019 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ken+LLCLRX9Vh2vo9iTsa0wVWU4INc2PxLJTpiRCxrA=;
        b=LQw4F4pZiVH+T5s9qVKBMilzjjZD0o33pyddJ92y5RaERuO0VQcjFGC5U/1YLpFVXt
         yMSfH1YTuSo6rLfbfA1WixnJTZkm/7kSYZq7Fi5Z1Upl0BaQ0xo04vHwjqpEIo/sfJ5v
         Ly5FOuoXF3k/KDvwHVmuQlXX4p3cDZ4qjZbOKdQw5pfSAYaR4nUj+6g0F591IY6WXGve
         XF4npRQNJBiyjyVZaSAob293ojBfaBuxewgbZf/8c4EJLvyvICnoLz9pJIL5uZh/kj0c
         1hGAww5kuzulMoprdujnpR1KItCSTf6lc5ACjEqhn7MXIJnVRLkFytA7fLUA01WH+6V5
         XLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Ken+LLCLRX9Vh2vo9iTsa0wVWU4INc2PxLJTpiRCxrA=;
        b=is3NMlP2dpCB0gz7/ULgHIKaRktQCO4V7hAKzmNwgXWeY7SG6maX6YrQJuJ/UBCztb
         1APZ3LJtLkmGxEihz70J5klvx3D4KFKepg6u5n0lg643hig4rXgZ6enL2d2kZuARWQG5
         +WD/BFeiTrT8r/4jM2SA1cMCLV/xM8PzcrHrO18wwRiOKEm6LIJy0mjlJEHxo1nuMNqQ
         q1qwJ5VtAMeTioGhyn47rQPC+ASXPvMn9P9eav+UN0N5A4vIyObhBmhEcbXJ97ZOkXpv
         CrBuc+955ql2Mj/DADqGGSUNuL7aSDdWVdf4IaL1Ww/8oD29EKocVmwexZAGtuL4cWaD
         xfmA==
X-Gm-Message-State: APjAAAUWDwCODbxgqJi741w8kzo6/nN8ZBlQ4cUpZ82vne9uxE0LO9yz
        IQoDpDzBBtihyjJtMJMFd04aSKYx
X-Google-Smtp-Source: APXvYqz2nuHydv1q3HdIawAvoDtszu7ccM80TjGwDIvfZdhP59VQ0wi5/taRZJw2cRjhfmmX1vIKlg==
X-Received: by 2002:ac8:360d:: with SMTP id m13mr80994205qtb.105.1561393974150;
        Mon, 24 Jun 2019 09:32:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8b21])
        by smtp.gmail.com with ESMTPSA id j79sm6776291qke.112.2019.06.24.09.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:32:52 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:32:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        kernel-team@fb.com
Subject: [PATCH] libata: don't request sense data on !ZAC ATA devices
Message-ID: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ZAC support added sense data requesting on error for both ZAC and ATA
devices. This seems to cause erratic error handling behaviors on some
SSDs where the device reports sense data availability and then
delivers the wrong content making EH take the wrong actions.  The
failure mode was sporadic on a LITE-ON ssd and couldn't be reliably
reproduced.

There is no value in requesting sense data from non-ZAC ATA devices
while there's a significant risk of introducing EH misbehaviors which
are difficult to reproduce and fix.  Let's do the sense data dancing
only for ZAC devices.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>
---
 drivers/ata/libata-eh.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9d687e1d4325..3bfd9da58473 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1469,7 +1469,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 	tf->hob_lbah = buf[10];
 	tf->nsect = buf[12];
 	tf->hob_nsect = buf[13];
-	if (ata_id_has_ncq_autosense(dev->id))
+	if (dev->class == ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))
 		tf->auxiliary = buf[14] << 16 | buf[15] << 8 | buf[16];
 
 	return 0;
@@ -1716,7 +1716,8 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
-	if ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary) {
+	if (dev->class == ATA_DEV_ZAC &&
+	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {
 		char sense_key, asc, ascq;
 
 		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
@@ -1770,10 +1771,11 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	switch (qc->dev->class) {
-	case ATA_DEV_ATA:
 	case ATA_DEV_ZAC:
 		if (stat & ATA_SENSE)
 			ata_eh_request_sense(qc, qc->scsicmd);
+		/* fall through */
+	case ATA_DEV_ATA:
 		if (err & ATA_ICRC)
 			qc->err_mask |= AC_ERR_ATA_BUS;
 		if (err & (ATA_UNC | ATA_AMNF))
