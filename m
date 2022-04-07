Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D426C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbiDGMjx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiDGMjw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:39:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4222571CE
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649335072; x=1680871072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dWSteLjWiW4FtRb9Atz/Sagv3btGwiSdR6lLsD/Kwnc=;
  b=Mn05WKlK/XqBWjoowrE3YiAyfUFUiPP4sAXhIlhPE4zYEdmdBBeAgR9R
   nn8z+O9nGE79KTiCiYAfEq5dDXUksb+rlJjpBQiJXdF6DmudNenAf/pTa
   7wuQKcY5DFYxNCgYnMtM52P5wuWNlnp4YnV3KDbc08XqWgbk7BZg+1sBU
   382j53O1KlIt/dYlJIlIWaXn5Hva5iRGbXenDVTEj5drLTUOxA4AJdGse
   /96M57bXgID2EUYFCcmRifQFaDqsM8XZs7XWySNafMtfQZ8wM2/Jr4leB
   0prPdTpSgjeQ9/al2tFNSiu/goWQDfAeAMB42234stm0euATCmPLD2Kow
   g==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="301515547"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:37:51 +0800
IronPort-SDR: WDwyFtjXnkvDIeCPQX8HPrX++3+TDV2krfOwIORh6ogf3eymbqH3jjWQe1tvJ2FRCOlFad9HaM
 AhHzhwVhg6gF4WeyB1bSfLKyy6k0a+eeJDIlGnMXaSYexIkLUdtyp3TGVUDqObaDpmdx1Scdqr
 qYFhaIjyIzqe1oOKeJmuKzBVeT1q8bl0crXUwaQjRHEAaXdpZLP1H6IGaA8sDss2nSqguFH8y0
 k4aByQTCHbqh0XmPTUh5oa9oznYIu0Wmaxd7PWA+L8BEOo3wTuO1UccRV6ErIr2MVOkfy6JaPN
 ko+RN//lFLRgR5dHHlAplCW9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:09:21 -0700
IronPort-SDR: JB+681DpHFS/9mTX7HIL9xpkS7EKB6utMGsB++1cGLoDvx6dXtNj/M7sDAalbNtu+enUh+hx9o
 hdEeCSIPiOhtUW9uXVLna5YgwP+7lefpsMYedfryMmc0OzkyoUdMBhrRW9M1MHym6pfb/E676S
 ecSsEdyXjhBTbWrnnjMhTRCv8mXAscxE6JAJYeoeOB+/2eL2bzevpD+JOsfx50CWYzV2sUwAfs
 BnjMxfrqr7bKA8nLz3OtR6Uvc+rEntuWH1K25eaWCsjou1kgqUtm85un9X7M/RapYAz2ihbXkQ
 mKM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:37:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ1B73H1dz1SHwl
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1649335071;
         x=1651927072; bh=dWSteLjWiW4FtRb9Atz/Sagv3btGwiSdR6lLsD/Kwnc=; b=
        rbRtodQe7TtfJ1ibk9aTFjNohEoMrD2I8SO6bsdJmcgl8IGo1JKI1sR+yYdXHR5i
        RsdJoH024YoiWvsa1ZzaqdNc8lZQz0KsnnzXAr14QJmkmW81EG72/WYQENjouRoi
        lQPo0pi8PYLa0NcEhHSF8zc8mTb5LOSotqnKkdhgEfwkFBS0cySS40scE4nxr68f
        +GoNtkFqAjHS3McUrjiQLafZuxyMu/uTaQBmhpYwmDpC/27viA43ku17YQu4PCJq
        NXCkR/dQs5ht6xX/HWSBtS2o4AmICSu3WpKT9BUiJiWpU9L65iMIbFyA0ff3kAqg
        odzsAMR8WZ10MCJFrHlNWw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 81W3nIYYdxfw for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:37:51 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ1B62N80z1Rvlx;
        Thu,  7 Apr 2022 05:37:50 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/5] libata.force improvements
Date:   Thu,  7 Apr 2022 21:37:43 +0900
Message-Id: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch series improves the usefulness of the libata.force kernel
boot parameters to facilitate field debugging of ata drives and adapter
issues by extending the range of horkage flags and link flags that can
be controlled.

The first patch is a simple cleanup of the drive blacklist array.
Patch 2 refactors the declaration of the force_tbl array defining the
possible values that libata.force can take. Patch 3 and 4 extend this
array adding most horkage flags and one link flag. Finally, patch 5
updates the kernel documentation reflecting these changes.

Damien Le Moal (5):
  ata: libata-core: cleanup ata_device_blacklist
  ata: libata-core: Refactor force_tbl definition
  ata: libata-core: Improve link flags forced settings
  ata: libata-core: Allow forcing most horkage flags
  doc: admin-guide: Update libata kernel parameters

 .../admin-guide/kernel-parameters.txt         |  71 +++--
 drivers/ata/libata-core.c                     | 271 +++++++++++-------
 2 files changed, 217 insertions(+), 125 deletions(-)

--=20
2.35.1

