Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F353C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 17 Dec 2021 23:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhLQX5f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Dec 2021 18:57:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1571 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLQX5f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2021 18:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639785454; x=1671321454;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ziVcku2nzpXj5v/jgnXpZeKezzkAJFhvfbmBy8iAL8=;
  b=o0P34Rb4k44jLZS2E/rY6PjxMl1xo1a5Hx4TOPYgEWaZaeX7U8rQwVb8
   jeZ3EyXuWpFMsYfE/ZfKMTtINAWQ4tMr5vFCME035A+DEBN7c4FSTntsn
   eGLo1AXJ8wFyQO5XGoI+kUDuSs34SG6Hi1DZFeTp8cHZgXVevp//xxpx4
   UAidLdlf+TtJ5c7Qejdrs34YB7AnYZ3MGN027THbAGM23bE6gIK6R4nJN
   LJaGaJzeb0XHBKHUYQanaegKFOtipbw+lINl2JP3/H9F8tbO7mF52uTnr
   zsjWJ7YoFS70uCD7JOsp7N370ZCvJBoqENxlHHLFQz7N6dTwsRxAY4oHB
   A==;
X-IronPort-AV: E=Sophos;i="5.88,215,1635177600"; 
   d="scan'208";a="292548008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2021 07:57:34 +0800
IronPort-SDR: klz9Px85kJguK61TZkg/Qz4pnovpSN9HUcNec1f3+AzzFeBcBhWuIAzF7jwvahkHXcubfAbXGC
 PhiEBUepvkqa68pnACPsWGNGuVT7c41KMSwTa7Me7CtKD3y6N6BKU+tSQicc+CwxxwF58cBJBL
 0Q80oE2ChA2JJyNgzPS7B/eKC+X6LLxwP6HrVUWXCiCeGPVETvaYEegssqX84CGdvNKSh9NCIS
 5QC/ZkTt2xAZtXTG6i2CV8O1HE7OOfy1l8apXAnr7KOiXABsCSvQvXBV/bNTScnEktTRo4HTXq
 F9KzSLZoUjrNfTIYWZbxg77V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:30:26 -0800
IronPort-SDR: EMcYvYAzWZxim8u7ed140TAZo/RtDV0ctSvJkQ7U62kQvz+ETF80/dV2RPx4V3fTpaFNAETSls
 Sn2nGpjb4NyF2qEl32XtUqkLvOc2/RFU0PtuRcUT2XbPQAXhYQoMEBOFGvu9rXEI/QFvJPh1b6
 9JFbfnRunVV4hpQMX8GiM1Ps740t54xGWjLmQUBTFRBjdaLB2Az49EQm+f+S4EIBYg5gz1BaAA
 IoLV1R27i0doeqFls/MMJVE5nee9plaH9sQxGGxB5Y6Vm5JWK7O4wSFGQsubcxkTBm0DzfileX
 leU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:57:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JG5Wf1fLYz1Rvlf
        for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2021 15:57:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1639785453;
         x=1642377454; bh=6ziVcku2nzpXj5v/jgnXpZeKezzkAJFhvfbmBy8iAL8=; b=
        RitaGV8Gb+dzW5Holv++j130pECLJ8+d83apAkvPGOr3bgE8G4Q4JrW6CvgmVamt
        WYetfY2s+iim5OFs5ps7WGdO6WQOL+i6PGdqA5negjo+2KovvdRZ9CMf1OkU6bZC
        YHAsAic6QuQN2//U5e10bXH82UZRvZBJMhwZUy+n5smyngC95jP8YtoYm5BTCxFi
        XKZQU/eg9r6hKJw/6dYFVNlZ5mcwC7ak1ilBvRQ37Xb1XuDa3jFkFmabBml2u4mt
        3MAvFRkshOT8Xc3xfsq05tOQQyqj+Ml6hOeEuY6EqOuwvVMkv3eY3aK12Pk6maE6
        BQ8whwvIL1kTj5e62beTDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eIM8GHsAvuWQ for <linux-ide@vger.kernel.org>;
        Fri, 17 Dec 2021 15:57:33 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JG5Wd2qQfz1RtVG;
        Fri, 17 Dec 2021 15:57:33 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.16-rc6
Date:   Sat, 18 Dec 2021 08:57:31 +0900
Message-Id: <20211217235731.304392-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e203=
9c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc6

for you to fetch changes up to 5da5231bb47864e5dd6c6731151e98b6ee498827:

  libata: if T_LENGTH is zero, dma direction should be DMA_NONE (2021-12-=
17 09:32:13 +0900)

----------------------------------------------------------------
libata fixes for 5.16-rc6

A single fix for this cycle:
* Check that ATA16 passthrough commands that do not transfer any data
  have a DMA direction set to DMA_NONE (From George).

----------------------------------------------------------------
George Kennedy (1):
      libata: if T_LENGTH is zero, dma direction should be DMA_NONE

 drivers/ata/libata-scsi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
