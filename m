Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439CE71D35
	for <linux-ide@archiver.kernel.org>; Fri, 29 Sep 2023 13:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjI2Nda (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2Nd3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 29 Sep 2023 09:33:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA9D1A8
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2023 06:33:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE88C433C8;
        Fri, 29 Sep 2023 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695994406;
        bh=cC8mzHbpxY4PLk7i2WSmnNQYu4Ui6S6CCP+tcqZn+nw=;
        h=From:To:Subject:Date:From;
        b=ZEjQsWWpeyFu+N2IYCHUnHucNWerLg2ISv6Sv6WWkovuJN5IYi2wxC0IvIl3dFNHW
         ta5zfAL2pe1v3EOP5ehabe5Kzvki97P18ZsWLiZPUqjXr8KxsCaHkKu8YBW4qQLzdV
         emWaW64o6XYfGsFejUBIFIDPPT7b3rbds0i7zCpGmiG6uGmxr3NUNaufoHM4ldljzS
         tZwpnUNTCWS9aYVBQ2ZR0/BxXvS7GP7Th4ZAwuWYQ02CRW9JVvIz4AquHvxSSL5tql
         oSKQkbIMZQ9x/8XroDAuEPLSdM4MQ0Lz0hYbLwFeh3DLjFWIlSt8Wva6a7XRli30fb
         Pn5YHSTVnKMng==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.6-rc4
Date:   Fri, 29 Sep 2023 22:33:24 +0900
Message-ID: <20230929133324.164211-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc4

for you to fetch changes up to 49728bdc702391902a473b9393f1620eea32acb0:

  ata: libata-eh: Fix compilation warning in ata_eh_link_report() (2023-09-28 21:24:18 +0900)

----------------------------------------------------------------
ATA fixes for 6.6-rc4

A larger than usual set of fixes for 6.6-rc4 due to the unexpected
number of fixes needed to address ATA disks suspend/resume issues.
In more details:

 - Add missing additionalProperties on child nodes to the pata-common DT
   bindings (Rob).

 - Fix handling of the REPORT SUPPORTED OPERATION CODES command to
   ignore reserved bits (Niklas).

 - Increase port multiplier soft reset timeout to accomodate slow
   devices and avoid issues on wakeup (Matthias).

 - A couple of minor code fixes to avoid compilation warnings in
   libata-core and libata-eh (me).

 - Many patches from me to address suspend/resume issues, and in
   particular a potential deadlock on resume due to the SCSI disk driver
   resume operation not being synchronized with libata EH port resume
   handling.  This is addressed by changing the scsi disk driver disk
   start/stop control to allow libata to execute disk suspend (spin
   down) and resume (spin up) on its own during system suspend/resume.
   Runtime suspend/resume control remains with the SCSI disk driver.
   Other fixes include:
    - Fix libata power management request issuing to avoid races.
    - Establish a link between ATA ports and SCSI devices to order PM
      operations.
    - Fix device removal to avoid issues with driver rmmod removal.
    - Fix synchronization of libata device rescan and SCSI disk resume
      operation.
    - Remove libsas PM operations as suspend/resume is handled directly
      by the sas controller resume.
    - Fix the SCSI disk driver to not issue commands to suspended disks,
      thus avoiding potential system lock-up on resume.

----------------------------------------------------------------
Damien Le Moal (11):
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-scsi: link ata port and scsi device
      scsi: sd: Differentiate system and runtime start/stop management
      ata: libata-scsi: Disable scsi device manage_system_start_stop
      scsi: Do not attempt to rescan suspended devices
      ata: libata-scsi: Fix delayed scsi_rescan_device() execution
      ata: libata-core: Do not register PM operations for SAS ports
      scsi: sd: Do not issue commands to suspended disks on shutdown
      ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Niklas Cassel (1):
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Rob Herring (1):
      dt-bindings: ata: pata-common: Add missing additionalProperties on child nodes

 .../devicetree/bindings/ata/pata-common.yaml       |   1 +
 drivers/ata/libata-core.c                          | 149 +++++++++++++++++++--
 drivers/ata/libata-eh.c                            |  48 ++++++-
 drivers/ata/libata-scsi.c                          |  97 +++++++++-----
 drivers/ata/libata-transport.c                     |   9 +-
 drivers/ata/libata.h                               |   4 +
 drivers/firewire/sbp2.c                            |   9 +-
 drivers/scsi/scsi_scan.c                           |  18 ++-
 drivers/scsi/sd.c                                  | 101 +++++++++++---
 drivers/scsi/sd.h                                  |   1 +
 include/linux/libata.h                             |  10 +-
 include/scsi/scsi_device.h                         |   5 +-
 include/scsi/scsi_host.h                           |   2 +-
 13 files changed, 378 insertions(+), 76 deletions(-)
