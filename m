Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BFC74A5B
	for <linux-ide@archiver.kernel.org>; Fri, 17 Mar 2023 22:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCQWyD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQWyC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Mar 2023 18:54:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED44D4F75
        for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2023 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679093618; x=1710629618;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yeJc0m0LYkyzD0GiYHcjF/zDokKxQY6QwHV1Y80N8b0=;
  b=IMGPeo5ygj2ykbAr5/5O3JeyMV6vjQkBUmQw193I52G6qx75OwRbEZXw
   HMovp4/H97KblX2yna9KBH1971WYRTglm76/HQLOtm0a7fEPplddmuBxg
   /EBHyGSjG4rnLrvQHukyFzo6EnVSskVD5TbLKR4pTWWqPbqPXR2BO+TS1
   w4Sragx6LPjZ28k27juMOPOEgZUIk6Muyx3oPJ7mxSHYguW//ACnrhtsn
   nB/3PCyLovGB383Fu3Cv39r45ip9Nx4nB0bzzVkjxbMpFCMfzQtcx0zbQ
   7YIjBDGDWS7YRGplplewVRDjitI6Hz3v3dgMuRhVkK01cxAGk8lEea3OJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,270,1673884800"; 
   d="scan'208";a="230857713"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2023 06:53:37 +0800
IronPort-SDR: CDJ2V4Jq6B175FCd5XkN9XDhtqgrAKTVkhnDOYJkj1qX7z077sAsB+AzVeHRXH7agLA/YxIdtV
 m/VYZVwVlcPB13MWurFSQmNDUNfiuepeE96hBkxE2nM+/m9yHVBHeYeyMRsPMqNBcmt6pZ2GA2
 /0/grLDseTZJECG/Cqbu6HUSlx8Bj5BaxIgVhIU5qiKaeniTIoIpqM5NGrTbm8AYZKoOch1zdM
 dXCvbYiikNL7cb5F3SP33wljMQV3QUjDcpxxdhHxMiMHwFqH5jCZ4G7ljV6hRZfXEfMtvwwkMm
 kyU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 15:10:01 -0700
IronPort-SDR: v8GsYucxVm2bPMMiG+si2KQnwm23FvTUq51pbOWbEyUm8lUvEqQKUrPEsOW3PpnLkDv8w4laW+
 5Bsu7F5ZE+M4k+jxYNUwX0gz523KOJtTUzPhKC/J4DbywaLvj9WHmNmf1mL6HNG8a7OkX6qI8l
 jwDezP7uhbpyp7A3PSp6uNQtv0aukTMVmfV8/XYZzIZ2Bab/ls2D/iJ1bBOH87ExdgXOFD6t0Q
 iB5R1RpXfyrE3PIh+IBJWix2Pr1535CPQsHRip6pbRa2cbY+fxunRtffaXk+dz7C3k1SLnpGIp
 gp8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 15:53:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PdfYs3YX0z1RtVn
        for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2023 15:53:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679093616;
         x=1681685617; bh=yeJc0m0LYkyzD0GiYHcjF/zDokKxQY6QwHV1Y80N8b0=; b=
        krIX6/tfiG4hLQSFZy1+YgVMW8KC1mimJ/ZHNq0XsDzukvpQ4DGspCt6tH/ifcXw
        3f4srim260HGF7+m9U8pOZ6AWJ9boULch9z6BFSZqENN0iPs/c+W8MAXWvm6J4lF
        ZqCyuE7B0cI2KhlBbiZSdwHDuPC4XvWaDNpGo7G2zSFIzdd2ZVbg5f5UUaw2Z0Bv
        6cFP7/BrWRGiWbpWUtUT66Zjhi6TuYcnhGfwHOxNqYs68wkjyp6we76opZ1It/zK
        +aKMS+R3tYObyjlMQR6UH3mCcsR/VoPg8VORKo9wlaf6tIFD0yt0+Y1vIA5MTfJP
        4Zedm0hw9lz3l8qAtozCLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UnkW6jMm6YMj for <linux-ide@vger.kernel.org>;
        Fri, 17 Mar 2023 15:53:36 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PdfYr2fVTz1RtVm;
        Fri, 17 Mar 2023 15:53:36 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.3-rc3
Date:   Sat, 18 Mar 2023 07:53:34 +0900
Message-Id: <20230317225334.30582-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit eeac8ede17557680855031c6f305ece2378af3=
26:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.3-rc3

for you to fetch changes up to 5bc9e2d43f86105a95f86fa096fb4e517bb0ce73:

  ata: pata_parport: fix memory leaks (2023-03-16 16:54:38 +0900)

----------------------------------------------------------------
ata fixes for 6.3-rc3

 * Two fixes from Ondrej for the pata_parport driver to address an issue
   with error handling during drive connection and to fix memory leaks
   in case of errors during initialization and when disconnecting a
   device.

----------------------------------------------------------------
Ondrej Zary (2):
      ata: pata_parport: fix parport release without claim
      ata: pata_parport: fix memory leaks

 drivers/ata/pata_parport/pata_parport.c | 30 +++++++++++++++++----------=
---
 1 file changed, 17 insertions(+), 13 deletions(-)
