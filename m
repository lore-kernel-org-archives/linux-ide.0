Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69364C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Oct 2022 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJEGQn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Oct 2022 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJEGQm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2022 02:16:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19739733D1
        for <linux-ide@vger.kernel.org>; Tue,  4 Oct 2022 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664950600; x=1696486600;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PhKj8w5hwURLsoz6sqK8+aIKEWk/NyntlVwo4cHBI2w=;
  b=lnpDUxnJaUP3M9EAFdWdOIhA8AjRYylTx21PN8fm9Z7gL5KW4eC7IIm0
   BTEgkAtSZT/z8cudAZ6L/go+cDJOYoi79SPBa2RU0b6xI5RxidWD6bp/T
   vk1/QrZPGuTsL4mgKaUMyqKhAb1Z4gIi6Rlt4TMedEQnr3T+AMq0y+KZw
   kXxnEcgalg6cw9w3SnHU6bOE1mgYBQma8F2RTIe+MHt2Lz4Q49jxdosvK
   tzMChWpMckDpHi9yXI//D3pF9cT0cM4imqQJn43njTTwHg6WbnDaXx7lS
   /mlOPrO385pf31/SYnZcUljvYn0onk8sKeT15pEvXQi2TUmctQKSzWYvr
   g==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="213423430"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 14:16:40 +0800
IronPort-SDR: Fu4c7+bisyhJVx+Ez0ZQgeLRHQ0IQrluqph5u/lxA6VMbWdsIvGjYt8ZWy1ifn1g9q14zDfLyD
 FG+oqaRu22mNYDj5o7hpwiv74fKaAMI1Jz2LNrLh08ycWMhZ6Q6gnqPYWW6jf68+095qzw9TSN
 3VgdubpFd3WDXaeEkVh12eohO6Wo/ew+vhoTEOJW+QTiwr08urW7zhrtQ9UzvirF+FjYDZwQ3E
 btaW0J1SaAm0vKoSITLy6ABLKj4/rSILbntkzpNoVfriIsP66CNgImjtnIdgG85Ajo97pNKHCG
 5bvzFTT8C9CkSFfI1rtqF7Iz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:30:53 -0700
IronPort-SDR: wfyA/GX10VOyAWUUAAW5xp/9tbgd2MPau8lULqYCtpN/zrpGlQseU5TnKh8BR1kBIaVhzoF2+z
 Fw1OPg1op+NAwEVoGYE9iuZBjL2AfFYzVBuwpkWsYh75m8s9uAquD2XJJTsXAEh8QeJGadSyA3
 HV8uB8TxS4ek2DQP6w3fEZVRaQhghlL1c+iVPZ6vmcAjTe952uvrNyFu7nTVGy16bKK4qDf670
 PNfULiaQopWzvjV1Cpxd/FvxK+BVx+qlcV5ys4JZmVJ8gAk7u/6ixsHtospGvGUvQW+0NZpgiu
 Guo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 23:16:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj48l5MmMz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  4 Oct 2022 23:16:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1664950599;
         x=1667542600; bh=PhKj8w5hwURLsoz6sqK8+aIKEWk/NyntlVwo4cHBI2w=; b=
        q27+3awudRj+z8WF7WAbtfcnhSFlFgLzOt4uHqoFppuB6pAWrIRN+/6zxCue4EYf
        6+CX135KuLloVrpjkuM3LbtnF5AjAfuayGGQ2i0OQCIX/oBonfTDIJgFQfAHQN3L
        1wZz/3zdNs+E7bylkfKia7x3N72YULOz0ON7b2IJ12Uv3fdaBbg9VhBhA4nQ8XpR
        LL+7AKQUI/a19S5QcjipE1/Hxf83BLU7jx4hJ/WwAd9vHVRul9ZLXNE+ZiZaZ9z9
        H6Yhs785DNV8lcT6ca6s1kjjd8tO0CY1JCdRHq0CrzEY9WMS9Vha9Fp7INUU+/2z
        AADg6QH2cVXpFUXoOShqcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gglSh-48R4V3 for <linux-ide@vger.kernel.org>;
        Tue,  4 Oct 2022 23:16:39 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj48k5lzlz1RvLy;
        Tue,  4 Oct 2022 23:16:38 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.1-rc1
Date:   Wed,  5 Oct 2022 15:16:37 +0900
Message-Id: <20221005061637.160994-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b8=
68:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.1-rc1

for you to fetch changes up to 71d7b6e51ad3370d850303b61b79528fb2872f0a:

  ata: libata-eh: avoid needless hard reset when revalidating link (2022-=
09-24 15:31:00 +0900)

----------------------------------------------------------------
ata changes for 6.1-rc1

* Print the timeout value for internal command failures due to a
  timeout (from Tomas).

* Improve parameter names in ata_dev_set_feature() to clarify this
  function use (from Niklas).

* Improve the ahci driver low power mode setting initialization to allow
  more flexibility for the user (from Rafael).

* Several patches to remove redundant variables in libata-core,
  libata-eh and the pata_macio driver and to fix typos in comments (from
  Jinpeng, Shaomin, Ye).

* Some code simplifications and macro renaming (for clarity) in various
  functions of libata-core (from me).

* Add a missing check for a potential failure of sata_scr_read() in
  sata_print_link_status() (from Li).

* Cleanup of libata Kconfig PATA_PLATFORM and PATA_OF_PLATFORM options
  (from Lukas).

* Cleanups of ata dt-bindings and improvements of libahci_platform, ahci
  and libahci code (from Serge)

* New driver for Synopsys AHCI SATA controllers, based of the generic
  ahci code (from Serge). One compilation warning fix is added for this
  driver (from me).

* Several fixes to macros used to discover a drive capabilities to be
  consistent with the ACS specifications (from Niklas).

* A couple of simplifcations to some libata functions, removing
  unnecessary arguments (from Niklas).

* An improvements to libata-eh code to avoid unnecessary link reset when
  revalidating a drive after a failed command. In practice, this extra,
  unneeded reset, reset does not cause any arm beyond slightly slowing
  down error recovery (from Niklas).

----------------------------------------------------------------
Damien Le Moal (5):
      ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
      ata: libata-core: Simplify ata_build_rw_tf()
      ata: libata-core: Simplify ata_dev_set_xfermode()
      ata: ahci_st: Fix compilation warning
      ata: ahci_st: Enable compile test

Jinpeng Cui (1):
      ata: libata-core: remove redundant err_mask variable

Li Zhong (1):
      ata: libata-core: Check errors in sata_print_link_status()

Lukas Bulwahn (2):
      ata: clean up how architectures enable PATA_PLATFORM and PATA_OF_PL=
ATFORM
      ata: make PATA_PLATFORM selectable only for suitable architectures

Niklas Cassel (8):
      ata: libata-core: improve parameter names for ata_dev_set_feature()
      ata: fix ata_id_sense_reporting_enabled() and ata_id_has_sense_repo=
rting()
      ata: fix ata_id_has_devslp()
      ata: fix ata_id_has_ncq_autosense()
      ata: fix ata_id_has_dipm()
      ata: libata: drop superfluous ata_eh_request_sense() parameter
      ata: libata: drop superfluous ata_eh_analyze_tf() parameter
      ata: libata-eh: avoid needless hard reset when revalidating link

Rafael J. Wysocki (1):
      ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0

Serge Semin (23):
      dt-bindings: ata: ahci-platform: Move dma-coherent to sata-common.y=
aml
      dt-bindings: ata: ahci-platform: Detach common AHCI bindings
      dt-bindings: ata: ahci-platform: Clarify common AHCI props constrai=
nts
      dt-bindings: ata: sata: Extend number of SATA ports
      dt-bindings: ata: sata-brcm: Apply common AHCI schema
      ata: libahci_platform: Convert to using platform devm-ioremap metho=
ds
      ata: libahci_platform: Convert to using devm bulk clocks API
      ata: libahci_platform: Sanity check the DT child nodes number
      ata: libahci_platform: Parse ports-implemented property in resource=
s getter
      ata: libahci_platform: Introduce reset assertion/deassertion method=
s
      dt-bindings: ata: ahci: Add platform capability properties
      ata: libahci: Extend port-cmd flags set with port capabilities
      ata: libahci: Discard redundant force_port_map parameter
      ata: libahci: Don't read AHCI version twice in the save-config meth=
od
      ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
      ata: ahci: Introduce firmware-specific caps initialization
      dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
      ata: libahci_platform: Add function returning a clock-handle by id
      ata: ahci: Add DWC AHCI SATA controller support
      dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schem=
a
      ata: ahci-dwc: Add platform-specific quirks support
      ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
      MAINTAINERS: Add maintainers for DWC AHCI SATA driver

Shaomin Deng (2):
      ata: pata_macio: Remove unneeded word in comments
      ata: libata-sff: Fix double word in comments

Tomas Henzl (1):
      ata: libata-core: Print timeout value when internal command times

ye xingchen (1):
      ata: libata-eh: Remove the unneeded result variable

 .../devicetree/bindings/ata/ahci-common.yaml       | 123 +++++
 .../devicetree/bindings/ata/ahci-platform.yaml     |  92 +---
 .../devicetree/bindings/ata/baikal,bt1-ahci.yaml   | 115 +++++
 .../devicetree/bindings/ata/brcm,sata-brcm.yaml    |   4 +-
 .../devicetree/bindings/ata/sata-common.yaml       |  17 +-
 .../bindings/ata/snps,dwc-ahci-common.yaml         | 102 +++++
 .../devicetree/bindings/ata/snps,dwc-ahci.yaml     |  75 ++++
 MAINTAINERS                                        |   9 +
 arch/arm/mach-versatile/Kconfig                    |   1 -
 arch/arm64/Kconfig                                 |   1 -
 drivers/ata/Kconfig                                |  18 +-
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci.c                                 |   9 +-
 drivers/ata/ahci.h                                 |  22 +-
 drivers/ata/ahci_da850.c                           |  47 +-
 drivers/ata/ahci_dm816.c                           |   4 +-
 drivers/ata/ahci_dwc.c                             | 493 +++++++++++++++=
++++++
 drivers/ata/ahci_mtk.c                             |   2 -
 drivers/ata/ahci_platform.c                        |   5 -
 drivers/ata/ahci_st.c                              |   4 -
 drivers/ata/libahci.c                              |  63 ++-
 drivers/ata/libahci_platform.c                     | 218 ++++++---
 drivers/ata/libata-core.c                          |  64 ++-
 drivers/ata/libata-eh.c                            |  38 +-
 drivers/ata/libata-sata.c                          |   6 +-
 drivers/ata/libata-scsi.c                          |   4 +-
 drivers/ata/libata-sff.c                           |   2 +-
 drivers/ata/libata.h                               |   7 +-
 drivers/ata/pata_macio.c                           |   3 +-
 include/dt-bindings/ata/ahci.h                     |  20 +
 include/linux/ahci_platform.h                      |   8 +-
 include/linux/ata.h                                |  39 +-
 include/linux/libata.h                             |   2 +-
 33 files changed, 1331 insertions(+), 287 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yam=
l
 create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci=
.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci-c=
ommon.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.y=
aml
 create mode 100644 drivers/ata/ahci_dwc.c
 create mode 100644 include/dt-bindings/ata/ahci.h
