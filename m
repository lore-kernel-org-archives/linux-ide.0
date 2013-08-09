From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v3 0/3] Introduce new SATA queued commands
Date: Thu,  8 Aug 2013 21:49:09 -0700
Message-ID: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44617 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234Ab3HIEvA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 00:51:00 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so6498030oag.10
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 21:50:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

This patch series updates the libata driver with some additional
commands which are specified in the more recent versions of the
SATA and ATA specifications. These commands are:

        SEND FPDMA QUEUED
        RECEIVE FPDMA QUEUED.

The new queued commands augment the existing READ and WRITE FPDMA
QUEUED commands. The commands are intended to transport non-media
data to/from a device in a non-blocking manner.

One application of these commands include a queued-style DSM TRIM
operation. The current DSM TRIM command is non-queued, and requires
the initiator to empty out the queue before issuance. The new DSM TRIM
allows the initiator to keep the queue full.

These patches have been validated on an Intel SATA AHCI controller,
on a Micron M500 SSD, using "postmark," "fstrim," and "fsck."

Version history:

v3:
- rebased to libata/for-3.12
- put H2D FIS "auxiliary" field changes in separate patch
- added "auxiliary" field population to all FIS-based SATA drivers

v2:
- rebased to 3.11-rc4
- moved auxiliary field to ata_queued_cmd struct
- updated signoff name

v1:
- initial

Marc Carino (3):
  libata: Populate host-to-device FIS "auxiliary" field
  libata: Add support for SEND/RECEIVE FPDMA QUEUED
  libata: Add support for queued DSM TRIM

 drivers/ata/acard-ahci.c  |  2 +-
 drivers/ata/libahci.c     |  2 +-
 drivers/ata/libata-core.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c | 27 +++++++++++++++++++++------
 drivers/ata/sata_fsl.c    |  2 +-
 drivers/ata/sata_mv.c     |  2 +-
 drivers/ata/sata_qstor.c  |  2 +-
 drivers/ata/sata_sil24.c  |  2 +-
 include/linux/ata.h       | 23 +++++++++++++++++++++++
 include/linux/libata.h    |  8 ++++++++
 10 files changed, 102 insertions(+), 12 deletions(-)

-- 
1.8.1.2

