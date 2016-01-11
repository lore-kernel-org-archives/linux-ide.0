From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH 2/2] ahci_xgene: Enable AHCI_HFLAG_EDGE_IRQ_BROKEN for APM X-Gen2 SATA host controller
Date: Mon, 11 Jan 2016 15:36:03 +0530
Message-ID: <1452506763-18649-3-git-send-email-stripathi@apm.com>
References: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:46535 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758909AbcAKKGu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 05:06:50 -0500
In-Reply-To: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch enables the AHCI_HFLAG_EDGE_IRQ_BROKEN for APM
X-Gene2 AHCI SATA host controller. Due to H/W errata, the
HOST_IRQ_STAT misses the edge interrupt from PORT_IRQ_STAT
when clearing the HOST_IRQ_STAT and reporting the PORT_IRQ_STAT
at the same clock cycle.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/ata/ahci_xgene.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index e2c6d9e..57c8463 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -779,7 +779,8 @@ skip_clk_phy:
 		hpriv->flags = AHCI_HFLAG_NO_NCQ;
 		break;
 	case XGENE_AHCI_V2:
-		hpriv->flags |= AHCI_HFLAG_YES_FBS | AHCI_HFLAG_EDGE_IRQ;
+		hpriv->flags |= AHCI_HFLAG_YES_FBS | AHCI_HFLAG_EDGE_IRQ |
+				AHCI_HFLAG_EDGE_IRQ_BROKEN;
 		break;
 	default:
 		break;
--
1.7.1

