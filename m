Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4FC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 22 Apr 2022 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiDVWyn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiDVWyb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2022 18:54:31 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8F23D476
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2022 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650665863; x=1682201863;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=roLKYIw+XMquY1AwtQW0eGBYwFUcaX4UJuMj3l3rV78=;
  b=NYsXpj6wdOYlMafrhXcsGFdgAIXhgqFBBykah6RzZx9Ro17167fEVTlo
   6fgKdW0nkHUOIAoB03vS6EMmLIvn8gKFIUR/MHaQQOf42zbzHHrxJmIl9
   yf1I/ygDsXwVP2G9kCjpAF0XsTIAYEEjo8UCXBguTZdgrlANukEoVsQc6
   5WcZen2qdFDgVtYxm8OZ+TI1MPNpXn+0b2gnoa3KqkrSt7WfbE7OMgiMA
   B8s10YWOhjeCdVq55Y+oLUeClBMlEdqVNp8mRH3ytAYZbVVoLdAc259Ao
   FVh9GNzjU9VLW6aF3KGcOCEyTbEjAK9ypu7rTAfqqNBeeVT70d+r+qNoW
   A==;
X-IronPort-AV: E=Sophos;i="5.90,282,1643644800"; 
   d="scan'208";a="203473646"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2022 06:17:11 +0800
IronPort-SDR: R45O2KP0DSlMcLypYNcLoFFVeCdKr4P8oNempoPxFkL+jiF8fxe4Ro7GLslzteQcQTMqC+ja/x
 i8fdCJT3SyGk/Ay46GTaYd5EuKSNi5WppzKyrFe90bXyNtTL4ILMEONR/KEoMm2I/UWVJYEYug
 0ix0UZXCFOiOR5rKN5x/56dAuPwJPubdjyFtBkQnCD6d6Z+c5HSMJ25r4e3QXjcAo6jT9NwovX
 bJHeEPET67B+wdVN9ZH9dGgXUOhaLQ32pYJZ7LrFmHGAmAY7vyDw5pytFH/lPxZnPxdWzRgzxi
 omfQsmRDDaYYwQ8a7xirXM2H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2022 14:48:11 -0700
IronPort-SDR: fqkGsuELmPM097TZieyQv8YsghVBY61UAl4Aj6oxfG60F1zMpFLMNcWd6OzY25ETHPex/uSniQ
 x2Py6nmG8dJxBAWOlbX1RBGculafxCdYN6K/ss9MSDqQAv6Dq71qixkxeGBe2vbg2O2hI2eta+
 sJpLI+kxdK3gy0a7aY/9ZG5y1qBiB89gPU3t0B6ZvjKhbVsp7OJauVi3lSM9Gwe66X0GvX/127
 Dn8TE2EGuOKtBeUXUcV2vuCtAyubS/XaDImy7+UQn9JLZr2Ka1OZx7BpUOhxz+omybZeMv4JTJ
 DzI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2022 15:17:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KlTKg68Kvz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2022 15:17:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1650665831;
         x=1653257832; bh=roLKYIw+XMquY1AwtQW0eGBYwFUcaX4UJuMj3l3rV78=; b=
        M/lMyv6ZLo8Xyw5yYzDPo/Mhs6uSLnDx6DdDg0rN73JAGdhDn1uRM3UUFmaZBi87
        6ZgLnAGDXE9rCNQxVZ1OT+Qw1ZQ31Vw1vaOL5JdsjmzfCOqJXz4XWmGkyZm0qKgW
        tGxg6v3+KqttNJb4v3W9DRV5Hiaji7PeNyXzzqP6uDrcs6Ztw0sEUF5/ycaD0j9J
        NM23qr7jYE9f8ZFlhVmxbQ8j/lWQK8TsBhwB9xIxzHvYXu/Ai8Y6QPYSbWCFt/j9
        RDK/oDF9gecCMoA77GuYtluWgto+k9Qe2jcIvuGOFmRD1X1hL1LjTKGVdnZiuJXa
        fwNz7JpnJ9PZ9pjFE6kQLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KJhyfJ4k-gde for <linux-ide@vger.kernel.org>;
        Fri, 22 Apr 2022 15:17:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KlTKg0hRqz1Rvlx;
        Fri, 22 Apr 2022 15:17:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.18-rc4
Date:   Sat, 23 Apr 2022 07:17:09 +0900
Message-Id: <20220422221709.3776774-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 55b014159ee7af63770cd7f2b6fe926f6dd993=
35:

  ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back (2022-=
04-06 11:08:04 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.18-rc4

for you to fetch changes up to aafa9f958342db36c17ac2a7f1b841032c96feb4:

  ata: pata_marvell: Check the 'bmdma_addr' beforing reading (2022-04-22 =
08:45:06 +0900)

----------------------------------------------------------------
ATA fixes for 5.18-rc4

A single fix to avoid a NULL pointer dereference in the pata_marvell
driver with adapters not supporting DMA, from Zheyu.

----------------------------------------------------------------
Zheyu Ma (1):
      ata: pata_marvell: Check the 'bmdma_addr' beforing reading

 drivers/ata/pata_marvell.c | 2 ++
 1 file changed, 2 insertions(+)
