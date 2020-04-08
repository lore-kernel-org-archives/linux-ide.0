Return-Path: <SRS0=LmOQ=5Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A413C2BA1A
	for <linux-ide@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D452075E
	for <linux-ide@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360933;
	bh=pkQRKk4Q3BJwEsZPq9Rvl8GhUQxw4EhOBSPeWUeyTXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRbiVaaDBJW73dACZ3LG+spd1W1mDWc2HvVGpKxYZ3cPGOyb6coIv8iuv0HjEnp/c
	 MrS089k/gdgFKBAh8lVUgtV1MsYNQpaYF5MaXmu9p+Osz4WaHe9GhS4JmUKAQq+MYr
	 S+darXsKkYjZlMju57vkoK22qWfulu3y6yX6tiWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgDHPsv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbgDHPqc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8AD215A4;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=pkQRKk4Q3BJwEsZPq9Rvl8GhUQxw4EhOBSPeWUeyTXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVsYDw/hg1IPkOLfiOqWetfXQhzaJ8qZ7bJQHbLy6BAC9Fa6hVGzFYBXLTOU5Jnhd
         VrLtZCyT8j0ovJNGbnwkz78SjqV/8DtXAdXC15UTBDy8OrQxx8JrIe9KMr0+uXmC5J
         Q/wLE6rbh+xTqCCqrIZ/ZQFSSqO0K/HLYN+W+w+E=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBI-IH; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 13/35] ata: libata-core: fix a doc warning
Date:   Wed,  8 Apr 2020 17:46:05 +0200
Message-Id: <5fd12ef049c330fe62eb0c23b61e8bea2812e445.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
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

