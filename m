From: Tejun Heo <tj@kernel.org>
Subject: Re: Regression between 2.6.34 and 2.6.35 ?
Date: Wed, 01 Dec 2010 15:45:52 +0100
Message-ID: <4CF65FA0.5050903@kernel.org>
References: <AANLkTi=g4F0mgS-w2jFs0r_PAcEk5bytdyAGP+rWJ-J5@mail.gmail.com>	<4CEFC051.7090800@kernel.org>	<AANLkTi=koJHKvqv6iuvuc-j3HGtSR+YJqaDQmM9JrViO@mail.gmail.com>	<4CF3CE68.2020500@kernel.org> <AANLkTi=Xnm8A0gBh9jcijTMdQ-YkajCM47YH07iBVF19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56215 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab0LAOp4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Dec 2010 09:45:56 -0500
In-Reply-To: <AANLkTi=Xnm8A0gBh9jcijTMdQ-YkajCM47YH07iBVF19@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Toma <antonio.toma@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 11/30/2010 07:53 PM, Antonio Toma wrote:
> here is usual information (interrupts and boot logs) after compiling
> and installing 2.6.36.1
> The issue is still there.
> Please, let me know how to patch for further debugging.

Can you please apply the following patch, see whether the behavior
changes and report the kernel log?

Thanks.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index d05387d..b8bc453 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1532,11 +1532,10 @@ static unsigned int __ata_sff_port_intr(struct ata_port *ap,
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			return ata_sff_idle_irq(ap);
 		break;
-	case HSM_ST:
-	case HSM_ST_LAST:
-		break;
-	default:
+	case HSM_ST_IDLE:
 		return ata_sff_idle_irq(ap);
+	default:
+		break;
 	}

 	/* check main status, clearing INTRQ if needed */
@@ -2821,7 +2820,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 		VPRINTK("ata%u: host_stat 0x%X\n", ap->print_id, host_stat);

 		/* if it's not our irq... */
-		if (!(host_stat & ATA_DMA_INTR))
+		if (!(host_stat & (ATA_DMA_INTR | ATA_DMA_ERR)))
 			return ata_sff_idle_irq(ap);

 		/* before we do anything else, clear DMA-Start bit */
@@ -2830,6 +2829,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)

 		if (unlikely(host_stat & ATA_DMA_ERR)) {
 			/* error when transfering data to/from memory */
+			ata_port_printk(ap, KERN_WARNING, "XXX AC_ERR_HOST_BUS\n");
 			qc->err_mask |= AC_ERR_HOST_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 		}
