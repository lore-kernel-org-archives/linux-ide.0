Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E702C4332F
	for <linux-ide@archiver.kernel.org>; Sat, 31 Dec 2022 00:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiLaA7u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Dec 2022 19:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiLaA7s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2022 19:59:48 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5801C913
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672448387; x=1703984387;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tImCCF00+4ZAGm9VYw+UzmfOtovDHta3IrUYUoyW0N8=;
  b=MUobrvR6xGPjjF8a5KGY2DagT3g0lHe7Gejj8d0j+9j3bG5IBHg1jdsx
   KH8Z2+DTb2KBtVKmG8EgUeNdh6TLmHd2VoG1PTZNN9ivzGjnChqcgiYNY
   6HmYeJzjQDaKM2zf8zgw6M30HoeyCW/7RdgMU5JvU/qYLAEcCEXCzSEQm
   gZE5TRWGxnftWcOrTGxp77zzwiOUo7I5ASgEYnew8vEmcYHqft/Tpz9aq
   yj/sEvouUDIN8TkSk++/kl2j75GV+w0gnznLI5pO/Rx8AAfwltoxCRX5v
   4LVrcWBUX5hejz9BKzUbWrPwtrwBPDJYxDNdURXxhh4Vu6Jrhgm3GKnKl
   w==;
X-IronPort-AV: E=Sophos;i="5.96,288,1665417600"; 
   d="scan'208";a="224839651"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Dec 2022 08:59:46 +0800
IronPort-SDR: PnlQZFeJGa3O6+NULvF1oEoSxe4YVLncuNywxTPP0QeQdpOyy9+K0t7c9M3DOwHMvqjqNdBubt
 kowzw0hsPps+tKrHS8KVRdC15PCTfM2GWtjfRnMzzjMC4Re2W6QUBy3gTpGvy43WP1XaX+xwmZ
 WFXKEb4uNmzpC+jpThsG22hDpP4PeNFy6MT2d5JYJnAfNof3igqZ6TH7+jU7HEcWEDNGbsAIml
 b86nVeo2Ghbv5lTo5h3C8bAcr2QbmjBdf089m6aG3P3YFaX6GpHk3hmqtC3tLlfqJoHwFE3w9Z
 oiA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 16:17:49 -0800
IronPort-SDR: 8X4s6BwFbFpX5uV9S1WPa038VsL/DuKKDlVi+pj7EbhPOz3iS9XMZO6eUyVOm+BcukihhJ2EC/
 ntbdHeHcshTWBvKbKpSqbCR4AGum/GDYnyjoGBkZVjix64Uk7w8ra7f0jr8frqlKbA76/k7Z/F
 umNXVDtDN4SSz9QGeGVQAnraLyrCtcPoThycHphRuc4Jchbdvivsa7Mh/4e636J99myF+c53mS
 wCztnJEyP0xOUvuX3UFEH2MsTFY6Olpo52R9dja/r6IYQzVuMWqwsC2QK1ESpnpH09suIpS/LQ
 xM4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 16:59:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NkP0y1Pc5z1RvTr
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 16:59:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672448385;
         x=1675040386; bh=tImCCF00+4ZAGm9VYw+UzmfOtovDHta3IrUYUoyW0N8=; b=
        E/zNzsjrvR6zl9qYzpHUce24neKGJ6UtrizLbz7KnpQmALGSHe5aYXAp1hrn51R8
        AZ0ItZYf2ncjMosriboBuMVYf+NenmgF/+Lja9J1+11K0Ji7ZWAqXdiquDUxWhTT
        p/3Wn++V3vKwzgIsdmaV4zMtWKldLXILAQHYeQ34L+39aaBZSZxXeG4OTEwstL1a
        nluWUGL3+E2CdQcNZYMrQVHs5t2zXezlrbGqx6ldlX66tSEhwxu3TwH3BCRsc6Rr
        kXRjZBmOJx9W+h9DdNg8q8UhF9ZefwuO70xg+Qq+JsjZYKK9qp2OmAayrhY5QpOG
        kMAhgElJaNcZKjysLZsxUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tQOBtDXtEEPr for <linux-ide@vger.kernel.org>;
        Fri, 30 Dec 2022 16:59:45 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NkP0x3Bpfz1RvLy;
        Fri, 30 Dec 2022 16:59:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.2-rc2
Date:   Sat, 31 Dec 2022 09:59:43 +0900
Message-Id: <20221231005943.20587-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71=
c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.2-rc2

for you to fetch changes up to 37e14e4f3715428b809e4df9a9958baa64c77d51:

  ata: ahci: Fix PCS quirk application for suspend (2022-12-27 11:06:57 +=
0900)

----------------------------------------------------------------
ATA fixes for 6.2-rc2

A single fix to address an issue with wake from suspend with PCS
adapters, from Adam.

----------------------------------------------------------------
Adam Vodopjan (1):
      ata: ahci: Fix PCS quirk application for suspend

 drivers/ata/ahci.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)
