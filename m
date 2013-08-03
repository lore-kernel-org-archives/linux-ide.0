From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH 0/2] Introduce new SATA queued commands
Date: Fri,  2 Aug 2013 20:34:54 -0700
Message-ID: <1375500896-22955-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40348 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab3HCDgQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Aug 2013 23:36:16 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so2502673obb.32
        for <linux-ide@vger.kernel.org>; Fri, 02 Aug 2013 20:36:16 -0700 (PDT)
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
allows the host to keep the queue full.

These patches have been validated on an Intel SATA AHCI controller,
on a Micron M500 SSD, using "postmark," "fstrim," and "fsck."

Marc C (2):
  libata: Add support for SEND/RECEIVE FPDMA QUEUED
  libata: Add support for queued DSM TRIM

 drivers/ata/libata-core.c | 25 +++++++++++++++++++++----
 drivers/ata/libata-scsi.c | 26 ++++++++++++++++++++------
 include/linux/ata.h       | 25 +++++++++++++++++++++++++
 include/linux/libata.h    |  4 ++++
 4 files changed, 70 insertions(+), 10 deletions(-)

-- 
1.8.1.2

