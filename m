Return-Path: <SRS0=Wagi=56=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74966C2BA19
	for <linux-ide@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4213920678
	for <linux-ide@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883178;
	bh=pkQRKk4Q3BJwEsZPq9Rvl8GhUQxw4EhOBSPeWUeyTXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMx/TwBkrA6v13GZitCPJuBDEMXkm6Dvo8whqU1SkNEFw13p0/XEtDVueFodjW9fe
	 Besh2xlca8mpiBSDvGANuR3o8eoHsN1nFq1XkhvTdXFYI+vZmB0DQ+0UPq9//2u8xo
	 47Jqa0ETbekMxm48PLmheLLyt0XHOneWWcbWH5Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502459AbgDNQwc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440373AbgDNQtR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD4C221EC;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=pkQRKk4Q3BJwEsZPq9Rvl8GhUQxw4EhOBSPeWUeyTXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rG5nVl1W0Rid3dG6nLfg4tMmA1DCW3FdHWe3eGgKITbBHXDH/TchxjTJtcazKc+3d
         puylXEIwwgNpsv8d6R8mE+cNxmdX/0dkZO4ZgaMsYW1I6wEaqeDQdbKoWeP2Fh26PN
         nnj+98DwIsnMxETSV0SYEMQjrN1HycbwkRRrcDsE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068nE-Fy; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH v2 29/33] ata: libata-core: fix a doc warning
Date:   Tue, 14 Apr 2020 18:48:55 +0200
Message-Id: <9a21444df75c46095c4b1839d2061d19c9addcff.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The docs toolchain doesn't recognise this pattern:

	@link->[hw_]sata_spd_limit

As it can't really process it. So, instead, let's mark it with
a literal block markup:

	``link->[hw_]sata_spd_limit``

in order to get rid of the following warning:

	./drivers/ata/libata-core.c:5974: WARNING: Unknown target name: "hw".

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beca5f91bb4c..69361ec43db5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5209,7 +5209,7 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
  *	sata_link_init_spd - Initialize link->sata_spd_limit
  *	@link: Link to configure sata_spd_limit for
  *
- *	Initialize @link->[hw_]sata_spd_limit to the currently
+ *	Initialize ``link->[hw_]sata_spd_limit`` to the currently
  *	configured value.
  *
  *	LOCKING:
-- 
2.25.2

