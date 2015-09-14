From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Mon, 14 Sep 2015 09:45:33 +0200
Message-ID: <4524877.YJljz8o2LZ@wuerfel>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com> <DM2PR03MB574B7F5FBB2844161CD7482FA5D0@DM2PR03MB574.namprd03.prod.outlook.com> <20150914065432.GA25168@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49481 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbINHpq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2015 03:45:46 -0400
In-Reply-To: <20150914065432.GA25168@wfg-t540p.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Yuantian Tang <Yuantian.Tang@freescale.com>, Tejun Heo <tj@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Monday 14 September 2015 14:54:32 Fengguang Wu wrote:
> On Mon, Sep 14, 2015 at 06:51:36AM +0000, Yuantian Tang wrote:
> > The ARCH should have been ARM for this driver.
> > Do you think this warning would go away if adding a dependency on ARM?
> 
> Yes, that may work.

In general, we really want to leave drivers with a COMPILE_TEST dependency
so they at least get cross-built on x86, ideally on all architectures.

Does something like the below help? I think we really just need to help
gcc a little to see the obvious.

	Arnd

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index e5e498812554..fc57208d8dcd 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -75,6 +75,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
 	bool online;
+	bool ls101021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -92,7 +93,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	 * After the sequence is complete, software should restore the
 	 * PxCMD and PxIS with the stored values.
 	 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (ls101021a_workaround) {
 		px_cmd = readl(port_mmio + PORT_CMD);
 		px_is = readl(port_mmio + PORT_IRQ_STAT);
 	}
@@ -106,7 +107,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 				 ahci_check_ready);
 
 	/* restore the PxCMD and PxIS on ls1021 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (ls101021a_workaround) {
 		px_val = readl(port_mmio + PORT_CMD);
 		if (px_val != px_cmd)
 			writel(px_cmd, port_mmio + PORT_CMD);

