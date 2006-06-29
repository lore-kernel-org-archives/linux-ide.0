From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 2/9] ahci.c conversion
Date: Thu, 29 Jun 2006 19:00:47 +0200
Message-ID: <20060629170047.GA20246@gollum.tnic>
References: <20060629160938.GC23122@zmei.tnic> <44A40019.1090905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.plus.mail.re2.yahoo.com ([206.190.53.27]:29041 "HELO
	smtp102.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750986AbWF2RAv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:00:51 -0400
Content-Disposition: inline
In-Reply-To: <44A40019.1090905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jun 30, 2006 at 01:30:17AM +0900, Tejun Heo wrote:
> >--- libata-dev/drivers/scsi/ahci.c.orig	2006-06-28 
> >09:13:10.000000000 +0200
> >+++ libata-dev/drivers/scsi/ahci.c	2006-06-29 17:29:06.000000000 +0200
> >@@ -617,10 +617,10 @@ static int ahci_softreset(struct ata_por
> > 	u8 *fis;
> > 	int rc;
> > 
> >-	DPRINTK("ENTER\n");
> >+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
> > 
> > 	if (ata_port_offline(ap)) {
> >-		DPRINTK("PHY reports no device\n");
> >+		ata_port_printk(ap, ATA_MSG_CMD, "PHY reports no device\n");
> 
> Not really CMD, I think it should be ATA_MSG_DEBUG.
We already have VDEBUG, do we ATA_MSG_DEBUG too, and if so, what is going to be
the difference between VDEBUG and DEBUG? Pending what we have decided here, I'm
gonna correct all other cases with DEBUG.
> 
> <--snip-->
> > 	if (ata_ratelimit())
> >-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
> >+		ata_port_printk(ap, ATA_MSG_DRV, "spurious interrupt "
> > 				"(irq_stat 0x%x active_tag %d sactive 
> > 				0x%x)\n",
> > 				status, ap->active_tag, ap->sactive);
> 
> I don't really understand why it should be DRV not INFO.  Is this to 
> discern between core and LLD messages?
right, this should be INFO.

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

