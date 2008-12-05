From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] libata: Cavium OCTEON SOC Compact Flash driver (v3)
Date: Fri, 05 Dec 2008 15:06:42 -0800
Message-ID: <4939B402.9010004@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:39651 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbYLEXGx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 18:06:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

This version is split into two separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The second is
the driver proper.

I will reply with the two patches.

Thanks,

David Daney (2):
   libata: Add two more columns to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v3).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   74 ++--
  drivers/ata/pata_octeon_cf.c |  956 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   12 +-
  5 files changed, 1014 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c

