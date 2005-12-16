From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: libata - oldpiix driver
Date: Fri, 16 Dec 2005 21:29:48 +0000
Message-ID: <1134768589.28761.69.camel@localhost.localdomain>
References: <1134053330.17102.28.camel@localhost.localdomain>
	 <20051216205955.GA21669@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:37569 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932455AbVLPV3h
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Dec 2005 16:29:37 -0500
In-Reply-To: <20051216205955.GA21669@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Gwe, 2005-12-16 at 21:59 +0100, Francois Romieu wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> :
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c
> > --- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	2005-12-07 17:26:37.000000000 +0000
> [...]
> > +static int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
> > +{
> [...]
> > +		if(adev->dma_mode)
> > +			oldpiix_set_dmamode(ap, adev);
> > +		else
> > +			oldpiix_set_dmamode(ap, adev);
> 
> Where is the difference ?

That would be a bug. Should be oldpiix_set_piomode for the second case.
Will go fix it now.

