From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: SATA link power management issues
Date: Mon, 12 Jan 2015 15:05:01 -0800 (PST)
Message-ID: <2526428.uJaEqCTeIa@xps13>
References: <3352987.ugV1Ipy7Z5@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3352987.ugV1Ipy7Z5@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org, stripathi@apm.com
List-Id: linux-ide@vger.kernel.org

I just tried the following and I no longer get errors:

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 97683e4..c815b31 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1708,10 +1708,10 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 		status &= ~PORT_IRQ_BAD_PMP;
 
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
+//	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
-	}
+// 	}
 
 	if (unlikely(status & PORT_IRQ_ERROR)) {
 		ahci_error_intr(ap, status);


I haven't read the specification, so this might be bad. I did this in
base of some consideration I made that, as far as I know, could be
completely wrong. I hope you can get something meaningful out of this.

Gabriele
