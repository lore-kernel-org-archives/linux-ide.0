From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 02/18] libahci: Move ahci_host_priv
 declaration to include/linux/ahci.h
Date: Wed, 19 Feb 2014 13:01:44 +0100
Message-ID: <1392811320-3132-3-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBTV2SKMAKGQETTR6HYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

With the ahci-platform.c changes later in this patch-set, some
arch/arm/mach-foo/*.c sata drivers need access to ahci_host_priv, so move
its declaration outside of drivers/ata.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci.h   | 20 +-------------------
 include/linux/ahci.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/ahci.h

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2c04211..0f80129 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,7 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
 
-#include <linux/clk.h>
+#include <linux/ahci.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -309,24 +309,6 @@ struct ahci_port_priv {
 	char			*irq_desc;	/* desc in /proc/interrupts */
 };
 
-struct ahci_host_priv {
-	void __iomem *		mmio;		/* bus-independent mem map */
-	unsigned int		flags;		/* AHCI_HFLAG_* */
-	u32			cap;		/* cap to use */
-	u32			cap2;		/* cap2 to use */
-	u32			port_map;	/* port map to use */
-	u32			saved_cap;	/* saved initial cap */
-	u32			saved_cap2;	/* saved initial cap2 */
-	u32			saved_port_map;	/* saved initial port_map */
-	u32 			em_loc; /* enclosure management location */
-	u32			em_buf_sz;	/* EM buffer size in byte */
-	u32			em_msg_type;	/* EM message type */
-	struct clk		*clk;		/* Only for platforms supporting clk */
-	void			*plat_data;	/* Other platform data */
-	/* Optional ahci_start_engine override */
-	void			(*start_engine)(struct ata_port *ap);
-};
-
 extern int ahci_ignore_sss;
 
 extern struct device_attribute *ahci_shost_attrs[];
diff --git a/include/linux/ahci.h b/include/linux/ahci.h
new file mode 100644
index 0000000..3499d44
--- /dev/null
+++ b/include/linux/ahci.h
@@ -0,0 +1,46 @@
+/*
+ *  ahci.h - Common AHCI SATA definitions and declarations
+ *
+ *  Maintained by:  Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+ *                  Please ALWAYS copy linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+ *                  on emails.
+ *
+ *  Copyright 2004-2005 Red Hat, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_AHCI_H__
+#define __LINUX_AHCI_H__
+
+#include <linux/clk.h>
+
+struct ata_port;
+
+struct ahci_host_priv {
+	void __iomem		*mmio;		/* bus-independent mem map */
+	unsigned int		flags;		/* AHCI_HFLAG_* */
+	u32			cap;		/* cap to use */
+	u32			cap2;		/* cap2 to use */
+	u32			port_map;	/* port map to use */
+	u32			saved_cap;	/* saved initial cap */
+	u32			saved_cap2;	/* saved initial cap2 */
+	u32			saved_port_map;	/* saved initial port_map */
+	u32			em_loc; /* enclosure management location */
+	u32			em_buf_sz;	/* EM buffer size in byte */
+	u32			em_msg_type;	/* EM message type */
+	struct clk		*clk;		/* Optional */
+	void			*plat_data;	/* Other platform data */
+	/* Optional ahci_start_engine override */
+	void			(*start_engine)(struct ata_port *ap);
+};
+
+#endif
-- 
1.8.5.3
