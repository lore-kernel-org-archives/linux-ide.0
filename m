Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F2C77B7A
	for <linux-ide@archiver.kernel.org>; Fri, 19 May 2023 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjESKlJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 May 2023 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjESKlI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2023 06:41:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806B1987
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2023 03:40:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af28303127so1861961fa.3
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2023 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684492837; x=1687084837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyshnJz2lezLJiGdca0o2MLpK1ZKClGTRjmIhGDZ1+0=;
        b=ef/8ydJdMosMbO6uImhw0qQrV4rlwreC9VG3cfh3N0VPU82GjAtBB5TpGODuHuSLaT
         YuSCYh0FWAD9amD+TkmFBHOo/UwiqDvFjbJvpA1FhTin77/sMu1Yx4CnNNwcrmzd9VcQ
         DgdS33Co0f7s4+9OKkgaT3lk2zK1FxR2RPj0/bBA1dXzV4fEbABRaLLCOaiOqoodPmmo
         CIph45Ev1Ov2L2x9UvYl+6Xfigwid41TabmdRREZaVYyM80Hd4l4gsRBNw9doMeOCNt2
         yv/dmp6rY+sIcvLhL2eKWYDxNRWoN6KQaFrMviJ6b1FzjMdSVWOKp8zxgTzEwpdy0pAZ
         WMiQ==
X-Gm-Message-State: AC+VfDyWx8qnV1enBsQuT+NdfOa4xilJy467fKGT118uH9ZEzYmUxSJy
        LuEqv/3R+tHzfD89Hb8wKhW/ngZpMWylBQ==
X-Google-Smtp-Source: ACHHUZ59UtLrXOtbht7UsNH9jkhLJG/qner5pdcU8oZQE7RVxkFv8Knmmqexet+NbjqhttoJZ3HoNA==
X-Received: by 2002:a2e:90c5:0:b0:2af:1817:26e1 with SMTP id o5-20020a2e90c5000000b002af181726e1mr621034ljg.30.1684492836654;
        Fri, 19 May 2023 03:40:36 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.246.252])
        by smtp.gmail.com with ESMTPSA id n17-20020a2e86d1000000b002af01da6c67sm770629ljj.32.2023.05.19.03.40.36
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:40:36 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 0443C425; Fri, 19 May 2023 12:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1684492835; bh=iUpmILWbh2LGnmIMrJ+9hC3WposRF+i/7qD/PRjjOlM=;
        h=From:To:Cc:Subject:Date:From;
        b=hYN0r9cM7KOYGZcfudlYJ63EZLlbFCLsDGhH1GIYTQln3bF/cyXhVMtt7YzFvbbfT
         EV6HRAn5qd/10xusCBb5jzL2BEffhrz9GmaQMdgHB5/cu3Rf/RRsIIT0b65ey6yV6K
         zX/2tPQNl8TbWVlQtaRNNH8Jj5zJpqVPP5lPeBXE=
Received: from x1-carbon.wdc.com (unknown [129.253.182.60])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id D098E38A;
        Fri, 19 May 2023 12:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1684492829; bh=iUpmILWbh2LGnmIMrJ+9hC3WposRF+i/7qD/PRjjOlM=;
        h=From:To:Cc:Subject:Date:From;
        b=NgrQi5cP4CueXXeBeXc7Fzz6ReFoZMN5s6aR9Mr4ityxn0Abz4CGfwMktNTn/+TON
         vnEFy2NlveTDe7sbHqlbpwgpSatw0S2GALdP+aINnQeMOOUMjPI1DkMBh8wFrEwEhF
         BEXhHVyqX3SDiFt/PNX+ISVkwdG1twmFJvRMTt3I=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-eh: Clarify ata_eh_qc_retry() behavior at call site
Date:   Fri, 19 May 2023 12:40:02 +0200
Message-Id: <20230519104003.37843-1-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

While the function documentation for ata_eh_qc_retry() is clear,
from simply reading the single function that calls ata_eh_qc_retry(),
it is not clear that ata_eh_qc_retry() might not retry the command.

Add a comment in the single function that calls ata_eh_qc_retry() to
clarify the behavior.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a6c901811802..170326dc1073 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3814,6 +3814,12 @@ void ata_eh_finish(struct ata_port *ap)
 			 * considering both err_mask and tf.
 			 */
 			if (qc->flags & ATA_QCFLAG_RETRY)
+				/*
+				 * Since qc->err_mask is set, ata_eh_qc_retry()
+				 * will not increment scmd->allowed, so upper
+				 * layer will only retry the command if it has
+				 * not already been retried too many times.
+				 */
 				ata_eh_qc_retry(qc);
 			else
 				ata_eh_qc_complete(qc);
@@ -3823,6 +3829,12 @@ void ata_eh_finish(struct ata_port *ap)
 			} else {
 				/* feed zero TF to sense generation */
 				memset(&qc->result_tf, 0, sizeof(qc->result_tf));
+				/*
+				 * Since qc->err_mask is not set,
+				 * ata_eh_qc_retry() will increment
+				 * scmd->allowed, so upper layer is guaranteed
+				 * to retry the command.
+				 */
 				ata_eh_qc_retry(qc);
 			}
 		}
-- 
2.40.1

