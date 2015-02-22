From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: SATA link power management issues
Date: Sun, 22 Feb 2015 21:53:35 +0100
Message-ID: <9895435.0ZSsstcbFA@xps13>
References: <3352987.ugV1Ipy7Z5@xps13> <2526428.uJaEqCTeIa@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35785 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBVUxi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Feb 2015 15:53:38 -0500
In-Reply-To: <2526428.uJaEqCTeIa@xps13>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org, stripathi@apm.com

Hi,

It seems that the following patch prevents errors when the policy is
changed. Could anybody explain why?

Thanks,
Gabriele

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07..38d39f7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1708,7 +1708,10 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 		status &= ~PORT_IRQ_BAD_PMP;
 
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
+	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER ||
+	    ap->link.flags & ATA_LFLAG_CHANGED) {
+		if (ap->link.flags & ATA_LFLAG_CHANGED)
+			ap->link.flags &= ~ATA_LFLAG_CHANGED;
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d2029a4..e8f965c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3489,6 +3489,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 	}
 
+	link->flags |= ATA_LFLAG_CHANGED;
+
 	return 0;
 
 fail:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fc03efa..5abf5f2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -205,6 +205,7 @@ enum {
 	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
+	ATA_LFLAG_CHANGED	= (1 << 10),
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
