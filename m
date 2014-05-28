From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ahci: imx: manage only sata_ref_clk in imx_sata_enable[disable]
Date: Wed, 28 May 2014 17:36:12 +0200
Message-ID: <5386026C.1010603@redhat.com>
References: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020603060902050409020604"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbaE1Pgq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 May 2014 11:36:46 -0400
In-Reply-To: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is a multi-part message in MIME format.
--------------020603060902050409020604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 05/28/2014 05:05 PM, Shawn Guo wrote:
> Doing suspend/resume on imx6q and imx53 boards with no SATA disk
> attached will trigger the following warning.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
> Modules linked in:
> CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
> Backtrace:
> [<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
>  r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
> [<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
> [<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
>  r5:00000009 r4:00000000
> [<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
>  r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
> [<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
> [<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
>  r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
> [<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
>  r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
> [<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
>  r5:00000000 r4:ddcd9410
> [<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
> ....
> 
> The reason is that the SATA controller has no working clock at this
> point, and thus ahci_enable_ahci() fails to enable the controller.  In
> case that there is no SATA disk attached, the imx_sata_disable() gets
> called in ahci_imx_error_handler(), and both sata_clk and sata_ref_clk
> will be disabled there.  Because all the imx_sata_enable() calls
> afterward will return immediately due to imxpriv->no_device check, the
> SATA controller working clock sata_clk will never get any chance to be
> enabled again.
> 
> This is a regression caused by commit 90870d79d4f2 (ahci-imx: Port to
> library-ised ahci_platform).  Before the commit, only sata_ref_clk is
> managed by the driver in enable/disable function.  But after the commit,
> all the clocks are enabled/disabled in a row by ahci platform helpers
> ahci_platform_enable[disable]_clks.  Since ahb_clk is a bus clock which
> does not have gate at all, and i.MX low-power hardware module already
> manages sata_clk across suspend/resume cycle, the only clock that needs
> to be managed by software is sata_ref_clk.
> 
> So instead of using ahci_platform_enable[disable]_clks to manage all
> the clocks in a row from imx_sata_enable[disable], we should manage
> only sata_ref_clk in there.

I disagree, the problem here is not the clk disable / enable, with
your patch the sata_clk never gets disabled, unless the driver gets unloaded
which clearly is the wrong thing to do.

The real problem is the weird error handling which is unique to
the ahci_imx code where if no disk is present it semi-permanently
shuts down (breaking later hotplug of sata without a reboot).

I assume that this weird error handling is done to save power in the
case no disk is attached. But if that is the case the surely disabling
the sata_clk in this scenario too is the right thing to do.

As for the "ahb_clk is a bus clock which does not have gate at all" argument,
if that were the case then the disabling of the sata_clk would not cause
any issues at all, so I'm not buying that argument.

The proper fix is obvious, if we've shutdown everything due to there
not being a device present at the initial probe, don't call
ahci_platform_resume_host on resume, as is done in the attached patch.

Regards,

Hans

--------------020603060902050409020604
Content-Type: text/x-patch;
 name="0001-ahci_imx-Fix-oops-on-suspend-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ahci_imx-Fix-oops-on-suspend-resume.patch"

>From 2381bd7a615f74e3ada88d6462fbb298b7d0e279 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 28 May 2014 17:33:05 +0200
Subject: [PATCH resend] ahci_imx: Fix oops on suspend/resume

Doing suspend/resume on imx6q and imx53 boards with no SATA disk
attached will trigger the following warning.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
Backtrace:
[<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
 r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
[<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
[<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
 r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
[<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
[<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
 r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
[<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
[<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
 r5:00000000 r4:ddcd9410
[<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
....

This is caused by the unique error handling in ahci_imx which permanently
powers down the achi bits if there is no disk attached on probe. Add a check
for this condition in the suspend / resume handlers to fix this warning.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 8befeb6..00e6ed8 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -215,9 +215,6 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 	struct device *dev = &imxpriv->ahci_pdev->dev;
 	int ret;
 
-	if (imxpriv->no_device)
-		return 0;
-
 	if (hpriv->target_pwr) {
 		ret = regulator_enable(hpriv->target_pwr);
 		if (ret)
@@ -453,6 +450,9 @@ static int imx_ahci_suspend(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int ret;
 
+	if (imxpriv->no_device)
+		return 0;
+
 	ret = ahci_platform_suspend_host(dev);
 	if (ret)
 		return ret;
@@ -468,6 +468,9 @@ static int imx_ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int ret;
 
+	if (imxpriv->no_device)
+		return 0;
+
 	ret = imx_sata_enable(hpriv);
 	if (ret)
 		return ret;
-- 
1.9.3


--------------020603060902050409020604--
