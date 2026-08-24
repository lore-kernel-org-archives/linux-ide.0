Received: from mx.bauer-kirch.com (mx.bauer-kirch.com [217.11.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4E346AE1
	for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.56.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570772; cv=none; b=fvycPPDQfA46/rZ0MjOX8L9kSPJr6eUmKEY6vcXncmR8AYkMHqFWP0rk6BKX2Me/Rzz52OCwXxFShc3ocquELuaE9NAqR1Up3uhsXoUhwgVOBqnFI77tlkUy7Xv3bFuUTRbeSeCm3E5a7amv3khfYnanwPIfwxZcH+diJjgHbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570772; c=relaxed/simple;
	bh=ZHTBm4pUgsPbfFFAl38cWPehT8HAwHXva4yjl8muKGg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=thrGpju6dzqpn434PnO5nxE/VpTsOM2gmXaAH81u/8nedqgKipTsnDjJhuXd+UHTcStIaUC83AbwWSqWNL77ceGUtGN4I3Knn8kFiGbEMtdgD8YqGHZAo2qpMc3Ge2ibSKeWLO/hpYcN+sxowKd3XFsFXMOCgpwD2vL7ghWnzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b=C/0hpwse; arc=none smtp.client-ip=217.11.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b="C/0hpwse"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=noerenberg.de; s=bauerkirch; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TisJJOJHn6Y4KcHTUyQatUMyLnpAW+EPvKimQ4g5sME=; b=C/0hpwsepNosWY48t3Mo+uHUYm
	bDEf1MHxWWfaOEgTk/O+ZublWED5JMGCsueq5tksagnOiRMAhZWEAJWVVAp8gDxZ/qbb/N/G+PB17
	V1yhwbsM9H1JyiEw5R1kxqtiFCPE7Lha7ka/S5z7Wx9q7oWM2jWlnFD8syuDtp6qmp9spnLWPGgHa
	0vnqV5OCXd84Aow6vBtPMxYUOQzMN+wmRXckpDPcm8SVayk/3Dfyr6WN/WtZRPucf5SIGa5ZviuLE
	NlPftX8orWxvuP2kSyWfGxAiyrnfqGxsOTB9n9GrD1SDv2rgdHQp7MqgbDCGCepiFUHoLkgZaTaTi
	OHn+VGWA==;
Received: by mail.bauer-kirch.de with ESMTPSA id 1wySoZ-00000001gOY-1LRx
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Mon, 24 Aug 2026 13:26:07 +0200
Message-ID: <50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de>
Date: Mon, 24 Aug 2026 13:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Subject: [PATCH] ata: ahci: clear HOST_IRQ_STAT before the ports on Marvell
 88SE61xx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


ahci_single_level_irq_intr() services the ports first and clears the global
HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section 10.6.2.  The
Marvell 88SE6111/6121/6145 family stops reporting interrupts for a port when
HOST_IRQ_STAT is cleared while PxIS still holds bits: PxIS keeps its content,
HOST_IRQ_STAT reads back as 0, the port is never looked at again, and the
command in flight only ends in a timeout.

Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood, 88SE6121
rev B2 behind PCIe) by polling the AHCI registers from userspace while an
IDENTIFY was outstanding:

  t=303.046  irq count 127  PxIS 0x00000000  PxCI 0x00000001   IDENTIFY issued
  t=303.057  irq count 128  PxIS 0x00000020  PxCI 0x00000000   CI cleared, DPS
                                                               set, one
                                                               interrupt taken
             ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
  t~308.05                                                     qc timeout after
                                                               5000 msecs

The command had completed - PxCI was clear and PxIS had DPS set - so
ahci_qc_complete() would have completed it.  It never got the chance because
the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.

Marvell's own driver for these chips clears the two registers in the opposite
order and says so ("clear global before channel"), and ahci_xgene handles its
broken edge latch the same way.  Since the reordering costs at most one
spurious interrupt per valid one on conforming controllers, do it in a private
interrupt handler selected for board_ahci_mv instead of changing libahci for
everyone.

With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the 88SE6121
without the drive-side 1.5 Gbps jumper that was needed before:

  WDC WD5000AADS-00S9B0  port 0  identified   7 ms after link up (never before)
  WDC WD3202ABYS-01B7A0  port 1  identified  28 ms after link up
  WDC WD30EFRX-68EUZN0   port 1  identified 200 ms after link up, 3 TB, HPA ok

Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145, which
Marvell's driver treats identically.

Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>

---
Damien,

this is the resolution of the thread we had in 2024 [1], sent as a new mail
rather than as a reply so that it does not get lost at the end of a long
thread.

To summarize the problem again: Gen2/3 HDDs only worked with the 88SE6121
controller in the Seagate Blackarmor NAS440 [2] when they were jumpered down
to Gen1 (1.5 Gbit/s).  That was unsatisfactory, because the very same drives
work at Gen2 speed (3 Gbit/s) without any jumper under the U-Boot bootloader.
With the patch below they work at 3 Gbit/s under Linux as well.

Both of your guesses back then turned out to be right:

> That is very odd. sata_lpm_ignore_phy_events() is only a couple of "if"
> statements and there are no register accesses in there. So if the few CPU
> cycles that takes make a difference, I would suspect that there is something
> odd going on with the marvell adapter interrupts.

> This hunk may not be directly related to the issue and commenting it out
> simply changes the timing making things better.

Exactly that.  On this machine CAP.SALP is 0, so link->lpm_policy never leaves
ATA_LPM_UNKNOWN and sata_lpm_ignore_phy_events() always returns false - the
hunk I had commented out was dead code there.  All it did was shorten the
window in which the interrupt goes missing.  Sorry for sending you down that
path.

How it was finally pinned down: I polled the AHCI registers from userspace
while an IDENTIFY was outstanding, which produced the trace in the commit
message above.  Seeing PxCI clear and PxIS set while HOST_IRQ_STAT read 0 was
the moment it became obvious.  Marvell's own driver for this chip family
("Thor", 1.0.0.9, 2007) then confirmed it: it acknowledges the two registers
in the opposite order from libahci, in three places, each with the comment

        /* clear global before channel */

and it does not use PxIS for completion at all, but derives it from
PORT_CMD_ISSUE / PORT_SCR_ACT.

Why U-Boot always worked, which puzzled me in 2024: it drives AHCI purely by
polling PORT_CMD_ISSUE in waiting_for_cmd_completed(), there is no
request_irq() anywhere in that driver, so a lost interrupt cannot affect it.
And why 2.x/3.x kernels often worked: the hazard is timing dependent and the
interrupt handler has grown over the years.  In the 3.2 log attached to the
bug the first IDENTIFY times out as well - only the retry after the hard reset
succeeds there.

One more thing worth recording, because bug 216094 spent years on it:
pci-mvebu is not involved.  The PCIe configuration is identical in the working
and the failing case - same MaxPayload, MaxReadReq and LnkCap, and the same
ABAR address with and without the DTB - there are no AER errors and PxSERR
stays 0.  So the INTx and AER work Pali did on pci-mvebu during that
discussion was never the missing piece.  libata was doing exactly what AHCI
1.1 prescribes all along; this controller simply does not behave that way.

Tested on 6.10-rc6 and on Debian's 6.1.0-50-marvell (armel), the latter across
a reboot with the module replaced, so the fix also works on the boot path that
had been broken since 3.16.

Not tested on the 88SE6145, which board_ahci_mv also covers; Marvell's driver
treats the family identically, but someone with that chip may want to confirm.

[1] https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
[2] https://github.com/hn/seagate-blackarmor-nas

 drivers/ata/ahci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1618,6 +1618,51 @@
 }
 #endif

+/*
+ * The Marvell 88SE6111/6121/6145 ("Thor") family stops reporting interrupts
+ * for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits: PxIS
+ * keeps its content, HOST_IRQ_STAT reads back as 0, the port is never looked
+ * at again and the command in flight only ends in a timeout.  On a 88SE6121
+ * this makes every SATA-2 or SATA-3 disk fail to IDENTIFY, while SATA-1 disks
+ * happen to win the race often enough to work.
+ *
+ * Clearing the host status before servicing the ports avoids it.  Marvell's
+ * own driver for these chips does the same and says so ("clear global before
+ * channel"), and ahci_xgene handles its broken edge latch the same way.  The
+ * price is at most one spurious interrupt per valid one, which is why this is
+ * not the generic behaviour - see AHCI 1.1 section 10.6.2.
+ *
+ * Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
+ */
+static irqreturn_t ahci_mv_irq_handler(int irq, void *dev_instance)
+{
+       struct ata_host *host = dev_instance;
+       struct ahci_host_priv *hpriv = host->private_data;
+       void __iomem *mmio = hpriv->mmio;
+       unsigned int rc;
+       u32 irq_stat, irq_masked;
+
+       irq_stat = readl(mmio + HOST_IRQ_STAT);
+       if (!irq_stat)
+               return IRQ_NONE;
+
+       irq_masked = irq_stat & hpriv->port_map;
+
+       spin_lock(&host->lock);
+
+       /*
+        * Use the unmasked value to clear the interrupt, as a spurious pending
+        * event on a dummy port might cause a screaming IRQ.
+        */
+       writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+       rc = ahci_handle_port_intr(host, irq_masked);
+
+       spin_unlock(&host->lock);
+
+       return IRQ_RETVAL(rc);
+}
+
 static void ahci_remap_check(struct pci_dev *pdev, int bar,
                struct ahci_host_priv *hpriv)
 {
@@ -1878,6 +1923,10 @@
                return -ENOMEM;
        hpriv->flags |= (unsigned long)pi.private_data;

+       /* the Marvell "Thor" family needs HOST_IRQ_STAT cleared first */
+       if (board_id == board_ahci_mv)
+               hpriv->irq_handler = ahci_mv_irq_handler;
+
        /* MCP65 revision A1 and A2 can't do MSI */
        if (board_id == board_ahci_mcp65 &&
            (pdev->revision == 0xa1 || pdev->revision == 0xa2))

