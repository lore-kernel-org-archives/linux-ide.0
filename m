From: suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v4 0/3] ata: Fixes related to edge trigger latch for the ahci_xgene_driver.
Date: Sat,  6 Feb 2016 11:25:21 +0530
Message-ID: <1454738124-9351-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>

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
* Reorder the patch sequence.

v4 change:
* Incorporate Tejun's changes.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>

Suman Tripathi (3):
  libahci: Implement the capability to override the generic ahci
    interrupt     handler.
  ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
  ahci_xgene: Implement the workaround to fix the missing of the edge
      interrupt for the HOST_IRQ_STAT.

 drivers/ata/ahci.h       |    5 ++-
 drivers/ata/ahci_xgene.c |   85 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c    |   62 +++++++++------------------------
 3 files changed, 104 insertions(+), 48 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
