From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 0/4] ata: ahci_platform: Add PHY support and OMAP support
Date: Mon, 20 Jan 2014 16:41:24 +0200
Message-ID: <1390228888-5537-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

Some platforms have a PHY hooked up to the SATA controller.
The PHY needs to be initialized and powered up for SATA to work.
We do that using the Generic PHY framework in PATCH 3.

In order to support SATA on the OMAP platforms we need to runtime
resume the device before use. PATCH 4 takes care of that.

PATCH 1 & 2 updates the DT compatible list.

Changelog:

v5:
- Don't use break after goto in switch case. Rebased on v3.13

v4:
- Tackle error conditions while using PHY framework APIs.

v3:
- Addressed review comments and rebased on 3.13-rc7
- DT binding update moved to new patch.

v2:
- got rid of Texas Instruments SATA wrapper driver
- adressed review comments

cheers,
-roger

---

Balaji T K (1):
  ata: ahci_platform: Manage SATA PHY

Roger Quadros (3):
  ata: ahci_platform: Add DT compatible for Synopsis DWC AHCI controller
  ata: ahci_platform: Update DT compatible list
  ata: ahci_platform: runtime resume the device before use

 .../devicetree/bindings/ata/ahci-platform.txt      |  4 +-
 drivers/ata/ahci.h                                 |  2 +
 drivers/ata/ahci_platform.c                        | 57 +++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
