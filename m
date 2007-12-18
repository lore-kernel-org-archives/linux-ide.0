From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] [libata] sata_mv: Support integrated controllers
Date: Tue, 18 Dec 2007 17:02:01 -0500
Message-ID: <47684359.9030706@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com> <1196610199229-git-send-email-saeed.bishara@gmail.com> <11966102001423-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45132 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbXLRWCD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 17:02:03 -0500
In-Reply-To: <11966102001423-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>

saeed.bishara@gmail.com wrote:
> From: Saeed Bishara <saeed@marvell.com>
> 
> Marvell's Orion SoC includes SATA controllers based on Marvell's
> PCI-to-SATA 88SX controllers. The integrated SATA unit is connected
> directly to the internal bus of the Orion SoC, and not via PCI.
> This patch extends the libATA sata_mv driver to support those
> controllers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>

Overall, looks pretty good.

My main comment is that several changes, like

-	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
+	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);

and

-	if (unlikely(irq_stat & PCI_ERR)) {
+	if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {

belong in patch #1, the PCI isolation patch, rather than this patch 
implementing support for integrated controllers.

Finally, don't hardcode a 32-bit DMA mask in your platform_device setup, 
pass that mask in via mv_sata_platform_data.

	Jeff



