From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream] libata: separate out SFF and BMDMA, take#2
Date: Mon, 10 May 2010 21:41:24 +0200
Message-ID: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44949 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab0EJTmZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com

Hello, Jeff, Sergei.

This is the second take of separate-out-SFF-and-BMDMA patchset.  The
initial take[L] was posted back in 2008.  It got mostly acked but
somehow forgotten in the middle of patch logistics by Jeff and me
both.  Thankfully, Sergei somehow digged this up. :-)

Other than refreshing on top of the current #upstream including
reflecting the changes in core code and addition of new drivers, the
bulk of patchset is about the same.

The patchset separates out SFF and BMDMA code and categorizes low
level drivers as such.  This has marginal benefit of having the
ability not to include unneded core code but the main point is
clearing the muddy line between SFF and BMDMA so that drivers don't
end up needing dummy functions or explicit boilerplate overrides not
knowing what's gonna be called.  It also makes verifying which driver
depends on which core functions much easier during both code review
(simply searching for sff in bmdma driver and dma in !bmdma driver
gives pretty good picture) and compile.

Please read patchset description of the initial take for more details.

Build tested on x86.  Tested on ahci and ata_piix.  Couldn't test more
as I'm away from my test equipments. :-( I think breakages from this
patchset wouldn't be too hard to catch but it definitely needs some
testing time in linux-next or whereever before hitting mainline.

This patchset is on top of the current #upstream
(3d02d7242c513f945009f74e8d59d45d861195e4) and contains the following
23 patches.

 0001-pata_sch-use-ata_pci_sff_init_one.patch
 0002-sata_inic162x-inic162x-is-not-dependent-on-CONFIG_AT.patch
 0003-sata_mv-remove-unnecessary-initialization.patch
 0004-libata-sff-update-bmdma-host-bus-error-handling.patch
 0005-libata-sff-kill-unused-prototype-and-make-ata_dev_se.patch
 0006-libata-kill-ATA_FLAG_DISABLED.patch
 0007-sata_inic162x-kill-PORT_PRD_ADDR-initialization.patch
 0008-libata-sff-reorder-SFF-BMDMA-functions.patch
 0009-libata-sff-clean-up-inheritance-in-several-drivers.patch
 0010-libata-sff-clean-up-BMDMA-initialization.patch
 0011-libata-sff-introduce-ata_sff_init-exit-and-ata_sff_p.patch
 0012-libata-sff-rename-ap-ops-drain_fifo-to-sff_drain_fif.patch
 0013-libata-sff-ap-last_-ctl-are-SFF-specific.patch
 0014-libata-sff-port_task-is-SFF-specific.patch
 0015-libata-sff-separate-out-BMDMA-EH.patch
 0016-libata-sff-ata_sff_-dumb_-qc_prep-are-BMDMA-specific.patch
 0017-libata-sff-prd-is-BMDMA-specific.patch
 0018-libata-sff-separate-out-BMDMA-qc_issue.patch
 0019-libata-sff-ata_sff_irq_clear-is-BMDMA-specific.patch
 0020-libata-sff-separate-out-BMDMA-irq-handler.patch
 0021-libata-sff-separate-out-BMDMA-init.patch
 0022-libata-sff-kill-dummy-BMDMA-ops-from-sata_qstor-and-.patch
 0023-libata-sff-make-BMDMA-optional.patch

It's also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git modularize-SFF

and contains the following changes.

 drivers/ata/Kconfig                 |  521 +++++------
 drivers/ata/Makefile                |   83 +
 drivers/ata/ata_generic.c           |    2 
 drivers/ata/ata_piix.c              |    4 
 drivers/ata/libata-core.c           |  179 ---
 drivers/ata/libata-eh.c             |    6 
 drivers/ata/libata-scsi.c           |    3 
 drivers/ata/libata-sff.c            | 1640 +++++++++++++++++++++---------------
 drivers/ata/libata.h                |   29 
 drivers/ata/pata_acpi.c             |   10 
 drivers/ata/pata_ali.c              |    7 
 drivers/ata/pata_amd.c              |    2 
 drivers/ata/pata_artop.c            |    2 
 drivers/ata/pata_at91.c             |    1 
 drivers/ata/pata_atiixp.c           |    6 
 drivers/ata/pata_atp867x.c          |    2 
 drivers/ata/pata_bf54x.c            |   20 
 drivers/ata/pata_cmd640.c           |   10 
 drivers/ata/pata_cmd64x.c           |    2 
 drivers/ata/pata_cs5520.c           |    4 
 drivers/ata/pata_cs5530.c           |    6 
 drivers/ata/pata_cs5535.c           |    2 
 drivers/ata/pata_cs5536.c           |    2 
 drivers/ata/pata_cypress.c          |    2 
 drivers/ata/pata_efar.c             |    4 
 drivers/ata/pata_hpt366.c           |    4 
 drivers/ata/pata_hpt37x.c           |    6 
 drivers/ata/pata_hpt3x2n.c          |    4 
 drivers/ata/pata_hpt3x3.c           |    2 
 drivers/ata/pata_icside.c           |    7 
 drivers/ata/pata_it8213.c           |    2 
 drivers/ata/pata_it821x.c           |    8 
 drivers/ata/pata_jmicron.c          |    2 
 drivers/ata/pata_macio.c            |    7 
 drivers/ata/pata_marvell.c          |    2 
 drivers/ata/pata_mpc52xx.c          |    2 
 drivers/ata/pata_netcell.c          |    2 
 drivers/ata/pata_ninja32.c          |    2 
 drivers/ata/pata_ns87415.c          |    4 
 drivers/ata/pata_octeon_cf.c        |   27 
 drivers/ata/pata_oldpiix.c          |    4 
 drivers/ata/pata_optidma.c          |    2 
 drivers/ata/pata_pcmcia.c           |    2 
 drivers/ata/pata_pdc2027x.c         |    6 
 drivers/ata/pata_pdc202xx_old.c     |    4 
 drivers/ata/pata_piccolo.c          |    2 
 drivers/ata/pata_platform.c         |    1 
 drivers/ata/pata_radisys.c          |    4 
 drivers/ata/pata_rdc.c              |    4 
 drivers/ata/pata_sc1200.c           |    6 
 drivers/ata/pata_scc.c              |   15 
 drivers/ata/pata_sch.c              |   12 
 drivers/ata/pata_serverworks.c      |    8 
 drivers/ata/pata_sil680.c           |    4 
 drivers/ata/pata_sis.c              |    2 
 drivers/ata/pata_sl82c105.c         |    2 
 drivers/ata/pata_triflex.c          |    2 
 drivers/ata/pata_via.c              |    6 
 drivers/ata/pdc_adma.c              |   74 -
 drivers/ata/sata_inic162x.c         |   25 
 drivers/ata/sata_mv.c               |   51 -
 drivers/ata/sata_nv.c               |  266 ++---
 drivers/ata/sata_promise.c          |   32 
 drivers/ata/sata_qstor.c            |  104 --
 drivers/ata/sata_sil.c              |   13 
 drivers/ata/sata_sil24.c            |    9 
 drivers/ata/sata_sis.c              |    4 
 drivers/ata/sata_svw.c              |    4 
 drivers/ata/sata_sx4.c              |   10 
 drivers/ata/sata_uli.c              |    6 
 drivers/ata/sata_via.c              |    8 
 drivers/ata/sata_vsc.c              |   12 
 drivers/scsi/ipr.c                  |    6 
 drivers/scsi/libsas/sas_scsi_host.c |    2 
 include/linux/ata.h                 |    2 
 include/linux/libata.h              |   99 +-
 76 files changed, 1743 insertions(+), 1700 deletions(-)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.scsi/45344
