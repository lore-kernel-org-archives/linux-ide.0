Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC30C43217
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 13:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJGNXz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJGNXy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 09:23:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68A7B1D0
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665149033; x=1696685033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8VgPq5U0t0vJb+AYCrzGc7AJWCGR+A5uMMbrYz6SMo=;
  b=BVLW0/yqyelAZs+ECshqP7+zTZYg9t48Nxn2zakjTZ7jtxbw8x8nnMUh
   AgsKtD+ewx80bWKt5/m78UA1QtjwNlcY7MlVZzCzoD3VOh5UeW6S+KMRQ
   3+cehoJ/jlbVgcVBDOCSpTi4l+61Ij2xEcTvCLaRnI0b3J4H7WwOr2PlE
   z8l23+GkCqiQV9CK54jThf7jWNXNemgh2CQ+CW7/mTGayHagXrPGlK2g3
   E4SkYoW4savBzD83kJKE/VwU+8dVNy6gy3jegom6dOzSB83ICBdGK3TyK
   8voKri9yspfYil0BqO8JygnFMwzCPQrhToRNX7pgf0jryGcFQISpUxv8y
   A==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661788800"; 
   d="scan'208";a="213238164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 21:23:53 +0800
IronPort-SDR: HxA9S0GR5PbGMupcPYmi7fUYMYYBOJaHXXuni2KmC/M/VRrpUuNRp/jVgk4pl4K0DyxPr6OePV
 cmL0eJggCUO/NU54vKm0eHh07enJYuIECIPZ6fk7S7+C2sIfTx6XVAWxTpjgZn/3cfU0ea2B1x
 Vp9pVY0Tfc16bIJ/AR3XB0wC4PpYhPGmAGFulw7wxmkU3c36y7Nx0RAPkkALRAXDZWoXf+Hp95
 u60eq0FeWWptNauNYXPvF0VoETXaLVTC/KXCOXM6XB1KKwMAQmo0GOwB3dw46w7+8h8BkWPw4a
 r+PKVCFp9hXmhh8t0+QS+DLc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 05:38:03 -0700
IronPort-SDR: mGnB2MXQxNkDrMloWvEqqxrOOeScLJK5Qhnnn92O4FKn1I3HkUYU64YlyxfxnMbug49WubQf/3
 gL3J733yO0d4X9kVqru8toB3FGkOxfg0wZarkf9mOK6/DVF7xyknSn0lvXiIVXqjKCTrJhJlGK
 LZAiqchoRsA0LkBDKNhcIdop+W+I61XK3jb6mdiJdP3qSLFx9YMjoUAN+45MdyXtZHnSy5KFhM
 p/pNpANU2sOQoJaSSV5qwYUK9/ZkQ4tykLrwsnTnqGHABr+GGHov+DY/FuJItis/4vV+CXltex
 tnc=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2022 06:23:52 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     john.garry@huawei.com, Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 1/4] ata: add ata_port_is_frozen() helper
Date:   Fri,  7 Oct 2022 15:23:37 +0200
Message-Id: <20221007132342.1590367-2-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007132342.1590367-1-niklas.cassel@wdc.com>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

At the request of the libata maintainer, introduce a ata_port_is_frozen()
helper function.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/libata.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index a505cfb92ab3..d5ac52654b42 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1043,6 +1043,11 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 	return ap->ops == &ata_dummy_port_ops;
 }
 
+static inline bool ata_port_is_frozen(const struct ata_port *ap)
+{
+	return ap->pflags & ATA_PFLAG_FROZEN;
+}
+
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-- 
2.37.3

