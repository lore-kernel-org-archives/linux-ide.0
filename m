Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0EC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 01:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiKLB6J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLB6I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 20:58:08 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B532BD0
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668218285; x=1699754285;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMLlJtLyv+IoSA0F2Spli7qnd64rUsa2ZvdgrMgGTkM=;
  b=HkN7j2UcUZYU3Mwt3nH6YxgK+QGxOuIlHuTQgO8QVBScsE9eSkWeg4ED
   riwo4jUr6KdssEP42Z5tgWBwgZQ3hy8YgKdgnhoC9pge2ADt1/S9N09e/
   vazArUlHhCtsnatsdniqPPV29GOvtePm8gTfWrFbkuKpnRFG3iIf6qDEa
   q7kygHA3/YTq5+37d1zCTnw+RnTYEzgQei8w1XbYvygs5yFpuzjQ0Yev4
   b/VXb2Pf8Jg5eZRR+JIL7vZ2qDomhqyswStlBP4JrHcDqxSz+DeXf8ASo
   XPxkx8EPnSY3sBv+XniiizGlDo3bKkYmLpPZjpuVlitU62bQQuW95nmYX
   g==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="214366509"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:58:04 +0800
IronPort-SDR: humzECwJD0ryR/tSty1tZp+/IVF5AN7crFUOF5ZzhiAzJyIRlpYaTebW1UJFcY+SeaGR5ZN+y+
 uzcC1dfTAnNFj9hKOJFsBm/uSSbbCbAymHuTIJ+irH6eSGyCpNVvIAMbk18hgQgfVlUiuAaxiz
 Z/GXVF283rU9EB4Qd/W92WEhKsQB5bM/P/DXqxeGt/QdcbWpEMPjJSQQpqx3/UIMU2Swf7bi0R
 dgYqXBUwBHVuyrxh4AomX8ZublORht6WV0y1kDDrK0bekobFTBalRQY3TyZrvgaoGdujxk7qNX
 QtE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:11:21 -0800
IronPort-SDR: DayunUljkYw8JOLMgPJH/J1VblMtK5320NNZsV3XVs/vQYe+DvMRRTg3+BmI3QIin+XAeNLPAO
 9f/1/Ljl1TnfjDYvm0L1TA3js3FNaS/iLeZBQT24oo/5QsxFD6tWR4eKEk98pQQUTUmZqf9eAK
 0Es5uGdW8AVqdbctIOM5izUXTX5n53KeP3yt44JJqPdq57PTTY9QYBBdabI6Xj2BxWJULChp24
 jxDgsmDbdCFuwaV7Rqc7im7PMvnv3HuAfoSTIJ+52o21tPfUCdBfE2KTPOEBmhwQMrL7DBfQQR
 4ZE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:58:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jcr4MmYz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:58:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1668218284;
         x=1670810285; bh=MMLlJtLyv+IoSA0F2Spli7qnd64rUsa2ZvdgrMgGTkM=; b=
        oNVQVe46AHJKMUYtnJGAlFC9WSgW2Oux0tXsl5qrbUp7PFbULg3Hdf/CZdQXvsDv
        Ubwx13Eh6t+qtaCCZSIsq0D1+VJR1S8uBgP9qYzWmKJqGiNV+4KIDHhWFSW5Ybsb
        2H/J72WoTjor3IQ3lNUyTRQ6wri/zbl8mTa+QrQYNDKpxL2hb6wasg/RI67Uy12p
        41zh+2DL3qaEDQt/g+E4z9YSZXrxfVZ3BcxRLC+MxGeNGG6TGkgWQtZQCVJ2zrVS
        xn6Zg0l8t/nCRJnJ6Mij7AJoQTfvZxM44KIylH70EMVncIRsDXM95iH9kQWuxpQY
        82J0KgrGqyje3bz9SVWASQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2a3rovZYanLK for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 17:58:04 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jcq67yMz1RvLy;
        Fri, 11 Nov 2022 17:58:03 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.1-rc5
Date:   Sat, 12 Nov 2022 10:58:02 +0900
Message-Id: <20221112015802.2192898-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 015618c3ec19584c83ff179fa631be8cec906a=
af:

  ata: palmld: fix return value check in palmld_pata_probe() (2022-10-31 =
20:28:05 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.1-rc5

for you to fetch changes up to e20e81a24a4d58744a29715aac2f795cd1651955:

  ata: libata-core: do not issue non-internal commands once EH is pending=
 (2022-11-12 07:51:06 +0900)

----------------------------------------------------------------
ata fixes for 6.1-rc5

Several libata generic code fixes for rc5:

 - Add missing translation of the SYNCHRONIZE CACHE 16 scsi command as
   this command is mandatory for host-managed ZBC drives. The lack of
   support for it in libata-scsi was causing issues with some
   passthrough applications using ZBC drives (from Shin'ichiro).

 - Fix the error path of libata-transport host, port, link and device
   attributes initialization (from Yingliang).

 - Prevent issuing new commands to a drive that is in the NCQ error
   state and undergoing recovery (From Niklas). This bug went unnoticed
   for a long time as commands issued to a drive in error state are
   aborted immediately and retried by the scsi layer, hiding the useless
   abort-and-retry sequence.

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata-core: do not issue non-internal commands once EH is pen=
ding

Shin'ichiro Kawasaki (1):
      ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command failure

Yang Yingliang (4):
      ata: libata-transport: fix double ata_host_put() in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tport_add()
      ata: libata-transport: fix error handling in ata_tlink_add()
      ata: libata-transport: fix error handling in ata_tdev_add()

 drivers/ata/libata-scsi.c      | 13 +++++++++++++
 drivers/ata/libata-transport.c | 19 +++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)
