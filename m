Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E47C6FD1F
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCWDi5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCWDiq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2023 23:38:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FFE388
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679542724; x=1711078724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mh6shQ7fpkoeC7Fx65fFuhoITwX3yL2ZjHH7GecROx8=;
  b=e1ulQrTeCvjuANzJLuZ9sqSuHleAPfTqVG9l/+BZRD/POW3/FUF7sfP2
   c035DgpDBzxBjbOUQzqhaopSj5fr9gkliShf+bDSFhRcv6IhjdC5wtOXK
   JBLzmT00tpv/VGBA0NC8zRySXAkEyeeSzqgkaP/UCFwfvNOqEZgejsivP
   kPSOqAoMiQ1ZGNjmi+tlBX7SAQlTchdq93tXUWEUHz1q9aD6hrHkRERJ3
   3XU9Xwq7dDfvtWq5B7YXA/0gqL9dzEvIh8EcPrbYT/+EYlsh6EFRM0Cmj
   8l3bSzaWWPEwoxS89+WL5UWx0zW49sIFAnGFXS0Pg6dwigBUhcQXR2SRL
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330711522"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 11:38:40 +0800
IronPort-SDR: 4Dbnj0qyZN6KJ4hWEwEYEStb5wmDCMpGqkTwR4Wr1K18TeAL7eRq/TK5FvJx97NelkGaootQon
 Ia6eldiykZRmw6Lwqo6PzNPkq+oHHE18aCi9I7oXGclcURys4/rpmj1KU6ENXRctOl0XdDmxQu
 oosLbs2Ipg6k+3O2o0vXAUQtOQj4E+/t0MKXFz/Wbqzo+s+zpTX79sARl5Fero+dd8k6X+5upg
 3DKXAZuGQnIyI2z0iUVRyaQKgcSOWYcKXuqvOXqM+ZVq2G2u1npd1TmBTzj8vc8MOI4H+8gShb
 lSQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 19:49:16 -0700
IronPort-SDR: AqHzQ+AhxCg7zIgYKsgDMkmM8D6ACe1VgJQzcpJilmZfUs9DqVoRkn0+1dsHu6FuYR/LkhNSO9
 I5Wru1210yRZ0F44aFDmMUjFa7/Ne+9zY8qsfCz7dGuCFjpatiGI/IjVMcDw0Al+rQ+T0wmbJJ
 k/qL7MqsPwGIBjk+CC/K8t5UME/9V3/YY0BUsDIMQCPAvePiLyYiL3nTBFBGkIJyszfnIxXKWT
 jNccFYvsjazcKl73GnrBySuMZ89mR0iN7RgAivfUYBcl2IJnXdk+XFUdywNLa9k9BVy5kB/1dk
 Uyc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 20:38:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhrfS4FZqz1RtVp
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679542720; x=1682134721; bh=Mh6shQ7fpkoeC7Fx65
        fFuhoITwX3yL2ZjHH7GecROx8=; b=Zjszx4RtXsNm6eDyhXG36l5A9K/MwvqUId
        9zR9nURVQiY5yPib5ZvJ74MKynCYsaxNhQ9FdvEb7tXpo8AU3WWMfsbWge6a8CR5
        ldMJ4cnSbU31F2SLGTeAoI4/kt4raJ01qCDSSTaprZSnrKFXhyqW0DfAC7TB3SzS
        9A0gdZ0MSmwqx+Y7RkoLOaArSDqerR9dKP1QLZD3zR7b4je3ZUv4awU0yaJs/cS8
        zCQeXNWR1qHWep1HbdRzAgpoaKDLc6Tvs41LUcWqwRrGnxtX5wtLZJeTQpcwd1ri
        VYawzB3+GnFYy26smBs4xenpiOvHl9xuQTZBDeonAkjF5oaMFexg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G-AWqbHrE3zX for <linux-ide@vger.kernel.org>;
        Wed, 22 Mar 2023 20:38:40 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhrfR4kyvz1RtVm;
        Wed, 22 Mar 2023 20:38:39 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 2/2] ata: pata_parport-bpck6: Declare mode_map as static
Date:   Thu, 23 Mar 2023 12:38:36 +0900
Message-Id: <20230323033836.352672-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
References: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Compilation C=3D1 of the bpck6 protocol module generates the following
message:

drivers/ata/pata_parport/bpck6.c:62:5: warning: symbol 'mode_map' was
not declared. Should it be static?

Fix this by declaring mode_map as static.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/pata_parport/bpck6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/=
bpck6.c
index 295dbe5cdaa4..76febd07a9bb 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -59,8 +59,8 @@
 #define PPCMODE_EPP_WORD	5
 #define PPCMODE_EPP_DWORD	6
=20
-int mode_map[] =3D { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
-		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
+static int mode_map[] =3D { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_B=
YTE,
+			  PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
=20
 static void bpck6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
--=20
2.39.2

