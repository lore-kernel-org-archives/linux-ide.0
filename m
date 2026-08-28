Received: from mx.bauer-kirch.com (mx.bauer-kirch.com [217.11.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1B3CB918
	for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.56.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900735; cv=none; b=BoWEdPy3TKFC0u2hn23XcEsH77WgIiA1D4XoyiCgYrggAf7XKh0FcVpsQdMWgrcUoGBbA6+kZ5+SAltXRwmddNtzpMrO7u/8bzktPF17+dj3mn3hR3RM4tsFYSSiHtG1tNcN3QnbiS2MIio7lTSE9IMbR54abpuTNBkNmUIoqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900735; c=relaxed/simple;
	bh=VpiG3Kk1nEfLE5lN48fnMD9YHuI9JUZ8i39MbkkuEM8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fG6P+HBsE+zdt45DhyXqNzzf20TYMLELBH7nHUBcYu0nxS/K33Xdys/BkwYhyknUIEcfpFo4p1NbgpM17C877KaSt+bi1uQJpnJYvpqb24TC4S+SOemL8MkXtkENBztz1BPp6wQuKFDLC2plyn5JyjIz432WFTNlFNwbb/Qf9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b=FEn/2J/s; arc=none smtp.client-ip=217.11.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b="FEn/2J/s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=noerenberg.de; s=bauerkirch; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PYJ8am55PTl/Tw/gCW0brtvxDsaa0LU4ngd40n35zgE=; b=FEn/2J/sPwq4wulw7tfe7yV7ge
	L19dLttJF0Yn6JOlXVYzpojjj9cpKZWxag6eqQ0rQR+N0zqxukice2pJ6Mj6gYHWNm8S0ZzeOCaZ2
	sC3WqnT/V2aaX+IlS+yW5aqXxrLCmIdn/dwgCp6upSscyZRFjo+g3ZBjt1Eqsr0sROj1XL0POWnY3
	clxEXi6redsjWJVc1cRHs7h9gfeZcKydMtlHz9oAVNETBTeELbqX6aRomLqA91+v7p9CklWdYy0Yu
	n869bi7OosvwPFBfUTGgcq+lGIodyEwEEdrlgd7oHmAhtrSESXogdeEeST1DwSobr7mFBUGoBcDj9
	YxLEd1RQ==;
Received: by mail.bauer-kirch.de with ESMTPSA id 1wzqeQ-00000003cB2-2Xjm
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Fri, 28 Aug 2026 09:05:22 +0200
Message-ID: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
Date: Fri, 28 Aug 2026 09:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Subject: [PATCH v2] ata: ahci: work around lost interrupts on Marvell 88SE61xx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


ahci_single_level_irq_intr() services the ports first and clears the
global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
looked at again, and the command in flight only ends in a timeout.

Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood,
88SE6121 rev B2 behind PCIe) by polling the AHCI registers from userspace
while an IDENTIFY was outstanding:

  t=303.046  irqs 127  PxIS 0x00000000  PxCI 0x00000001
             IDENTIFY issued
  t=303.057  irqs 128  PxIS 0x00000020  PxCI 0x00000000
             CI cleared, DPS set, one interrupt taken
             ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
  t~308.05   qc timeout after 5000 msecs

The command had completed - PxCI was clear and PxIS had DPS set - so
ahci_qc_complete() would have completed it.  It never got the chance
because the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.

Marvell's own driver for these chips clears the two registers in the
opposite order and says so ("clear global before channel"), and
ahci_xgene handles its broken edge latch the same way.  Since the
reordering costs at most one spurious interrupt per valid one on
conforming controllers, do it in a private interrupt handler selected for
board_ahci_mv instead of changing libahci for everyone.

With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the
88SE6121 without the drive-side 1.5 Gbps jumper that was needed before.
Time from link up to a successful IDENTIFY:

  WDC WD5000AADS-00S9B0  port 0    7 ms  (never identified before)
  WDC WD3202ABYS-01B7A0  port 1   28 ms
  WDC WD30EFRX-68EUZN0   port 1  200 ms  (3 TB, HPA detection ok)

Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145,
which Marvell's driver treats identically.

Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>

---
Damien,

as requested, resent with the new title.  The patch itself is byte for byte
v1 [1]; only the commit message changed.

v2:
 - retitle "clear HOST_IRQ_STAT before the ports" -> "work around lost
   interrupts", per review
 - rewrap the commit log at 75 columns and reflow the register trace, which
   had lines up to 79 characters
 - no functional change

The answer to your review question is in that thread as well: registering
ahci_thunderx_irq_handler() unchanged for board_ahci_mv does not work on this
chip.  It still clears HOST_IRQ_STAT after servicing the ports, and the loop
cannot make up for that, because once IS has been written while an unserviced
PxIS bit was standing, this controller never re-asserts it -- the re-read
returns 0 and the loop exits.

[1] https://lore.kernel.org/linux-ide/50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de/

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
