From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v4 0/3] Introduce new SATA queued commands
Date: Fri, 23 Aug 2013 02:40:44 -0700
Message-ID: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:57266 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab3HWJmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 05:42:16 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so493504oag.27
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 02:42:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc C <marc.ceeeee@gmail.com>

From: Marc C <marc.ceeeee@gmail.com>

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

v4:
- put "auxiliary" field back into taskfile struct
- add ATA controller flag to indicate support (default on) for new
field
- style cleanups

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

 drivers/ata/ahci.c        |  8 ++++++++
 drivers/ata/libata-core.c | 30 ++++++++++++++++++++++++++----
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++------
 include/linux/ata.h       | 23 +++++++++++++++++++++++
 include/linux/libata.h    | 20 ++++++++++++++++++++
 5 files changed, 96 insertions(+), 10 deletions(-)

-- 
1.8.1.2

