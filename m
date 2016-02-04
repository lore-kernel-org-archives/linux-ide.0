From: suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 0/3] ata: Fixes related to edge trigger latch for the ahci_xgene_driver.
Date: Fri,  5 Feb 2016 02:50:23 +0530
Message-ID: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:60067 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754173AbcBDVVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 16:21:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

From: Suman Tripathi <stripathi@apm.com>

This patch set implements a workaround for an errate in the APM
X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
misses the edge interrupt from the PORT_IRQ_STAT when clearing the
HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
cycle. It also implements the capability to override generic interrupt
handler.

v1 change:
* Implement the capability for LDD to override interrupt handler.

* ahci_xgene driver implements the edge trigger interrupt handler.

v2 change:
* Remove the AHCI_HFLAG_EDGE_IRQ frim libahci.

v3 change:
* Reorder the patch sequence

Signed-off-by: Suman Tripathi <stripathi@apm.com>

Suman Tripathi (3):
  libahci: Implement the capability to override the generic ahci
    interrupt     handler.
  libahci: ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
  ahci_xgene: Implement the workaround to fix the missing of edge
    interrupt for HOST_IRQ_STAT.

 drivers/ata/ahci.h       |    5 ++-
 drivers/ata/ahci_xgene.c |   85 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c    |   66 +++++++++++-------------------------
 3 files changed, 107 insertions(+), 49 deletions(-)

