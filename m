Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E6C38A2D
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJXH0S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJXH0R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 03:26:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFD5FAF2
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666596374; x=1698132374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LRB8MO45s3rRxcsDG+Tr0WhDSVSREUVWqETwFqf7yLE=;
  b=Ijsg6P6h1PYUjZinM1cB4nCPn0lsmUdEO3i5/rvFrE7LvQr/d96ocu+S
   gqRu6Q3fyttsh5KCF0O/Le3XSe3M3jvqGslkYVaiKCrTdp/eZnqcVXNmu
   +xAcaTfmYxrFZCW91H77Vg7NW4nPmR3MwlVivMOk5CxwjG3xCbNi4vW7R
   8dClvwgVY7tNfXKquBbG7weVllicy3hS7dl1fltx+Neh4+D5I4oOi9ar1
   /NTRMydJyxoqvr6QZogte3pLHU1MASt2wh3i0BAqEXwB0Je5z2OuYKk88
   eqcK7AUeVXoKojl0rso6i7875rYsxhk+Hjg7/V5bAeXO+zz9mTd3hZnUT
   w==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="318901542"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 15:26:12 +0800
IronPort-SDR: kHUJjOtCcWVk4l6DUqPBTSOkdHHBycwuI4qys2+IeVfchox++VnnX9352GanLy9oARk0K2g9Xv
 o42eRLL+2SxlowMBFZrXWNecfZddSd6qFPLJ7y5X2p88RBrz+WoPIXuu00etUoW9sxQiBfNLX1
 b7gWysOXbGAbcKvRhbbf+lkKekYON5H/UgYG9cfbJF9r838RxbBN8TGV03U/qeLa0f6Z0VSoVd
 druSvRYn1ArzqKOpqCNvzPfLLTwAF+vxxXqsQqhfM3W/WY6Id/ID2cJ4nKRQtgzU7s8w/j2Uhj
 MSMnyZokIneAwM14eFhVQfcM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 23:39:56 -0700
IronPort-SDR: cDgEgd4YdiyPR0oYVty9RGd252G1AMpKH8covypkG7cTrtcRAi7nsb3MPI71tp/I9r3iR7yCpb
 ds7g7Re+5BBxpF294i+JnBD+nU0JvCm5nvutLZ21E+WACdw1py7Ib1S22jJNRM0MFa6KrafA9b
 RkNPc4sQtCExyzJPeSBupaxpvjo9lG/flCFVUiiCCJEcFzs9RzcwfbyRn9CSfd7O2+CuPZPUJ5
 Y8gixJdGM0Rlf9da9jOlQnkdBLfXTGRJajzTmVNIXSDGEIZBDU9OOqAeHg6od8GegVk1dIhenY
 Rbk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 00:26:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwmpD12S9z1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1666596371;
         x=1669188372; bh=LRB8MO45s3rRxcsDG+Tr0WhDSVSREUVWqETwFqf7yLE=; b=
        Rg647uSfVbs+hzKlGmjvCOFFLuFZdXMFTP+/U1iiEuu1dbJXbGxVMe7qEaUsnfXF
        gk1Qrb6I3opwTQ06CnSuhJ7F6WJj8PO0gPV3ru05DqgXjRjcqYRhX2cUkK+hXtrX
        MYx5wEXQ7zx1zhWNVi5NG2xzY4isWbAjL64U+r8/qu4ciFvSdXFS5orPV20omlhK
        YEqVilErcUvWVHgJB0eFiCUvtoTNo/dtP8MXCpyq9K8U0kcH+JfaO1OBknRnYy3e
        PJxfRnhXWqVmHV8N54NIJ0/2bAL+EnbF3oZn82Te3Az54KolUukOG6GxG7vaH34n
        pELg9tkG9gXme2gwRtnzEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ZFi5luMjwLw for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 00:26:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwmpC0MK9z1RvLy;
        Mon, 24 Oct 2022 00:26:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 0/3] Improve libata support for FUA
Date:   Mon, 24 Oct 2022 16:26:06 +0900
Message-Id: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

These patches cleanup and improve libata support for the FUA device
feature. Patch 3 enables FUA support by default for any drive that
reports supporting the feature.

Changes from v1:
 - Removed Maciej's patch 2. Instead, blacklist drives which are known
   to have a buggy FUA support.

Damien Le Moal (3):
  ata: libata: cleanup fua handling
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/ata/libata-core.c                     | 36 +++++++++++++++++--
 drivers/ata/libata-scsi.c                     | 30 ++--------------
 include/linux/libata.h                        |  8 +++--
 4 files changed, 43 insertions(+), 34 deletions(-)

--=20
2.37.3

