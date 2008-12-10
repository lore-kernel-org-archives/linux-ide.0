From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] libata: Cavium OCTEON SOC Compact Flash driver (v5)
Date: Wed, 10 Dec 2008 15:37:53 -0800
Message-ID: <494052D1.10208@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19083 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbYLJXiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2008 18:38:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: linux-mips <linux-mips@linux-mips.org>

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This fifth version is split into three separate patches.  The first
adds some entries to the ata_timing table in libata-core.c.  The
Second adds some special handling to ata_pio_need_iordy() for Compact
Flash devices, The final patch is is the driver proper.

I will reply with the three patches.

David Daney (3):
   libata: Add another column to the ata_timing table.
   libata: Add special ata_pio_need_iordy() handling for Compact Flash.
   libata: New driver for OCTEON SOC Compact Flash interface (v5).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   76 ++--
  drivers/ata/pata_octeon_cf.c |  956 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   10 +-
  5 files changed, 1014 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c

