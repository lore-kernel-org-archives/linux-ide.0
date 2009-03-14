From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 00/73] libata: use ata.h mode mask defines everywhere
Date: Sat, 14 Mar 2009 19:35:13 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60141 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756557AbZCNTXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:23:23 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiYhV-000Eos-9y
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 19:35:13 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch series converts all drivers/ata/ drivers to use ATA_PIOx /=20
ATA_MWDMAx / ATA_UDMAx defines for transfer masks, uncovering a few=20
possible bugs in the process. Nothing important.

This series makes no functional changes, only converts hex codes to the=
ir=20
corresponding defines. Fixes and questions afterwards.

shortlog below:

Erik Inge Bols=C3=B8 (73):
  pata_acpi: use ata.h mode mask defines
  [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
  pata_octeon_cf: use ata.h mode mask defines
  ahci: use ata.h mode mask defines
  ata_generic: use ata.h mode mask defines
  ata_piix: use ata.h mode mask defines
  pata_ali: use ata.h mode mask defines
  pata_amd: use ata.h mode mask defines
  pata_artop: use ata.h mode mask defines
  pata_at32: use ata.h mode mask defines
  pata_atiixp: use ata.h mode mask defines
  pata_bf54x: use ata.h mode mask defines
  pata_cmd640: use ata.h mode mask defines
  pata_cmd64x: use ata.h mode mask defines
  pata_cs5520: use ata.h mode mask defines
  pata_cs5530: use ata.h mode mask defines
  pata_cs5535: use ata.h mode mask defines
  pata_cs5536: use ata.h mode mask defines
  pata_cypress: use ata.h mode mask defines
  pata_efar: use ata.h mode mask defines
  pata_hpt366: use ata.h mode mask defines
  pata_hpt37x: use ata.h mode mask defines
  pata_hpt3x2n: use ata.h mode mask defines
  pata_hpt3x3: use ata.h mode mask defines
  pata_icside: use ata.h mode mask defines
  pata_isapnp: use ata.h mode mask defines
  pata_it8213: use ata.h mode mask defines
  pata_it821x: use ata.h mode mask defines
  pata_ixp4xx_cf: use ata.h mode mask defines
  pata_jmicron: use ata.h mode mask defines
  pata_legacy: use ata.h mode mask defines
  pata_marvell: use ata.h mode mask defines
  pata_mpc52xx: use ata.h mode mask defines
  pata_mpiix: use ata.h mode mask defines
  pata_netcell: use ata.h mode mask defines
  pata_ninja32: use ata.h mode mask defines
  pata_ns87410: use ata.h mode mask defines
  pata_ns87415: use ata.h mode mask defines
  pata_oldpiix: use ata.h mode mask defines
  pata_opti: use ata.h mode mask defines
  pata_optidma: use ata.h mode mask defines
  pata_pcmcia: use ata.h mode mask defines
  pata_pdc2027x: use ata.h mode mask defines
  pata_pdc202xx_old: use ata.h mode mask defines
  pata_qdi: use ata.h mode mask defines
  pata_radisys: use ata.h mode mask defines, add ATA_UDMA24_ONLY
  pata_rb532_cf: use ata.h mode mask defines
  pata_rz1000: use ata.h mode mask defines
  pata_sc1200: use ata.h mode mask defines
  pata_scc: use ata.h mode mask defines
  pata_sch: remove superfluous mode mask comments
  pata_serverworks: use ata.h mode mask defines
  pata_sil680: use ata.h mode mask defines
  pata_sis: use ata.h mode mask defines
  pata_sl82c105: use ata.h mode mask defines
  pata_triflex: use ata.h mode mask defines
  pata_via: use ata.h mode mask defines
  pata_winbond: use ata.h mode mask defines
  pdc_adma: use ata.h mode mask defines, add ATA_PIO4_ONLY
  sata_fsl: use ata.h mode mask defines
  sata_inic162x: use ata.h mode mask defines
  sata_mv: use ata.h mode mask defines
  sata_nv: use ata.h mode mask defines
  sata_promise: use ata.h mode mask defines
  sata_qstor: use ata.h mode mask defines
  sata_sil24: use ata.h mode mask defines
  sata_sil: use ata.h mode mask defines
  sata_sis: use ata.h mode mask defines
  sata_svw: use ata.h mode mask defines
  sata_sx4: use ata.h mode mask defines
  sata_uli: use ata.h mode mask defines
  sata_via: use ata.h mode mask defines
  sata_vsc: use ata.h mode mask defines

 drivers/ata/ahci.c              |   16 ++++----
 drivers/ata/ata_generic.c       |    4 +-
 drivers/ata/ata_piix.c          |   60 ++++++++++++++++---------------=
-
 drivers/ata/pata_acpi.c         |    6 ++--
 drivers/ata/pata_ali.c          |   28 ++++++++--------
 drivers/ata/pata_amd.c          |   70 +++++++++++++++++++------------=
-------
 drivers/ata/pata_artop.c        |   16 ++++----
 drivers/ata/pata_at32.c         |   16 +++++----
 drivers/ata/pata_atiixp.c       |    6 ++--
 drivers/ata/pata_bf54x.c        |    2 +-
 drivers/ata/pata_cmd640.c       |    2 +-
 drivers/ata/pata_cmd64x.c       |   24 +++++++-------
 drivers/ata/pata_cs5520.c       |    2 +-
 drivers/ata/pata_cs5530.c       |    8 ++--
 drivers/ata/pata_cs5535.c       |    4 +-
 drivers/ata/pata_cs5536.c       |    4 +-
 drivers/ata/pata_cypress.c      |    4 +-
 drivers/ata/pata_efar.c         |    6 ++--
 drivers/ata/pata_hpt366.c       |    4 +-
 drivers/ata/pata_hpt37x.c       |   28 ++++++++--------
 drivers/ata/pata_hpt3x2n.c      |    4 +-
 drivers/ata/pata_hpt3x3.c       |    6 ++--
 drivers/ata/pata_icside.c       |    4 +-
 drivers/ata/pata_isapnp.c       |    2 +-
 drivers/ata/pata_it8213.c       |    4 +-
 drivers/ata/pata_it821x.c       |   16 ++++----
 drivers/ata/pata_ixp4xx_cf.c    |    2 +-
 drivers/ata/pata_jmicron.c      |    4 +-
 drivers/ata/pata_legacy.c       |    2 +-
 drivers/ata/pata_marvell.c      |    8 ++--
 drivers/ata/pata_mpc52xx.c      |    4 +-
 drivers/ata/pata_mpiix.c        |    2 +-
 drivers/ata/pata_netcell.c      |    4 +-
 drivers/ata/pata_ninja32.c      |    2 +-
 drivers/ata/pata_ns87410.c      |    2 +-
 drivers/ata/pata_ns87415.c      |    8 ++--
 drivers/ata/pata_octeon_cf.c    |    4 +-
 drivers/ata/pata_oldpiix.c      |    4 +-
 drivers/ata/pata_opti.c         |    2 +-
 drivers/ata/pata_optidma.c      |   10 +++---
 drivers/ata/pata_pcmcia.c       |    2 +-
 drivers/ata/pata_pdc2027x.c     |   12 +++---
 drivers/ata/pata_pdc202xx_old.c |   12 +++---
 drivers/ata/pata_qdi.c          |    4 +-
 drivers/ata/pata_radisys.c      |    6 ++--
 drivers/ata/pata_rb532_cf.c     |    2 +-
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |    6 ++--
 drivers/ata/pata_scc.c          |    4 +-
 drivers/ata/pata_sch.c          |    6 ++--
 drivers/ata/pata_serverworks.c  |   20 +++++-----
 drivers/ata/pata_sil680.c       |    8 ++--
 drivers/ata/pata_sis.c          |   32 ++++++++++-------
 drivers/ata/pata_sl82c105.c     |    6 ++--
 drivers/ata/pata_triflex.c      |    4 +-
 drivers/ata/pata_via.c          |   24 +++++++-------
 drivers/ata/pata_winbond.c      |    2 +-
 drivers/ata/pdc_adma.c          |    2 +-
 drivers/ata/sata_fsl.c          |    4 +-
 drivers/ata/sata_inic162x.c     |    4 +-
 drivers/ata/sata_mv.c           |   16 ++++----
 drivers/ata/sata_nv.c           |    6 ++--
 drivers/ata/sata_promise.c      |   28 ++++++++--------
 drivers/ata/sata_qstor.c        |    2 +-
 drivers/ata/sata_sil.c          |   16 ++++----
 drivers/ata/sata_sil24.c        |   18 +++++-----
 drivers/ata/sata_sis.c          |    4 +-
 drivers/ata/sata_svw.c          |   16 ++++----
 drivers/ata/sata_sx4.c          |    4 +-
 drivers/ata/sata_uli.c          |    2 +-
 drivers/ata/sata_via.c          |   16 ++++----
 drivers/ata/sata_vsc.c          |    4 +-
 include/linux/ata.h             |    6 +++
 73 files changed, 359 insertions(+), 345 deletions(-)
