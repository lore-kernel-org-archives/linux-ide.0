Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C5BC433FE
	for <linux-ide@archiver.kernel.org>; Thu, 20 Oct 2022 23:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJTXuy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTXuw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2022 19:50:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB91B1554
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666309850; x=1697845850;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vGB08sUmHs++/LPcjyE/POa3NclVM+4mCTzdfG825s4=;
  b=KPdZxDTMu51zvBlbrLvCQTVz3jv52PCAvFFBHVhhAwL2AY+t2FFF8FJ4
   epAkvYvpwAVnN1zQXs8ZZp61imaZUx4MBHKgAqaOvfPXIiOFGNuplZrsm
   A8/rYdWEDzdqcKUNVnr/K7fI+Er7EjB7WCrhnkvZPDnhXRZVY/fin+03G
   vVjTXIHP9bThdNN76aPAgXuH7YwGOxn5XqPPX9LlqzyAfrPdIKQE0rxjB
   TNv4lDmXCQkplPVRAeQOgO2AMh+VjREhHNeXnP6Xl4U/yC3J5woqqi9R/
   /YIJ4PtE+MUfkb0NIlbdQ+rnKwf2rUJvCfkYpl9ynqrob60uXpYvbb54K
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214758483"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 07:50:49 +0800
IronPort-SDR: ztgUUW/hUWSxoE2/2WVEPE+jQ3WOnDFrzIps/15A6YS7H9gSJmXbVPJHR98aJ1hukrDwk8gGTR
 6HmEJlZYQ2DcTRJS0vxtbOUuu5ZhLTtOX/uGyz/VlG0vW6vtlBh88pi04tQMHg0gO1g65bJX0P
 I6uArZJupkYzzI0fI8gxwia3uj0pkuRCZGRzFOdKJRZuvCWfOPO7+So30sa3G1FmrCvnns+OPF
 XbWOdip28QAKUW+Lp+2yVOVx7TpFcMbmRf6RxlekXuT0+7JzNTufaaObF8+QEz8ErVU92o7K++
 /hFg4C2QYSZC56/kPFqttr0e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:04:39 -0700
IronPort-SDR: 84JWEE3FpArpft3TFZ8gud9R0tf6dPypORLIY4kmWTrSGbSLCoB+IOr+uOX3SIhR+cBvHCzR0z
 fFRQZ+mSQqOu6hy6Dc8jqWFpHiO1q5CgxHPCZQPA88FOBiZLFg3pYXhrQcL7c+zQ5WuSy/ygl6
 To7sKM07C9AuDtHP/iyhp2YrEebLHrAv+6sAn+h7Jgj4nJq7Sm3cdF06juUtEz/dEjJ146HFcl
 YueVt+CuYKxpCV3ZKssFg2y3zrBpWQBjr8Croxc8+lUZIvLEHshK5rJtfU68wmGXuvIVuay3/v
 0mE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:50:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MtkrB3zRJz1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:50:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1666309850;
         x=1668901851; bh=vGB08sUmHs++/LPcjyE/POa3NclVM+4mCTzdfG825s4=; b=
        brmn240R98PG78gpDqD0Q0lxjJjBSoD1qUHEwE/vFtMH5OLPITzk1fEh8XOtnsGf
        Nn0EbnimZebzb5cABXutVPwXkFaJ1V4God09u/SKZtnGzXXnA748HYSWdmaAbMlK
        QRIubLYc7GdBPaD3s6lrrdxkQ6nlJFg+LvOleJMRft9TfGVzdbmGSYER0zueUlHZ
        LzhDcLjLCCG7TzAiYzCprM9srrv+jjF+slaKhYZSpnYb/sXSty3FgMD1tE2ly1F3
        u7ZqN2y6rNSUIZRT4syD8HNdVOBJWyiWubqDg1PMpXqqRjCXUtLbWQ89s1NxJ8CG
        K1s9q9+JYOxPU3uom7SUCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RujmgJZSX57e for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 16:50:50 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtkr95QGZz1RvLy;
        Thu, 20 Oct 2022 16:50:49 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.1-rc2
Date:   Fri, 21 Oct 2022 08:50:48 +0900
Message-Id: <20221020235048.181004-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc7=
80:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.1-rc2

for you to fetch changes up to 2ce3a0bf2010b16c78b78cc35a97fa913f1be0ca:

  ata: ahci_qoriq: Fix compilation warning (2022-10-18 08:02:14 +0900)

----------------------------------------------------------------
ata fixes for 6.1-rc2

Several minor fixes for rc2:

* Fix the module alias for the ahci_imx driver to get autoloading to
  work (from Alexander).

* Fix a potential array-index-out-of-bounds problem with the enclosure
  managment support in the ahci driver (from Kai-Heng).

* Several patches to fix compilation warnings thrown by clang in the
  ahci_st, sata_rcar, ahci_brcm, ahci_xgene, ahci_imx and ahci_qoriq
  drivers (from me).

----------------------------------------------------------------
Alexander Stein (1):
      ata: ahci-imx: Fix MODULE_ALIAS

Damien Le Moal (6):
      ata: ahci_st: Fix compilation warning
      ata: sata_rcar: Fix compilation warning
      ata: ahci_brcm: Fix compilation warning
      ata: ahci_xgene: Fix compilation warning
      ata: ahci_imx: Fix compilation warning
      ata: ahci_qoriq: Fix compilation warning

Kai-Heng Feng (1):
      ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS

 drivers/ata/ahci.h       | 2 +-
 drivers/ata/ahci_brcm.c  | 2 +-
 drivers/ata/ahci_imx.c   | 4 ++--
 drivers/ata/ahci_qoriq.c | 2 +-
 drivers/ata/ahci_st.c    | 2 +-
 drivers/ata/ahci_xgene.c | 2 +-
 drivers/ata/sata_rcar.c  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
