From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] libata: Cavium OCTEON SOC Compact Flash driver (v4)
Date: Mon, 08 Dec 2008 17:37:46 -0800
Message-ID: <493DCBEA.9090007@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20538 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYLIBnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 20:43:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: linux-mips <linux-mips@linux-mips.org>

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This version is split into three separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The Second adds
some special handling to ata_pio_need_iordy() for Compact Flash
devices, The final patch is is the driver proper.

I will reply with the three patches.

David Daney (3):
   libata: Add two more columns to the ata_timing table.
   libata: Add special ata_pio_need_iordy() handling for Compact Flash.
   libata: New driver for OCTEON SOC Compact Flash interface (v3).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   78 ++--
  drivers/ata/pata_octeon_cf.c |  945 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   12 +-
  5 files changed, 1007 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c

