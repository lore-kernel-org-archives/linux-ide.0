From: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Subject: [PATCH 1/3] RFC: AHCI: libahci is missing DMA
Date: Wed,  4 Dec 2013 13:10:53 +0100
Message-ID: <1386159055-10264-2-git-send-email-oliver@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBZFX7SKAKGQE3BTPKII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1386159055-10264-1-git-send-email-oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

The Allwinner sunxi platforms have patched in the following to enable
DMA. This patch enables DMA controllers for the SUNXI Architecture.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
---
 drivers/ata/ahci.h    | 6 ++++++
 drivers/ata/libahci.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efdf..2bf2423 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -138,6 +138,7 @@ enum {
 	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
 	PORT_FBS		= 0x40, /* FIS-based Switching */
 	PORT_DEVSLP		= 0x44, /* device sleep */
+	PORT_DMA		= 0x70, /* direct memory access */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -209,6 +210,11 @@ enum {
 	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
 	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
 
+	/* PORT_DMA bits */
+	PORT_DMA_SETUP_OFFSET	= 8, /* dma setup offset */
+	PORT_DMA_SETUP_MASK	= (0xff << PORT_DMA_SETUP_OFFSET),/* dma mask */
+	PORT_DMA_SETUP_INIT	= (0x44 << 0),
+
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..d697a74 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -570,6 +570,14 @@ void ahci_start_engine(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
+#ifdef CONFIG_ARCH_SUNXI
+	/* Setup DMA before DMA start */
+	tmp = readl(port_mmio + PORT_DMA);
+	tmp &= ~PORT_DMA_SETUP_MASK;
+	tmp |= PORT_DMA_SETUP_INIT << PORT_DMA_SETUP_OFFSET;
+	writel(tmp, port_mmio + PORT_DMA);
+#endif
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
-- 
1.8.3.2
