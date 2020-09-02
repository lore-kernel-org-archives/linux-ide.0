Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC53C433E2
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2CC20758
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599064373;
	bh=phKkQQ1aN7O/ugGWoKkTDxN5bLWId9pkfkFu8neVP2M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KHDfeN/lAyX2R919JScHEhw1oGUpUmdvdPJ1CixbGaFE7fgaxzGUEYolI1lr7q5uU
	 11qZbWhU9f1i3Hg+tZwSTxMr7tLFBG01VlyWu0PJiauIAo7R+dTxS86FpLR8x+boUb
	 VjkYNM1Xa0r1QAbjo456xA3oqe1kKJxSE7BrLh4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBQcx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBQcv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2020 12:32:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA940C061244
        for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2020 09:32:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so4032021qtr.8
        for <linux-ide@vger.kernel.org>; Wed, 02 Sep 2020 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YtdCrq9IL3YvWGWpLFHgunxhN3nTePzTmcFQohfU8YE=;
        b=Kqd0ks6cmslbdSJX3k32gmCWjHYXRSyhpIaVZR4oIkmZ9f/4voBEUTWZ6xxt8SkWCL
         L60uXe3VmtjknMTFL0vlQtD0+kvMVE0Fj2DOJsl4RBEsF1fP6CT9UFarVhHpOULx2fdY
         zxRmDo9Z/D0pXzC2vlDEWGRzObOrl+/m7nefLnvwwddx/64KUnYFqwmLoXLfYYOmNd+v
         PrsgjFhEoec02Lcs94Y+VQTU9iw+EEu2re6oWUIhR+f1U3eKjPBhxMwrTvEV1YGulEFU
         Xt4duS3jQgV2GMdZws/yCdTCyNPR9xaONeYiV7beyrS3VA4YBbmf4RXez1u1Gd6wU/WR
         BbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=YtdCrq9IL3YvWGWpLFHgunxhN3nTePzTmcFQohfU8YE=;
        b=Uw/Wva2ZdeZMMyCOmbNjnMavUHpNTkeuTtN0scuoOndcAXOlBCnEGGeGZTHBcS9byn
         AEA9PUwbNph35I4bmB7uh+1ZqT+Db6xgsVJ8E+2FocAztJ3oj/+7P7lYy5Fqny9DQqZx
         E3DsZVzVDDMC1BuAvzBPjNgQp2xGt0jbnsqAGEqqIBNITro9+rSpPhNZnWn57/F7ewGT
         DO/SlWjge85sO6he/VFVyHELFGnzcLn/xPHz2R65IR1XNRJ1UaVnC8RNtEvveFwafq0k
         97SbLGzujaujET6BfvhMC3fgSGwr+38FejDZPNXh/5iijCdkPle6UjLl2GYCr3JIhSog
         61mA==
X-Gm-Message-State: AOAM5323Ll6fWUZYxBlfoqZaN5YNT1urQ5WwEjXqhnaWFchxSX+1ckwL
        73aWYD6ajPTsTgAjFXdk+PfDILpEvgOaLw==
X-Google-Smtp-Source: ABdhPJzNMOwvKs7Wg093+73undE72TomNNJuan2r7ONCdRwoTB84CEQrSeASnHuca8ip0OIggHuEQA==
X-Received: by 2002:ac8:4d07:: with SMTP id w7mr7520556qtv.243.1599064370056;
        Wed, 02 Sep 2020 09:32:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id e90sm4542688qtd.4.2020.09.02.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:32:49 -0700 (PDT)
Date:   Wed, 2 Sep 2020 12:32:45 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, kernel-team@fb.com, karthikgs@fb.com
Subject: [libata-5.9] libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply
 to Sandisks
Message-ID: <20200902163245.GH4230@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

All three generations of Sandisk SSDs lock up hard intermittently.
Experiments showed that disabling NCQ lowered the failure rate significantly
and the kernel has been disabling NCQ for some models of SD7's and 8's,
which is obviously undesirable.

Karthik worked with Sandisk to root cause the hard lockups to trim commands
larger than 128M. This patch implements ATA_HORKAGE_MAX_TRIM_128M which
limits max trim size to 128M and applies it to all three generations of
Sandisk SSDs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Karthik Shivaram <karthikgs@fb.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c |    5 ++---
 drivers/ata/libata-scsi.c |    8 +++++++-
 include/linux/libata.h    |    1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1a82058defdb6..f546a5761c4f2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3868,9 +3868,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
 
-	/* Some Sandisk SSDs lock up hard with NCQ enabled.  Reported on
-	   SD7SN6S256G and SD8SN8U256G */
-	{ "SanDisk SD[78]SN*G",	NULL,		ATA_HORKAGE_NONCQ, },
+	/* Sandisk SD7/8/9s lock up hard on large trims */
+	{ "SanDisk SD[789]*",	NULL,		ATA_HORKAGE_MAX_TRIM_128M, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4ce4cd32508ce..70431912dc635 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2080,6 +2080,7 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 
 static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 {
+	struct ata_device *dev = args->dev;
 	u16 min_io_sectors;
 
 	rbuf[1] = 0xb0;
@@ -2105,7 +2106,12 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	 * with the unmap bit set.
 	 */
 	if (ata_id_has_trim(args->id)) {
-		put_unaligned_be64(65535 * ATA_MAX_TRIM_RNUM, &rbuf[36]);
+		u64 max_blocks = 65535 * ATA_MAX_TRIM_RNUM;
+
+		if (dev->horkage & ATA_HORKAGE_MAX_TRIM_128M)
+			max_blocks = 128 << (20 - SECTOR_SHIFT);
+
+		put_unaligned_be64(max_blocks, &rbuf[36]);
 		put_unaligned_be32(1, &rbuf[28]);
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77ccf040a128b..5f550eb27f811 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -421,6 +421,7 @@ enum {
 	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
+	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
