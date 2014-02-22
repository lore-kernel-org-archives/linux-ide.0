From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 1/3] ahci_platform: Drop support for ahci-strict
 platform device type
Date: Sat, 22 Feb 2014 17:22:53 +0100
Message-ID: <1393086175-6383-2-git-send-email-hdegoede@redhat.com>
References: <1393086175-6383-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB4E5UOMAKGQE3SWUZHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393086175-6383-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

I've done a grep over the entire kernel tree and nothing is using this
(anymore?).

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_platform.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 75698a4..9fb99cf 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -32,7 +32,6 @@ static void ahci_host_stop(struct ata_host *host);
 enum ahci_type {
 	AHCI,		/* standard platform ahci */
 	IMX53_AHCI,	/* ahci on i.mx53 */
-	STRICT_AHCI,	/* delayed DMA engine start */
 };
 
 static struct platform_device_id ahci_devtype[] = {
@@ -43,9 +42,6 @@ static struct platform_device_id ahci_devtype[] = {
 		.name = "imx53-ahci",
 		.driver_data = IMX53_AHCI,
 	}, {
-		.name = "strict-ahci",
-		.driver_data = STRICT_AHCI,
-	}, {
 		/* sentinel */
 	}
 };
@@ -76,13 +72,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_platform_retry_srst_ops,
 	},
-	[STRICT_AHCI] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_DELAY_ENGINE),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_platform_ops,
-	},
 };
 
 static struct scsi_host_template ahci_platform_sht = {
-- 
1.9.0
