From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: BUG: AHCI: ata8 port resetting needlessly, slow boot
Date: Mon, 3 Nov 2014 10:11:16 +0100
Message-ID: <20141103091116.GA21659@kwain>
References: <54564A6C.4060009@bitsync.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51758 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751175AbaKCJLT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Nov 2014 04:11:19 -0500
Content-Disposition: inline
In-Reply-To: <54564A6C.4060009@bitsync.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zlatko Calusic <zcalusic@bitsync.net>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Zlatko,

On Sun, Nov 02, 2014 at 04:14:52PM +0100, Zlatko Calusic wrote:
> 
> I have an issue with AHCI driver, starting with kernel 3.17.0, where ata8
> port is resetting multiple times during boot, and it takes about a minute
> until it gives up, dmesg excerpt:
> 
> [    0.698367] ata8: SATA max UDMA/133 abar m8192@0xfebfe000 port 0xfebfe180
> irq 16
> [    6.052229] ata8: link is slow to respond, please be patient (ready=-19)
> [   10.744229] ata8: COMRESET failed (errno=-16)
> [   16.098114] ata8: link is slow to respond, please be patient (ready=-19)
> [   20.790040] ata8: COMRESET failed (errno=-16)
> [   26.144229] ata8: link is slow to respond, please be patient (ready=-19)
> [   55.826199] ata8: COMRESET failed (errno=-16)
> [   55.826386] ata8: limiting SATA link speed to 1.5 Gbps
> [   60.874228] ata8: COMRESET failed (errno=-16)
> [   60.874413] ata8: reset failed, giving up
> 
> In kernel 3.16.0 the same port was reported as dummy and the boot sequence
> was fast:
> 
> [    0.757323] ata8: DUMMY
> 
> I took some time, bisected between 3.16 and 3.17, and eventually found this
> commit as culprit:
> 
> commit 725c7b570fda4207e465ff8856c2c12c2645a685
> Author: Antoine Ténart <antoine.tenart@free-electrons.com>
> Date:   Wed Jul 30 20:13:56 2014 +0200
> 
>     ata: libahci_platform: move port_map parameters into the AHCI structure
> 
> Indeed, after reverting that commit in current 3.18-rc2, once again ata8 is
> reported as dummy, and the machine boots fast.
> 
> I'm attaching the full dmesg output.

Thanks for reporting this!
Can you give a try to the attached patch, to see if it fixes the issue?

Thanks,

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--y0ulUmNC+osPPQO6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-ahci-fix-AHCI-parameters-not-taken-into-account.patch"

>From 78af1100856d5f304b794727005fda589d2c4c84 Mon Sep 17 00:00:00 2001
From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Mon, 3 Nov 2014 09:56:11 +0100
Subject: [PATCH] ahci: fix AHCI parameters not taken into account

Changes into the AHCI subsystem have introduced a bug by not taking into
account the force_port_map and mask_port_map parameters when using the
ahci_pci_save_initial_config function. This commit fixes it by setting
the internal parameters of the ahci_port_priv structure.

Fixes: 725c7b570fda

Reported-by: Zlatko Calusic <zcalusic@bitsync.net>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a29f8012fb08..b3da6a2c44dd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -504,12 +504,9 @@ MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	unsigned int force_port_map = 0;
-	unsigned int mask_port_map = 0;
-
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
-		force_port_map = 1;
+		hpriv->force_port_map = 1;
 	}
 
 	/*
@@ -519,9 +516,9 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 	 */
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
 		if (pdev->device == 0x6121)
-			mask_port_map = 0x3;
+			hpriv->mask_port_map = 0x3;
 		else
-			mask_port_map = 0xf;
+			hpriv->mask_port_map = 0xf;
 		dev_info(&pdev->dev,
 			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");
 	}
-- 
2.1.0


--y0ulUmNC+osPPQO6--
