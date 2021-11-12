Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FCC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 00:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B661252
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 00:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhKLA2B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:28:01 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43512 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKLA2A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 19:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636676710; x=1668212710;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ruyU8X4e9VuAAMZuSpmCIL1KxugzFsL/akp4sbfJPMQ=;
  b=ZrJL0kg1ZBHZW/n5k1c+lCbKSYtI7LvidQUMeCunYCr9x2u4DkJEdcIr
   y3CVBkj1bv5+YRoB/wKeyKCX66fY/LEvdtUH6u9bv0O9eJ79lXlLUTJfA
   MNXPQs0pCZTEPJH1fLfgWYEacwej4kc05iDeE4wDL/lu+scGcatZgLOJ7
   QTDSxY5v4fREn2gu9rvZeujk0rf+yNFfBBN+qK8g4DjtbUBwxBdChQn3A
   Jrsvv5bL0kCKXv7tBFl29LHKoLxZc0MkPsKAmKaWp+Qz2eHr9W1UYPMtw
   LgxpYR7PPvmJQ8wSSNBmpvzdZdBAi5m+NvDgOCyhEJs9iz5I6/V+ADG/p
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,227,1631548800"; 
   d="scan'208";a="185392032"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2021 08:25:10 +0800
IronPort-SDR: uzCCQhJC1/h1h1enFasZAtYnuxNyu8hoOoYfyxJL4S8GPkiRZ24kR3hi1woicVc+mNzcsD7JCt
 FEaUlhHqx5cLMwQrWvrQGa5QjC02zAEEz2ffCqOboGCO5xx8LdrX2ApLnkS84gsVPEQwP0SD1s
 QKKRIBGbfAdIRKRHUKmA83NuyVzhg9nOlXWPSnWGVVkad8+pg+cLQwASUul/ApQ5NAWEBhRUVJ
 ZxU3rGpKK4e+lCp1xYPqnkfUpcJWMh/NpASdvhGcQkqRKGLl7ou0ETEOovjTFtVgZ/XwMenaXG
 AZBc5AH2y+VDTb9xPKfXbCPO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 16:00:20 -0800
IronPort-SDR: pc5XNcr7V+31XhByT3/PBgsw/l8trYyAi6Hdk7LwW5Xb97R+7tlvYTQ8+PgSGXDcdPKlacC0aD
 NuIc0qg68Gpfk/h3ZfvivsNT+cCU/P+7zm++uakZiA75k4hGGTqhvwMT11ZKHiwJ+037GhgqXR
 fCiqDieYcJ9siLG4Ou/1X5ZEYWoUDjmxZq/k5pUns04cIJSNWoD6Rpkegop8UlqRtzNXBfn70m
 pNKDfrLrg6FXO89ncNyUrxd8so9UcC89hb8MVvcfxSbHCq+wvNTkDOFZ+cmAxyEkGQGq+LEopZ
 Rq4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 16:25:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hqzr637Crz1RtVm
        for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2021 16:25:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636676710;
         x=1639268711; bh=ruyU8X4e9VuAAMZuSpmCIL1KxugzFsL/akp4sbfJPMQ=; b=
        as4BsKdpKeUvylSEQZ2rrpIZhoz6dR0HB3LZR9VAo4Ys+7mmXDbq9dlNwVJhwnVH
        G2GXsN1KbKzTLYddCQNvQUkycKpVwG1AiECO2YBAHLHF6KRHavzuuXKyiq0uyz92
        5OCM8mJpXsruhq+OtjO+MaOfQ06HB5eXRUDW2YAeqpzZPItoBTFkUqZn23QAZj3b
        eLipefgSCzFGp2HsitLzA64hn0lolGSWVcB59JbAxyp3EARKQGePNQPwkZihW1VX
        6UIUHkblyyBtECMJ+UZLrQGmGEZ/iNyZlMfjKGX7l8rOajRLcy/fiuxhUclHpPIm
        Ge7NCRXtso6P+5uIWu8fZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J2XAq0CSfE3v for <linux-ide@vger.kernel.org>;
        Thu, 11 Nov 2021 16:25:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hqzr54RQpz1RtVl;
        Thu, 11 Nov 2021 16:25:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] second round of libata changes for 5.16-rc1
Date:   Fri, 12 Nov 2021 09:25:06 +0900
Message-Id: <20211112002506.564912-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit debe436e77c72fcee804fb867f275e6d31aa99=
9c:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel=
/git/tytso/ext4 (2021-11-10 17:05:37 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc1-p2

for you to fetch changes up to 1b87bda1f29a91720a410ac0819866a3cf0df32d:

  libata: libahci: declare ahci_shost_attr_group as static (2021-11-12 08=
:05:47 +0900)

----------------------------------------------------------------
libata changes for 5.16-rc1, second round

Second round of updates for libata for 5.16:
* Fix READ LOG EXT and READ LOG DMA EXT command timeouts during disk
  revalidation after a resume or a modprobe of the LLDD (from me).
* Remove unnecessary error message in sata_highbank driver (from Xu).
* Better handling of accesses to the IDENTIFY DEVICE data log for drives
  that do not support this log page (from me).
* Fix ahci_shost_attr_group declaration in ahci driver (from me).

----------------------------------------------------------------
Damien Le Moal (3):
      libata: fix read log timeout value
      libata: add horkage for missing Identify Device log
      libata: libahci: declare ahci_shost_attr_group as static

Xu Wang (1):
      ata: sata_highbank: Remove unnecessary print function dev_err()

 drivers/ata/libahci.c       |  2 +-
 drivers/ata/libata-core.c   | 13 ++++++++++++-
 drivers/ata/libata-eh.c     |  8 ++++++++
 drivers/ata/sata_highbank.c |  4 +---
 include/linux/libata.h      |  3 ++-
 5 files changed, 24 insertions(+), 6 deletions(-)
