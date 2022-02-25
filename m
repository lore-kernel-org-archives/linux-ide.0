Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F82C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 06:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiBYGEI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiBYGED (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2022 01:04:03 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9851E180D27
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2022 22:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645769011; x=1677305011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ui55X3chFLTe2KNN39orvqB3QWCLSPJObz7/SBBfiyw=;
  b=nSThTmBp9LOVzSryDN1T0cu+O7uMSCoUnUgBOWr2tJwdL6jPBs5+jheN
   VjYpCppF0NIhKojeQmeLUWjseFkvH6QF8kxuGFjUEYhONHT7Mnr4+exc/
   8l9jtPgQQaplgWcCfXWZ8Iq6fIyG+3uLVBRtzL/quaEg1EdHU3QQFR2YS
   awfQil7FGds2hgbUqMM6eiEp8wjerxzaNV8Vx9jkIcoUsyxbAkFh60GZ0
   iIoxZOYiGVAld4remRvORf8xc/Mfpw2PlFRlX1PJ+VmT5r8b+F6F3mzmu
   vw/t67uBwjwz/mmWtbJqUu+T+zwPXoXg5kFGNE1b8KeUJbv7sfFPmL1uH
   A==;
X-IronPort-AV: E=Sophos;i="5.90,135,1643644800"; 
   d="scan'208";a="193922031"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2022 14:03:31 +0800
IronPort-SDR: gMTaF5ypYy+h5NpHxBD1fCzv76ukltH3ZLD9Mp/lc/R21iPAgklG8k2xP6ptfh0Hhia2i7ce2v
 kkq+LSF+tyNZOrUc3oxHX/AObYVzMlIy87JPjXHIQHm3L2dxIW1FhOiYhMJeqpvNNdrhERvi+n
 7JxUrc5CDrIXre9fW3v106nKv2e0W/XtjmJbWYPTZamdC6KTfCCLTGnScimMrSeWgmTTrE3nOi
 QRccgGF5squTT349hm3+MWajxElZJLFMSwkc/4QBxzqOyc5OFO4lDcbdzfIR++Xa45kNXmFEZB
 oh+//2BejBwm+EuKDQAouz3a
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 21:35:01 -0800
IronPort-SDR: 9EJg3J+oRn73QkgrCSEiBJPXlI+7at63OuUoV8zNYU/TrJ1Yt8bCwBuJgJNwUCRhZxkIIViWKK
 qd/jr8j60L9PsnXkB1xwRZf6x9U+OPdAu4JUROZquevgYq48Nmp+KdB4E4Km9243KVmTvEqL2R
 FbkuXbdq6nvWvEvs5emm1LERJZxqsRZV5n53qa+AkAQghuc+9MpgmZeyqQP4MnOpxf8+5I3lFi
 JsWQXQUD0WgWC7zBXb1IM2tZVdKUY+Y3Sce2xhUOIKD+4W+4Ke+7DH5DSUu9EeTHh38M8LEZ/y
 t70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:03:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K4fN40SSxz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2022 22:03:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1645769011;
         x=1648361012; bh=ui55X3chFLTe2KNN39orvqB3QWCLSPJObz7/SBBfiyw=; b=
        eZW6lsklFFMYsNIocasEKl4IVn1QA9bbkSzlzPIoqckrDsM8kdDvd36HKvM3fJHk
        YjJBDZg9Hx2A2Dfw+YrSKHF4ZmaytfjHADjaGnf238tH0AAasXZkoAOCLaLXrBw+
        qBIKfBfeFrOtKjxZ3SkZxCeEnIiZeTW/Z+bBxjoP/85yaAqPn1cdhPRgWrK2uLkZ
        23M1txlt3bo++RQWpkgAaTtZN3fPxHkFPvyrX8qh0LGgNprbd7O+ik1p/3Y1HvOF
        DPyDYXe9iByV8yFYgbE1KNG2NiXB/HwyP1lLLExQUNmcad886VBiBQHfZAKSn2U/
        DZ+OhU8D4bJb5bfOcxGq0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aKHI3q-Th5t9 for <linux-ide@vger.kernel.org>;
        Thu, 24 Feb 2022 22:03:31 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K4fN30q5Nz1Rvlx;
        Thu, 24 Feb 2022 22:03:30 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Cc:     "Justin M . Forbes" <jforbes@fedoraproject.org>
Subject: [GIT PULL] ata fixes for 5.17-rc6
Date:   Fri, 25 Feb 2022 15:03:29 +0900
Message-Id: <20220225060329.482448-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit c8ea23d5fa59f28302d4e3370c75d9c308e644=
10:

  ata: libata-core: Disable TRIM on M88V29 (2022-02-08 17:06:14 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc6

for you to fetch changes up to 8d093e02e898b24c58788b0289e3202317a96d2a:

  ata: pata_hpt37x: disable primary channel on HPT371 (2022-02-23 09:39:3=
7 +0900)

----------------------------------------------------------------
ata fixes for 5.17.0-rc6

Two fixes for the pata_hpt37x driver for 5.17-rc6, both from Sergey:

* Fix a PCI register access using an incorrect size (8bits instead of
  16bits).

* Make sure to always disable the primary channel as it is unused.

----------------------------------------------------------------
Sergey Shtylyov (2):
      ata: pata_hpt37x: fix PCI clock detection
      ata: pata_hpt37x: disable primary channel on HPT371

 drivers/ata/pata_hpt37x.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)
