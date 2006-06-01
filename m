From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme, part 1 (25% done)
Date: Thu, 1 Jun 2006 07:38:49 +0200
Message-ID: <20060601053849.GB8523@gollum.tnic>
References: <20060531054633.GA4875@zmei.tnic> <20060531063957.GD14179@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:44686 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751672AbWFAFix (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jun 2006 01:38:53 -0400
Content-Disposition: inline
In-Reply-To: <20060531063957.GD14179@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Wed, May 31, 2006 at 02:39:57AM -0400, Jeff Garzik wrote:
> On Wed, May 31, 2006 at 07:46:33AM +0200, Borislav Petkov wrote:
> > This patch converts the first 25% of libata-core.c to the new debugging scheme.
> > 
> > Signed-off-by: <petkov@uni-muenster.de>
> 
> Looks good at first glance, though I'll hold off on apply until I return
> from the Red Hat Summit in Nashville.
> 
> It made me remember another point, though:  in order to avoid
> regressions, after applying your patch, I would think that you would
> want to create a patch which did something like
> 
> #ifndef ATA_VERBOSE_DEBUG
> 	ap->msg_enable = xxx
> #else ATA_DEBUG
> 	ap->msg_enable = yyy
> #else
> 	ap->msg_enable = ...
> #endif

Ok, i was thinking something along the lines of the following; for better
granularity we might add more ATA_XXX defines or let the user subsequently
adjust dbg level through sysfs...? (The patch applies on top of the one i sent you
before.)

Adjust initial debugging levels through preprocessor defines.

Signed-off-by: <petkov@uni-muenster.de>

 
--- libata-dev/drivers/scsi/libata-core.c.orig1	2006-06-01 07:02:42.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-01 07:32:44.000000000 +0200
@@ -5200,7 +5200,15 @@ static void ata_host_init(struct ata_por
 	ap->sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
-	ap->msg_enable = ATA_MSG_DRV;
+
+#if defined(ATA_VERBOSE_DEBUG)
+	/* turn on all debugging levels */
+	ap->msg_enable = 0x00FF;
+#elif defined(ATA_DEBUG)
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+#else 
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR;
+#endif
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

