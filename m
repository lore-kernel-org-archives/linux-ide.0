From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH 0/2] ata: Introduce the AHCI_HFLAG_EDGE_IRQ_BROKEN in libahci and enabling it for ahci_xgene driver.
Date: Mon, 11 Jan 2016 15:36:01 +0530
Message-ID: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:46527 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758794AbcAKKGq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 05:06:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch set implements a workaround for an errate in the APM
X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
misses the edge interrupt from the PORT_IRQ_STAT when clearing the
HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
cycle.

Signed-off-by: Suman Tripathi <stripathi@apm.com>

Suman Tripathi (2):
  libahci: Implement the workaround to fix the missing of edge
    interrupt for HOST_IRQ_STAT
  ahci_xgene: Enable AHCI_HFLAG_EDGE_IRQ_BROKEN for APM X-Gen2 SATA
    host controller

 drivers/ata/ahci.h       |    2 ++
 drivers/ata/ahci_xgene.c |    3 ++-
 drivers/ata/libahci.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletions(-)

