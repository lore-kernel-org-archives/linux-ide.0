From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v5 0/4] Introduce new SATA queued commands
Date: Sat, 24 Aug 2013 23:22:47 -0700
Message-ID: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:52072 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab3HYGXQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Aug 2013 02:23:16 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so2146282obc.6
        for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2013 23:23:16 -0700 (PDT)
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

v5:
- style cleanups

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

Marc Carino (4):
  libata: Populate host-to-device FIS "auxiliary" field
  libata: Add H2D FIS "auxiliary" port flag
  libata: Add support for SEND/RECEIVE FPDMA QUEUED
  libata: Add support for queued DSM TRIM

 drivers/ata/ahci.c        |  8 ++++++++
 drivers/ata/libata-core.c | 26 ++++++++++++++++++++++----
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++------
 include/linux/ata.h       | 21 +++++++++++++++++++++
 include/linux/libata.h    | 16 ++++++++++++++++
 5 files changed, 86 insertions(+), 10 deletions(-)

-- 
1.8.1.2

