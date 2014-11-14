From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ahci_sunxi: Make AHCI_HFLAG_NO_PMP flag
 configurable with a module option
Date: Fri, 14 Nov 2014 16:09:31 +0100
Message-ID: <1415977771-5909-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORBM5WTCRQKGQECQXIDKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

The use of the AHCI_HFLAG_NO_PMP flag is something which we inherited from
the Allwinner android kernel sources, and I've always wanted to test if this
is really necessary.

So recently I've bought a sata port multiplexer, and I've given this a test
spin on both A10 and A20 devices, and it seems to work fine:

[    2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5 ports, feat 0x5/0xf
[    2.175511] ata1.00: hard resetting link
[    2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    2.531430] ata1.01: hard resetting link
[    2.974465] ata1.01: link resume succeeded after 1 retries
[    3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.101431] ata1.02: hard resetting link
[    4.174466] ata1.02: failed to resume link (SControl 0)
[    4.180065] ata1.02: SATA link down (SStatus 0 SControl 0)
(and the same for links 3 and 4)

Once the NO_PMP flag is removed it correctly sees the 2 disks which I've
attached, and I can mount and use them just fine.

Unfortunately when I then directly attached a disk to the sata port on the
sunxi SoC, and booted a kernel without the AHCI_HFLAG_NO_PMP flag, it would
not recognize that disk.

It turns out that the sata controller in the sunxi SoCs fails to handle
soft-resets issued to directly attached disks, and when pmp support is
enabled the kernel will always issue a soft-reset.

So add a module parameter to enable pmp usage, and default this to off, so
that directly attached disks keep working normally.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_sunxi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index e44d675..b5aedca 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -27,6 +27,12 @@
 #include <linux/regulator/consumer.h>
 #include "ahci.h"
 
+/* Insmod parameters */
+static bool enable_pmp;
+module_param(enable_pmp, bool, 0);
+MODULE_PARM_DESC(enable_pmp,
+	"Enable support for sata port multipliers, only use if you use a pmp!");
+
 #define AHCI_BISTAFR	0x00a0
 #define AHCI_BISTCR	0x00a4
 #define AHCI_BISTFCTR	0x00a8
@@ -184,7 +190,15 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 		goto disable_resources;
 
 	hpriv->flags = AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
-		       AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
+		       AHCI_HFLAG_YES_NCQ;
+
+	/*
+	 * The sunxi sata controller seems to be unable to successfully do a
+	 * soft reset if no pmp is attached, so disable pmp use unless
+	 * requested, otherwise directly attached disks do not work.
+	 */
+	if (!enable_pmp)
+		hpriv->flags |= AHCI_HFLAG_NO_PMP;
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_sunxi_port_info);
 	if (rc)
-- 
2.1.0
