From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: Re: problems with sata_nv and MV88SX5081 under 2.6.28, fine
	under2.6.17.6
Date: Tue, 13 Jan 2009 17:01:07 +0000
Message-ID: <1231866067.20422.296.camel@ukabzc383.uk.saic.com>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
	 <496B9130.2000708@pobox.com>
	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F13@0602-its-exmb01.eu.saic.com>
	 <496BA7C5.2020802@pobox.com>
	 <D1CE94B2C9BA8C42AC5C7BBCD82D5DAE672F14@0602-its-exmb01.eu.saic.com>
	 <496BAA1F.5030802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:60435 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbZAMRBs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jan 2009 12:01:48 -0500
In-Reply-To: <496BAA1F.5030802@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Mark.

It bisected down to the following:

e3472cbe5c10a91c737405cd706142787736392c is first bad commit
commit e3472cbe5c10a91c737405cd706142787736392c
Author: Albert Lee <albertcc@tw.ibm.com>
Date:   Thu Dec 7 11:37:58 2006 +0800

    [PATCH] libata: let ATA_FLAG_PIO_POLLING use polling pio for
ATA_PROT_NODATA
    
    Even if ATA_FLAG_PIO_POLLING is set, libata uses irq pio for the
ATA_PROT_NODATA protocol.
    This patch let ATA_FLAG_PIO_POLLING use polling pio for the
ATA_PROT_NODATA protocol.
    
    Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>


Now, why it dies after that, I don't know, it's one flag being added.

I guess I could try the latest kernel with that removed and see what
happens?

Cheers,
Eamonn








On Mon, 2009-01-12 at 15:37 -0500, Mark Lord wrote:
> Hamilton, Eamonn [OS-IE] wrote:
> > 
> > 
> > With any luck I'll be able to bisect it down in the next day or so, git 
> > willing - I've never used the thing, but I hear good reports ;)
> ..
> 
> Okay, no changes whatsoever in sata_mv between .19 and .20.
> Are you sure about those two kernel versions?
> 
> Cheers


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

