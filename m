From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: kill spurious NCQ completion detection
Date: Fri, 07 Dec 2007 12:46:23 +0900
Message-ID: <4758C20F.8020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:5528 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXLGDqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 22:46:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1125325wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Dec 2007 19:46:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, albertl@mail.com, diego torres <dtor>

Spurious NCQ completion detection implemented in ahci was incorrect.
On AHCI receving and processing FISes and raising interrupts are not
interlocked and spurious interrupts are expected.

For example, if an interrupt occurs while interrupt handler is running
and the running interrupt handler handles the event the new IRQ
indicated, after IRQ handler finishes, it will be executed again
because IRQ pending bit is set by the new interrupt but there won't be
anything to process.

Please read the following message for more information.

  http://article.gmane.org/gmane.linux.ide/26012

This patch...

* Removes all spurious IRQ whining from ahci.  Spurious NCQ completion
  detection was completely wrong.  Spurious D2H Register FIS taught us
  that some early drives send spurious D2H Register FIS with I bit set
  while NCQ commands are in progress but none of recent drives does
  that and even the ones which show such behavior can do NCQ fine.

* Kills all NCQ blacklist entries which were added because of spurious
  NCQ completions.  I tracked down each commit and verified all
  removed ones are actually added because of spurious completions.

  WD740ADFD-00NLR1 wasn't deleted but moved upward because the drive
  not only had spurious NCQ completions but also is slow on sequential
  data transfers if NCQ is enabled.

  Maxtor 7V300F0 was added by 0e3dbc01d53940fe10e5a5cfec15ede3e929c918
  from Alan Cox.  I can only find evidences that the drive only had
  troubles with spuruious completions by searching the mailing list.
  This entry needs to be verified and removed if it doesn't have other
  NCQ related problems.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
Alan, can you please check why 7V300F0 was added?  Thanks a lot.

 drivers/ata/ahci.c        |   74 +---------------------------------------------
 drivers/ata/libata-core.c |   18 -----------
 2 files changed, 4 insertions(+), 88 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4688dbf..7ef497a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1638,7 +1638,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
 	u32 status, qc_active;
-	int rc, known_irq = 0;
+	int rc;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
@@ -1696,80 +1696,12 @@ static void ahci_port_intr(struct ata_port *ap)
 
 	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
 
-	/* If resetting, spurious or invalid completions are expected,
-	 * return unconditionally.
-	 */
-	if (resetting)
-		return;
-
-	if (rc > 0)
-		return;
-	if (rc < 0) {
+	/* while resetting, invalid completions are expected */
+	if (unlikely(rc < 0 && !resetting)) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
 		ata_port_freeze(ap);
-		return;
-	}
-
-	/* hmmm... a spurious interrupt */
-
-	/* if !NCQ, ignore.  No modern ATA device has broken HSM
-	 * implementation for non-NCQ commands.
-	 */
-	if (!ap->link.sactive)
-		return;
-
-	if (status & PORT_IRQ_D2H_REG_FIS) {
-		if (!pp->ncq_saw_d2h)
-			ata_port_printk(ap, KERN_INFO,
-				"D2H reg with I during NCQ, "
-				"this message won't be printed again\n");
-		pp->ncq_saw_d2h = 1;
-		known_irq = 1;
-	}
-
-	if (status & PORT_IRQ_DMAS_FIS) {
-		if (!pp->ncq_saw_dmas)
-			ata_port_printk(ap, KERN_INFO,
-				"DMAS FIS during NCQ, "
-				"this message won't be printed again\n");
-		pp->ncq_saw_dmas = 1;
-		known_irq = 1;
 	}
-
-	if (status & PORT_IRQ_SDB_FIS) {
-		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
-
-		if (le32_to_cpu(f[1])) {
-			/* SDB FIS containing spurious completions
-			 * might be dangerous, whine and fail commands
-			 * with HSM violation.  EH will turn off NCQ
-			 * after several such failures.
-			 */
-			ata_ehi_push_desc(ehi,
-				"spurious completions during NCQ "
-				"issue=0x%x SAct=0x%x FIS=%08x:%08x",
-				readl(port_mmio + PORT_CMD_ISSUE),
-				readl(port_mmio + PORT_SCR_ACT),
-				le32_to_cpu(f[0]), le32_to_cpu(f[1]));
-			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_SOFTRESET;
-			ata_port_freeze(ap);
-		} else {
-			if (!pp->ncq_saw_sdb)
-				ata_port_printk(ap, KERN_INFO,
-					"spurious SDB FIS %08x:%08x during NCQ, "
-					"this message won't be printed again\n",
-					le32_to_cpu(f[0]), le32_to_cpu(f[1]));
-			pp->ncq_saw_sdb = 1;
-		}
-		known_irq = 1;
-	}
-
-	if (!known_irq)
-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
-				status, ap->link.active_tag, ap->link.sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b514a80..e4dea86 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4140,6 +4140,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices where NCQ should be avoided */
 	/* NCQ is slow */
 	{ "WDC WD740ADFD-00",	NULL,		ATA_HORKAGE_NONCQ },
+	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	/* http://thread.gmane.org/gmane.linux.ide/14907 */
 	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 	/* NCQ is broken */
@@ -4154,23 +4155,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
-	/* Drives which do spurious command completion */
-	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
-	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
-	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
-	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
-	{ "Hitachi HTS542525K9SA00", "BBFOC31P", ATA_HORKAGE_NONCQ, },
-	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
-	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
-	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
-	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
-	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
-	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
-	{ "ST9160821AS",	"3.CCD",	ATA_HORKAGE_NONCQ, },
-	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
-	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
-	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
-	{ "Maxtor 7V300F0",	"VA111900",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
