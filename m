From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/4] libahci: Add a pre ahci_start_engine hook
Date: Sat,  4 Jan 2014 10:14:35 +0100
Message-ID: <1388826878-5602-2-git-send-email-hdegoede@redhat.com>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBD5CT6LAKGQE33NKTWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388826878-5602-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

Allwinner A10 and A20 ARM SoCs have an AHCI sata controller which need a
special register to be poked before starting the DMA engine.

This register gets reset on an ahci_stop_engine call, so there is no other
place then ahci_start_engine where this poking can be done.

This commit adds a pre ahci_start_engine hook for use by the Allwinner AHCI
driver (and potentially other drivers in the future).

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci.h    | 2 ++
 drivers/ata/libahci.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efd..1bba479 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -323,6 +323,8 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clk;		/* Only for platforms supporting clk */
 	void			*plat_data;	/* Other platform data */
+	/* Optional pre ahci_start_engine hook */
+	void			(*pre_start_engine)(struct ata_port *ap);
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..780e9df 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -568,8 +568,12 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 tmp;
 
+	if (hpriv->pre_start_engine)
+		hpriv->pre_start_engine(ap);
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
-- 
1.8.4.2
