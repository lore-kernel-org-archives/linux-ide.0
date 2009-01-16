From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: Re: problems with sata_mv and MV88SX5081 under 2.6.28, fine under
	2.6.17.6
Date: Fri, 16 Jan 2009 10:52:44 +0000
Message-ID: <1232103164.28875.24.camel@ukabzc383.uk.saic.com>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
	 <496B9130.2000708@pobox.com>
	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F13@0602-its-exmb01.eu.saic.com>
	 <496BA7C5.2020802@pobox.com>
	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F14@0602-its-exmb01.eu.saic.com>
	 <496BAA1F.5030802@pobox.com>
	 <1231866067.20422.296.camel@ukabzc383.uk.saic.com>
	 <496CEB3A.2090608@rtr.ca>  <496F9063.3080702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:44073 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZAPKxU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 05:53:20 -0500
In-Reply-To: <496F9063.3080702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Hi Mark,

The fix does indeed allow the cards to function normally under 2.6.28.

many thanks for all the work - now all I have to do is try and figure
out how to recover this array without going to backup if I can help
it :(

Oh well, if it as easy, everybody would be doing it :)


On Thu, 2009-01-15 at 14:37 -0500, Mark Lord wrote:
> > Eamonn Hamilton wrote:
> >> Hi Mark.
> >>
> >> It bisected down to the following:
> >>
> >> e3472cbe5c10a91c737405cd706142787736392c is first bad commit
> >> commit e3472cbe5c10a91c737405cd706142787736392c
> >> Author: Albert Lee <albertcc@tw.ibm.com>
> >> Date:   Thu Dec 7 11:37:58 2006 +0800
> >>
> >> libata: let ATA_FLAG_PIO_POLLING use polling pio for ATA_PROT_NODATA
> >>
> >> Even if ATA_FLAG_PIO_POLLING is set, libata uses irq pio for the 
> >> ATA_PROT_NODATA protocol.
> >> This patch let ATA_FLAG_PIO_POLLING use polling pio for the 
> >> ATA_PROT_NODATA protocol.
> >>
> >> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> >> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> >> ---
> > ..
> >> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> >> index 8816e30..d2e6863 100644
> >> --- a/drivers/ata/libata-core.c
> >> +++ b/drivers/ata/libata-core.c
> >> @@ -4960,6 +4960,7 @@ unsigned int ata_qc_issue_prot(struct 
> >> ata_queued_cmd *qc)
> >>     if (ap->flags & ATA_FLAG_PIO_POLLING) {
> >>         switch (qc->tf.protocol) {
> >>         case ATA_PROT_PIO:
> >> +        case ATA_PROT_NODATA:
> >>         case ATA_PROT_ATAPI:
> >>         case ATA_PROT_ATAPI_NODATA:
> >>             qc->tf.flags |= ATA_TFLAG_POLLING;
> >>
> > ..
> >> Now, why it dies after that, I don't know, it's one flag being added.
> ..
> 
> Eamonn,
> 
> Have you tried testing with the latest sata_mv fix?
> This fixes interrupt problems with all 8-port sata_mv chips,
> including the one you have access to.
> 
> Please give this patch a try and report back.  Thanks.
> The patch is against 2.6.28, but will probably apply
> to several earlier kernel versions as well.
> 
> --- linux-2.6.28/drivers/ata/sata_mv.c	2009-01-13 15:57:11.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c	2009-01-14 16:56:38.000000000 -0500
> @@ -883,7 +883,7 @@
>  		struct mv_host_priv *hpriv = ap->host->private_data;
>  		int hardport = mv_hardport_from_port(ap->port_no);
>  		void __iomem *hc_mmio = mv_hc_base_from_port(
> -					mv_host_base(ap->host), hardport);
> +					mv_host_base(ap->host), ap->port_no);
>  		u32 hc_irq_cause, ipending;
>  
>  		/* clear EDMA event indicators, if any */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

