From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] libata: Add OCTEON Compact Flash driver (v7).
Date: Thu, 15 Jan 2009 17:44:27 -0800
Message-ID: <496FE67B.9000509@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25511 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbZAPBph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 20:45:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>

Linus recently merged support for the mips/Octeon cpu.

please consider adding this driver for the Compact Flash system
present on many of the OCTEON development boards.

Fixes from v6 as suggested by Alan Cox and described in patch 2/2.

This is a two part patch set, the first part adds a new column to the
ata_timing table (for dmack_hold).  This is used by the second patch
which is the driver itself.

I will reply with the two patches.

Thanks,

David Daney (2):
   libata: Add another column to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v7).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   72 ++--
  drivers/ata/pata_octeon_cf.c |  965 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |    9 +-
  5 files changed, 1018 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c

