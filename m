From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 2/2] ahci_xgene: Enable AHCI_HFLAG_EDGE_IRQ_BROKEN for APM X-Gen2 SATA host controller
Date: Thu, 24 Dec 2015 13:01:29 +0530
Message-ID: <1450942289-12660-3-git-send-email-stripathi@apm.com>
References: <1450942289-12660-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450942289-12660-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch enables the AHCI_HFLAG_EDGE_IRQ_BROKEN for APM
X-Gene2 AHCI SATA host controller. Due to H/W errata, the
HOST_IRQ_STAT misses the edge interrupt from PORT_IRQ_STAT
when clearing the HOST_IRQ_STAT and reporting the PORT_IRQ_STAT
at the same clock cycle.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
