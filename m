Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60FCC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 14 Jan 2022 06:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiANG7W (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:59:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51131 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiANG7W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 01:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642143562; x=1673679562;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iwjI2cQOVjjxYkZbaGDRXJTXPD7NjfVFW4xGsvOufwA=;
  b=VqXzbMwbUzGkBv6tD+XkChMG/IV4jJlwJ44UXKICyzBQa12o/vI93FK1
   buLURoC7tIBQixn6GyoIUHpcWl9ODWMeYRSyFysP4H+wxCYEDOqiCBi3o
   DJcYKHRqA1wSwKwStSReMiNla0hh1Ih1IezckplfSea+1lRYKx5nUcu4g
   1FGDvaRDoPhgyyssn5CaMcGFn5ftI696ESjTRmn5C27/FucioA1+pIJko
   gY4NLA3pAHl0UpM+3PrE/p1S/0VPFfzfq8EegxesurucCPe5Zwn6y9k1I
   QvYJVl9N5GXTvAuoOPEyBy8WVoP5qArTRhoWAGXX1o1k1DrjmYVk+Dcss
   g==;
X-IronPort-AV: E=Sophos;i="5.88,287,1635177600"; 
   d="scan'208";a="191462105"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2022 14:59:12 +0800
IronPort-SDR: YwhULnALJlAunxPywXxxtpemSY+nC6sFNAQGXqT4dQKWXd6klTpTsKNUwwgRq+FBJ28PyChRp7
 Js6q99fL54ZZrwHUKsbZRIS+eALcHInWW/az+VTNkWBy6Enf71zJqOgcFxAQqNVx94JgWjdnfV
 BAPVfLnvZQnfk+BDsdLvxcRhqx0lHOAyq8gNETftjTaq3RVmjWYbF2cUf5egdOcdBoT+H0p/5V
 HhgE7Dqt7ye1DvWZnQLGb6Yzz8gfqyi2dNlNeedJhbwNYb3yGFJnA5uL+4a5q3vav3Ck3qV32J
 wdyoWUxBhMc13dLCm8qeMDzx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:31:30 -0800
IronPort-SDR: GINfds8ORXz5+/ivfscGYWue9zPT9T3OitGwPkOQWLZyakrJ9j5BPJNFYfxkPNq7TiFDg8Vezn
 fKw/0/92sgnmDSmx6IvrNRmUHHVTiTZkwYX/LPdAH639TI+Wj8HuGTtaG3rK0HXE8VOiRL2ZfE
 JLCv87RKjECnA+kODnrpNfJF/8+cf/10biZMfWu85RXP3lMcRrOz9K3dRTVWyYObhO/lfWHLrt
 2jgMlx7PPOQsZ3MuU2EdUxIXikbxJoY1HCa9PH2WUGKI5zMRljtafoa2scb6DlSbEWuKMW0NVS
 YE8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:59:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JZsbf5fJJz1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 13 Jan 2022 22:59:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1642143550;
         x=1644735551; bh=iwjI2cQOVjjxYkZbaGDRXJTXPD7NjfVFW4xGsvOufwA=; b=
        l3lHFwO2rFj4TMSwJ4bDoXNLW/EV1efxWo3m0/Ctm69RX+Y3r2SK+riq44N8NR1Q
        c1ENhdLe/JUruJTonC8KlNE71Lg+VYAjZNp7pftaMoQHRJROAEkQkDDeaOJaK+2P
        qs1Mg9kQDufk69zI/rfqp8MNSSIs3KE1bzLjwHKk3H2VM1PId3i5LBESrv/Q67uP
        GtdbV5G6iZIHCqb/HoftTUGWdsw8x77YhKFJhAm2xbBHmvT8eeAPT23+OxeI8BwI
        A9/yK2mewNE4CTEBozeNK3YnM9+TAMD4LeL90g6Yb5CCDmhCRLrDz8RQm3tPRDVj
        81HJU2m9LvBZRe7RTaoTPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eoC0Me71tGoE for <linux-ide@vger.kernel.org>;
        Thu, 13 Jan 2022 22:59:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JZsbd5wjfz1Rwrw;
        Thu, 13 Jan 2022 22:59:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 5.17-rc1
Date:   Fri, 14 Jan 2022 15:59:06 +0900
Message-Id: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b=
48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc1

for you to fetch changes up to 237fe8885a3fdab169bf670790c9f40046af45d3:

  ata: pata_ali: remove redundant return statement (2022-01-14 15:17:17 +=
0900)

----------------------------------------------------------------
ATA changes for 5.17-rc1

A larger than usual set of changes for this cycle. The bulk of the change=
s are
part of a rework of libata messages and debugging features from Hannes. I=
n more
details, the changes are as follows.

* Small code cleanups in the pata_ali driver (unnecessary variable
  initialization and simplified return statement, from Jason and  Colin.
* Switch to using struct_group() in the sata_fsl driver, from Kees.
* Convert many sysfs attribute show functions to use sysfs_emit() instead=
 of
  snprintf(), from me.
* sata_dwc_460ex driver code cleanups, from Andy.
* Improve DMA setup and remove superfluous error message in libahci_platf=
orm,
  from Andy
* A small code cleanup in libata to use min() instead of open coding test=
,
  from Changcheng.
* Rework of libata messages from Hannes. This is especially focused on
  replacing compile time defined debugging messages (DPRINTK() and VPRINT=
K())
  with regular dynamic debugging messages (pr_debug()) and traceipoint ev=
ents.
  Both libata-core and many drivers are updated to have a consistent debu=
gging
  level control for all drivers.
* Extend compile test support to as many drivers as possible in ATA Kconf=
ig to
  improve compile test coverage, from me.
* Fixes to avoid compile time warnings (W=3D1) and sparse warnings in sat=
a_fsl
  and ahci_xgene drivers, from me.
* Fix the interface of the read_id() port operation method to clarify tha=
t the
  data buffer passed as an argument is little endian. This avoids sparse
  warnings in the pata_netcell, pata_it821x, ahci_xgene, ahci_cevaxi and
  ahci_brcm drivers. From me.
* Small code cleanup in the pata_octeon_cf driver, from Minghao.
* Improved IRQ configuration code in pata_of_platform, from Lad.
* Simplified implementation of __ata_scsi_queuecmd(), from Wenchao.
* Debounce delay flag renaming, from Paul.
* Add support for AMD A85 FCH (Hudson D4) AHCI adapters, from Paul

----------------------------------------------------------------
Andy Shevchenko (5):
      ata: sata_dwc_460ex: Use devm_platform_*ioremap_resource() APIs
      ata: sata_dwc_460ex: Use temporary variable for struct device
      ata: sata_dwc_460ex: Remove unused forward declaration
      ata: libahci_platform: Remove bogus 32-bit DMA mask attempt
      ata: libahci_platform: Get rid of dup message when IRQ can't be ret=
rieved

Changcheng Deng (1):
      ata: libata: use min() to make code cleaner

Colin Ian King (1):
      ata: pata_ali: remove redundant return statement

Damien Le Moal (24):
      ata: libata-sata: use sysfs_emit()
      ata: libata-scsi: use sysfs_emit()
      ata: ahci: use sysfs_emit()
      ata: sata_fsl: use sysfs_emit()
      ata: sata_fsl: add compile test support
      ata: ahci_brcm: add compile test support
      ata: ahci_da850: add compile test support
      ata: ahci_dm816: add compile test support
      ata: ahci_mtk: add compile test support
      ata: ahci_mvebu: add compile test support
      ata: ahci_sunxi: add compile test support
      ata: ahci_tegra: add compile test support
      ata: ahci_xgene: add compile test support
      ata: ahci_seattle: add compile test support
      ata: pata_bk3710: add compile test support
      ata: sata_fsl: fix scsi host initialization
      ata: sata_fsl: fix cmdhdr_tbl_entry and prde struct definitions
      ata: ahci_xgene: use correct type for port mmio address
      ata: fix read_id() ata port operation interface
      ata: pata_cs5535: add compile test support
      ata: pata_ftide010: add compile test support
      ata: pata_imx: add compile test support
      ata: pata_pxa: add compile test support
      ata: pata_samsung_cf: add compile test support

Hannes Reinecke (68):
      ata: libata: remove pointless debugging messages
      ata: libata: whitespace cleanup
      ata: libata: Add ata_port_classify() helper
      ata: libata: move ata_dump_id() to dynamic debugging
      ata: libata: sanitize ATA_HORKAGE_DUMP_ID
      ata: libata: add reset tracepoints
      ata: libata: add qc_prep tracepoint
      ata: libata: tracepoints for bus-master DMA
      ata: libata-sff: tracepoints for HSM state machine
      ata: libata-scsi: drop DPRINTK calls for cdb translation
      ata: libata: add tracepoints for ATA error handling
      ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX() macr=
os
      ata: libata: revamp ata_get_cmd_descript()
      ata: libata: move DPRINTK to ata debugging
      ata: sata_mv: kill 'port' argument in mv_dump_all_regs()
      ata: sata_mv: replace DPRINTK with dynamic debugging
      ata: pata_octeon_cf: remove DPRINTK() macro in interrupt context
      ata: pdc_adma: Remove DPRINTK call
      ata: sata_fsl: move DPRINTK to ata debugging
      ata: sata_rcar: replace DPRINTK() with ata_port_dbg()
      ata: sata_qstor: replace DPRINTK() with dev_dbg()
      ata: pata_pdc2027x: Replace PDPRINTK() with standard ata logging
      ata: libata: remove pointless VPRINTK() calls
      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining=
 ones
      ata: pdc_adma: Drop pointless VPRINTK() calls and remove disabled N=
CQ debugging
      ata: pata_octeon_cf: Drop pointless VPRINTK() calls and convert the=
 remaining one
      ata: pata_via: Drop pointless VPRINTK() calls
      ata: sata_promise: Drop pointless VPRINTK() calls and convert the r=
emaining ones
      ata: sata_qstor: Drop pointless VPRINTK() calls
      ata: sata_rcar: Drop pointless VPRINTK() calls
      ata: sata_inic162x: Drop pointless VPRINTK() calls
      ata: sata_mv: Drop pointless VPRINTK() call and convert the remaini=
ng one
      ata: sata_nv: drop pointless VPRINTK() calls and convert remaining =
ones
      ata: sata_fsl: convert VPRINTK() calls to ata_port_dbg()
      ata: sata_sil: Drop pointless VPRINTK() calls
      ata: sata_sx4: Drop pointless VPRINTK() calls and convert the remai=
ning ones
      ata: sata_sx4: add module parameter 'dimm_test'
      ata: libata: drop ata_msg_error() and ata_msg_intr()
      ata: libata: drop ata_msg_ctl()
      ata: libata: drop ata_msg_malloc()
      ata: libata: drop ata_msg_warn()
      ata: libata: drop ata_msg_probe()
      ata: libata: drop ata_msg_info()
      ata: libata: drop ata_msg_drv()
      ata: libata: remove 'new' ata message handling
      ata: libata: remove debug compilation switches
      ata: pata_atp867x: convert printk() calls
      ata: pata_cmd640: convert printk() calls
      ata: pata_cmd64x: convert printk() calls
      ata: pata_cs5520: convert printk() calls
      ata: pata_cs5536: convert printk() calls
      ata: pata_cypress: convert printk() calls
      ata: pata_it821x: convert printk() calls
      ata: pata_marvell: convert printk() calls
      ata: pata_rz1000: convert printk() calls
      ata: pata_serverworks: convert printk() calls
      ata: pata_sil680: convert printk() calls
      ata: sata_sx4: convert printk() calls
      ata: sata_mv: convert remaining printk() to structured logging
      ata: pata_hpt37x: convert pr_XXX() calls
      ata: pata_octeon_cf: Replace pr_XXX() calls with structured logging
      ata: pata_hpt3x2n: convert pr_XXX() calls
      ata: sata_gemini: convert pr_err() calls
      ata: pata_hpt366: convert pr_warn() calls
      ata: libata-scsi: rework ata_dump_status to avoid using pr_cont()
      ata: sata_dwc_460ex: drop DEBUG_NCQ
      ata: sata_dwc_460ex: remove 'check_status' argument
      ata: sata_dwc_460ex: Remove debug compile options

Jason Wang (1):
      ata: pata_ali: no need to initialise statics to 0

Kees Cook (1):
      ata: sata_fsl: Use struct_group() for memcpy() region

Lad Prabhakar (1):
      ata: pata_of_platform: Use platform_get_irq_optional() to get the i=
nterrupt

Minghao Chi (1):
      ata: pata_octeon_cf: remove redundant val variable

Paul Menzel (2):
      ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
      ata: ahci: Add support for AMD A85 FCH (Hudson D4)

Wenchao Hao (1):
      ata: libata-scsi: simplify __ata_scsi_queuecmd()

 drivers/ata/Kconfig             |  44 ++---
 drivers/ata/acard-ahci.c        |   4 -
 drivers/ata/ahci.c              |  24 ++-
 drivers/ata/ahci_brcm.c         |   4 +-
 drivers/ata/ahci_ceva.c         |   5 +-
 drivers/ata/ahci_qoriq.c        |   4 -
 drivers/ata/ahci_xgene.c        |  12 +-
 drivers/ata/ata_piix.c          |  11 +-
 drivers/ata/libahci.c           |  33 +---
 drivers/ata/libahci_platform.c  |  14 +-
 drivers/ata/libata-acpi.c       |  69 +++----
 drivers/ata/libata-core.c       | 231 +++++-----------------
 drivers/ata/libata-eh.c         |  72 ++++---
 drivers/ata/libata-pmp.c        |   8 -
 drivers/ata/libata-sata.c       |  11 +-
 drivers/ata/libata-scsi.c       | 170 +++++-----------
 drivers/ata/libata-sff.c        |  88 +++------
 drivers/ata/libata-trace.c      |  47 +++++
 drivers/ata/libata-transport.c  |  48 ++++-
 drivers/ata/libata.h            |   5 +-
 drivers/ata/pata_ali.c          |   4 +-
 drivers/ata/pata_arasan_cf.c    |   3 +
 drivers/ata/pata_atp867x.c      | 105 +++++-----
 drivers/ata/pata_cmd640.c       |   2 +-
 drivers/ata/pata_cmd64x.c       |   4 +-
 drivers/ata/pata_cs5520.c       |   4 +-
 drivers/ata/pata_cs5536.c       |   4 +-
 drivers/ata/pata_cypress.c      |   2 +-
 drivers/ata/pata_ep93xx.c       |   1 -
 drivers/ata/pata_hpt366.c       |   5 +-
 drivers/ata/pata_hpt37x.c       |  20 +-
 drivers/ata/pata_hpt3x2n.c      |  12 +-
 drivers/ata/pata_it821x.c       |  66 ++++---
 drivers/ata/pata_ixp4xx_cf.c    |   6 +-
 drivers/ata/pata_marvell.c      |   9 +-
 drivers/ata/pata_netcell.c      |   5 +-
 drivers/ata/pata_octeon_cf.c    |  54 ++----
 drivers/ata/pata_of_platform.c  |  15 +-
 drivers/ata/pata_pdc2027x.c     |  71 +++----
 drivers/ata/pata_pdc202xx_old.c |   2 -
 drivers/ata/pata_rz1000.c       |   4 +-
 drivers/ata/pata_serverworks.c  |   4 +-
 drivers/ata/pata_sil680.c       |   9 +-
 drivers/ata/pata_via.c          |  12 --
 drivers/ata/pdc_adma.c          |  33 +---
 drivers/ata/sata_dwc_460ex.c    | 165 ++++------------
 drivers/ata/sata_fsl.c          | 212 +++++++++-----------
 drivers/ata/sata_gemini.c       |   4 +-
 drivers/ata/sata_inic162x.c     |   4 +-
 drivers/ata/sata_mv.c           | 132 ++++++-------
 drivers/ata/sata_nv.c           |  54 ++----
 drivers/ata/sata_promise.c      |  31 +--
 drivers/ata/sata_qstor.c        |  15 +-
 drivers/ata/sata_rcar.c         |  26 +--
 drivers/ata/sata_sil.c          |   1 -
 drivers/ata/sata_sil24.c        |   5 +-
 drivers/ata/sata_sx4.c          | 148 +++++---------
 include/linux/libata.h          | 138 ++++++-------
 include/trace/events/libata.h   | 416 ++++++++++++++++++++++++++++++++++=
+++++-
 59 files changed, 1272 insertions(+), 1439 deletions(-)
