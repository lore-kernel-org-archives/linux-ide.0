From: Robert Richter <rric@kernel.org>
Subject: [PATCH v5 0/2] ahci: Add generic MSI-X support for single interrupts to SATA PCI
Date: Fri,  5 Jun 2015 19:49:24 +0200
Message-ID: <1433526566-21136-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33525 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbbFERtd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2015 13:49:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

This patch set adds generic support for MSI-X interrupts to the SATA
PCI driver.

One patch does the generic change, the other add support for Cavium's
ThunderX host controller.


Robert Richter (2):
  ahci: Add generic MSI-X support for single interrupts to SATA PCI
    driver
  ahci: Add support for Cavium's ThunderX host controller

 drivers/ata/ahci.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

-- 
2.1.1

