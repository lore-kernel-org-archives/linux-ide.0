From: Mark Lord <liml@rtr.ca>
Subject: Re: problems with sata_mv and MV88SX5081 under 2.6.28, fine under
 2.6.17.6
Date: Tue, 13 Jan 2009 14:27:54 -0500
Message-ID: <496CEB3A.2090608@rtr.ca>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>	 <496B9130.2000708@pobox.com>	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F13@0602-its-exmb01.eu.saic.com>	 <496BA7C5.2020802@pobox.com>	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F14@0602-its-exmb01.eu.saic.com>	 <496BAA1F.5030802@pobox.com> <1231866067.20422.296.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58070 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZAMT1z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jan 2009 14:27:55 -0500
In-Reply-To: <1231866067.20422.296.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

Eamonn Hamilton wrote:
> Hi Mark.
> 
> It bisected down to the following:
> 
> e3472cbe5c10a91c737405cd706142787736392c is first bad commit
> commit e3472cbe5c10a91c737405cd706142787736392c
> Author: Albert Lee <albertcc@tw.ibm.com>
> Date:   Thu Dec 7 11:37:58 2006 +0800
> 
>libata: let ATA_FLAG_PIO_POLLING use polling pio for ATA_PROT_NODATA
>
>Even if ATA_FLAG_PIO_POLLING is set, libata uses irq pio for the ATA_PROT_NODATA protocol.
>This patch let ATA_FLAG_PIO_POLLING use polling pio for the ATA_PROT_NODATA protocol.
>
>Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>Signed-off-by: Jeff Garzik <jeff@garzik.org>
>---
..
>diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>index 8816e30..d2e6863 100644
>--- a/drivers/ata/libata-core.c
>+++ b/drivers/ata/libata-core.c
>@@ -4960,6 +4960,7 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
> 	if (ap->flags & ATA_FLAG_PIO_POLLING) {
> 		switch (qc->tf.protocol) {
> 		case ATA_PROT_PIO:
>+		case ATA_PROT_NODATA:
> 		case ATA_PROT_ATAPI:
> 		case ATA_PROT_ATAPI_NODATA:
> 			qc->tf.flags |= ATA_TFLAG_POLLING;
> 
..
> Now, why it dies after that, I don't know, it's one flag being added.
> 
> I guess I could try the latest kernel with that removed and see what happens?
..

You certainly could.  That routine is now in libata-sff.c,
but otherwise looks the same as you found it.

Mmm.. I seem to recall seeing some funny biz in this area when
I was working on sata_mv last year.. time to fire up the test rig
and poke around more at this stuff.

Ideally, I'd like to tell sata_mv to use IRQs for all commands,
rather than the polling that the ATA_FLAG_PIO_POLLING induces.
But there was something funny about it at the time, so I left it.

Cheers
