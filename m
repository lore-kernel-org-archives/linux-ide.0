Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6859C4167B
	for <linux-ide@archiver.kernel.org>; Mon, 12 Dec 2022 05:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLLFIt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Dec 2022 00:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiLLFIs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2022 00:08:48 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2495BD
        for <linux-ide@vger.kernel.org>; Sun, 11 Dec 2022 21:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670821725; x=1702357725;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yEH3o1hzWUGdBvpFj3bVzW8li4cshnUBhG7ggJisbuQ=;
  b=iN6fLsvKIxVUuzhYhpZ+qdBWKSsOaAT9VHRF5gj6LJfYGtq62wuCmRCs
   jx9UiRo3tQQQGKRdIzi5lE/h/m5TbF+xPAC4u8Ue1G2rrbAnBlDz8vOH6
   kydgEaz1sPCk/dZCT5TtP79KwDtFKqJHuiD8IkHdbVFhyx5SxPMNojE88
   UBDwGDyONjBhvbcruRdF/fZ3AAOzLQYjrOwmgotEI51BgUZgsK5SMYe+T
   BatiWl/cdHyBuQmNYvcEDnXL8XHxRvxYN19CWVNrO+AbSWHWt/I+/U8RH
   k1mBZDL/2k6IEUzIdemiBDNQZGQUhCD3dUkjXOuRmNWgAebNtBn+4NjoL
   A==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="216618418"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 13:08:44 +0800
IronPort-SDR: 5KYnvB7+ThEkJXonz6ZjJ+bR1T/jx5Brt8C8+mWp6Qia5FS2qu+X/RRU5j8EJLK3dQ30yoeLdx
 1PhHPexvXdoWENGe85XSw65ma2sIad5I0HsoCInBBhlJNCQ1nfNmJctJS2i1PsOCHRjPJHCj32
 oFfuiKsUIxAg4ZqkyfF2YBqa5wUZiqBeZ9MsdSxe3RM4NjzkmtTbmf1d1+B26LgowWUBP9PcjT
 6iqi9VUbeRFQm+7q5RMmNrYi3kT20aGO4mSUXbZlMQlNJKBb4BnFLpjfEU5Ovd346EpsNjywY6
 wZA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 20:21:25 -0800
IronPort-SDR: V5P5knK4Q4m3ycFn8kdAyIU/BGLGJ4lkEgCgRSkjQ2gyrDWMzoKhUMgIQEL7Ru1tM6gRLuHvNV
 i0LKqe2W6SHucZ5RNHsLTRudHE0dc2YQewM5XgYlUOo9m/EEm6FO53PFjhCMyRCrDS2qGVku4S
 udcKCOxokVxffTaa4VwBq8OEDEWeXe0d8Ak3FGXZcmK1dhMuKsSEQ2LJkzr2BjKkm0+FKWfqg8
 RZrLp2fipK47N/Ga3uC++fZr81HYJwS+jbgeNpY4OW3uDefY8xnmryWEFHeRg64WzL6qvx1zWm
 CyY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 21:08:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NVqR00tnrz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 11 Dec 2022 21:08:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1670821723;
         x=1673413724; bh=yEH3o1hzWUGdBvpFj3bVzW8li4cshnUBhG7ggJisbuQ=; b=
        rKd0P1gkBvPzfmplEPm735WxUazUp1hYSneOaL5BDoQLFa35LJF5ezfKT3XpEzhm
        o7K+34rwr25FiXi568oSkpAud9ylkaQOybDNEzxHP+anEu2wCObJs9kwh4cgLZdF
        heXokCmZzLzku81mnHW2vavhVf8GbP74emh03zNOX5kvmzUMriDlmvwzvh1SMJUj
        DpqP2Z8dWk+wZ7Hx5WNrWNcaS1cSn1YyidkeJvtL+kEia8CcIWymNOVObrI+UXhR
        aElbb/xi3S/RXIcl3V2H2bp7nvB2g+IUoj24YfUGCG+5Mqax4isjFmhiZWdiDMIt
        693SjZFSkQBhu5+Hz6bGcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GZj_pKEdWoZN for <linux-ide@vger.kernel.org>;
        Sun, 11 Dec 2022 21:08:43 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NVqQz1YJkz1RvLy;
        Sun, 11 Dec 2022 21:08:42 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.2
Date:   Mon, 12 Dec 2022 14:08:41 +0900
Message-Id: <20221212050841.1877401-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
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
ags/ata-6.2-rc1

for you to fetch changes up to f07788079f515ca4a681c5f595bdad19cfbd7b1d:

  ata: ahci: fix enum constants for gcc-13 (2022-12-06 14:33:30 +0900)

----------------------------------------------------------------
ata changes for 6.2

ata changes fro 6.2 include the ususal set of driver fixes and
improvements as well as several patches improving libata core in
preparation of the introduction of the support for the command duration
limits feature. In more details:

  - Define the missing COMPLETED sense key in scsi header (from me).

  - Several patches to improve libata handling of the status of
    completed commands and the retry and sense data reported to the scsi
    layer for failed commands. In particular, this widen the support for
    NCQ autosense to all drives that support this feature instead of
    restricting this feature use to ZAC drives only (from Niklas).

  - Cleanup of the pata_mpc52xx and sata_dwc_460ex drivers to remove the
    use of the deprecated NO_IRQ macro (from Christophe).

  - Fix build dedependency on OF vs use of the of_match_ptr() macro to
    avoid build errors with the sata_gemini and pata_ftide010 drivers
    (from me).

  - Some libata cleanups using the new helper function
    ata_port_is_frozen() (from Niklas).

  - Improve internal command handling by not retrying commands that
    failed with a timeout (from Niklas).

  - Remove code for several unused libata helper functions (from
    Niklas).

  - Remove the palmchip pata_bk3710 driver. A couple of other driver
    removal should come in through the arm tree pull request (from
    Arnd).

  - Remove unused variable and function in the sata_dwc_460ex driver and
    libata-sff code (from Colin and Sergey).

  - Minor cleanup of the pata_ep93xx driver platform code (from
    Minghao).

  - Remove the unnecessary linux/msi.h include from the ahci driver
    (from Thomas).

  - Changes to libata enum constants definitions to avoid warnings with
    gcc-13 (from Arnd).

----------------------------------------------------------------
Arnd Bergmann (2):
      ata: remove palmchip pata_bk3710 driver
      ata: ahci: fix enum constants for gcc-13

Christophe Leroy (2):
      ata: pata_mpc52xx: Replace NO_IRQ with 0
      ata: sata_dwc_460ex: Check !irq instead of irq =3D=3D NO_IRQ

Colin Ian King (1):
      ata: sata_dwc_460ex: remove variable num_processed

Damien Le Moal (3):
      scsi: Define the COMPLETED sense key
      ata: sata_gemini: Remove dependency on OF for compile tests
      ata: pata_ftide010: Remove build dependency on OF

Minghao Chi (1):
      ata: pata_ep93xx: use devm_platform_get_and_ioremap_resource()

Niklas Cassel (13):
      ata: libata: fix NCQ autosense logic
      ata: libata: clarify when ata_eh_request_sense() will be called
      ata: libata: only set sense valid flag if sense data is valid
      ata: libata: fetch sense data for ATA devices supporting sense repo=
rting
      ata: libahci: read correct status and error field for NCQ commands
      ata: add ata_port_is_frozen() helper
      ata: make use of ata_port_is_frozen() helper
      scsi: libsas: make use of ata_port_is_frozen() helper
      ata: libata-core: do not retry reading the log on timeout
      ata: remove unused helper ata_id_lba48_enabled()
      ata: remove unused helper ata_id_flush_enabled()
      ata: remove unused helper ata_id_flush_ext_enabled()
      ata: libata: fix commands incorrectly not getting retried during NC=
Q error

Sergey Shtylyov (1):
      ata: libata-sff: kill unused ata_sff_busy_sleep()

Thomas Gleixner (1):
      ata: ahci: Remove linux/msi.h include

 drivers/ata/Kconfig           |  13 +-
 drivers/ata/Makefile          |   1 -
 drivers/ata/ahci.c            |   1 -
 drivers/ata/ahci.h            | 245 +++++++++++++--------------
 drivers/ata/libahci.c         |  20 ++-
 drivers/ata/libata-acpi.c     |   4 +-
 drivers/ata/libata-core.c     |   7 +-
 drivers/ata/libata-eh.c       |  40 +++--
 drivers/ata/libata-sata.c     |  50 +++++-
 drivers/ata/libata-scsi.c     |  18 +-
 drivers/ata/libata-sff.c      |  56 -------
 drivers/ata/libata.h          |   1 +
 drivers/ata/pata_bk3710.c     | 380 ------------------------------------=
------
 drivers/ata/pata_ep93xx.c     |   3 +-
 drivers/ata/pata_ftide010.c   |   2 +-
 drivers/ata/pata_mpc52xx.c    |   2 +-
 drivers/ata/sata_dwc_460ex.c  |  12 +-
 drivers/ata/sata_gemini.c     |   2 +-
 drivers/ata/sata_nv.c         |   2 +-
 drivers/ata/sata_promise.c    |   2 +-
 drivers/ata/sata_sx4.c        |   2 +-
 drivers/scsi/libsas/sas_ata.c |   2 +-
 include/linux/ata.h           |  31 ----
 include/linux/libata.h        |   7 +-
 include/scsi/scsi_proto.h     |   4 +-
 25 files changed, 249 insertions(+), 658 deletions(-)
 delete mode 100644 drivers/ata/pata_bk3710.c
