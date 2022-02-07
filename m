Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A28C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 14:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiBGOcY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiBGOEz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 09:04:55 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73DC0401C2
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644242692; x=1675778692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGbkun4sedr0fS2wHO1wHFNZUoNnNcmBZkwmqTRydpY=;
  b=OK27zJkDWA98ycDc+yqpgRm1wRNHFeVgW7e6Kh3hr5f75BvUYz7olBJR
   AgOBf/qAUIlLsUXFZIUwL51fVK8HEXOLwiIUapVbgogQDt4/hfC53XOj0
   ZafjxBHUqMpj+SvuXd+HKd/Ukl2Q1qo0qgTFpi9rvCb7WxJ2I3sK66ZzQ
   35aysOCe19dFsKbd6CfFsral6qcqi1FBMFUsdrRCXq9qSEiPjGgLEWc+l
   W62ExNBpB4aKRSWAfSlS+E/KmnqzeotHDA2zz5K6IhRAqdzU4salPbgRV
   DiAijOrMrZYcxOBvrohUiAO0RLt5TEGoHTefWSr4bzKUcMPN2NNRkxqKi
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="191272603"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 22:04:52 +0800
IronPort-SDR: LI5fHhTfNMfjRE8C4aJyCfHmcj1bRUWa9LFKh/T29hdpmjUSIGAA9jDQKLO618Ju7Pm3k8Ysk8
 H5199nFlazEkR0zYqTnGXFr4bYEko0AiXL+16Uh1WveDhjN6lvcSY8EIOV7fI6Hyllvinejy0s
 U/wtbcvzySrbWHmZC6mZYryubRHG2uNpkToR0ZT5bk76fsR5FScMaNbbiyPGlmRDFAqqmcHkxZ
 u4p5HO1U9QovV2VYRrOq6IjbpKfxyFETdGHmoxZGxI6WdoyQNyme+d1vzz0f+8Knm89edE+d4Z
 jCDPM7C8N/SUU0IWJlnHuofv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 05:37:54 -0800
IronPort-SDR: d4bqscPRzc0ckylIjw/CT6h/bVZJ5RXi3rIgT8w0prKT2kILTKM4MLNRgom1Cdw2MElosGOMcd
 rUtTimfKxkLrGkXmxFcvvpivpWk4CnMQk44GcB5yClZQYSV0pXkd//6coikZX/EV2Br+ORp0NQ
 M1l4ixGsyM0QzCALptm5HqF/qBg/9U80evnNmrapmikbm9ZFhPdimFIOsHczfZ6WeokhowNABH
 CmfVHujIvUA4QkMkT47O1QL89cgoV24azi0x8S+VtIQhN9qBWKBVuTKitIOnoamYOLBTotOht3
 eTY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:04:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jsnvn27cPz1SHwl
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 06:04:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644242692;
         x=1646834693; bh=gGbkun4sedr0fS2wHO1wHFNZUoNnNcmBZkwmqTRydpY=; b=
        GDnNTDHyCMuceVKCsLA8Uwpy9gBF7SE+7otlBjk1mWPfKGzlnuQ9rnHQkXb9mU4e
        w70Z1gA2tzIpOKc5jRMIc7wuENciZtGmO9l6SSZMKzvj9ljaWyTfGer9pz278sHO
        WRAiUQi5u799oI3GWYf4LumpsQrVlmQaKUGiFgveaYjWDHb7SJVvUonNbyHIKiqb
        OER+Z4G68IBOv8HuNZbwvlBPV7GUBBdLIoEmxQnXlz/wVT7Eg7qaCpDp1rJfVlrs
        98SRFvjlhN9N7UvgvNnLYzhnYTXXut65Ppjy5M7VaF0aPWVWFGmM5+tLo2NdLXK7
        bEqYUB8HcROtcLw1bj2X5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fmpxX6ELRxrG for <linux-ide@vger.kernel.org>;
        Mon,  7 Feb 2022 06:04:52 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jsnvm0GgHz1Rwrw;
        Mon,  7 Feb 2022 06:04:51 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Cc:     "Justin M . Forbes" <jforbes@fedoraproject.org>
Subject: [GIT PULL] ata fixes for 5.17-rc4
Date:   Mon,  7 Feb 2022 23:04:50 +0900
Message-Id: <20220207140450.1072531-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd555=
66:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc4

for you to fetch changes up to fda17afc6166e975bec1197bd94cd2a3317bce3f:

  ata: libata-core: Fix ata_dev_config_cpr() (2022-02-07 22:38:02 +0900)

----------------------------------------------------------------
ata fixes for 5.17-rc4

A single patch in this pull request, from me, to fix a bug that is
causing boot issues in the field (reports of problems with Fedora 35).
The bug affects mostly old-ish drives that have issues with read log
page command handling.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-core: Fix ata_dev_config_cpr()

 drivers/ata/libata-core.c | 14 ++++++--------
 include/linux/ata.h       |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)
