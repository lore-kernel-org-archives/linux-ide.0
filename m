From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 0/2] ata: Introduce the AHCI_HFLAG_EDGE_IRQ_BROKEN in libahci and enabling it for ahci_xgene driver.
Date: Thu, 24 Dec 2015 13:01:27 +0530
Message-ID: <1450942289-12660-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch set implements a workaround for an errate in the APM
X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
misses the edge interrupt from the PORT_IRQ_STAT when clearing the
HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
cycle.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>

Suman Tripathi (2):
  libahci: Implement the workaround to fix the missing of edge
    interrupt for HOST_IRQ_STAT
  ahci_xgene: Enable AHCI_HFLAG_EDGE_IRQ_BROKEN for APM X-Gen2 SATA
    host controller

 drivers/ata/ahci.h       |    2 ++
 drivers/ata/ahci_xgene.c |    3 ++-
 drivers/ata/libahci.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
