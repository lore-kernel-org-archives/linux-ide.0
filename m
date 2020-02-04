Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCBC35251
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D837F20674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBDQ4H (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgBDQ4H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86411AF79;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 00/46] ata: kill ATA_DEBUG
Date:   Tue,  4 Feb 2020 17:55:01 +0100
Message-Id: <20200204165547.115220-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi all,

this is a rewrite of an earlier patchset titled
'ata: move DPRINTK to dynamic debugging'.
The overall idea is that it's really tiresome to having
to recompile the kernel every time one wants or needs
to debug ata issues, especially as the kernel already provides
mechanism for dynamic debugging messages.

At the same time dynamic debugging does increase the load on
the logging subsystem, and things like printk() are poorly
suited for high-speed logging.

So this patchset does several things:
- cleans up the logging messages by removing duplicate
  or pointless messages
- Converts I/O and error handling related messages to
  tracepoints
- Moves all remaining messages over to dynamic debugging

With that ATA_DEBUG can be killed.

Note, I'll be preparing an additional patchset for killing
off ATA_VERBOSE_DEBUG, too, but wanted to get this one out
first before it becomes too large.

As usual, comments and reviews are welcome.

Hannes Reinecke (46):
  libata: drop BPRINTK()
  libata.h: whitespace and indentation fixes
  libata-transport: Whitespace cleanup
  libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
  libata: remove pointless debugging messages
  ata_piix: remove debugging message in piix_init()
  libata-core: remove pointless debugging messages
  libata: Add ata_port_classify() helper
  libata: move ata_dump_id() to dynamic debugging
  sata_mv: replace DPRINTK with 'pci_dump' module parameter
  sata_nv: move DPRINTK to ata debugging
  sata_sx4: move DPRINTK to VPRINTK
  ata_piix: Drop DPRINTK() statement
  libata: add reset tracepoints
  ahci: drop DPRINTK() calls in reset
  ahci_qorig: drop DPRINTK() calls in reset
  pata_octeon_cf: drop DPRINTK() calls in reset
  libahci: drop DPRINTK() calls in reset
  sata_rcar: drop DPRINTK() calls in reset
  sata_sil24: drop DPRINTK() calls in reset
  sata_fsl: drop DPRINTK() calls in reset
  libata-core: drop DPRINTK() calls in reset
  libata-sff: drop DPRINTK() calls in reset
  libata: tracepoints for bus-master DMA
  libata-sff: add tracepoints for HSM state machine
  pata_octeon_cf: add bmdma tracepoints and drop DPRINTK()
  sata_rcar: drop DPRINTK call in sata_rcar_exec_command()
  libata-scsi: drop DPRINTK calls for cdb translation
  libata-sff: add tracepoints for ata_sff_flush_pio_task()
  libata-core: add postreset tracepoints
  pata_octeon_cf: move DPRINTK to VPRINTK
  pata_pdc202xx_old: Drop DPRINTK in pdc202xx_exec_command()
  pata_sil680: Drop DPRINTK in sil_sff_exec_command()
  pdc_adma: move DPRINTK to VPRINTK
  sata_rcar: move DPRINTK to VPRINTK
  sata_qstor: move DPRINTK to VPRINTK
  pata_pdc2027x: Replace PDPRINTK() with standard ata logging
  sata_fsl: move DPRINTK to ata debugging
  libata: add tracepoints for ATA error handling
  libata-eh: remove DPRINTK() calls for request sense
  libata-core: move DPRINTK to ata debugging
  libata: remove DPRINTK() macro
  libata: kill ATA_MSG_INFO
  libata: kill ATA_MSG_CTL
  libata: remove references to ATA_DEBUG
  libata: remove ATA_NDEBUG

 drivers/ata/acard-ahci.c        |   4 -
 drivers/ata/ahci.c              |  12 +-
 drivers/ata/ahci_qoriq.c        |   4 -
 drivers/ata/ata_piix.c          |   3 -
 drivers/ata/libahci.c           |  15 +-
 drivers/ata/libata-acpi.c       |  48 +++---
 drivers/ata/libata-core.c       | 216 ++++++++---------------
 drivers/ata/libata-eh.c         |  47 ++---
 drivers/ata/libata-pmp.c        |   8 -
 drivers/ata/libata-scsi.c       |  20 +--
 drivers/ata/libata-sff.c        |  76 ++++----
 drivers/ata/libata-trace.c      |  29 ++++
 drivers/ata/libata-transport.c  |  18 +-
 drivers/ata/pata_octeon_cf.c    |  16 +-
 drivers/ata/pata_pdc2027x.c     |  81 ++++-----
 drivers/ata/pata_pdc202xx_old.c |   2 -
 drivers/ata/pata_sil680.c       |   1 -
 drivers/ata/pdc_adma.c          |   2 +-
 drivers/ata/sata_fsl.c          |  96 +++++------
 drivers/ata/sata_inic162x.c     |   2 +-
 drivers/ata/sata_mv.c           |  71 ++++----
 drivers/ata/sata_nv.c           |  28 ++-
 drivers/ata/sata_qstor.c        |   2 +-
 drivers/ata/sata_rcar.c         |   8 +-
 drivers/ata/sata_sil24.c        |   5 +-
 drivers/ata/sata_sx4.c          |   2 +-
 include/linux/libata.h          | 106 +++++-------
 include/trace/events/libata.h   | 373 ++++++++++++++++++++++++++++++++++++++++
 28 files changed, 761 insertions(+), 534 deletions(-)

-- 
2.16.4

