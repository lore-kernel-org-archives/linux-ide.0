From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v1 0/2] ata: Fixes related to edge trigger latch for ahci_xgene driver.
Date: Thu, 14 Jan 2016 11:00:22 +0530
Message-ID: <1452749424-28919-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:49751 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752045AbcANFbI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2016 00:31:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch set implements a workaround for an errate in the APM
X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
misses the edge interrupt from the PORT_IRQ_STAT when clearing the
HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
cycle. It also implements the capability to override generic interrupt
handler.

v1 change:
* Implement the capability for LDD to override interrupt handler.

* ahci_xgene driver implements the edge trigger interrupt handler.

Signed-off-by: Suman Tripathi <stripathi@apm.com>


Suman Tripathi (2):
  libahci: Implement the capability to override the generic ahci
    interrupt handler
  ahci_xgene: Implement the workaround to fix the missing of edge
    interrupt for HOST_IRQ_STAT

 drivers/ata/ahci.h       |    2 +
 drivers/ata/ahci_xgene.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libahci.c    |   18 ++++++---
 3 files changed, 98 insertions(+), 6 deletions(-)

