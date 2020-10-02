Return-Path: <SRS0=wLrF=DJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C59C46466
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A5420796
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601678583;
	bh=ja+EpcG/jvtrD7xvepje1LK8+8EBKYbHikZ8TtuyvxE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=v8JcYbSfKBdqGERYqeelbGt4Bub9DzZUdC4rkk3RbLSmGvnGN0XGZ3GwWYCf0mD0g
	 UOTJrrJ9sfKCFurvm4UBjH4uV/US2xWB8DgSx3clEbtlmNRiqBG/lqaOQMCph0bk/g
	 eCFSHL1Ay0cqhmtUtY32UIkuywywFNlB/PoXuhY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJBWnD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJBWnD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 2 Oct 2020 18:43:03 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C5C206C9;
        Fri,  2 Oct 2020 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601678583;
        bh=ja+EpcG/jvtrD7xvepje1LK8+8EBKYbHikZ8TtuyvxE=;
        h=Date:From:To:Cc:Subject:From;
        b=pxQhleCVf4C9Qr3ENUJQ6KxTnnWBIEZ10UewyfHfJ/d/nsgKPU6c6gQlmDqhdJjLM
         zvh7iyh+YCxXnpo8sBT5ComsfrubzLLbJRaTVm83Zku1W3t+FgKIHF6UAlVZzIcQRv
         XywwHVEqCITUJSEwJMd2XhakaUh+jy3z1TqYdtWs=
Date:   Fri, 2 Oct 2020 17:48:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] pata_cmd64x: Use fallthrough pseudo-keyword
Message-ID: <20201002224852.GA463@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace /* FALL THRU */ comment with the new pseudo-keyword macro
fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ata/pata_cmd64x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3134eaec9e3d..1d74d89b5bed 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -461,7 +461,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 1:
 			ppi[0] = &cmd_info[4];
 			ppi[1] = &cmd_info[4];
-			/* FALL THRU */
+			fallthrough;
 		/* Early revs have no CNTRL_CH0 */
 		case 2:
 		case 0:
-- 
2.27.0

