From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] libata: Cavium OCTEON SOC Compact Flash driver (v2)
Date: Mon, 24 Nov 2008 17:36:48 -0800
Message-ID: <492B56B0.9030409@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:58966 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbYKYBg7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 20:36:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: linux-mips <linux-mips@linux-mips.org>

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122704699515601), I
have a new version of our CF driver for your consideration.

This second version I split into two separate patches.  The first adds
some entries to the ata_timing table in libata-core.  The second is
the driver proper.

I will reply with the two patches.

David Daney (2):
   libata: Add three more columns to the ata_timing table.
   libata: New driver for OCTEON SOC Compact Flash interface (v2).

  drivers/ata/Kconfig          |    9 +
  drivers/ata/Makefile         |    1 +
  drivers/ata/libata-core.c    |   76 ++--
  drivers/ata/pata_octeon_cf.c |  904 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/libata.h       |   14 +-
  5 files changed, 966 insertions(+), 38 deletions(-)
  create mode 100644 drivers/ata/pata_octeon_cf.c

