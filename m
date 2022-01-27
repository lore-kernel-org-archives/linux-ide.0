Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D0C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 07:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiA0H3W (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:29:22 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23782 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiA0H3W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 02:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643268562; x=1674804562;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9uQtm/XGQkXRsoEhShWreLlMuzaM+VyGCWE+WlNvjko=;
  b=ZkAKIf8UPGN0IBDVQrNX6ZdQNqXWnLxURPoqBCy7sHFL+uhvz/gHDKMr
   pxHFDkY1o5JV8NH2MxixrEn3a7n98+zKraJu4Y4J6IRbdJSK2zuYENUya
   YEks0p4qiwo2Hl1FAMht+mXCVjCPt9p2WkTzeEH0mlqyEh7K73n4MFZgE
   h5EEzwISJ2jXwK4xJDIThZNEnPH/ct4R5x9tBvywOQH4yaRBdrfKJCQ8Y
   Vg7ermyBfkW/yMTatk92zIXwPmpvwRPyWlosyQZ8ga2AbSIejb8lIf1K1
   m7KhIaVP5jQtLiCLBli1IR2rUklo6WumzZXrbRl+zFyIZvhS/5xIUMlqr
   g==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="295583694"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 15:29:22 +0800
IronPort-SDR: eCDWVm1dkxb5riERaKr/lmzUttkUMJhtUVNHDxlO7qCSBbHYgGaJdUQzGqe5oABi0d1t3on5ht
 B/kTRNgk6E62kYj/yM5aUF8v98LFPh34PcTEbkvXq59Ey9GMfb6FVTFyp03MIhXE2v/0529eNL
 v7UugwyHNBZCXYZib2rcFCjU0Pk0b7tpCEjsYP6c4T2Zwv2OEgNZnkRvyn9YObP1YhQ4dHbcLs
 SZk4s3lJc7/dVRspFCg2yXX2ewMhy7ke4u/HPLKqcefuXpWLubHlseQQv9Ht1kTUYXIgqip+5A
 x3PfqNDgqWBgsIzc8F4Gjpd9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:02:40 -0800
IronPort-SDR: cgJPhYV+7sVNllkEyKR96Ww8EKRd1Lkm+ggKfieCzRAZUmNOMP4wBG26hLmjxAsZsGiy1ZBwb6
 wOOMuLxDzNBox6FBRduaC3UDPH0Zx80BIkzaYkofS4bCK8DjBKHga3M+QT/MQ8OTZ+VzIpdPCU
 4432wTUi3nC+T2vbNVuPZNtPChaLsRiazj4yJ8ulVFPPEUOsRIpF6BykkOfXPoKMmSaizk/Dw4
 8MoTc1exObHGaEOOENjqx+twZiCccyoATB7Z9/6eeYMcMFnG46gLpagmyqc3laI4BjYmx/Shwh
 kYU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:29:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JksfT5fZpz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1643268561;
         x=1645860562; bh=9uQtm/XGQkXRsoEhShWreLlMuzaM+VyGCWE+WlNvjko=; b=
        T3AzhoGdHjZLB3k+xx1plpeLrPl7tsbQmOt/KtkBViGElJxhxqhhkKzXaE+EGstx
        ChtggHPDNMrmhLWYe0Usu4ju2X9c8XqBdTXA+CkwkbqvYPsmQM7GonRpfTlzedeG
        0wb1L58asDrZnrbHcuEZbXTs/AqfAr+o2Awb1RkvOknfDni9l9bYamkzhKP7RxvI
        p8tneNArNS6i/081ZPNV2oKAxEac+AT20qbrr6PuyF6uIYdhD4tumwCDo3y2ZXpp
        ATxZUNngi7ZfqgHkBqwGdqJlQV1f6mTQAJxCO2L0FGVCW/SSPHuVTdzSa3bl9kqH
        P9M5tUzX8+RE7hkirpzRFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ud5jN6B_z7sA for <linux-ide@vger.kernel.org>;
        Wed, 26 Jan 2022 23:29:21 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JksfT10Xhz1RvlN
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:20 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 0/3] libata-scsi cleanup
Date:   Thu, 27 Jan 2022 16:29:16 +0900
Message-Id: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

3 small patches to cleanup the code in libata-scsi. No functional change
is introduced.

Damien Le Moal (3):
  ata: libata-scsi: Cleanup ata_get_xlat_func()
  ata: libata-scsi: Simplify ata_scsi_mode_select_xlat()
  ata: libata-scsi: Simplify scsi_XX_lba_len()

 drivers/ata/libata-scsi.c | 47 ++++++++-------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

--=20
2.34.1

