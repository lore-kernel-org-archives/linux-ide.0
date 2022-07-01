Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ADEC43334
	for <linux-ide@archiver.kernel.org>; Fri,  1 Jul 2022 00:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiGAAtG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jun 2022 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGAAtF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2022 20:49:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5D2A255
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2022 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656636542; x=1688172542;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r0l5+r2ZWjM1GCTDoybfZ7hI2CFa1+Bw47L/ZyVPJzw=;
  b=mOhzIQYw08rdsj+WQMQz50vTw2OMxY/Pz47DTm+wbpsZ8kJVgGAMk4+j
   LV9NBzBY/6H3UH7diJkWSpu4Qr8Oeefq4ao6ufTvbXFyZtdqNoAGBiiwG
   f32hcWIKwHDv8JPLFKg8D0Qhhgkz16dHxXHaYG/xttfbzfevswfc6BvoQ
   WD8ZDWy+58koyn3UDk3ptQy8vH9H+mGkLm3I5aeNYQvs3bxN2EQZFxvZv
   U1bfz4OmkyfTQNKvvOi6ecCCQ0SmkieIX0W+n/M93cR98hVFnwwcqnYu3
   /YF1Esc2RoQbW7nUDUUsJlN+WnhRbmopSpAjqwWtmS4BM5s9DobCexdEW
   g==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="308864558"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 08:49:01 +0800
IronPort-SDR: XOgu3AzLZcOsZ9kD9Y05UGFQ9myHfbTJf/JbbNWDMMF7OJgjsLz/5GLUu+8gm5esQRLLk8qkOD
 AIvK5PG/CVjPf0f7EjsHJzW8OgW1rWfjfIUwBkyKW9Jcsl3jaNAexfPAdVXfpKx8vGcIBNKYBe
 ya1XgyOljgkBp/S/wKG++wqhNJ8JwX/ssdiSH205ZVprB9KikQpuSEmglRwM+DvDiWFrG7+ni5
 VuKlxAYCf4/vOyFrVBIG/No0SC/sSS5BAE9RXUJC4bXmUGFcJUndFMeGYOBFkiBGQZSgsTpobA
 Y97SMxYE8lEpl/7J2PTQ/vCE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 17:11:14 -0700
IronPort-SDR: mQHgXCpHlCYqWYH5IfbsdbeyUeU/AyKLBXXYTEo/KXLGsVqPBjugxnyHn1peKgqJ+LGnh2sPYU
 lhHxP9o7Db8JT8WcTpyRpqA89eIUZfshDXqsp8oHmXBqUZ6rWT3RpbVuTDyO7zQeXaB+ff2Va0
 9FWRK8eS5QFL3Fvs/WaGkTx8ZCv2b0meSqyV6QVXzbMdcQfh4ca6lD6b1/bWSPGocbuP4wTqwR
 QgIXel55DzfscWFSIheBz/1iwMj8XVE2DRYCNhs002qZqZLHu0K5x81ME4IkYZM9xSsbMveBiM
 Xg4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 17:49:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYxR14z5kz1Rwnl
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2022 17:49:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1656636541;
         x=1659228542; bh=r0l5+r2ZWjM1GCTDoybfZ7hI2CFa1+Bw47L/ZyVPJzw=; b=
        UnYXGeDTkRx64w8E17QD6TbUM3o1X7uICQ790ZVO2amafeIRivkEx6XURUbF+FUw
        cxzmjZogqC4qwPc68HNehZDx4/OvmyEjOP+zgwgY0JIoZK7a615wViV8+kOfo+KK
        FVbuMmW7bnytzeBDAk6If4Q0Eo4Z0NpyPAzuUPQZqz99I6fVhB7fykdtjRZcXPUf
        neogV9ttDRmJzZW7qAVjUj0eAe3ISVVHhOruKH9yC4lCYY2z87kmEKaPZdCjMvOa
        HkDOw3yg2VqvTxgBkfRXLekf+5yoqF+bIKPVU67n+qNgUJCgPENmE51+9xc+Vk/7
        stHizxFrREzpD1EMdTHrKA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jc8_joMJUaoH for <linux-ide@vger.kernel.org>;
        Thu, 30 Jun 2022 17:49:01 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYxR067d9z1RtVk;
        Thu, 30 Jun 2022 17:49:00 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.19-rc5
Date:   Fri,  1 Jul 2022 09:48:59 +0900
Message-Id: <20220701004859.7645-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 540a92bfe6dab7310b9df2e488ba247d784d01=
63:

  ata: libata: add qc->flags in ata_qc_complete_template tracepoint (2022=
-06-17 16:30:03 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.19-rc5

for you to fetch changes up to 32788beb103f7f71e0192dce701f387070914651:

  ata: pata_cs5535: Fix W=3D1 warnings (2022-06-30 08:21:43 +0900)

----------------------------------------------------------------
ATA fixes for 5.19-rc5

* Fix a compilation warning with some versions of gcc/sparse when
  compiling the pata_cs5535 driver, from John.

----------------------------------------------------------------
John Garry (1):
      ata: pata_cs5535: Fix W=3D1 warnings

 drivers/ata/pata_cs5535.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
