From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v2 0/2] Introduce new SATA queued commands
Date: Thu,  8 Aug 2013 00:16:20 -0700
Message-ID: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38336 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933704Ab3HHHQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 03:16:49 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so4713549oag.25
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 00:16:49 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
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
allows the host to keep the queue full.

These patches have been validated on an Intel SATA AHCI controller,
on a Micron M500 SSD, using "postmark," "fstrim," and "fsck."

Version history:

v2:
- rebased to 3.11-rc4
- moved auxiliary field to ata_queued_cmd struct
- updated signoff name

v1:
- initial

Marc Carino (2):
  libata: Add support for SEND/RECEIVE FPDMA QUEUED
  libata: Add support for queued DSM TRIM

 drivers/ata/ahci.h        |  8 ++++++++
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-core.c | 15 +++++++++++++++
 drivers/ata/libata-scsi.c | 27 +++++++++++++++++++++------
 include/linux/ata.h       | 25 +++++++++++++++++++++++++
 include/linux/libata.h    |  6 ++++++
 6 files changed, 76 insertions(+), 6 deletions(-)

-- 
1.8.1.2

