Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3675C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 00:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E14E60FDA
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 00:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJYAOT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Oct 2021 20:14:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27061 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJYAOS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2021 20:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635120717; x=1666656717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7lYaW/KixYVXKdt1siPCM6PK3Xu/J2VlPGzBtqvSwXI=;
  b=TtxhnyDLIj2KbZU0f852KPCR8fcXk8cNfWtqp6QR8nZyv1HT+QxYGXoI
   2qGXY3nNIN2CyJsLTjWSun0MPjKBqMwh92dmwixHSA6mKkrKpSfI2SHmY
   BjWCadvlohL00/i+REwhRzjCS/bMPg82Lk72NSs+JBwAn/dW+Eo8JU8Cu
   sJveZGnCQ7INQI0XkQINe3DQi1NjsWMRaCR7U3JRwZNghLx/a+0hQkfo1
   JTHtzMplfn99Q8u3MD8UD4wnqofuCnAsY8C/bRG1WZUG+nuLw1mMTDD4J
   ZyjJCy6pX50uEmKBLvBsR6/lAcFIb8WOB0FA5WZpf/x61pD+Rf/MbVV38
   w==;
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="183724905"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2021 08:11:56 +0800
IronPort-SDR: NDfZqZb8Y/Kv2Pt6X5s2/S/VKjQ3pZxc67FJBUYm/ceMpFc/nyTAXG+aYwytRIqCX7qohrfPj4
 QEu5RmCMlFmhMLMG4fTcN1m4Z1+BxZ1Mv6u/swKKf3iPsYYxvzK3qzmQOEgMXRHBwQfJq7oeAN
 M3xDWvjXbTB7GL097m3Eia0469HyItpHLVRkNb3KHkUFoF0h0H9NMdDxFj8oeS6QYEDGfktXHk
 DzLR50cMefbKlMLHHQoo9ykIpA3ZeWPgYpurINPUbXXGG3Nqyc4W5SRhSmo8XgTRee9d9HMhhD
 t1U6e44oqBYugZhXL830l+d6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 16:47:29 -0700
IronPort-SDR: geZTdhYI5EyEBRyRhdq8Yn0qqExhoI4VYrZzYWXgnU/qb+3n1jU5CbhNdLmrylG4NNuuadw5zt
 Y15B/w3zKmn1m2TvnvZdauzR9lhBurMRAUfSRJTexSwS00JBq1F8YigysuKP33wdu5N5Y1kZrZ
 AikXSegLMJNd8oaYM7kHuwqSchR0QOASLGwXh1xMEzt108zjJRYATfRe1uGe2D0NEAVdGiBTSW
 y08jrORlJKAcDM2QkdA5uRbef+v9rZcA7j9CYM83zFGzOYiuNcqsD1xNHEfSbDDs/RlZ5Peb9s
 g6c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 17:11:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HcwP85Cqhz1RtVn
        for <linux-ide@vger.kernel.org>; Sun, 24 Oct 2021 17:11:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1635120716;
         x=1637712717; bh=7lYaW/KixYVXKdt1siPCM6PK3Xu/J2VlPGzBtqvSwXI=; b=
        rQCC1OUOqQNfN/4q9CRsDZNVtwZ121BBVi75zK73SlJut0sPAzsc5gJMeP/svM+c
        F61FCwg6jngJj94vQju+O//LWzp+Rokqd1rv3qBqxLzGPhtGTGxlNptYPtCeRDMl
        Xs9zII7tAJgZp8ZN6wTdEy6dHGQhjLisC2sOfbPpzlH1eNirHNXTP3PIJE5/YZVq
        v8E0UrVgbgyeb3n/MqYoOilZvZBSdW128ujGjE6331mUop66nCtlV6vtgcy8YI7k
        YQdFyq2GperU3+jBLHz+zdmp217ZwrAifwUNvp+8errb1fIgYM5mxQdQ6isE3aMQ
        IlgELUKUCRZWuj56hp2v6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id blpeVjPlusIE for <linux-ide@vger.kernel.org>;
        Sun, 24 Oct 2021 17:11:56 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HcwP76Zs5z1RtVl;
        Sun, 24 Oct 2021 17:11:55 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.15-rc7
Date:   Mon, 25 Oct 2021 09:11:54 +0900
Message-Id: <20211025001154.856544-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 776c75010803849c1cc4f11031a2b3960ab052=
02:

  ata: ahci_platform: fix null-ptr-deref in ahci_platform_enable_regulato=
rs() (2021-10-14 12:22:47 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.15-rc7

for you to fetch changes up to a0023bb9dd9bc439d44604eeec62426a990054cd:

  ata: sata_mv: Fix the error handling of mv_chip_id() (2021-10-25 08:53:=
04 +0900)

----------------------------------------------------------------
libata fixes for 5.15-rc7

A single fix in this pull request addressing an invalid error code
return in the sata_mv driver (from Zheyu).

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

----------------------------------------------------------------
Zheyu Ma (1):
      ata: sata_mv: Fix the error handling of mv_chip_id()

 drivers/ata/sata_mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
