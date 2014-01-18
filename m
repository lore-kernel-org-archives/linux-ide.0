From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 01/13] libahci: Allow drivers to override start_engine
Date: Sun, 19 Jan 2014 00:48:43 +0100
Message-ID: <1390088935-7193-2-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB4NF5SLAKGQE5F5MOZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

Allwinner A10 and A20 ARM SoCs have an AHCI sata controller which needs a
special register to be poked before starting the DMA engine.

This register gets reset on an ahci_stop_engine call, so there is no other
place then ahci_start_engine where this poking can be done.

This commit allows drivers to override ahci_start_engine behavior for use by
the Allwinner AHCI driver (and potentially other drivers in the future).

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci.h    | 2 ++
 drivers/ata/libahci.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efd..8f60f33 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -323,6 +323,8 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clk;		/* Only for platforms supporting clk */
 	void			*plat_data;	/* Other platform data */
+	/* Optional ahci_start_engine override */
+	void			(*start_engine)(struct ata_port *ap);
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..f6eabbc 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -568,8 +568,14 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 tmp;
 
+	if (hpriv->start_engine) {
+		hpriv->start_engine(ap);
+		return;
+	}
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
-- 
1.8.4.2
