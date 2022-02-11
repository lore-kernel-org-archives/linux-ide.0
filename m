Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C37C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 11 Feb 2022 13:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349169AbiBKNGa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Feb 2022 08:06:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350436AbiBKNG3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2022 08:06:29 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC2FD2
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2022 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644584786; x=1676120786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZCN4KuG/A015qGqAFfSvspjzrmRxb08eNKDuriaUfg=;
  b=k+ec/aeNG8eGV5+BZAMVngFwe8mP8fx3zimQ5StQBL8PCTIVd5VPRE3/
   1bP1E91JXzLWr2qA9ZX46nZQEOAI/gaTyeg63tlGSHgbESh5RyQNjceW6
   +ygW+GAYWTJZ4KAUM7crcAMHpFpu1Gfvgvfpt1WM/Cakokx5N6KxpQomG
   0JCvIEdnE5FAsGVM+UW24YEMVTtoK3AufuyHSC1o/LZvt8gCgTK1VG4gu
   dchDwqcwlF1Y9V3dprrPvWsafPqOCXi3PFJbJ3yie0ePxkXGVyvMrUKjx
   zwUmfYAxHV0tSyxkf8p/ShjgbWIB64EROz14XDbJ434b7Zod7b3s16n4X
   A==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635177600"; 
   d="scan'208";a="296798760"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 21:06:25 +0800
IronPort-SDR: jhtM5Lgvm9dQL8akg874wYNzsNcOLGMSP3xl0PSG45Oi9ykpsTvzEvb0yncSdhsbHogQIME4e/
 T6FdFXbA3FiLuM5gevcqdcGg7dUc+dm222AESRgFiKOXx6lsHjvTYyP9nOlWRiLdb9Wqy5li8O
 FKcNy+c1ops2n38VUIMyDl4Ed/WAvWifpeeLxDrBVtFULHCoPRsbb91Pg+z9N3agtaoRGNXvcc
 e4InIjPorReNXFxoBZ7i9UwbbsBvziNkn03aliyjt4LOpMfykRWySAZ8y+oWoFe0AxUKHs+ZLD
 JUd9uLB9AwPoLXXI+0Den+1d
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:39:21 -0800
IronPort-SDR: 28IQoBNbH8idmMOOy3NgiTm3XohGDAWxCLwKmDzLcELpv/YfWjhGxBNKY7KJ6xQ4OBmkO23xeb
 FRVVtrTehjjZCuL36dbMgvqOG89wLm5Nhi2QA7wEQaJYYaSWwG3nrTtjn5tLcTrf1ljY0gOQG2
 lxd2j6jrQisdQlzRl17ZA8wgT5mbctNulyzxbCr451HWQDKp5qxZWNzzVWBm/R+WH64RZrrzs6
 P0wRJ1eWZJJKN87RvYfOOHr2wYh69Dookb4gO8LqZ8ngEntCkEs9CYWTveRPlX7mqIg1M+iWo5
 QkQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 05:06:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JwDQV26jZz1SVny
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2022 05:06:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644584785;
         x=1647176786; bh=RZCN4KuG/A015qGqAFfSvspjzrmRxb08eNKDuriaUfg=; b=
        X5ec4H8s7HUsiKuG/QmYSeadTjybARL1+BXhAK25orTFzRIdhtsl0Yw7KwMO7PsV
        3/kgJ7fPMFP4ISRB7RNw1FkL5zJTRDV2p3q15pbHkItlB7pLcWAL88j+ksBLG3p3
        o1Do1B7xdk6IkGvAMdsYK1fi2vIWCtd7jxChzWPbOnk6ukjplxMWkQQbOSgRUMNx
        iUyOFN+8pPKOM/mTlcfWCKL45npG2IULT/j5f3A8rigRZVPc4NEzytkJCh92YdYD
        22fOOnFD6FMsSgLzrsEj89QjlyezhBqvGF87St5I06WXcwW7TJ5YbgLbummGHbEO
        b9wOSCQSkJjYLod16Hxmyg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4oYrb4rxSQxv for <linux-ide@vger.kernel.org>;
        Fri, 11 Feb 2022 05:06:25 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JwDQT2crXz1Rwrw;
        Fri, 11 Feb 2022 05:06:25 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Cc:     "Justin M . Forbes" <jforbes@fedoraproject.org>
Subject: [GIT PULL] ata fixes for 5.17-rc4, followup
Date:   Fri, 11 Feb 2022 22:06:22 +0900
Message-Id: <20220211130622.965310-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit fda17afc6166e975bec1197bd94cd2a3317bce=
3f:

  ata: libata-core: Fix ata_dev_config_cpr() (2022-02-07 22:38:02 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc4-2

for you to fetch changes up to c8ea23d5fa59f28302d4e3370c75d9c308e64410:

  ata: libata-core: Disable TRIM on M88V29 (2022-02-08 17:06:14 +0900)

----------------------------------------------------------------
ata fixes for 5.17-rc4

A couple of additional fixes for 5.17-rc4:

* Fix compilation warnings in the sata_fsl driver (powerpc), from me.

* Disable TRIM commands on M88V29 devices as these commands are failing
  despite the device reporting it supports TRIM. From Zoltan.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: sata_fsl: fix sscanf() and sysfs_emit() format strings

Zoltan Boszormenyi (1):
      ata: libata-core: Disable TRIM on M88V29

 drivers/ata/libata-core.c |  1 +
 drivers/ata/sata_fsl.c    | 16 +++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)
