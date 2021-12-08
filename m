Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BB1C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhLHQgd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLHQgc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1278E1FD3E;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P6Prnv20miX/4xDb+oS9UDt51yzbfN2ii1KsSGaD35M=;
        b=PIxPjCLsKVKGQEynOo3gV+YQhKNchPzclOdxMc+sKFYfevgnAWqPv7oMbTqoRBBpYGGU7z
        0gQXAfCTEWDk2q3vCHZDjafyAR2DP5oyImBT7MFhvL9dCs0IndK8ZUSobn8YkF4sWNPiOL
        Ohhwvfg7EcKwzkD4RT0mXpoPZrp3FA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P6Prnv20miX/4xDb+oS9UDt51yzbfN2ii1KsSGaD35M=;
        b=W1KpAa2qGgTRlNVQweih7upG72PzcnbUv5nHFQexG5omeIpE43NQhDGw2q3Khsnp8A6bvw
        z5PdkPuwnhYMjCCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D8994A3B93;
        Wed,  8 Dec 2021 16:32:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id CC99D5191F5D; Wed,  8 Dec 2021 17:32:59 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 00/73] libata: rework logging, take II
Date:   Wed,  8 Dec 2021 17:31:42 +0100
Message-Id: <20211208163255.114660-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

after some prodding from individual persons I've resurrected my
patchset to put libata logging on a even keel, and use structured
logging for everything.
So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX() calls,
and moves everything over to structured logging (ie the dev_XXX()
calls).
Additionally I've added more tracepoints to trace command flow
and EH, HSM, and other related things.

So everything is looking far saner now.

As usual, comments and reviews are welcome.

I know that the device names suck. Blame Tejun.

Hannes Reinecke (73):
  libata: remove pointless debugging messages
  libata: Add ata_port_classify() helper
  libata: move ata_dump_id() to dynamic debugging
  libata: sanitize ATA_HORKAGE_DUMP_ID
  sata_mv: replace DPRINTK with 'pci_dump' module parameter
  sata_mv: kill 'port' argument in mv_dump_all_regs()
  libata: add reset tracepoints
  libata: drop DPRINTK() calls in reset
  libata: tracepoints for bus-master DMA
  libata: drop debugging statements for bus-master DMA
  pata_octeon_cf: add bmdma tracepoints and drop DPRINTK() calls
  pata_arasan_cf: use generic tracepoints
  sata_dwc_460ex: use generic tracepoints
  sata_nv: use generic tracepoints
  libata-sff: tracepoints for HSM state machine
  libata-sff: add tracepoints for ata_sff_flush_pio_task()
  libata-scsi: drop DPRINTK calls for cdb translation
  libata: add tracepoints for ATA error handling
  libata: drop DPRINTK() calls during ATA error handling
  libata-eh: remove DPRINTK() calls for request sense
  libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
  libata: add qc_prep tracepoint
  libata: move DPRINTK to ata debugging
  pata_octeon_cf: remove DPRINTK() macro in interrupt context
  pdc_adma: Remove DPRINTK call
  sata_fsl: move DPRINTK to ata debugging
  sata_rcar: replace DPRINTK() with ata_port_dbg()
  sata_qstor: replace DPRINTK() with ata_port_dbg()
  pata_pdc2027x: Replace PDPRINTK() with standard ata logging
  libata: remove pointless VPRINTK() calls
  ahci: Drop pointless VPRINTK() calls and convert the remaining ones
  pdc_adma: Drop pointless VPRINTK() calls and convert the remaining
    ones
  pata_octeon_cf: Drop pointless VPRINTK() calls and convert the
    remaining ones
  pata_via: Drop pointless VPRINTK() calls
  sata_promise: Drop pointless VPRINTK() calls and convert the remaining
    ones
  sata_qstor: Drop pointless VPRINTK() calls
  sata_rcar: Drop pointless VPRINTK() calls
  sata_inic162x: Drop pointless VPRINTK() calls
  sata_mv: Drop pointless VPRINTK() call and convert the remaining one
  sata_nv: drop pointless VPRINTK() calls and convert remaining ones
  sata_fsl: convert VPRINTK() calls to ata_port_dbg()
  sata_sil: Drop pointless VPRINTK() calls
  sata_sx4: Drop pointless VPRINTK() calls and convert the remaining
    ones
  sata_sx4: add module parameter 'dimm_test'
  libata: drop ata_msg_error() and ata_msg_intr()
  libata: drop ata_msg_ctl()
  libata: drop ata_msg_malloc()
  libata: drop ata_msg_warn()
  libata: drop ata_msg_probe()
  libata: drop ata_msg_info()
  libata: drop ata_msg_drv()
  libata: remove 'new' ata message handling
  libata: remove debug compilation switches
  pata_atp867x: convert blank printk() calls
  pata_cmd640: convert blank printk() calls
  pata_cmd64x: convert blank printk() calls
  pata_cs5520: convert blank printk() calls
  pata_cs5536: convert blank printk() calls
  pata_cypressx: convert blank printk() calls
  pata_it821x: convert blank printk() calls
  pata_marvell: convert blank printk() calls
  pata_rz1000: convert blank printk() calls
  pata_serverworks: convert blank printk() calls
  pata_sil680: convert blank printk() calls
  pdc_adma: remove disabled debugging messages
  sata_sx4: convert blank printk() calls
  sata_mv: convert remaining printk() to structured logging
  pata_hpt37x: convert pr_XXX() calls
  pata_octeon_cf: Replace pr_XXX() calls with structured logging
  pata_hpt3x2n: convert pr_XXX() calls
  pata_hpt3x2n: convert pr_err() calls
  pata_hpt366: convert pr_warn() calls
  libata-scsi: rework ata_dump_status to avoid using pr_cont()

 drivers/ata/acard-ahci.c        |   4 -
 drivers/ata/ahci.c              |  13 +-
 drivers/ata/ahci_qoriq.c        |   4 -
 drivers/ata/ahci_xgene.c        |   4 -
 drivers/ata/ata_piix.c          |   3 -
 drivers/ata/libahci.c           |  33 +--
 drivers/ata/libata-acpi.c       |  71 +++---
 drivers/ata/libata-core.c       | 270 ++++++++--------------
 drivers/ata/libata-eh.c         |  50 +++--
 drivers/ata/libata-pmp.c        |   8 -
 drivers/ata/libata-sata.c       |   5 -
 drivers/ata/libata-scsi.c       | 111 ++-------
 drivers/ata/libata-sff.c        |  86 +++----
 drivers/ata/libata-trace.c      |  29 +++
 drivers/ata/libata.h            |   1 -
 drivers/ata/pata_arasan_cf.c    |   3 +
 drivers/ata/pata_atp867x.c      |  29 +--
 drivers/ata/pata_cmd640.c       |   2 +-
 drivers/ata/pata_cmd64x.c       |   4 +-
 drivers/ata/pata_cs5520.c       |   4 +-
 drivers/ata/pata_cs5536.c       |   4 +-
 drivers/ata/pata_cypress.c      |   2 +-
 drivers/ata/pata_hpt366.c       |   4 +-
 drivers/ata/pata_hpt37x.c       |  19 +-
 drivers/ata/pata_hpt3x2n.c      |  11 +-
 drivers/ata/pata_it821x.c       |  43 ++--
 drivers/ata/pata_ixp4xx_cf.c    |   6 +-
 drivers/ata/pata_marvell.c      |   9 +-
 drivers/ata/pata_octeon_cf.c    |  48 +---
 drivers/ata/pata_pdc2027x.c     |  71 +++---
 drivers/ata/pata_pdc202xx_old.c |   2 -
 drivers/ata/pata_rz1000.c       |   4 +-
 drivers/ata/pata_serverworks.c  |   4 +-
 drivers/ata/pata_sil680.c       |   9 +-
 drivers/ata/pata_via.c          |  12 -
 drivers/ata/pdc_adma.c          |  33 +--
 drivers/ata/sata_dwc_460ex.c    |  71 +-----
 drivers/ata/sata_fsl.c          | 165 ++++++--------
 drivers/ata/sata_gemini.c       |   4 +-
 drivers/ata/sata_inic162x.c     |   4 +-
 drivers/ata/sata_mv.c           | 147 ++++++------
 drivers/ata/sata_nv.c           |  53 ++---
 drivers/ata/sata_promise.c      |  31 +--
 drivers/ata/sata_qstor.c        |  15 +-
 drivers/ata/sata_rcar.c         |  25 +--
 drivers/ata/sata_sil.c          |   1 -
 drivers/ata/sata_sil24.c        |   5 +-
 drivers/ata/sata_sx4.c          | 148 +++++-------
 include/linux/libata.h          |  99 ++------
 include/trace/events/libata.h   | 387 +++++++++++++++++++++++++++++++-
 50 files changed, 992 insertions(+), 1178 deletions(-)

-- 
2.29.2

