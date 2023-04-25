Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8EFC6FD18
	for <linux-ide@archiver.kernel.org>; Tue, 25 Apr 2023 14:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjDYOXd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Apr 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjDYOXc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Apr 2023 10:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F8413FA4
        for <linux-ide@vger.kernel.org>; Tue, 25 Apr 2023 07:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9DF62567
        for <linux-ide@vger.kernel.org>; Tue, 25 Apr 2023 14:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E057AC433D2;
        Tue, 25 Apr 2023 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682432593;
        bh=FizRTzvozA8qYe/HVZBromF6UjXC538QRscGm+Y0LjU=;
        h=From:To:Subject:Date:From;
        b=jbv1I8vDGcs+rvZIXmq1nPiVYoy0r/5U4F+FWU/Aj09X1erUBpbFUeR8fImO1MziZ
         pkZLjtl2MMqrKaO3olqP0YzBsM3D3b8ItUxpJiUXK59mI0h8boqQnaI7rEKjVGofEO
         M9CV8FNFfEVLtx3LWJszUg1argL2sPHTkFybm4uJOG/wbHkENTkwd+5Ea+kaPATu3U
         Daw01joU/zO8xyeaqekiXCNoHvN5rTu6OvsILbHZpJ5d8TGg8ryIdFkObUvcKLQ8Bc
         3dlTGSSWYQRSdN9GFMstSQoLGbPxHklUll7/8m8IXTsJPHsQF9QJbFYKJg3ujoFe5+
         uJVicbXilb2Xw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.4-rc1
Date:   Tue, 25 Apr 2023 23:23:11 +0900
Message-Id: <20230425142311.186448-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc1

for you to fetch changes up to 140b26035b2d379d94e6e3936ab2e0adf94efe46:

  ata: pata_parport-bpck6: Declare mode_map as static (2023-03-28 09:28:06 +0900)

----------------------------------------------------------------
ata change for 6.4-rc1

 * Many cleanups of the pata_parport driver and of its protocol modules,
   from Ondrej.

 * Remove unused code (ata_id_xxx() functions), from Sergey.

 * Add Add UniPhier SATA controller DT bindings, from Kunihiko.

 * Fix dependencies for the Freescale QorIQ AHCI SATA controller driver,
   from Geert.

 * DT property handling improvements, from Rob.

----------------------------------------------------------------
Damien Le Moal (2):
      ata: pata_parport-bpck6: Remove dependency on 64BIT
      ata: pata_parport-bpck6: Declare mode_map as static

Geert Uytterhoeven (1):
      ahci: qoriq: Add platform dependencies

Kunihiko Hayashi (1):
      dt-bindings: ata: Add UniPhier controller binding

Ondrej Zary (50):
      ata: pata_parport: fix EPAT C7/C8 Kconfig
      ata: pata_parport: probe all units automatically
      ata: pata_parport: Remove pi_swab16 and pi_swab32
      ata: pata_parport: remove useless printks at module_init of bpck6
      ata: pata_parport: Introduce module_pata_parport_driver macro
      ata: pata_parport: remove devtype from struct pi_adapter
      ata: pata_parport: remove device from struct pi_adapter
      ata: pata_parport: remove typedef struct PIA
      ata: pata_parport: remove verbose parameter from log_adapter()
      ata: pata_parport: remove scratch parameter from log_adapter()
      ata: pata_parport: use dev_* instead of printk
      ata: pata_parport: use print_hex_*
      ata: pata_parport: simplify log_adapter prints, remove VERSION defines
      ata: pata_parport: remove bpck6 verbose parameter
      ata: pata_parport: remove verbose parameter from test_proto()
      ata: pata_parport: remove scratch parameter from test_proto()
      ata: pata_parport: remove obsolete changelogs
      ata: pata_parport: move pata_parport.h to drivers/ata/pata_parport
      ata: pata_parport-bpck6: remove useless defines
      ata: pata_parport-bpck6: remove useless range check from read/write_regr
      ata: pata_parport-bpck6: don't cast pi->pardev to struct pardevice *
      ata: pata_parport-bpck6: pass around struct pi_adapter *
      ata: pata_parport-bpck6: remove lpt_addr from struct ppc_storage
      ata: pata_parport-bpck6: remove ppc_id from struct ppc_storage
      ata: pata_parport-bpck6: remove org_* from struct ppc_storage
      ata: pata_parport-bpck6: remove mode from struct ppc_storage
      ata: pata_parport-bpck6: remove struct ppc_storage
      ata: pata_parport-bpck6: remove parallel port bit defines
      ata: parport_pc: add 16-bit and 8-bit fast EPP transfer flags
      ata: pata_parport-bpck6: use parport access functions instead of port I/O
      ata: pata_parport-bpck6: use parport_frob_control and remove CUR_CTRL
      ata: pata_parport-bpck6: remove PPC_FLAGS
      ata: pata_parport-bpck6: remove ppc6_close
      ata: pata_parport-bpck6: merge ppc6_rd_port into bpck6_read_regr
      ata: pata_parport-bpck6: merge ppc6_wr_port into bpck6_write_regr
      ata: pata_parport-bpck6: merge ppc6_rd_port16_blk into bpck6_read_block
      ata: pata_parport-bpck6: merge ppc6_wr_port16_blk into bpck6_write_block
      ata: pata_parport-bpck6: merge ppc6_rd_data_blk into bpck6_read_block
      ata: pata_parport-bpck6: merge ppc6_wr_data_blk into bpck6_write_block
      ata: pata_parport-bpck6: move ppc6_wait_for_fifo to bpck6.c and rename
      ata: pata_parport-bpck6: move ppc6_wr_extout to bpck6.c and rename
      ata: pata_parport-bpck6: move ppc6_open to bpck6.c and rename
      ata: pata_parport-bpck6: merge ppc6_select into bpck6_open
      ata: pata_parport-bpck6: move ppc6_deselect to bpck6.c and rename
      ata: pata_parport-bpck6: move ppc6_send_cmd to bpck6.c and rename
      ata: pata_parport-bpck6: move ppc6_rd_data_byte to bpck6.c and rename
      ata: pata_parport-bpck6: move ppc6_wr_data_byte to bpck6.c and rename
      ata: pata_parport-bpck6: move defines and mode_map to bpck6.c
      ata: pata_parport-bpck6: delete ppc6lnx.c
      ata: pata_parport-bpck6: reduce indents in bpck6_open

Rob Herring (1):
      ata: Use of_property_present() for testing DT property presence

Sergey Shtylyov (2):
      ata: drop unused ata_id_to_hd_driveid()
      ata: drop unused ata_id_is_lba_capacity_ok()

 .../devicetree/bindings/ata/ahci-platform.yaml     |  49 +-
 drivers/ata/Kconfig                                |   1 +
 drivers/ata/ahci_mtk.c                             |   2 +-
 drivers/ata/libahci_platform.c                     |   2 +-
 drivers/ata/pata_parport/Kconfig                   |   2 +-
 drivers/ata/pata_parport/aten.c                    |  45 +-
 drivers/ata/pata_parport/bpck.c                    |  86 +--
 drivers/ata/pata_parport/bpck6.c                   | 541 ++++++++++-----
 drivers/ata/pata_parport/comm.c                    |  52 +-
 drivers/ata/pata_parport/dstr.c                    |  45 +-
 drivers/ata/pata_parport/epat.c                    |  48 +-
 drivers/ata/pata_parport/epia.c                    |  55 +-
 drivers/ata/pata_parport/fit2.c                    |  37 +-
 drivers/ata/pata_parport/fit3.c                    |  39 +-
 drivers/ata/pata_parport/friq.c                    |  56 +-
 drivers/ata/pata_parport/frpw.c                    |  71 +-
 drivers/ata/pata_parport/kbic.c                    |  66 +-
 drivers/ata/pata_parport/ktti.c                    |  38 +-
 drivers/ata/pata_parport/on20.c                    |  45 +-
 drivers/ata/pata_parport/on26.c                    |  52 +-
 drivers/ata/pata_parport/pata_parport.c            |  31 +-
 .../ata/pata_parport}/pata_parport.h               |  41 +-
 drivers/ata/pata_parport/ppc6lnx.c                 | 726 ---------------------
 drivers/ata/sata_dwc_460ex.c                       |   4 +-
 drivers/parport/parport_pc.c                       |  20 +-
 include/linux/ata.h                                |  71 --
 include/uapi/linux/parport.h                       |   3 +
 27 files changed, 683 insertions(+), 1545 deletions(-)
 rename {include/linux => drivers/ata/pata_parport}/pata_parport.h (75%)
 delete mode 100644 drivers/ata/pata_parport/ppc6lnx.c
